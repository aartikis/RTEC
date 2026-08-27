 # Dynamic Grounding

 Dynamic grounding relies on two operations: building the domains
and updating the domains. The first one is used for collecting
the domain elements from input events, and the second one is
used for discarding or keeping elements of the domains based
on the needs of the current recognition period.

 ## Building domains

 For each domain, the set of input entities from which the domain
 elements are collected must be declared by the user in the
 declarations file using the collectGrounds predicate:

 ```
 collectGrounds([event1(VarA,...,VarB,...,VarN),
                event1(...,VarA,...,VarB,...,VarN,...),
                event2(VarA,...,VarB,...,VarN),
                ...,
                eventN(VarA,VarB,...,VarN)],domainA(VarA,...,VarK)).

 ```

 - The first argument of the collectGrounds predicate is a list containing all the input events containing the values for the elements (VarA,VarB,...,VarK) that the domain is going to be filled with. 
 - The second argument is the name of the domain (domainA) along with the variables that unify with the variables used in the input events contained in the list of the first argument.

 For instance, consider the example below with the following input events:

 ```
 lose_wallet(Person), win_lottery(Person), steals(Person1,Person2),
 leaves(Person1,Person2)

 ```

 And the following output entities:

 ```
 rich(Person)=true
 robbery(Person1,Person2)=true
 ```

 which are grounded using the person(Person), and the personPair(Person1,Person2) grounding predicates (domains).
 
 Therefore, these are the corresponding grounding declarations in the declarations file:
 
 ```
 grounding(rich(person)=true) :- person(Person).
 grounding(robbery(Person1,Person2)=true) :- personPair(Person1,Person2).
 
 ```
 Consequently, in this example the collectGrounds declarations are the
 following:
 
 ```
 collectGrounds([win_lottery(Person),
                lose_wallet(Person)
                ],person(Person)).

 collectGrounds([steals(Person1,Person2)
                ],personPair(Person1,Person2)).
 
 ```
 ## Updating the domains

 Applying dynamic grounding, requires the execution of several
 operations in each recognition query time. First, we must
 collect for all domains their elements from SDEs that fall within
 the window and then we must discard all redundant elements.

 To find the redundant items the user has to declare the dependencies
 of grounded entities with their grounding predicates (domains)
 using the dgrounded predicate.
 
 ```
 grounding(fluent1(VarA,VarB,...,VarI,VarJ,...,VarN)=value):-domainA(VarA),domainB(VarB),...,domainAB(VarA,VarB),... etc

 dgrounded(fluent1(VarA,...)=value,domainA(VarA)).
 dgrounded(fluent1(...,VarB,...)=value,domainB(VarB)).
 ...
 dgrounded(fluent1(VarA,VarB,...)=value,domainAB(VarA,VarB)).
 ...
 
 ```

 In our example the dgrounded declarations are the following:
 
 ```
 grounding(rich(person)=true) :- person(Person).
 dgrounded(rich(person)=true,person(Person)).

 grounding(robbery(Person1,Person2)=true) :- personPair(Person1,Person2).
 dgrounded(robbery(Person1,Person2)=true, personPair(Person1,Person2)).

 ```
 Care must be taken when the grounding of fluents depends on the groundings of other
 fluents. For example consider a statically determined fluent with the
 following definition and grounding:

 ```
 holdsFor(scared(Person)=true, I) :-
    holdsFor(robbery(Person,_Thief)=true, I).

 grounding(scared(Person)=true):-person(Person).
 
 ```
 
 In this case, the `Person' appearing in the first argument of the `robbery' fluent is
 required for the grounding of the `scared' fluent. Consequently, an additional dgrounded
 declaration is required for the `robbery' fluent:

```
dgrounded(robbery(Person,_Thief)=true,person(Person)).

```