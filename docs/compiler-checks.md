# Checks of the Event Description

The compiler translates the rules of an event description and does not reject mistakes. For example, an `initiatedAt` rule whose first condition is a `holdsAt` compiles but never fires, and a `;` next to other conditions is written without brackets, so that `A,(B;C)` is read back as `(A,B);C`.

While compiling, RTEC therefore checks the event description and prints a message to the standard error for each likely mistake:

```
RTEC warning: <file>:<line>: [<check>] <clause head>: <problem>.
RTEC error: <file>:<line>: [<check>] <clause head>: <problem>.
```

Warnings do not change the compiled event description. Errors are the mistakes on which the compiler cannot finish: RTEC prints all of them, writes a compiled event description without rules and stops.

Warnings:

| Check | Reported |
|---|---|
| rule form | An `initiatedAt` or `terminatedAt` rule that does not start with `happensAt(Event, T)`: the compiler attaches the time window to the first condition only, which can give wrong intervals, e.g. with deadlines. A `holdsAt` as the first condition of an `initiatedAt`, `terminatedAt` or `happensAt` rule, which then never fires, and a negation as the first condition of a `happensAt` rule. A `happensAt` or `holdsAt` condition whose time-point no earlier condition binds. A `start` or `end` event inside a negation of several conditions, `\+ (A, B)`: the compiler does not translate the conditions there, so the event never happens. A `holdsFor` rule with a `happensAt`, `holdsAt`, `initiatedAt` or `terminatedAt` condition, which is not evaluated on its intervals, or whose body does not compute its interval list. A rule head without a fluent-value pair, which the compiler skips. |
| disjunction | A `;` next to other conditions, which loses its brackets. A rule body that is a `;`: an `initiatedAt` or `terminatedAt` rule then has no time window, and a `holdsFor` rule gives the intervals of one alternative only. A `start` or `end` event inside the `;` of a `happensAt` rule whose body is a `;`, or inside `\+ (A ; B)`: the compiler does not translate the conditions there, so the event never happens. A `->`. `holdsAt` rules translate `;`, but the compiler drops a `holdsAt` rule with `->`. |
| built-in | A predicate of RTEC with the wrong number of arguments, e.g. `union_all/3`. A single interval list where a list of interval lists is needed, e.g. `union_all(I1, I)` instead of `union_all([I1], I)`. `holdsAt`, `holdsFor`, `start` or `end` without a fluent-value pair. `happensAt` of a fluent-value pair. An Allen relation outside a `holdsFor` rule, an unknown relation in `allen/5`, or an output mode other than `source`, `target`, `lhs`, `rhs`, `union`, `intersection`, `relative_complement` and `relative_complement_inverse`. |
| fi/p | `fi` without two fluent-value pairs, with two different fluents, or with arguments that never match, e.g. `location(alice)` and `location(bob)`. A duration that is a name, or that neither the body nor the fluent-value pairs of the `fi` bind, so that RTEC stops with an error when it applies the `fi`, or that is not a positive integer. `fi` on a fluent-value pair defined by `holdsFor` rules. `p` without a fluent-value pair, or without a matching `fi`. `fi` or `p` used as a condition. |
| grounding | The target value of a `fi` has no grounding, so RTEC computes no intervals for it. |
| number | A name, or an interval list, as an operand of a comparison or on the right of `is`, e.g. `Speed > minSpeed`. RTEC stops with an error when it evaluates such a condition. |

Errors:

| Check | Reported |
|---|---|
| fluent | A variable where the compiler needs a fluent: in the head of an `initiatedAt`, `terminatedAt` or `holdsFor` rule, of an `initially` or of a `grounding`; in a `holdsAt`, `holdsFor`, `start` or `end` condition of an `initiatedAt`, `terminatedAt`, `holdsFor` or `happensAt` rule; in the target of a `fi`. |
| fi/p | A `fi` whose target matches its source, e.g. `fi(rich(X)=true, rich(X)=true, 10)`. |

For example, compiling

```prolog
initiatedAt(rich(X)=true, T) :-
    holdsAt(location(X)=pub, T),
    happensAt(win_lottery(X), T).
```

prints

```
RTEC warning: rules.prolog:1: [rule form] initiatedAt(rich(X)=true,T): holdsAt(location(X)=pub,T) as the first condition is evaluated before the time-point T is known, so this rule never fires; start with happensAt(Event, T).
```

The unit tests of the checks are in `unit-tests/compiler-tests/checks`. Run them with `./runcompilerchecks-SWI.sh` in `unit-tests/compiler-tests`.

[🠔](contents.md)
