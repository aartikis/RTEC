%----------------------------------------------%
%   Author Manos Pitsikalis                    %
%   Pattern thresholds for the Brest dataset   %
%----------------------------------------------%

% high speed near coast
thresholds(hcNearCoastMax,5.0).

% underWay
thresholds(underWayMin,2.7).
thresholds(underWayMax,48.6).

% on route
thresholds(onRouteDist,0.5).

%incompatible speed with user defined thr
thresholds(incomMin,3).
thresholds(incomMax,12).

%adrift
thresholds(adriftAngThr,40.0).

%aground
thresholds(agroundMinDiff,0.2).
thresholds(agroundTime,3600).

%atAnchorOrMoored
thresholds(aOrMTime,1800).

%trawlspeed
thresholds(trawlspeedMin,1.0).
thresholds(trawlspeedMax,9.0).

%trawlingCourse
thresholds(trawlingCrs,1800).

%tugging
thresholds(tugSearchWin,600).
thresholds(tugMinSpeed,1.2).
thresholds(tugSpeedDiffMax,3.0).
thresholds(tugAngleDiffMax,60.0).

thresholds(tuggingMin,1.2).
thresholds(tuggingMax,15.0).
thresholds(tuggingTime,300).


%moving
thresholds(movingMin,0.5).
thresholds(movingMax,48.6).

%rendezvous
thresholds(rendezvousTime,240).

%SAR
thresholds(sarMinSpeed,2.7).
%thresholds(sarMaxSpeed,_).


%trawling
%thresholds(trawlingTime,T):-thresholds(trawlingCrs,T1),T is T1+300.
thresholds(trawlingTime,3600).

%maa
thresholds(maaTime,600).

%loitering
thresholds(loiteringTime,1800).
