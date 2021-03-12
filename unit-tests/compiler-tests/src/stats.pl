:-['../../../src/utilities/interval-manipulation.prolog'].
:-use_module(library(lists)).

:-multifile event/4.
find_event_names(Events):-setof(E,D^V^T^event(D,E,V,T),Events).
find_args_of_event(Event,Args):-setof(V,D^T^Event^event(D,Event,V,T),Args).

find_total([],0).
find_total([(S,E)|L],T):-find_total(L,S1),D is E-S,T is S1+D.

triplesum((A1,B1,C1),(A2,B2,C2),(A3,B3,C3)):-A3 is A1 + A2, B3 is B1 + B2, C3 is C1 + C2.

triplesumlist([],(0,0,0)).
triplesumlist([A|B],Sum):-
    triplesumlist(B,SumO),triplesum(SumO,A,Sum).

triplemean(L,(M1,M2,M3)):-triplesumlist(L,(S1,S2,S3)),length(L,Size),M1 is round(S1/Size),M2 is round(S2/Size),M3 is round(S3/Size).

compare_intervals(A,B,(Common,OnlyA,OnlyB)):-
    intersect_all([A,B],Intersected),
    find_total(Intersected,Common),
    relative_complement_all(A,[B],OnlyAIntervals),
    find_total(OnlyAIntervals,OnlyA),
    relative_complement_all(B,[A],OnlyBIntervals),
    find_total(OnlyBIntervals,OnlyB).

compare_args([],_,[]).
compare_args([Vessel|OtherVessels],Event,[Comp|OtherComp]):-
    findall(Icri,event(normal,Event,Vessel,Icri),Icr),
    findall(Irawi,event(manual,Event,Vessel,Irawi),Iraw),
    union_all(Icr,I1),
    union_all(Iraw,I2),
    compare_intervals(I1,I2,Comp),
    compare_args(OtherVessels,Event,OtherComp).

compare_all_args_of_event(Event,L):-
    find_args_of_event(Event,Vessels),
    compare_args(Vessels,Event,L).

writeElementsSeparated(_,[]).
writeElementsSeparated(ResultStream,[E]):-
    write(ResultStream,E).
writeElementsSeparated(ResultStream,[E|L]):-
    write(ResultStream,E),
    write(ResultStream,','),
    writeElementsSeparated(ResultStream,L).

compare_events([],[],_).
compare_events([Event|OtherEvents],[(Event,(M1,M2,M3))|Other],ResultStream):-
    %write('Comparing event: '),write(Event),nl,
    compare_all_args_of_event(Event,Results),
    triplesumlist(Results,(M1,M2,M3)),
    writeElementsSeparated(ResultStream,[Event,M1,M2,M3]),
    nl(ResultStream),
    compare_events(OtherEvents,Other,ResultStream).

compare_all_events(ResultFilename):-
    open(ResultFilename, write, ResultStream),
    nl(ResultStream),
    find_event_names(Events),
    %write('Found all events.'),nl,
    compare_events(Events,Results,ResultStream),
    check_for_errors(Results),
    close(ResultStream).
    %write('Finished.').


check_for_errors(Results):-
    findall(M,(
                member(M,Results),
                M = (Event,(M1,0,0))
             ),Results),
            write('----Status : PASSED'),nl.

check_for_errors(Results):-
            write('----Status : FAILED'),nl.

