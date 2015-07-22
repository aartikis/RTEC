
:- ['../../../src/RTEC.prolog'].
:- ['pre-processing.prolog'].
:- ['caviar_declarations.prolog'].

initiatedAt(person(_131136)=true, _, _131124, _) :-
     happensAtProcessedIE(_131136,start(walking(_131136)=true),_131124),
     \+happensAtIE(disappear(_131136),_131124).

initiatedAt(person(_131136)=true, _, _131124, _) :-
     happensAtProcessedIE(_131136,start(running(_131136)=true),_131124),
     \+happensAtIE(disappear(_131136),_131124).

initiatedAt(person(_131136)=true, _, _131124, _) :-
     happensAtProcessedIE(_131136,start(active(_131136)=true),_131124),
     \+happensAtIE(disappear(_131136),_131124).

initiatedAt(person(_131136)=true, _, _131124, _) :-
     happensAtProcessedIE(_131136,start(abrupt(_131136)=true),_131124),
     \+happensAtIE(disappear(_131136),_131124).

initiatedAt(person(_131136)=false, _, _131124, _) :-
     happensAtIE(disappear(_131136),_131124).

initiatedAt(leaving_object(_131136,_131137)=true, _, _131124, _) :-
     happensAtIE(appear(_131137),_131124),
     holdsAtProcessedIE(_131137,inactive(_131137)=true,_131124),
     holdsAtProcessedSimpleFluent(_131136,person(_131136)=true,_131124),
     holdsAtProcessedSDFluent(_131136,closeSymmetric(_131136,_131137,30)=true,_131124).

initiatedAt(leaving_object(_131136,_131137)=false, _, _131124, _) :-
     happensAtIE(disappear(_131137),_131124).

initiatedAt(meeting(_131136,_131137)=true, _, _131124, _) :-
     happensAtProcessedSDFluent(_131136,start(greeting1(_131136,_131137)=true),_131124),
     \+happensAtIE(disappear(_131136),_131124),
     \+happensAtIE(disappear(_131137),_131124).

initiatedAt(meeting(_131136,_131137)=true, _, _131124, _) :-
     happensAtProcessedSDFluent(_131136,start(greeting2(_131136,_131137)=true),_131124),
     \+happensAtIE(disappear(_131136),_131124),
     \+happensAtIE(disappear(_131137),_131124).

initiatedAt(meeting(_131136,_131137)=false, _, _131124, _) :-
     happensAtProcessedIE(_131136,start(running(_131136)=true),_131124).

initiatedAt(meeting(_131136,_131137)=false, _, _131124, _) :-
     happensAtProcessedIE(_131137,start(running(_131137)=true),_131124).

initiatedAt(meeting(_131136,_131137)=false, _, _131124, _) :-
     happensAtProcessedIE(_131136,start(abrupt(_131136)=true),_131124).

initiatedAt(meeting(_131136,_131137)=false, _, _131124, _) :-
     happensAtProcessedIE(_131137,start(abrupt(_131137)=true),_131124).

initiatedAt(meeting(_131136,_131137)=false, _, _131124, _) :-
     happensAtProcessedSDFluent(_131136,start(close(_131136,_131137,34)=false),_131124).

holdsForSDFluent(close(_131139,_131140,24)=true,_131124) :-
     holdsForProcessedIE(_131139,distance(_131139,_131140,24)=true,_131124).

holdsForSDFluent(close(_131139,_131140,25)=true,_131124) :-
     holdsForProcessedSDFluent(_131139,close(_131139,_131140,24)=true,_131147),
     holdsForProcessedIE(_131139,distance(_131139,_131140,25)=true,_131160),
     union_all([_131147,_131160],_131124).

holdsForSDFluent(close(_131139,_131140,30)=true,_131124) :-
     holdsForProcessedSDFluent(_131139,close(_131139,_131140,25)=true,_131147),
     holdsForProcessedIE(_131139,distance(_131139,_131140,30)=true,_131160),
     union_all([_131147,_131160],_131124).

holdsForSDFluent(close(_131139,_131140,34)=true,_131124) :-
     holdsForProcessedSDFluent(_131139,close(_131139,_131140,30)=true,_131147),
     holdsForProcessedIE(_131139,distance(_131139,_131140,34)=true,_131160),
     union_all([_131147,_131160],_131124).

holdsForSDFluent(close(_131139,_131140,_131141)=false,_131124) :-
     holdsForProcessedSDFluent(_131139,close(_131139,_131140,_131141)=true,_131147),
     complement_all([_131147],_131124).

holdsForSDFluent(closeSymmetric(_131139,_131140,_131141)=true,_131124) :-
     holdsForProcessedSDFluent(_131139,close(_131139,_131140,_131141)=true,_131147),
     holdsForProcessedSDFluent(_131140,close(_131140,_131139,_131141)=true,_131160),
     union_all([_131147,_131160],_131124).

holdsForSDFluent(greeting1(_131139,_131140)=true,_131124) :-
     holdsForProcessedSDFluent(_131139,activeOrInactivePerson(_131139)=true,_131146),
     \+_131146=[],
     holdsForProcessedSimpleFluent(_131140,person(_131140)=true,_131165),
     \+_131165=[],
     holdsForProcessedSDFluent(_131139,close(_131139,_131140,25)=true,_131184),
     \+_131184=[],
     intersect_all([_131146,_131184,_131165],_131205),
     \+_131205=[],
     !,
     holdsForProcessedIE(_131140,running(_131140)=true,_131228),
     holdsForProcessedIE(_131140,abrupt(_131140)=true,_131239),
     relative_complement_all(_131205,[_131228,_131239],_131124).

holdsForSDFluent(greeting1(_131130,_131131)=true,[]).

holdsForSDFluent(greeting2(_131139,_131140)=true,_131124) :-
     holdsForProcessedIE(_131139,walking(_131139)=true,_131146),
     \+_131146=[],
     holdsForProcessedSDFluent(_131140,activeOrInactivePerson(_131140)=true,_131165),
     \+_131165=[],
     holdsForProcessedSDFluent(_131140,close(_131140,_131139,25)=true,_131184),
     \+_131184=[],
     !,
     intersect_all([_131146,_131165,_131184],_131124).

holdsForSDFluent(greeting2(_131130,_131131)=true,[]).

holdsForSDFluent(activeOrInactivePerson(_131139)=true,_131124) :-
     holdsForProcessedIE(_131139,active(_131139)=true,_131145),
     holdsForProcessedIE(_131139,inactive(_131139)=true,_131156),
     holdsForProcessedSimpleFluent(_131139,person(_131139)=true,_131167),
     intersect_all([_131156,_131167],_131178),
     union_all([_131145,_131178],_131124).

holdsForSDFluent(moving(_131139,_131140)=true,_131124) :-
     holdsForProcessedIE(_131139,walking(_131139)=true,_131146),
     holdsForProcessedIE(_131140,walking(_131140)=true,_131157),
     intersect_all([_131146,_131157],_131168),
     \+_131168=[],
     holdsForProcessedSDFluent(_131139,close(_131139,_131140,34)=true,_131186),
     \+_131186=[],
     !,
     intersect_all([_131168,_131186],_131124).

holdsForSDFluent(moving(_131130,_131131)=true,[]).

holdsForSDFluent(fighting(_131139,_131140)=true,_131124) :-
     holdsForProcessedIE(_131139,abrupt(_131139)=true,_131146),
     holdsForProcessedIE(_131140,abrupt(_131140)=true,_131157),
     union_all([_131146,_131157],_131168),
     \+_131168=[],
     holdsForProcessedSDFluent(_131139,close(_131139,_131140,24)=true,_131186),
     \+_131186=[],
     intersect_all([_131168,_131186],_131207),
     \+_131207=[],
     !,
     holdsForProcessedIE(_131139,inactive(_131139)=true,_131228),
     holdsForProcessedIE(_131140,inactive(_131140)=true,_131239),
     union_all([_131228,_131239],_131250),
     relative_complement_all(_131207,[_131250],_131124).

holdsForSDFluent(fighting(_131130,_131131)=true,[]).

cachingOrder2(_131123, close(_131123,_131124,24)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, close(_131123,_131124,25)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, close(_131123,_131124,30)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, close(_131123,_131124,34)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, close(_131123,_131124,34)=false) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, closeSymmetric(_131123,_131124,30)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, person(_131123)=true) :-
     list_of_ids(_131123).

cachingOrder2(_131123, activeOrInactivePerson(_131123)=true) :-
     list_of_ids(_131123).

cachingOrder2(_131123, greeting1(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, greeting2(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, leaving_object(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, leaving_object(_131123,_131124)=true) :-
     symmetric_id_pair(_131123,_131124).

cachingOrder2(_131123, meeting(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, moving(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

cachingOrder2(_131123, fighting(_131123,_131124)=true) :-
     id_pair(_131123,_131124).

buildFromPoints2(_131123, walking(_131123)=true) :-
     list_of_ids(_131123).

buildFromPoints2(_131123, active(_131123)=true) :-
     list_of_ids(_131123).

buildFromPoints2(_131123, inactive(_131123)=true) :-
     list_of_ids(_131123).

buildFromPoints2(_131123, running(_131123)=true) :-
     list_of_ids(_131123).

buildFromPoints2(_131123, abrupt(_131123)=true) :-
     list_of_ids(_131123).

