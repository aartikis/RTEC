:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
:-dynamic initiatedAt/4, holdsForSDFluent/2, initiatedAt/2, terminatedAt/2, terminatedAt/4, maxDuration/3, maxDurationUE/3.
holdsForSDFluent(workingEfficiently(_3162)=true,_3134) :-
     holdsForProcessedSimpleFluent(_3162,working(_3162)=true,_3178),
     holdsForProcessedSDFluent(_3162,sleeping_at_work(_3162)=true,_3194),
     relative_complement_all(_3178,[_3194],_3208),
     findall((_3212,_3214),(member(_3208,(_3212,_3214)),holdsAtProcessedSimpleFluent(_3162,location(_3162)=work,_3212)),_3134).

cachingOrder2(_3138, workingEfficiently(_3138)=true) :-
     person(_3138).
