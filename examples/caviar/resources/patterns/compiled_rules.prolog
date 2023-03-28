:- dynamic id/1.

initiatedAt(person(_1910)=true, _1956, _1880, _1962) :-
     happensAtProcessedIE(_1910,start(walking(_1910)=true),_1880),_1956=<_1880,_1880<_1962,
     \+happensAtIE(disappear(_1910),_1880).

initiatedAt(person(_1910)=true, _1956, _1880, _1962) :-
     happensAtProcessedIE(_1910,start(running(_1910)=true),_1880),_1956=<_1880,_1880<_1962,
     \+happensAtIE(disappear(_1910),_1880).

initiatedAt(person(_1910)=true, _1956, _1880, _1962) :-
     happensAtProcessedIE(_1910,start(active(_1910)=true),_1880),_1956=<_1880,_1880<_1962,
     \+happensAtIE(disappear(_1910),_1880).

initiatedAt(person(_1910)=true, _1956, _1880, _1962) :-
     happensAtProcessedIE(_1910,start(abrupt(_1910)=true),_1880),_1956=<_1880,_1880<_1962,
     \+happensAtIE(disappear(_1910),_1880).

initiatedAt(person(_1910)=false, _1926, _1880, _1932) :-
     happensAtIE(disappear(_1910),_1880),
     _1926=<_1880,
     _1880<_1932.

initiatedAt(leaving_object(_1910,_1912)=true, _1998, _1880, _2004) :-
     happensAtIE(appear(_1912),_1880),_1998=<_1880,_1880<_2004,
     holdsAtProcessedIE(_1912,inactive(_1912)=true,_1880),
     holdsAtProcessedSimpleFluent(_1910,person(_1910)=true,_1880),
     holdsAtProcessedSDFluent(_1910,closeSymmetric(_1910,_1912,30)=true,_1880).

initiatedAt(leaving_object(_1910,_1912)=false, _1928, _1880, _1934) :-
     happensAtIE(disappear(_1912),_1880),
     _1928=<_1880,
     _1880<_1934.

initiatedAt(meeting(_1910,_1912)=true, _1980, _1880, _1986) :-
     happensAtProcessedSDFluent(_1910,start(greeting1(_1910,_1912)=true),_1880),_1980=<_1880,_1880<_1986,
     \+happensAtIE(disappear(_1910),_1880),
     \+happensAtIE(disappear(_1912),_1880).

initiatedAt(meeting(_1910,_1912)=true, _1980, _1880, _1986) :-
     happensAtProcessedSDFluent(_1910,start(greeting2(_1910,_1912)=true),_1880),_1980=<_1880,_1880<_1986,
     \+happensAtIE(disappear(_1910),_1880),
     \+happensAtIE(disappear(_1912),_1880).

initiatedAt(meeting(_1910,_1912)=false, _1938, _1880, _1944) :-
     happensAtProcessedIE(_1910,start(running(_1910)=true),_1880),
     _1938=<_1880,
     _1880<_1944.

initiatedAt(meeting(_1910,_1912)=false, _1938, _1880, _1944) :-
     happensAtProcessedIE(_1912,start(running(_1912)=true),_1880),
     _1938=<_1880,
     _1880<_1944.

initiatedAt(meeting(_1910,_1912)=false, _1938, _1880, _1944) :-
     happensAtProcessedIE(_1910,start(abrupt(_1910)=true),_1880),
     _1938=<_1880,
     _1880<_1944.

initiatedAt(meeting(_1910,_1912)=false, _1938, _1880, _1944) :-
     happensAtProcessedIE(_1912,start(abrupt(_1912)=true),_1880),
     _1938=<_1880,
     _1880<_1944.

initiatedAt(meeting(_1910,_1912)=false, _1942, _1880, _1948) :-
     happensAtProcessedSDFluent(_1910,start(close(_1910,_1912,34)=false),_1880),
     _1942=<_1880,
     _1880<_1948.

holdsForSDFluent(close(_1910,_1912,24)=true,_1880) :-
     holdsForProcessedIE(_1910,distance(_1910,_1912,24)=true,_1880).

holdsForSDFluent(close(_1910,_1912,25)=true,_1880) :-
     holdsForProcessedSDFluent(_1910,close(_1910,_1912,24)=true,_1934),
     holdsForProcessedIE(_1910,distance(_1910,_1912,25)=true,_1954),
     union_all([_1934,_1954],_1880).

holdsForSDFluent(close(_1910,_1912,30)=true,_1880) :-
     holdsForProcessedSDFluent(_1910,close(_1910,_1912,25)=true,_1934),
     holdsForProcessedIE(_1910,distance(_1910,_1912,30)=true,_1954),
     union_all([_1934,_1954],_1880).

holdsForSDFluent(close(_1910,_1912,34)=true,_1880) :-
     holdsForProcessedSDFluent(_1910,close(_1910,_1912,30)=true,_1934),
     holdsForProcessedIE(_1910,distance(_1910,_1912,34)=true,_1954),
     union_all([_1934,_1954],_1880).

holdsForSDFluent(close(_1910,_1912,24)=false,_1880) :-
     holdsForProcessedSDFluent(_1910,close(_1910,_1912,24)=true,_1934),
     complement_all([_1934],_1880).

holdsForSDFluent(closeSymmetric(_1910,_1912,24)=true,_1880) :-
     holdsForProcessedSDFluent(_1910,close(_1910,_1912,24)=true,_1934),
     holdsForProcessedSDFluent(_1912,close(_1912,_1910,24)=true,_1954),
     union_all([_1934,_1954],_1880).

holdsForSDFluent(greeting1(_1910,_1912)=true,_1880) :-
     holdsForProcessedSDFluent(_1910,activeOrInactivePerson(_1910)=true,_1928),
     \+_1928=[],
     holdsForProcessedSimpleFluent(_1912,person(_1912)=true,_1954),
     \+_1954=[],
     holdsForProcessedSDFluent(_1910,close(_1910,_1912,25)=true,_1984),
     \+_1984=[],
     intersect_all([_1928,_1984,_1954],_2018),
     \+_2018=[],
     !,
     holdsForProcessedIE(_1912,running(_1912)=true,_2044),
     holdsForProcessedIE(_1912,abrupt(_1912)=true,_2060),
     relative_complement_all(_2018,[_2044,_2060],_1880).

holdsForSDFluent(greeting1(_1904,_1906)=true,[]).

holdsForSDFluent(greeting2(_1910,_1912)=true,_1880) :-
     holdsForProcessedIE(_1910,walking(_1910)=true,_1928),
     \+_1928=[],
     holdsForProcessedSDFluent(_1912,activeOrInactivePerson(_1912)=true,_1954),
     \+_1954=[],
     holdsForProcessedSDFluent(_1912,close(_1912,_1910,25)=true,_1984),
     \+_1984=[],
     !,
     intersect_all([_1928,_1954,_1984],_1880).

holdsForSDFluent(greeting2(_1904,_1906)=true,[]).

holdsForSDFluent(activeOrInactivePerson(_1910)=true,_1880) :-
     holdsForProcessedIE(_1910,active(_1910)=true,_1926),
     holdsForProcessedIE(_1910,inactive(_1910)=true,_1942),
     holdsForProcessedSimpleFluent(_1910,person(_1910)=true,_1958),
     intersect_all([_1942,_1958],_1976),
     union_all([_1926,_1976],_1880).

holdsForSDFluent(moving(_1910,_1912)=true,_1880) :-
     holdsForProcessedIE(_1910,walking(_1910)=true,_1928),
     holdsForProcessedIE(_1912,walking(_1912)=true,_1944),
     intersect_all([_1928,_1944],_1962),
     \+_1962=[],
     holdsForProcessedSDFluent(_1910,close(_1910,_1912,34)=true,_1992),
     \+_1992=[],
     !,
     intersect_all([_1962,_1992],_1880).

holdsForSDFluent(moving(_1904,_1906)=true,[]).

holdsForSDFluent(fighting(_1910,_1912)=true,_1880) :-
     holdsForProcessedIE(_1910,abrupt(_1910)=true,_1928),
     holdsForProcessedIE(_1912,abrupt(_1912)=true,_1944),
     union_all([_1928,_1944],_1962),
     \+_1962=[],
     holdsForProcessedSDFluent(_1910,close(_1910,_1912,24)=true,_1992),
     \+_1992=[],
     intersect_all([_1962,_1992],_2020),
     \+_2020=[],
     !,
     holdsForProcessedIE(_1910,inactive(_1910)=true,_2046),
     holdsForProcessedIE(_1912,inactive(_1912)=true,_2062),
     union_all([_2046,_2062],_2080),
     relative_complement_all(_2020,[_2080],_1880).

holdsForSDFluent(fighting(_1904,_1906)=true,[]).

buildFromPoints2(_1884, walking(_1884)=true) :-
     id(_1884).

buildFromPoints2(_1884, walking(_1884)=true) :-
     id(_1884).

buildFromPoints2(_1884, active(_1884)=true) :-
     id(_1884).

buildFromPoints2(_1884, active(_1884)=true) :-
     id(_1884).

buildFromPoints2(_1884, inactive(_1884)=true) :-
     id(_1884).

buildFromPoints2(_1884, inactive(_1884)=true) :-
     id(_1884).

buildFromPoints2(_1884, running(_1884)=true) :-
     id(_1884).

buildFromPoints2(_1884, running(_1884)=true) :-
     id(_1884).

buildFromPoints2(_1884, abrupt(_1884)=true) :-
     id(_1884).

buildFromPoints2(_1884, abrupt(_1884)=true) :-
     id(_1884).

points(orientation(_2178)=_2174).

points(appearance(_2178)=_2174).

points(coord(_2178,_2180,_2182)=true).

points(walking(_2178)=true).

points(active(_2178)=true).

points(inactive(_2178)=true).

points(running(_2178)=true).

points(abrupt(_2178)=true).

grounding(appear(_2178)) :- 
     id(_2178).

grounding(disappear(_2178)) :- 
     id(_2178).

grounding(orientation(_2184)=_2180) :- 
     id(_2184).

grounding(appearance(_2184)=_2180) :- 
     id(_2184).

grounding(coord(_2184,_2186,_2188)=_2180) :- 
     id(_2184).

grounding(walking(_2184)=_2180) :- 
     id(_2184).

grounding(active(_2184)=_2180) :- 
     id(_2184).

grounding(inactive(_2184)=_2180) :- 
     id(_2184).

grounding(running(_2184)=_2180) :- 
     id(_2184).

grounding(abrupt(_2184)=_2180) :- 
     id(_2184).

grounding(close(_2184,_2186,24)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(close(_2184,_2186,25)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(close(_2184,_2186,30)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(close(_2184,_2186,34)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(close(_2184,_2186,34)=false) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(closeSymmetric(_2184,_2186,30)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(walking(_2184)=true) :- 
     id(_2184).

grounding(active(_2184)=true) :- 
     id(_2184).

grounding(inactive(_2184)=true) :- 
     id(_2184).

grounding(abrupt(_2184)=true) :- 
     id(_2184).

grounding(running(_2184)=true) :- 
     id(_2184).

grounding(person(_2184)=true) :- 
     id(_2184).

grounding(activeOrInactivePerson(_2184)=true) :- 
     id(_2184).

grounding(greeting1(_2184,_2186)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(greeting2(_2184,_2186)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(leaving_object(_2184,_2186)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(meeting(_2184,_2186)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(moving(_2184,_2186)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

grounding(fighting(_2184,_2186)=true) :- 
     id(_2184),id(_2186),_2184@<_2186.

inputEntity(walking(_1940)=true).
inputEntity(disappear(_1934)).
inputEntity(running(_1940)=true).
inputEntity(active(_1940)=true).
inputEntity(abrupt(_1940)=true).
inputEntity(appear(_1934)).
inputEntity(inactive(_1940)=true).
inputEntity(distance(_1940,_1942,24)=true).
inputEntity(distance(_1940,_1942,25)=true).
inputEntity(distance(_1940,_1942,30)=true).
inputEntity(distance(_1940,_1942,34)=true).
inputEntity(orientation(_1940)=_1936).
inputEntity(appearance(_1940)=_1936).
inputEntity(coord(_1940,_1942,_1944)=_1936).

outputEntity(person(_2080)=true).
outputEntity(person(_2080)=false).
outputEntity(leaving_object(_2080,_2082)=true).
outputEntity(leaving_object(_2080,_2082)=false).
outputEntity(meeting(_2080,_2082)=true).
outputEntity(meeting(_2080,_2082)=false).
outputEntity(close(_2080,_2082,24)=true).
outputEntity(close(_2080,_2082,25)=true).
outputEntity(close(_2080,_2082,30)=true).
outputEntity(close(_2080,_2082,34)=true).
outputEntity(close(_2080,_2082,_2084)=false).
outputEntity(closeSymmetric(_2080,_2082,_2084)=true).
outputEntity(greeting1(_2080,_2082)=true).
outputEntity(greeting2(_2080,_2082)=true).
outputEntity(activeOrInactivePerson(_2080)=true).
outputEntity(moving(_2080,_2082)=true).
outputEntity(fighting(_2080,_2082)=true).

event(disappear(_2232)).
event(appear(_2232)).

simpleFluent(person(_2306)=true).
simpleFluent(person(_2306)=false).
simpleFluent(leaving_object(_2306,_2308)=true).
simpleFluent(leaving_object(_2306,_2308)=false).
simpleFluent(meeting(_2306,_2308)=true).
simpleFluent(meeting(_2306,_2308)=false).

sDFluent(close(_2398,_2400,24)=true).
sDFluent(close(_2398,_2400,25)=true).
sDFluent(close(_2398,_2400,30)=true).
sDFluent(close(_2398,_2400,34)=true).
sDFluent(close(_2398,_2400,_2402)=false).
sDFluent(closeSymmetric(_2398,_2400,_2402)=true).
sDFluent(greeting1(_2398,_2400)=true).
sDFluent(greeting2(_2398,_2400)=true).
sDFluent(activeOrInactivePerson(_2398)=true).
sDFluent(moving(_2398,_2400)=true).
sDFluent(fighting(_2398,_2400)=true).
sDFluent(walking(_2398)=true).
sDFluent(running(_2398)=true).
sDFluent(active(_2398)=true).
sDFluent(abrupt(_2398)=true).
sDFluent(inactive(_2398)=true).
sDFluent(distance(_2398,_2400,24)=true).
sDFluent(distance(_2398,_2400,25)=true).
sDFluent(distance(_2398,_2400,30)=true).
sDFluent(distance(_2398,_2400,34)=true).
sDFluent(orientation(_2398)=_2394).
sDFluent(appearance(_2398)=_2394).
sDFluent(coord(_2398,_2400,_2402)=_2394).

index(disappear(_2538),_2538).
index(appear(_2538),_2538).
index(person(_2538)=true,_2538).
index(person(_2538)=false,_2538).
index(leaving_object(_2538,_2598)=true,_2538).
index(leaving_object(_2538,_2598)=false,_2538).
index(meeting(_2538,_2598)=true,_2538).
index(meeting(_2538,_2598)=false,_2538).
index(close(_2538,_2598,24)=true,_2538).
index(close(_2538,_2598,25)=true,_2538).
index(close(_2538,_2598,30)=true,_2538).
index(close(_2538,_2598,34)=true,_2538).
index(close(_2538,_2598,_2600)=false,_2538).
index(closeSymmetric(_2538,_2598,_2600)=true,_2538).
index(greeting1(_2538,_2598)=true,_2538).
index(greeting2(_2538,_2598)=true,_2538).
index(activeOrInactivePerson(_2538)=true,_2538).
index(moving(_2538,_2598)=true,_2538).
index(fighting(_2538,_2598)=true,_2538).
index(walking(_2538)=true,_2538).
index(running(_2538)=true,_2538).
index(active(_2538)=true,_2538).
index(abrupt(_2538)=true,_2538).
index(inactive(_2538)=true,_2538).
index(distance(_2538,_2598,24)=true,_2538).
index(distance(_2538,_2598,25)=true,_2538).
index(distance(_2538,_2598,30)=true,_2538).
index(distance(_2538,_2598,34)=true,_2538).
index(orientation(_2538)=_2592,_2538).
index(appearance(_2538)=_2592,_2538).
index(coord(_2538,_2598,_2600)=_2592,_2538).


cachingOrder2(_3006, person(_3006)=true) :- % level: 1
     id(_3006).

cachingOrder2(_2952, close(_2952,_2954,24)=true) :- % level: 1
     id(_2952),id(_2954),_2952@<_2954.

cachingOrder2(_3932, close(_3932,_3934,25)=true) :- % level: 2
     id(_3932),id(_3934),_3932@<_3934.

cachingOrder2(_3912, close(_3912,_3914,34)=false) :- % level: 2
     id(_3912),id(_3914),_3912@<_3914.

cachingOrder2(_3892, closeSymmetric(_3892,_3894,30)=true) :- % level: 2
     id(_3892),id(_3894),_3892@<_3894.

cachingOrder2(_3876, activeOrInactivePerson(_3876)=true) :- % level: 2
     id(_3876).

cachingOrder2(_3858, fighting(_3858,_3860)=true) :- % level: 2
     id(_3858),id(_3860),_3858@<_3860.

cachingOrder2(_5070, close(_5070,_5072,30)=true) :- % level: 3
     id(_5070),id(_5072),_5070@<_5072.

cachingOrder2(_5052, greeting1(_5052,_5054)=true) :- % level: 3
     id(_5052),id(_5054),_5052@<_5054.

cachingOrder2(_5034, greeting2(_5034,_5036)=true) :- % level: 3
     id(_5034),id(_5036),_5034@<_5036.

cachingOrder2(_5778, meeting(_5778,_5780)=true) :- % level: 4
     id(_5778),id(_5780),_5778@<_5780.

cachingOrder2(_5758, close(_5758,_5760,34)=true) :- % level: 4
     id(_5758),id(_5760),_5758@<_5760.

cachingOrder2(_6276, leaving_object(_6276,_6278)=true) :- % level: 5
     id(_6276),id(_6278),_6276@<_6278.

cachingOrder2(_6258, moving(_6258,_6260)=true) :- % level: 5
     id(_6258),id(_6260),_6258@<_6260.

collectGrounds([walking(_2538)=true, walking(_2538)=true, disappear(_2538), running(_2538)=true, running(_2538)=true, active(_2538)=true, active(_2538)=true, abrupt(_2538)=true, abrupt(_2538)=true, appear(_2538), inactive(_2538)=true, inactive(_2538)=true, orientation(_2538)=_2552, appearance(_2538)=_2552, coord(_2538,_2558,_2560)=_2552],id(_2538)).

dgrounded(person(_3344)=true, id(_3344)).
dgrounded(leaving_object(_3288,_3290)=true, id(_3288)).
dgrounded(leaving_object(_3288,_3290)=true, id(_3290)).
dgrounded(meeting(_3232,_3234)=true, id(_3232)).
dgrounded(meeting(_3232,_3234)=true, id(_3234)).
dgrounded(close(_3174,_3176,24)=true, id(_3174)).
dgrounded(close(_3174,_3176,24)=true, id(_3176)).
dgrounded(close(_3116,_3118,25)=true, id(_3116)).
dgrounded(close(_3116,_3118,25)=true, id(_3118)).
dgrounded(close(_3058,_3060,30)=true, id(_3058)).
dgrounded(close(_3058,_3060,30)=true, id(_3060)).
dgrounded(close(_3000,_3002,34)=true, id(_3000)).
dgrounded(close(_3000,_3002,34)=true, id(_3002)).
dgrounded(close(_2942,_2944,34)=false, id(_2942)).
dgrounded(close(_2942,_2944,34)=false, id(_2944)).
dgrounded(closeSymmetric(_2884,_2886,30)=true, id(_2884)).
dgrounded(closeSymmetric(_2884,_2886,30)=true, id(_2886)).
dgrounded(greeting1(_2828,_2830)=true, id(_2828)).
dgrounded(greeting1(_2828,_2830)=true, id(_2830)).
dgrounded(greeting2(_2772,_2774)=true, id(_2772)).
dgrounded(greeting2(_2772,_2774)=true, id(_2774)).
dgrounded(activeOrInactivePerson(_2740)=true, id(_2740)).
dgrounded(moving(_2684,_2686)=true, id(_2684)).
dgrounded(moving(_2684,_2686)=true, id(_2686)).
dgrounded(fighting(_2628,_2630)=true, id(_2628)).
dgrounded(fighting(_2628,_2630)=true, id(_2630)).
