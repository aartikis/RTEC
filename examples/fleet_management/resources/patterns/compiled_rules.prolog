:- dynamic vehicle/1.

initiatedAt(stoppedState(_122)=true, _138, _92, _144) :-
     happensAtIE(notMoving(_122),_92),
     _138=<_92,
     _92<_144.

initiatedAt(stoppedState(_122)=true, _138, _92, _144) :-
     happensAtIE(stopped(_122),_92),
     _138=<_92,
     _92<_144.

initiatedAt(normalSpeed(_122)=true, _176, _92, _182) :-
     happensAtIE(moving(_122,_128),_92),_176=<_92,_92<_182,
     vehicleType(_122,_140),
     vehicleSpeed(_140,_146),
     _128=<_146.

initiatedAt(overSpeeding(_122)=true, _176, _92, _182) :-
     happensAtIE(moving(_122,_128),_92),_176=<_92,_92<_182,
     vehicleType(_122,_140),
     vehicleSpeed(_140,_146),
     _128>_146.

initiatedAt(dangerousDriving(_122)=true, _160, _92, _166) :-
     happensAtIE(acceleration(_122),_92),_160=<_92,_92<_166,
     holdsAtProcessedSimpleFluent(_122,overSpeeding(_122)=true,_92).

initiatedAt(dangerousDriving(_122)=true, _160, _92, _166) :-
     happensAtIE(braking(_122),_92),_160=<_92,_92<_166,
     holdsAtProcessedSimpleFluent(_122,overSpeeding(_122)=true,_92).

initiatedAt(dangerousDriving(_122)=true, _160, _92, _166) :-
     happensAtIE(cornering(_122),_92),_160=<_92,_92<_166,
     holdsAtProcessedSimpleFluent(_122,overSpeeding(_122)=true,_92).

initiatedAt(dangerousDriving(_122)=true, _160, _92, _166) :-
     happensAtIE(ice(_122),_92),_160=<_92,_92<_166,
     holdsAtProcessedSimpleFluent(_122,overSpeeding(_122)=true,_92).

initiatedAt(notEconomicDriving(_122)=true, _216, _92, _222) :-
     happensAtIE(fuelLevel(_122,_128),_92),_216=<_92,_92<_222,
     holdsAtProcessedSimpleFluent(_122,overSpeeding(_122)=true,_92),
     vehicleType(_122,_156),
     vehicleTank(_156,_162),
     _172 is _162/2,
     _128<_172.

initiatedAt(reFuel(_122)=true, _160, _92, _166) :-
     happensAtIE(closeToGas(_122),_92),_160=<_92,_92<_166,
     holdsAtProcessedSimpleFluent(_122,notEconomicDriving(_122)=true,_92).

terminatedAt(stoppedState(_122)=true, _140, _92, _146) :-
     happensAtIE(moving(_122,_128),_92),
     _140=<_92,
     _92<_146.

terminatedAt(normalSpeed(_122)=true, _176, _92, _182) :-
     happensAtIE(moving(_122,_128),_92),_176=<_92,_92<_182,
     vehicleType(_122,_140),
     vehicleSpeed(_140,_146),
     _128>_146.

terminatedAt(normalSpeed(_122)=true, _138, _92, _144) :-
     happensAtIE(notMoving(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(normalSpeed(_122)=true, _138, _92, _144) :-
     happensAtIE(stopped(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(overSpeeding(_122)=true, _176, _92, _182) :-
     happensAtIE(moving(_122,_128),_92),_176=<_92,_92<_182,
     vehicleType(_122,_140),
     vehicleSpeed(_140,_146),
     _128=<_146.

terminatedAt(overSpeeding(_122)=true, _138, _92, _144) :-
     happensAtIE(notMoving(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(overSpeeding(_122)=true, _138, _92, _144) :-
     happensAtIE(stopped(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(dangerousDriving(_122)=true, _138, _92, _144) :-
     happensAtIE(notMoving(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(dangerousDriving(_122)=true, _138, _92, _144) :-
     happensAtIE(stopped(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(notEconomicDriving(_122)=true, _220, _92, _226) :-
     happensAtIE(fuelLevel(_122,_128),_92),_220=<_92,_92<_226,
     \+holdsAtProcessedSimpleFluent(_122,overSpeeding(_122)=true,_92),
     vehicleType(_122,_160),
     vehicleTank(_160,_166),
     _176 is _166/2,
     _128>=_176.

terminatedAt(notEconomicDriving(_122)=true, _138, _92, _144) :-
     happensAtIE(notMoving(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(notEconomicDriving(_122)=true, _138, _92, _144) :-
     happensAtIE(stopped(_122),_92),
     _138=<_92,
     _92<_144.

terminatedAt(reFuel(_122)=true, _194, _92, _200) :-
     happensAtIE(fuelLevel(_122,_128),_92),_194=<_92,_92<_200,
     vehicleType(_122,_140),
     vehicleTank(_140,_146),
     _156 is _146/2,
     _128>=_156.

terminatedAt(reFuel(_122)=true, _194, _92, _200) :-
     happensAtIE(fuelLevel(_122,_128),_92),_194=<_92,_92<_200,
     vehicleType(_122,_140),
     vehicleTank(_140,_146),
     _156 is _146/2,
     _128>=_156.

holdsForSDFluent(normal2dangerousDriving(_122)=true,_92) :-
     holdsForProcessedSimpleFluent(_122,normalSpeed(_122)=true,_138),
     holdsForProcessedSimpleFluent(_122,dangerousDriving(_122)=true,_154),
     catch(call(rct_computation_formula(seq,0,normal2dangerousDriving(_122)=true,[normalSpeed(_122)=true,dangerousDriving(_122)=true],[_138,_154],_92)),_400,writeln(assumptionViolation(normal2dangerousDriving(_122)=true)))->true;queryTime(_486),_92=([],_486).

holdsForSDFluent(normal2notEconomicDriving(_122)=true,_92) :-
     holdsForProcessedSimpleFluent(_122,normalSpeed(_122)=true,_138),
     holdsForProcessedSimpleFluent(_122,notEconomicDriving(_122)=true,_154),
     catch(call(rct_computation_formula(seq,1,normal2notEconomicDriving(_122)=true,[normalSpeed(_122)=true,notEconomicDriving(_122)=true],[_138,_154],_92)),_400,writeln(assumptionViolation(normal2notEconomicDriving(_122)=true)))->true;queryTime(_486),_92=([],_486).

grounding(moving(_396,_398)) :- 
     vehicle(_396).

grounding(acceleration(_396)) :- 
     vehicle(_396).

grounding(braking(_396)) :- 
     vehicle(_396).

grounding(cornering(_396)) :- 
     vehicle(_396).

grounding(ice(_396)) :- 
     vehicle(_396).

grounding(fuelLevel(_396,_398)) :- 
     vehicle(_396).

grounding(closeToGas(_396)) :- 
     vehicle(_396).

grounding(notMoving(_396)) :- 
     vehicle(_396).

grounding(stopped(_396)) :- 
     vehicle(_396).

grounding(stoppedState(_402)=true) :- 
     vehicle(_402).

grounding(normalSpeed(_402)=true) :- 
     vehicle(_402).

grounding(overSpeeding(_402)=true) :- 
     vehicle(_402).

grounding(dangerousDriving(_402)=true) :- 
     vehicle(_402).

grounding(notEconomicDriving(_402)=true) :- 
     vehicle(_402).

grounding(reFuel(_402)=true) :- 
     vehicle(_402).

grounding(notEconomicDriving(_402)=true) :- 
     vehicle(_402).

grounding(normal2dangerousDriving(_402)=true) :- 
     vehicle(_402).

grounding(normal2notEconomicDriving(_402)=true) :- 
     vehicle(_402).

inputEntity(notMoving(_152)).
inputEntity(stopped(_152)).
inputEntity(moving(_152,_154)).
inputEntity(acceleration(_152)).
inputEntity(braking(_152)).
inputEntity(cornering(_152)).
inputEntity(ice(_152)).
inputEntity(fuelLevel(_152,_154)).
inputEntity(closeToGas(_152)).

outputEntity(stoppedState(_274)=true).
outputEntity(normalSpeed(_274)=true).
outputEntity(overSpeeding(_274)=true).
outputEntity(dangerousDriving(_274)=true).
outputEntity(notEconomicDriving(_274)=true).
outputEntity(reFuel(_274)=true).
outputEntity(normal2dangerousDriving(_274)=true).
outputEntity(normal2notEconomicDriving(_274)=true).

event(notMoving(_378)).
event(stopped(_378)).
event(moving(_378,_380)).
event(acceleration(_378)).
event(braking(_378)).
event(cornering(_378)).
event(ice(_378)).
event(fuelLevel(_378,_380)).
event(closeToGas(_378)).

simpleFluent(stoppedState(_500)=true).
simpleFluent(normalSpeed(_500)=true).
simpleFluent(overSpeeding(_500)=true).
simpleFluent(dangerousDriving(_500)=true).
simpleFluent(notEconomicDriving(_500)=true).
simpleFluent(reFuel(_500)=true).


sDFluent(normal2dangerousDriving(_660)=true).
sDFluent(normal2notEconomicDriving(_660)=true).

index(notMoving(_674),_674).
index(stopped(_674),_674).
index(moving(_674,_734),_674).
index(acceleration(_674),_674).
index(braking(_674),_674).
index(cornering(_674),_674).
index(ice(_674),_674).
index(fuelLevel(_674,_734),_674).
index(closeToGas(_674),_674).
index(stoppedState(_674)=true,_674).
index(normalSpeed(_674)=true,_674).
index(overSpeeding(_674)=true,_674).
index(dangerousDriving(_674)=true,_674).
index(notEconomicDriving(_674)=true,_674).
index(reFuel(_674)=true,_674).
index(normal2dangerousDriving(_674)=true,_674).
index(normal2notEconomicDriving(_674)=true,_674).


cachingOrder2(_1072, stoppedState(_1072)=true) :- % level in dependency graph: 1, processing order in component: 1
     vehicle(_1072).

processingLevel(1,_1072, stoppedState(_1072)=true).
cachingOrder2(_1050, normalSpeed(_1050)=true) :- % level in dependency graph: 1, processing order in component: 1
     vehicle(_1050).

processingLevel(1,_1050, normalSpeed(_1050)=true).
cachingOrder2(_1028, overSpeeding(_1028)=true) :- % level in dependency graph: 1, processing order in component: 1
     vehicle(_1028).

processingLevel(1,_1028, overSpeeding(_1028)=true).
cachingOrder2(_1380, dangerousDriving(_1380)=true) :- % level in dependency graph: 2, processing order in component: 1
     vehicle(_1380).

processingLevel(2,_1380, dangerousDriving(_1380)=true).
cachingOrder2(_1358, notEconomicDriving(_1358)=true) :- % level in dependency graph: 2, processing order in component: 1
     vehicle(_1358).

processingLevel(2,_1358, notEconomicDriving(_1358)=true).
cachingOrder2(_1640, reFuel(_1640)=true) :- % level in dependency graph: 3, processing order in component: 1
     vehicle(_1640).

processingLevel(3,_1640, reFuel(_1640)=true).
cachingOrder2(_1618, normal2dangerousDriving(_1618)=true) :- % level in dependency graph: 3, processing order in component: 1
     vehicle(_1618).

processingLevel(3,_1618, normal2dangerousDriving(_1618)=true).
cachingOrder2(_1596, normal2notEconomicDriving(_1596)=true) :- % level in dependency graph: 3, processing order in component: 1
     vehicle(_1596).

processingLevel(3,_1596, normal2notEconomicDriving(_1596)=true).
collectGrounds([notMoving(_492), stopped(_492), moving(_492,_506), acceleration(_492), braking(_492), cornering(_492), ice(_492), fuelLevel(_492,_506), closeToGas(_492)],vehicle(_492)).

dgrounded(stoppedState(_844)=true, vehicle(_844)).
dgrounded(normalSpeed(_812)=true, vehicle(_812)).
dgrounded(overSpeeding(_780)=true, vehicle(_780)).
dgrounded(dangerousDriving(_748)=true, vehicle(_748)).
dgrounded(notEconomicDriving(_716)=true, vehicle(_716)).
dgrounded(notEconomicDriving(_684)=true, vehicle(_684)).
dgrounded(reFuel(_652)=true, vehicle(_652)).
dgrounded(normal2dangerousDriving(_620)=true, vehicle(_620)).
dgrounded(normal2notEconomicDriving(_588)=true, vehicle(_588)).
