
/******************************************* DECLARATIONS ***************************
 1. Declare the entities of the event description: 
	-events (event/1), 
	-simple fluents (simpleFluent/1), and
	-statically determined fluents (sDFluent/1).
 2. For each entity, state if it is input (inputEntity/1) or output (outputEntity/1). 
	-Simple fluents are, by definition, output entities and must be declared so.
 3. For each entity, state its index (index/2). 
	-A fluent F must have the same index in all fluent-value pairs F=V.
 Note: All values V of a simple fluent F must be explicitly declared by means of:
	-simpleFluent/1
	-outputEntity/1
	-index/2.
 4. For input entities expressed as statically determined fluents, state whether:
	-The fluent instances will be reported as time-points (points/1) or intervals;
	 by default, RTEC assumes that fluent instances are reported as intervals
	 (in this case no declarations are necessary).
	-The list of intervals of the input entity will be constructed by 
	 collecting individual intervals (collectIntervals/1), or built from 
	 time-points (buildFromPoints/1). If no declarations are provided here,
	 then the input entity may not participate in the specification of 
	 output entities. 	 
 5. Specify the grounding of each fluent and output entity expressed as event.
 6. Declare the order of caching of output entities.
 *************************************************************************************/

% the declaration below is necessary for SWI Prolog:
% This is probably due to dynamic grounding
:- dynamic vessel/1, vpair/2.

%%%%%%%%%%%%%%%%%% INPUT %%%%%%%%%%%%%%%%%%
event(change_in_speed_start(_)).	inputEntity(change_in_speed_start(_)).		index(change_in_speed_start(Vessel), Vessel).
event(change_in_speed_end(_)).		inputEntity(change_in_speed_end(_)).		index(change_in_speed_end(Vessel), Vessel).
event(change_in_heading(_)).		inputEntity(change_in_heading(_)).		index(change_in_heading(Vessel), Vessel).
event(stop_start(_)).			inputEntity(stop_start(_)).			index(stop_start(Vessel), Vessel).
event(stop_end(_)).			inputEntity(stop_end(_)).			index(stop_end(Vessel), Vessel).
event(slow_motion_start(_)).		inputEntity(slow_motion_start(_)).		index(slow_motion_start(Vessel), Vessel).
event(slow_motion_end(_)).		inputEntity(slow_motion_end(_)).		index(slow_motion_end(Vessel), Vessel).
event(gap_start(_)).			inputEntity(gap_start(_)).			index(gap_start(Vessel), Vessel).
event(gap_end(_)).			inputEntity(gap_end(_)).			index(gap_end(Vessel), Vessel).
event(entersArea(_,_)).			inputEntity(entersArea(_,_)).			index(entersArea(Vessel,_), Vessel).
event(leavesArea(_,_)).			inputEntity(leavesArea(_,_)).			index(leavesArea(Vessel,_), Vessel).
event(coord(_,_,_)).			inputEntity(coord(_,_,_)).			index(coord(Vessel,_,_), Vessel).
event(velocity(_,_,_,_)).		inputEntity(velocity(_,_,_,_)).			index(velocity(Vessel,_,_,_), Vessel).
sDFluent(proximity(_,_)=true).		inputEntity(proximity(_,_)=true).		index(proximity(Vessel,_)=true, Vessel).


%%%%%%%%%%%% OUTPUT %%%%%%%%%%%%
simpleFluent(gap(_)=nearPorts).			outputEntity(gap(_)=nearPorts).			index(gap(Vessel)=nearPorts, Vessel).
simpleFluent(gap(_)=farFromPorts).		outputEntity(gap(_)=farFromPorts).		index(gap(Vessel)=farFromPorts, Vessel).

simpleFluent(stopped(_)=nearPorts).		outputEntity(stopped(_)=nearPorts).		index(stopped(Vessel)=_, Vessel).
simpleFluent(stopped(_)=farFromPorts).	        outputEntity(stopped(_)=farFromPorts).	        

simpleFluent(lowSpeed(_)=true).		        outputEntity(lowSpeed(_)=true).		        index(lowSpeed(Vessel)=true, Vessel).
simpleFluent(lowSpeed(_)=false).		outputEntity(lowSpeed(_)=false).	        index(lowSpeed(Vessel)=false, Vessel).

simpleFluent(changingSpeed(_)=true).		outputEntity(changingSpeed(_)=true).		index(changingSpeed(Vessel)=true, Vessel).
simpleFluent(changingSpeed(_)=false).		outputEntity(changingSpeed(_)=false).		index(changingSpeed(Vessel)=false, Vessel).

simpleFluent(withinArea(_,_)=true).		outputEntity(withinArea(_,_)=true).		index(withinArea(Vessel,_)=true, Vessel).
simpleFluent(withinArea(_,_)=false).		outputEntity(withinArea(_,_)=false).		index(withinArea(Vessel,_)=false, Vessel).

simpleFluent(highSpeedNearCoast(_)=true).	outputEntity(highSpeedNearCoast(_)=true).	index(highSpeedNearCoast(Vessel)=true, Vessel).
simpleFluent(highSpeedNearCoast(_)=false).	outputEntity(highSpeedNearCoast(_)=false).	index(highSpeedNearCoast(Vessel)=false, Vessel).

simpleFluent(movingSpeed(_)=below).		outputEntity(movingSpeed(_)=below).		index(movingSpeed(Vessel)=_, Vessel).
simpleFluent(movingSpeed(_)=above).		outputEntity(movingSpeed(_)=above).		
simpleFluent(movingSpeed(_)=normal).		outputEntity(movingSpeed(_)=normal).		

simpleFluent(sarSpeed(_)=true).			outputEntity(sarSpeed(_)=true).			index(sarSpeed(Vessel)=true, Vessel).
simpleFluent(sarSpeed(_)=false).		outputEntity(sarSpeed(_)=false).		index(sarSpeed(Vessel)=false, Vessel).

simpleFluent(sarMovement(_)=true).		outputEntity(sarMovement(_)=true).		index(sarMovement(Vessel)=_, Vessel).
simpleFluent(sarMovement(_)=false).		outputEntity(sarMovement(_)=false).		

simpleFluent(drifting(_)=true).			outputEntity(drifting(_)=true).			index(drifting(Vessel)=true, Vessel).
simpleFluent(drifting(_)=false).		outputEntity(drifting(_)=false).		index(drifting(Vessel)=false, Vessel).

simpleFluent(tuggingSpeed(_)=true).		outputEntity(tuggingSpeed(_)=true).		index(tuggingSpeed(Vessel)=true, Vessel).
simpleFluent(tuggingSpeed(_)=false).		outputEntity(tuggingSpeed(_)=false).		index(tuggingSpeed(Vessel)=false, Vessel).

simpleFluent(trawlSpeed(_)=true).		outputEntity(trawlSpeed(_)=true).		index(trawlSpeed(Vessel)=true, Vessel).
simpleFluent(trawlSpeed(_)=false).		outputEntity(trawlSpeed(_)=false).		index(trawlSpeed(Vessel)=false, Vessel).

simpleFluent(trawlingMovement(_)=true).         outputEntity(trawlingMovement(_)=true).         index(trawlingMovement(Vessel)=_, Vessel).
simpleFluent(trawlingMovement(_)=false).        outputEntity(trawlingMovement(_)=false).        


sDFluent(underWay(_)=true).					outputEntity(underWay(_)=true).					index(underWay(Vessel)=true, Vessel).
sDFluent(inSAR(_)=true).					outputEntity(inSAR(_)=true).					index(inSAR(Vessel)=true, Vessel).
sDFluent(anchoredOrMoored(_)=true).			outputEntity(anchoredOrMoored(_)=true).	    	index(anchoredOrMoored(Vessel)=true, Vessel).
sDFluent(tugging(_,_)=true).				outputEntity(tugging(_,_)=true).				index(tugging(Vessel,_)=true, Vessel).
sDFluent(rendezVous(_,_)=true).				outputEntity(rendezVous(_,_)=true).				index(rendezVous(Vessel,_)=true, Vessel).
sDFluent(trawling(_)=true).					outputEntity(trawling(_)=true).					index(trawling(Vessel)=true, Vessel).
sDFluent(pilotOps(_,_)=true).				outputEntity(pilotOps(_,_)=true).				index(pilotOps(Vessel,_)=true, Vessel).
sDFluent(loitering(_)=true).				outputEntity(loitering(_)=true).				index(loitering(Vessel)=true, Vessel).

sDFluent(disappearedInArea(_,_)=true).		outputEntity(disappearedInArea(_,_)=true).		index(disappearedInArea(Vessel, _)=true, Vessel).

sDFluent(stoppedWithinArea(_,_)=true).		outputEntity(stoppedWithinArea(_,_)=true).		index(stoppedWithinArea(Vessel, _)=true, Vessel).

sDFluent(stoppedMeetsGap(_)=true).		outputEntity(stoppedMeetsGap(_)=true).		index(stoppedMeetsGap(Vessel)=true, Vessel).
sDFluent(dangerNearCoast(_)=true).		outputEntity(dangerNearCoast(_)=true).		index(dangerNearCoast(Vessel)=true, Vessel).
sDFluent(highSpeedNCBeforeDrifting(_)=true).		outputEntity(highSpeedNCBeforeDrifting(_)=true).		index(highSpeedNCBeforeDrifting(Vessel)=true, Vessel).
sDFluent(gainingSpeed(_)=true).		outputEntity(gainingSpeed(_)=true).		index(gainingSpeed(Vessel)=true, Vessel).
sDFluent(speedChangeAbove(_)=true).		outputEntity(speedChangeAbove(_)=true).		index(speedChangeAbove(Vessel)=true, Vessel).

sDFluent(movingSpeedStartsUnderway(_)=_).		outputEntity(movingSpeedStartsUnderway(_)=_).		index(movingSpeedStartsUnderway(Vessel)=_, Vessel).
sDFluent(movingSpeedFinishesUnderway(_)=_).		outputEntity(movingSpeedFinishesUnderway(_)=_).		index(movingSpeedFinishesUnderway(Vessel)=_, Vessel).
sDFluent(movingSpeedEqualUnderway(_)=_).		outputEntity(movingSpeedEqualUnderway(_)=_).		index(movingSpeedEqualUnderway(Vessel)=_, Vessel).

sDFluent(collisionDanger(_,_)=true).		outputEntity(collisionDanger(_,_)=true).		index(collisionDanger(Vessel, _)=true, Vessel).
sDFluent(suspiciousRendezVous(_,_)=true).	outputEntity(suspiciousRendezVous(_,_)=true).	index(suspiciousRendezVous(Vessel, _)=true, Vessel).
sDFluent(anchoredFarFromPorts(_)=true).	outputEntity(anchoredFarFromPorts(_)=true).	index(anchoredFarFromPorts(Vessel)=true, Vessel).
sDFluent(anchoredNearPorts(_)=true).	outputEntity(anchoredNearPorts(_)=true).	index(anchoredNearPorts(Vessel)=true, Vessel).

sDFluent(driftingWhileTugging(_,_)=true).	outputEntity(driftingWhileTugging(_,_)=true).	index(driftingWhileTugging(Vessel, _)=true, Vessel).

sDFluent(tuggingStartsProximity(_,_)=true).	outputEntity(tuggingStartsProximity(_,_)=true).	index(tuggingStartsProximity(Vessel, _)=true, Vessel).
sDFluent(tuggingFinishesProximity(_,_)=true).	outputEntity(tuggingFinishesProximity(_,_)=true).	index(tuggingFinishesProximity(Vessel, _)=true, Vessel).
sDFluent(tuggingEqualProximity(_,_)=true).	outputEntity(tuggingEqualProximity(_,_)=true).	index(tuggingEqualProximity(Vessel, _)=true, Vessel).
sDFluent(rendezVousStartsProximity(_,_)=true).	outputEntity(rendezVousStartsProximity(_,_)=true).	index(rendezVousStartsProximity(Vessel, _)=true, Vessel).
sDFluent(rendezVousFinishesProximity(_,_)=true).	outputEntity(rendezVousFinishesProximity(_,_)=true).	index(rendezVousFinishesProximity(Vessel, _)=true, Vessel).
sDFluent(rendezVousEqualProximity(_,_)=true).	outputEntity(rendezVousEqualProximity(_,_)=true).	index(rendezVousEqualProximity(Vessel, _)=true, Vessel).
sDFluent(pilotOpsStartsProximity(_,_)=true).	outputEntity(pilotOpsStartsProximity(_,_)=true).	index(pilotOpsStartsProximity(Vessel, _)=true, Vessel).
sDFluent(pilotOpsFinishesProximity(_,_)=true).	outputEntity(pilotOpsFinishesProximity(_,_)=true).	index(pilotOpsFinishesProximity(Vessel, _)=true, Vessel).
sDFluent(pilotOpsEqualProximity(_,_)=true).	outputEntity(pilotOpsEqualProximity(_,_)=true).	index(pilotOpsEqualProximity(Vessel, _)=true, Vessel).

sDFluent(fishingTripInArea(_)=true).				outputEntity(fishingTripInArea(_)=true).				index(fishingTripInArea(Vessel)=true, Vessel).
sDFluent(fishingTripTrawling(_)=true).				outputEntity(fishingTripTrawling(_)=true).				index(fishingTripTrawling(Vessel)=true, Vessel).

% For input entities expressed as statically determined fluents, state whether 
% the fluent instances will be reported as time-points (points/1) or intervals.
% By default, RTEC assumes that fluent instances are reported as intervals
% (in this case no declarations are necessary).
% This part of the declarations is used by the data loader.

% No points/1 declarations are necessary in this application.


% For input entities expressed as statically determined fluents, state whether 
% the list of intervals of the input entity will be constructed by 
% collecting individual intervals (collectIntervals/1), or built from 
% time-points (buildFromPoints/1). If no declarations are provided for some,
% input entity, then the input entity may not participate in the specification of 
% output entities.

collectIntervals(proximity(_,_)=true).



% Define the groundings of the fluents and output entities/events:

grounding(proximity(Vessel1, Vessel2)=true)                		:- vpair(Vessel1, Vessel2).
dgrounded(proximity(Vessel1, Vessel2)=true, vpair(Vessel1, Vessel2)).
dgrounded(proximity(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(proximity(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(gap(Vessel)=PortStatus)                         		:- vessel(Vessel), portStatus(PortStatus).
dgrounded(gap(Vessel)=_ , vessel(Vessel)).

grounding(stopped(Vessel)=PortStatus)                     		:- vessel(Vessel), portStatus(PortStatus).
dgrounded(stopped(Vessel)=_ , vessel(Vessel)).

grounding(potentialAground(Vessel)=nearPorts)                     	:- vessel(Vessel).
grounding(potentialAground(Vessel)=farFromPorts)                 	:- vessel(Vessel).
dgrounded(potentialAground(Vessel)=_ , vessel(Vessel)).

grounding(lowSpeed(Vessel)=true)                          		:- vessel(Vessel).
dgrounded(lowSpeed(Vessel)=true , vessel(Vessel)).

grounding(changingSpeed(Vessel)=true)                     		:- vessel(Vessel).
dgrounded(changingSpeed(Vessel)=true , vessel(Vessel)).

grounding(withinArea(Vessel, AreaType)=true)               		:- vessel(Vessel), areaType(AreaType).
dgrounded(withinArea(Vessel,_)=true , vessel(Vessel)).

grounding(underWay(Vessel)=true)                          		:- vessel(Vessel).
dgrounded(underWay(Vessel)=true , vessel(Vessel)).

grounding(sarSpeed(Vessel)=true)                          		:- vessel(Vessel), vesselType(Vessel,sar).
dgrounded(sarSpeed(Vessel)=true , vessel(Vessel)).

grounding(sarMovement(Vessel)=true)                         		:- vessel(Vessel), vesselType(Vessel,sar).
dgrounded(sarMovement(Vessel)=true , vessel(Vessel)).
grounding(sarMovement(Vessel)=false)                        		:- vessel(Vessel), vesselType(Vessel,sar).
dgrounded(sarMovement(Vessel)=false , vessel(Vessel)).
grounding(inSAR(Vessel)=true)                         			:- vessel(Vessel).
dgrounded(inSAR(Vessel)=true , vessel(Vessel)).



grounding(highSpeedNearCoast(Vessel)=true)                		:- vessel(Vessel).
dgrounded(highSpeedNearCoast(Vessel)=true , vessel(Vessel)).

grounding(drifting(Vessel)=true)                 		        :- vessel(Vessel).
dgrounded(drifting(Vessel)=true , vessel(Vessel)).

grounding(aground(Vessel)=PortStatus)                     		:- vessel(Vessel), portStatus(PortStatus).
dgrounded(aground(Vessel)=_PortStatus, vessel(Vessel)).

grounding(anchoredOrMoored(Vessel)=true)                  		:- vessel(Vessel).
dgrounded(anchoredOrMoored(Vessel)=true, vessel(Vessel)).

grounding(trawlSpeed(Vessel)=true)                        		:- vessel(Vessel), vesselType(Vessel,fishing).
dgrounded(trawlSpeed(Vessel)=true, vessel(Vessel)).

grounding(movingSpeed(Vessel)=Status)                       		:- vessel(Vessel), movingStatus(Status).
dgrounded(movingSpeed(Vessel)=below, vessel(Vessel)).
dgrounded(movingSpeed(Vessel)=above, vessel(Vessel)).
dgrounded(movingSpeed(Vessel)=normal, vessel(Vessel)).

grounding(pilotOps(Vessel1, Vessel2)=true)               		:- vpair(Vessel1, Vessel2).
dgrounded(pilotOps(Vessel1, Vessel2)=true, vpair(Vessel1, Vessel2)).
dgrounded(pilotOps(Vessel1,_)=true, vessel(Vessel1)).
dgrounded(pilotOps(_, Vessel2)=true, vessel(Vessel2)).

%======================================= experimental grounding start ===========================================
grounding(tuggingSpeed(Vessel)=true)                          	:- vessel(Vessel).
dgrounded(tuggingSpeed(Vessel)=true , vessel(Vessel)).

grounding(tugging(Vessel1, Vessel2)=true)                  		:- vpair(Vessel1, Vessel2).
dgrounded(tugging(Vessel1, Vessel2)=true, vpair(Vessel1, Vessel2)).
dgrounded(tugging(Vessel1,_)=true, vessel(Vessel1)).
dgrounded(tugging(_, Vessel2)=true, vessel(Vessel2)).

grounding(rendezVous(Vessel1, Vessel2)=true)               		:- vpair(Vessel1, Vessel2).
dgrounded(rendezVous(Vessel1, Vessel2)=true, vpair(Vessel1, Vessel2)).
dgrounded(rendezVous(Vessel1,_)=true, vessel(Vessel1)).
dgrounded(rendezVous(_, Vessel2)=true, vessel(Vessel2)).
%======================================= experimental grounding end ===========================================



grounding(trawlingMovement(Vessel)=true)		                :- vessel(Vessel), vesselType(Vessel,fishing).
dgrounded(trawlingMovement(Vessel)=true, vessel(Vessel)).

grounding(trawlingMovement(Vessel)=false)               	        :- vessel(Vessel), vesselType(Vessel,fishing).
dgrounded(trawlingMovement(Vessel)=false, vessel(Vessel)).

grounding(trawling(Vessel)=true)                          		:- vessel(Vessel).
dgrounded(trawling(Vessel)=true, vessel(Vessel)).

grounding(loitering(Vessel)=true) :- vessel(Vessel).
dgrounded(loitering(Vessel)=true, vessel(Vessel)).

grounding(disappearedInArea(Vessel, AreaType)=true) :- vessel(Vessel), areaType(AreaType).
dgrounded(disappearedInArea(Vessel, _AreaType)=true, vessel(Vessel)).

grounding(stoppedWithinArea(Vessel, AreaType)=true) :- vessel(Vessel), areaType(AreaType).
dgrounded(stoppedWithinArea(Vessel, _AreaType)=true, vessel(Vessel)).

grounding(stoppedMeetsGap(Vessel)=true) :- vessel(Vessel).
dgrounded(stoppedMeetsGap(Vessel)=true, vessel(Vessel)).

grounding(highSpeedNCBeforeDrifting(Vessel)=true) :- vessel(Vessel).
dgrounded(highSpeedNCBeforeDrifting(Vessel)=true, vessel(Vessel)).

grounding(dangerNearCoast(Vessel)=true) :- vessel(Vessel).
dgrounded(dangerNearCoast(Vessel)=true, vessel(Vessel)).

grounding(gainingSpeed(Vessel)=true) :- vessel(Vessel).
dgrounded(gainingSpeed(Vessel)=true, vessel(Vessel)).

grounding(speedChangeAbove(Vessel)=true) :- vessel(Vessel).
dgrounded(speedChangeAbove(Vessel)=true, vessel(Vessel)).

grounding(movingSpeedStartsUnderway(Vessel)=Status) :- vessel(Vessel), movingStatus(Status).
dgrounded(movingSpeedStartsUnderway(Vessel)=below, vessel(Vessel)).
dgrounded(movingSpeedStartsUnderway(Vessel)=above, vessel(Vessel)).
dgrounded(movingSpeedStartsUnderway(Vessel)=normal, vessel(Vessel)).

grounding(movingSpeedFinishesUnderway(Vessel)=Status) :- vessel(Vessel), movingStatus(Status).
dgrounded(movingSpeedFinishesUnderway(Vessel)=below, vessel(Vessel)).
dgrounded(movingSpeedFinishesUnderway(Vessel)=above, vessel(Vessel)).
dgrounded(movingSpeedFinishesUnderway(Vessel)=normal, vessel(Vessel)).

grounding(movingSpeedEqualUnderway(Vessel)=Status) :- vessel(Vessel), movingStatus(Status).
dgrounded(movingSpeedEqualUnderway(Vessel)=below, vessel(Vessel)).
dgrounded(movingSpeedEqualUnderway(Vessel)=normal, vessel(Vessel)).
dgrounded(movingSpeedEqualUnderway(Vessel)=above, vessel(Vessel)).

grounding(collisionDanger(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(collisionDanger(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(collisionDanger(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(collisionDanger(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(suspiciousRendezVous(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(suspiciousRendezVous(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(suspiciousRendezVous(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(suspiciousRendezVous(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(driftingWhileTugging(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(driftingWhileTugging(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(driftingWhileTugging(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(driftingWhileTugging(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(anchoredFarFromPorts(Vessel)=true) :- vessel(Vessel).
dgrounded(anchoredFarFromPorts(Vessel)=true, vessel(Vessel)).

grounding(anchoredNearPorts(Vessel)=true) :- vessel(Vessel).
dgrounded(anchoredNearPorts(Vessel)=true, vessel(Vessel)).

grounding(tuggingStartsProximity(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(tuggingStartsProximity(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(tuggingStartsProximity(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(tuggingStartsProximity(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(tuggingFinishesProximity(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(tuggingFinishesProximity(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(tuggingFinishesProximity(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(tuggingFinishesProximity(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(tuggingEqualProximity(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(tuggingEqualProximity(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(tuggingEqualProximity(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(tuggingEqualProximity(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(rendezVousStartsProximity(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(rendezVousStartsProximity(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(rendezVousStartsProximity(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(rendezVousStartsProximity(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(rendezVousFinishesProximity(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(rendezVousFinishesProximity(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(rendezVousFinishesProximity(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(rendezVousFinishesProximity(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(rendezVousEqualProximity(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(rendezVousEqualProximity(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(rendezVousEqualProximity(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(rendezVousEqualProximity(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(pilotOpsStartsProximity(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(pilotOpsStartsProximity(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(pilotOpsStartsProximity(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(pilotOpsStartsProximity(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(pilotOpsFinishesProximity(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(pilotOpsFinishesProximity(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(pilotOpsFinishesProximity(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(pilotOpsFinishesProximity(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(pilotOpsEqualProximity(Vessel1, Vessel2)=true) :- vpair(Vessel1, Vessel2).
dgrounded(pilotOpsEqualProximity(Vessel1, Vessel2)=true, vpair(Vessel1,Vessel2)).
dgrounded(pilotOpsEqualProximity(Vessel1, _Vessel2)=true, vessel(Vessel1)).
dgrounded(pilotOpsEqualProximity(_Vessel1, Vessel2)=true, vessel(Vessel2)).

grounding(fishingTripInArea(Vessel)=true) :- vessel(Vessel).
dgrounded(fishingTripInArea(Vessel)=true, vessel(Vessel)).

grounding(fishingTripTrawling(Vessel)=true) :- vessel(Vessel).
dgrounded(fishingTripTrawling(Vessel)=true, vessel(Vessel)).

collectGrounds([coord(Vessel,_,_), entersArea(Vessel,_), leavesArea(Vessel,_)], vessel(Vessel)).
collectGrounds([proximity(Vessel1, Vessel2)=true], vpair(Vessel1, Vessel2)).


% Declare the order of caching of output entities.

cachingOrder(withinArea(_,_)=true).
cachingOrder(gap(_)=nearPorts).
cachingOrder(gap(_)=farFromPorts).
cachingOrder(stopped(_)=nearPorts).
cachingOrder(stopped(_)=farFromPorts).
cachingOrder(lowSpeed(_)=true).
cachingOrder(changingSpeed(_)=true).
cachingOrder(movingSpeed(_)=below).
cachingOrder(movingSpeed(_)=above).
cachingOrder(movingSpeed(_)=normal).
cachingOrder(underWay(_)=true).
cachingOrder(highSpeedNearCoast(_)=true).
cachingOrder(drifting(_)=true).
cachingOrder(sarSpeed(_)=true).
cachingOrder(sarMovement(_)=true).
%cachingOrder(sarMovement(_)=false).
cachingOrder(inSAR(_)=true).
cachingOrder(anchoredOrMoored(_)=true).
cachingOrder(tuggingSpeed(_)=true).
cachingOrder(tugging(_,_)=true).
cachingOrder(rendezVous(_,_)=true).
cachingOrder(pilotOps(_,_)=true).
cachingOrder(trawlSpeed(_)=true).
cachingOrder(trawlingMovement(_)=true).
%cachingOrder(trawlingMovement(_)=false).
cachingOrder(trawling(_)=true).
cachingOrder(loitering(_)=true).

needsGrounding(_, _, _) :- fail.
buildFromPoints(_) :- fail.
