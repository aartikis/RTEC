initiatedAt(rich(_131139)=true, _131158, _131124, _131160) :-
     happensAtIE(win_lottery(_131139),_131124),_131158=<_131124,_131124<_131160,
     \+holdsAtProcessedSimpleFluent(_131139,sleeping(_131139)=true,_131124).

initiatedAt(sleeping(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(sleep_start(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

initiatedAt(location(_131139)=_131127, _131146, _131124, _131148) :-
     happensAtIE(go_to(_131139,_131127),_131124),
     _131146=<_131124,
     _131124<_131148.

initiatedAt(working(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(starts_working(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

initiatedAt(shappy(_131139)=true, _131150, _131124, _131152) :-
     happensAtProcessedSDFluent(_131139,start(happy(_131139)=true),_131124),
     _131150=<_131124,
     _131124<_131152.

terminatedAt(rich(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(lose_wallet(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

terminatedAt(sleeping(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(sleep_end(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

terminatedAt(working(_131139)=true, _131145, _131124, _131147) :-
     happensAtIE(ends_working(_131139),_131124),
     _131145=<_131124,
     _131124<_131147.

terminatedAt(working(_131139)=true, _131150, _131124, _131152) :-
     happensAtProcessedSimpleFluent(_131139,start(rich(_131139)=true),_131124),
     _131150=<_131124,
     _131124<_131152.

terminatedAt(working(_131139)=true, _131152, _131124, _131154) :-
     happensAtIE(go_to(_131139,_131148),_131124),_131152=<_131124,_131124<_131154,
     _131148\=work.

terminatedAt(shappy(_131139)=true, _131150, _131124, _131152) :-
     happensAtProcessedSDFluent(_131139,end(happy(_131139)=true),_131124),
     _131150=<_131124,
     _131124<_131152.

holdsForSDFluent(happy(_131139)=true,_131124) :-
     holdsForProcessedSimpleFluent(_131139,rich(_131139)=true,_131145),
     holdsForProcessedSimpleFluent(_131139,location(_131139)=pub,_131156),
     union_all([_131145,_131156],_131124).

holdsForSDFluent(infiniteBeers(_131139)=true,_131124) :-
     holdsForProcessedSimpleFluent(_131139,location(_131139)=pub,_131145),
     holdsForProcessedSimpleFluent(_131139,rich(_131139)=true,_131156),
     intersect_all([_131145,_131156],_131124).

holdsForSDFluent(shortHappiness(_131139)=true,_131124) :-
     holdsForProcessedSimpleFluent(_131139,location(_131139)=pub,_131145),
     holdsForProcessedSimpleFluent(_131139,rich(_131139)=true,_131156),
     relative_complement_all(_131145,[_131156],_131124).

holdsForSDFluent(drunk(_131139)=true,_131124) :-
     holdsForProcessedSDFluent(_131139,happy(_131139)=true,_131145),
     holdsForProcessedSDFluent(_131139,infiniteBeers(_131139)=true,_131156),
     intersect_all([_131145,_131156],_131124).

holdsForSDFluent(sleeping_at_work(_131139)=true,_131124) :-
     holdsForProcessedSimpleFluent(_131139,working(_131139)=true,_131145),
     holdsForProcessedSimpleFluent(_131139,sleeping(_131139)=true,_131156),
     intersect_all([_131145,_131156],_131124).

holdsForSDFluent(workingEfficiently(_131139)=true,_131124) :-
     holdsForProcessedSimpleFluent(_131139,working(_131139)=true,_131145),
     holdsForProcessedSDFluent(_131139,sleeping_at_work(_131139)=true,_131156),
     relative_complement_all(_131145,[_131156],_131124).

cachingOrder2(_131123, location(_131123)=home) :-
     person(_131123),place(home).

cachingOrder2(_131123, location(_131123)=pub) :-
     person(_131123),place(pub).

cachingOrder2(_131123, location(_131123)=work) :-
     person(_131123),place(work).

cachingOrder2(_131123, sleeping(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, rich(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, rich(_131123)=false) :-
     person(_131123).

cachingOrder2(_131123, working(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, working(_131123)=false) :-
     person(_131123).

cachingOrder2(_131123, sleeping_at_work(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, workingEfficiently(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, happy(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, happy(_131123)=false) :-
     person(_131123).

cachingOrder2(_131123, shappy(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, infiniteBeers(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, shortHappiness(_131123)=true) :-
     person(_131123).

cachingOrder2(_131123, drunk(_131123)=true) :-
     person(_131123).

