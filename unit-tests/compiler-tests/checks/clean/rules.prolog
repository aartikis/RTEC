% Forms that the checks must accept: no warning.

% A rule whose first condition is an initiatedAt at the time-point of the head, as in the manual.
initiatedAt(happy(X)=true, T) :-
    initiatedAt(rich(X)=true, T).

initiatedAt(rich(X)=true, T) :-
    happensAt(win_lottery(X), T).

terminatedAt(rich(X)=true, T) :-
    happensAt(lose_wallet(X), T),
    \+ holdsAt(location(X)=home, T).

% A holdsFor fact and a holdsFor rule whose first condition is a background predicate.
holdsFor(greeting(_X, _Y)=true, []).
holdsFor(content(X)=true, I) :-
    person(X),
    holdsFor(rich(X)=true, I1),
    holdsFor(location(X)=pub, I2),
    intersect_all([I1, I2], I3),
    relative_complement_all(I3, [I1], I4),
    complement_all([I4], I).

% An Allen relation in a holdsFor rule.
holdsFor(drinking(X)=true, I) :-
    holdsFor(location(X)=pub, I1),
    holdsFor(rich(X)=true, I2),
    allen(during, I1, I2, intersection, I).

% Deadlines: a fi with a duration bound by its body, a p, a fi with a number, and a holdsAt rule with a disjunction.
initiatedAt(ticketValid(Car)=true, T) :-
    happensAt(buy_ticket(Car), T).
terminatedAt(ticketValid(Car)=true, T) :-
    happensAt(leave(Car), T).
fi(ticketValid(Car)=true, ticketValid(Car)=false, D) :-
    thresholds(ticketDuration, D).
p(ticketValid(_Car)=true).

initiatedAt(mayPost(User)=true, T) :-
    happensAt(register(User), T).
initiatedAt(mayPost(User)=false, T) :-
    happensAt(post(User), T).
fi(mayPost(User)=false, mayPost(User)=true, 30).

holdsAt(busy(X)=true, T) :-
    (   holdsAt(location(X)=work, T)
    ;   holdsAt(location(X)=gym, T)
    ).

% Comparisons with numbers and with a threshold.
initiatedAt(location(X)=far, T) :-
    happensAt(move(X, Distance), T),
    thresholds(farDistance, Far),
    Distance > Far,
    Distance =< 1000.

% A ';' of background predicates under a negation: it keeps its brackets.
initiatedAt(lucky(X)=true, T) :-
    happensAt(win_lottery(X), T),
    \+ (banned(X) ; minor(X)).

% happensAt rules have no time window: a background predicate first is fine, and so is a body that is a ';'
% without start or end events.
happensAt(celebrate(X), T) :-
    person(X),
    happensAt(win_lottery(X), T).
happensAt(party(X), T) :-
    (   happensAt(win_lottery(X), T)
    ;   happensAt(birthday(X), T)
    ).

% A holdsAt condition at an earlier time-point that the condition before it binds.
initiatedAt(newlyRich(X)=true, T) :-
    happensAt(win_lottery(X), T),
    Tp is T-1,
    \+ holdsAt(rich(X)=true, Tp).

% An fi whose duration comes from its fluent-value pairs, and an fi whose body is a ';'.
initiatedAt(timer(Id, D)=on, T) :-
    happensAt(start_timer(Id, D), T).
fi(timer(Id, D)=on, timer(Id, D)=off, D).
initiatedAt(alarm(X)=on, T) :-
    happensAt(arm(X), T).
fi(alarm(X)=on, alarm(X)=off, D) :-
    (   thresholds(shortAlarm, D)
    ;   thresholds(longAlarm, D)
    ).

grounding(win_lottery(Person)) :- person(Person).
grounding(lose_wallet(Person)) :- person(Person).
grounding(move(Person, _Distance)) :- person(Person).
grounding(buy_ticket(Car)) :- car(Car).
grounding(leave(Car)) :- car(Car).
grounding(register(User)) :- user(User).
grounding(post(User)) :- user(User).
grounding(rich(Person)=true) :- person(Person).
grounding(happy(Person)=true) :- person(Person).
grounding(content(Person)=true) :- person(Person).
grounding(drinking(Person)=true) :- person(Person).
grounding(location(Person)=far) :- person(Person).
grounding(ticketValid(Car)=true) :- car(Car).
grounding(ticketValid(Car)=false) :- car(Car).
grounding(mayPost(User)=true) :- user(User).
grounding(mayPost(User)=false) :- user(User).
grounding(birthday(Person)) :- person(Person).
grounding(start_timer(Id, D)) :- timer(Id), duration(D).
grounding(arm(Device)) :- device(Device).
grounding(celebrate(Person)) :- person(Person).
grounding(party(Person)) :- person(Person).
grounding(lucky(Person)=true) :- person(Person).
grounding(newlyRich(Person)=true) :- person(Person).
grounding(timer(Id, D)=on) :- timer(Id), duration(D).
grounding(timer(Id, D)=off) :- timer(Id), duration(D).
grounding(alarm(Device)=on) :- device(Device).
grounding(alarm(Device)=off) :- device(Device).
