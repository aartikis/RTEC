initiatedAt(fa(P)=true, T):-
	happensAt(sa(P),T).
terminatedAt(fa(P)=true,T):-
	happensAt(ea(P),T).


initiatedAt(fb(P)=true, T):-
	happensAt(sb(P),T).
terminatedAt(fb(P)=true,T):-
	happensAt(eb(P),T).
	
initiatedAt(fc(P)=true, T):-
	happensAt(sc(P),T).
terminatedAt(fc(P)=true,T):-
	happensAt(ec(P),T).

%holdsFor(contains(P)=true, I):-
%	holdsFor(fa(P)=true, Ia),
%	holdsFor(fb(P)=true, Ib),
%	during(Ib, Ia, union, I).

%holdsFor(caseA(P)=true, I):-
%	holdsFor(contains(P)=true,Ia),
%%	holdsFor(fc(P)=true,Ic),
%	intersect_all([Ia, Ic], I).

%holdsFor(caseB(P)=true, I):-
%	holdsFor(contains(P)=true,Ia),
%%	holdsFor(fc(P)=true,Ic),
%	during(Ic,Ia,union, I).

holdsFor(caseA(P)=true, I):-
	holdsFor(fa(P)=true, Ia),
	holdsFor(fb(P)=true, Ib),
	during(Ib, Ia, union, Id),
	holdsFor(fc(P)=true, Ic),
	intersect_all([Id, Ic], I).

holdsFor(caseB(P)=true, I):-
	holdsFor(fa(P)=true, Ia),
	holdsFor(fc(P)=true, Ic),
	during(Ic, Ia, union, Id),
	holdsFor(fb(P)=true, Ib),
	during(Ib, Id, union, I).

	

grounding(sa(P)):-p(P).
grounding(sb(P)):-p(P).
grounding(sc(P)):-p(P).
grounding(ea(P)):-p(P).
grounding(eb(P)):-p(P).
grounding(ec(P)):-p(P).


grounding(fa(P)=true):- p(P).
grounding(fb(P)=true):- p(P).
grounding(fc(P)=true):- p(P).

%grounding(contains(P)=true):- p(P).
grounding(caseA(P)=true):- p(P).
grounding(caseB(P)=true):- p(P).

