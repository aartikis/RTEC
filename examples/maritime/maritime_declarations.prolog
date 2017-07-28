event(coord(_,_,_)).	inputEntity(coord(_,_,_)).	index(coord(Vessel,_,_), Vessel).
event(gap_start(_)).	inputEntity(gap_start(_)).	index(gap_start(Vessel), Vessel).
event(isInArea(_,_)).	inputEntity(isInArea(_,_)).	index(isInArea(Vessel,_), Vessel).
event(leavesArea(_,_)).	inputEntity(leavesArea(_,_)).	index(leavesArea(Vessel,_), Vessel).
event(slow_motion_end(_)).	inputEntity(slow_motion_end(_)).	index(slow_motion_end(Vessel), Vessel).
event(slow_motion_start(_)).	inputEntity(slow_motion_start(_)).	index(slow_motion_start(Vessel), Vessel).
event(stop_end(_)).	inputEntity(stop_end(_)).	index(stop_end(Vessel), Vessel).
event(stop_start(_)).	inputEntity(stop_start(_)).	index(stop_start(Vessel), Vessel).
event(velocity(_,_,_)).	inputEntity(velocity(_,_,_)).	index(velocity(Vessel,_,_), Vessel).

sDFluent(proximity(_,_)=true).	inputEntity(proximity(_,_)=true).	index(proximity(Vessel1,_)=true, Vessel1).


simpleFluent(highSpeedIn(_,_)=true).	outputEntity(highSpeedIn(_,_)=true).	index(highSpeedIn(Vessel,_)=true, Vessel).
simpleFluent(lowSpeed(_)=true).	outputEntity(lowSpeed(_)=true).	index(lowSpeed(Vessel)=true, Vessel).
simpleFluent(sailing(_)=true).	outputEntity(sailing(_)=true).	index(sailing(Vessel)=true, Vessel).
simpleFluent(stopped(_)=true).	outputEntity(stopped(_)=true).	index(stopped(Vessel)=true, Vessel).
simpleFluent(withinArea(_,_)=true).	outputEntity(withinArea(_,_)=true).	index(withinArea(Vessel,_)=true, Vessel).

sDFluent(loitering(_)=true).	outputEntity(loitering(_)=true).	index(loitering(Vessel)=true, Vessel).
sDFluent(rendezVouz(_,_)=true).	outputEntity(rendezVouz(_,_)=true).	index(rendezVouz(Vessel1,_)=true, Vessel1).

cachingOrder(highSpeedIn(_,_)=true).	%1
cachingOrder(sailing(_)=true).	%1
cachingOrder(stopped(_)=true).	%1
cachingOrder(withinArea(_,_)=true).	%1
cachingOrder(lowSpeed(_)=true).	%2
cachingOrder(loitering(_)=true).	%3
cachingOrder(rendezVouz(_,_)=true).	%3
