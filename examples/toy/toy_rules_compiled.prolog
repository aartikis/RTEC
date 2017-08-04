initiatedAt(rich(_131261)=true, _, _131249, _) :-
     happensAtIE(win_lottery(_131261),_131249).

initiatedAt(location(_131261)=_131259, _, _131249, _) :-
     happensAtIE(go_to(_131261,_131259),_131249).

terminatedAt(rich(_131261)=true, _, _131249, _) :-
     happensAtIE(lose_wallet(_131261),_131249).

holdsForSDFluent(happy(_131264)=true,_131249) :-
     holdsForProcessedSimpleFluent(_131264,rich(_131264)=true,_131270),
     holdsForProcessedSimpleFluent(_131264,location(_131264)=pub,_131281),
     union_all([_131270,_131281],_131249).

cachingOrder2(_131248, location(_131248)=home) :-
     person(_131248),place(home).

cachingOrder2(_131248, location(_131248)=pub) :-
     person(_131248),place(pub).

cachingOrder2(_131248, location(_131248)=work) :-
     person(_131248),place(work).

cachingOrder2(_131248, rich(_131248)=true) :-
     person(_131248).

cachingOrder2(_131248, rich(_131248)=false) :-
     person(_131248).

cachingOrder2(_131248, happy(_131248)=true) :-
     person(_131248).

cachingOrder2(_131248, happy(_131248)=false) :-
     person(_131248).

