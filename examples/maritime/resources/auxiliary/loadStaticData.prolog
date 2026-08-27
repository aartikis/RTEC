:- multifile bigAreaType/2.

%Port reasoning
:-['./portRelatedData/portStatuses.prolog'].

%Area ids and types
:-['./areaIDs/anchorage_big_areas.prolog'].
:-['./areaIDs/fishing_big_areas.prolog'].
:-['./areaIDs/natura_big_areas.prolog'].
:-['./areaIDs/nearCoast_big_areas.prolog'].
:-['./areaIDs/nearCoast5k_big_areas.prolog'].
:-['./areaIDs/nearPorts_big_areas.prolog'].
:-['./areaIDs/areaTypes.prolog'].

%Vessel information
:-['./vesselInformation/vesselStaticInfo.prolog'].
:-['./vesselInformation/typeSpeeds.prolog'].
% Asserting all vessels before execution is not required, because we use dynamic grounding.
%:-['./vesselInformation/vessels.prolog'].
%:-['./vesselInformation/vesselPairs.prolog'].

%Patterns parameters
:-['./patternsParameters/thresholds.prolog'].
:-['./patternsParameters/movingStatus.prolog'].

%Static data predicates
:-['./staticDataPredicates.prolog'].
