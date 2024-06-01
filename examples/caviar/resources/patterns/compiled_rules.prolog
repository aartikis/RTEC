:- dynamic id/1.

initiatedAt(person(_1882)=true, _1928, _1852, _1934) :-
     happensAtProcessedIE(_1882,start(walking(_1882)=true),_1852),_1928=<_1852,_1852<_1934,
     \+happensAtIE(disappear(_1882),_1852).

initiatedAt(person(_1882)=true, _1928, _1852, _1934) :-
     happensAtProcessedIE(_1882,start(running(_1882)=true),_1852),_1928=<_1852,_1852<_1934,
     \+happensAtIE(disappear(_1882),_1852).

initiatedAt(person(_1882)=true, _1928, _1852, _1934) :-
     happensAtProcessedIE(_1882,start(active(_1882)=true),_1852),_1928=<_1852,_1852<_1934,
     \+happensAtIE(disappear(_1882),_1852).

initiatedAt(person(_1882)=true, _1928, _1852, _1934) :-
     happensAtProcessedIE(_1882,start(abrupt(_1882)=true),_1852),_1928=<_1852,_1852<_1934,
     \+happensAtIE(disappear(_1882),_1852).

initiatedAt(person(_1882)=false, _1898, _1852, _1904) :-
     happensAtIE(disappear(_1882),_1852),
     _1898=<_1852,
     _1852<_1904.

initiatedAt(leaving_object(_1882,_1884)=true, _1970, _1852, _1976) :-
     happensAtIE(appear(_1884),_1852),_1970=<_1852,_1852<_1976,
     holdsAtProcessedIE(_1884,inactive(_1884)=true,_1852),
     holdsAtProcessedSimpleFluent(_1882,person(_1882)=true,_1852),
     holdsAtProcessedSDFluent(_1882,closeSymmetric(_1882,_1884,30)=true,_1852).

initiatedAt(leaving_object(_1882,_1884)=false, _1900, _1852, _1906) :-
     happensAtIE(disappear(_1884),_1852),
     _1900=<_1852,
     _1852<_1906.

initiatedAt(meeting(_1882,_1884)=true, _1952, _1852, _1958) :-
     happensAtProcessedSDFluent(_1882,start(greeting1(_1882,_1884)=true),_1852),_1952=<_1852,_1852<_1958,
     \+happensAtIE(disappear(_1882),_1852),
     \+happensAtIE(disappear(_1884),_1852).

initiatedAt(meeting(_1882,_1884)=true, _1952, _1852, _1958) :-
     happensAtProcessedSDFluent(_1882,start(greeting2(_1882,_1884)=true),_1852),_1952=<_1852,_1852<_1958,
     \+happensAtIE(disappear(_1882),_1852),
     \+happensAtIE(disappear(_1884),_1852).

initiatedAt(meeting(_1882,_1884)=false, _1910, _1852, _1916) :-
     happensAtProcessedIE(_1882,start(running(_1882)=true),_1852),
     _1910=<_1852,
     _1852<_1916.

initiatedAt(meeting(_1882,_1884)=false, _1910, _1852, _1916) :-
     happensAtProcessedIE(_1884,start(running(_1884)=true),_1852),
     _1910=<_1852,
     _1852<_1916.

initiatedAt(meeting(_1882,_1884)=false, _1910, _1852, _1916) :-
     happensAtProcessedIE(_1882,start(abrupt(_1882)=true),_1852),
     _1910=<_1852,
     _1852<_1916.

initiatedAt(meeting(_1882,_1884)=false, _1910, _1852, _1916) :-
     happensAtProcessedIE(_1884,start(abrupt(_1884)=true),_1852),
     _1910=<_1852,
     _1852<_1916.

initiatedAt(meeting(_1882,_1884)=false, _1914, _1852, _1920) :-
     happensAtProcessedSDFluent(_1882,start(close(_1882,_1884,34)=false),_1852),
     _1914=<_1852,
     _1852<_1920.

initiatedAt(meeting(_1882,_1884)=false, _1900, _1852, _1906) :-
     happensAtIE(disappear(_1882),_1852),
     _1900=<_1852,
     _1852<_1906.

initiatedAt(meeting(_1882,_1884)=false, _1900, _1852, _1906) :-
     happensAtIE(disappear(_1884),_1852),
     _1900=<_1852,
     _1852<_1906.

holdsForSDFluent(close(_1882,_1884,24)=true,_1852) :-
     holdsForProcessedIE(_1882,distance(_1882,_1884,24)=true,_1852).

holdsForSDFluent(close(_1882,_1884,25)=true,_1852) :-
     holdsForProcessedSDFluent(_1882,close(_1882,_1884,24)=true,_1906),
     holdsForProcessedIE(_1882,distance(_1882,_1884,25)=true,_1926),
     union_all([_1906,_1926],_1852).

holdsForSDFluent(close(_1882,_1884,30)=true,_1852) :-
     holdsForProcessedSDFluent(_1882,close(_1882,_1884,25)=true,_1906),
     holdsForProcessedIE(_1882,distance(_1882,_1884,30)=true,_1926),
     union_all([_1906,_1926],_1852).

holdsForSDFluent(close(_1882,_1884,34)=true,_1852) :-
     holdsForProcessedSDFluent(_1882,close(_1882,_1884,30)=true,_1906),
     holdsForProcessedIE(_1882,distance(_1882,_1884,34)=true,_1926),
     union_all([_1906,_1926],_1852).

holdsForSDFluent(close(_1882,_1884,_1886)=false,_1852) :-
     holdsForProcessedSDFluent(_1882,close(_1882,_1884,_1886)=true,_1906),
     complement_all([_1906],_1852).

holdsForSDFluent(closeSymmetric(_1882,_1884,_1886)=true,_1852) :-
     holdsForProcessedSDFluent(_1882,close(_1882,_1884,_1886)=true,_1906),
     holdsForProcessedSDFluent(_1884,close(_1884,_1882,_1886)=true,_1926),
     union_all([_1906,_1926],_1852).

holdsForSDFluent(greeting1(_1882,_1884)=true,_1852) :-
     holdsForProcessedSDFluent(_1882,activeOrInactivePerson(_1882)=true,_1900),
     \+_1900=[],
     holdsForProcessedSimpleFluent(_1884,person(_1884)=true,_1926),
     \+_1926=[],
     holdsForProcessedSDFluent(_1882,close(_1882,_1884,25)=true,_1956),
     \+_1956=[],
     intersect_all([_1900,_1956,_1926],_1990),
     \+_1990=[],
     !,
     holdsForProcessedIE(_1884,running(_1884)=true,_2016),
     holdsForProcessedIE(_1884,abrupt(_1884)=true,_2032),
     relative_complement_all(_1990,[_2016,_2032],_1852).

holdsForSDFluent(greeting1(_1876,_1878)=true,[]).

holdsForSDFluent(greeting2(_1882,_1884)=true,_1852) :-
     holdsForProcessedIE(_1882,walking(_1882)=true,_1900),
     \+_1900=[],
     holdsForProcessedSDFluent(_1884,activeOrInactivePerson(_1884)=true,_1926),
     \+_1926=[],
     holdsForProcessedSDFluent(_1884,close(_1884,_1882,25)=true,_1956),
     \+_1956=[],
     !,
     intersect_all([_1900,_1926,_1956],_1852).

holdsForSDFluent(greeting2(_1876,_1878)=true,[]).

holdsForSDFluent(activeOrInactivePerson(_1882)=true,_1852) :-
     holdsForProcessedIE(_1882,active(_1882)=true,_1898),
     holdsForProcessedIE(_1882,inactive(_1882)=true,_1914),
     holdsForProcessedSimpleFluent(_1882,person(_1882)=true,_1930),
     intersect_all([_1914,_1930],_1948),
     union_all([_1898,_1948],_1852).

holdsForSDFluent(moving(_1882,_1884)=true,_1852) :-
     holdsForProcessedIE(_1882,walking(_1882)=true,_1900),
     holdsForProcessedIE(_1884,walking(_1884)=true,_1916),
     intersect_all([_1900,_1916],_1934),
     \+_1934=[],
     holdsForProcessedSDFluent(_1882,close(_1882,_1884,34)=true,_1964),
     \+_1964=[],
     !,
     intersect_all([_1934,_1964],_1852).

holdsForSDFluent(moving(_1876,_1878)=true,[]).

holdsForSDFluent(fighting(_1882,_1884)=true,_1852) :-
     holdsForProcessedIE(_1882,abrupt(_1882)=true,_1900),
     holdsForProcessedIE(_1884,abrupt(_1884)=true,_1916),
     union_all([_1900,_1916],_1934),
     \+_1934=[],
     holdsForProcessedSDFluent(_1882,close(_1882,_1884,24)=true,_1964),
     \+_1964=[],
     intersect_all([_1934,_1964],_1992),
     \+_1992=[],
     !,
     holdsForProcessedIE(_1882,inactive(_1882)=true,_2018),
     holdsForProcessedIE(_1884,inactive(_1884)=true,_2034),
     union_all([_2018,_2034],_2052),
     relative_complement_all(_1992,[_2052],_1852).

holdsForSDFluent(fighting(_1876,_1878)=true,[]).

buildFromPoints2(_1856, walking(_1856)=true) :-
     id(_1856).

buildFromPoints2(_1856, active(_1856)=true) :-
     id(_1856).

buildFromPoints2(_1856, inactive(_1856)=true) :-
     id(_1856).

buildFromPoints2(_1856, running(_1856)=true) :-
     id(_1856).

buildFromPoints2(_1856, abrupt(_1856)=true) :-
     id(_1856).

points(orientation(_2150)=_2146).

points(appearance(_2150)=_2146).

points(coord(_2150,_2152,_2154)=true).

points(walking(_2150)=true).

points(active(_2150)=true).

points(inactive(_2150)=true).

points(running(_2150)=true).

points(abrupt(_2150)=true).

grounding(appear(_2150)) :- 
     id(_2150).

grounding(disappear(_2150)) :- 
     id(_2150).

grounding(orientation(_2156)=_2152) :- 
     id(_2156).

grounding(appearance(_2156)=_2152) :- 
     id(_2156).

grounding(coord(_2156,_2158,_2160)=_2152) :- 
     id(_2156).

grounding(walking(_2156)=_2152) :- 
     id(_2156).

grounding(active(_2156)=_2152) :- 
     id(_2156).

grounding(inactive(_2156)=_2152) :- 
     id(_2156).

grounding(running(_2156)=_2152) :- 
     id(_2156).

grounding(abrupt(_2156)=_2152) :- 
     id(_2156).

grounding(close(_2156,_2158,24)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(close(_2156,_2158,25)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(close(_2156,_2158,30)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(close(_2156,_2158,34)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(close(_2156,_2158,34)=false) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(closeSymmetric(_2156,_2158,30)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(walking(_2156)=true) :- 
     id(_2156).

grounding(active(_2156)=true) :- 
     id(_2156).

grounding(inactive(_2156)=true) :- 
     id(_2156).

grounding(abrupt(_2156)=true) :- 
     id(_2156).

grounding(running(_2156)=true) :- 
     id(_2156).

grounding(person(_2156)=true) :- 
     id(_2156).

grounding(activeOrInactivePerson(_2156)=true) :- 
     id(_2156).

grounding(greeting1(_2156,_2158)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(greeting2(_2156,_2158)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(leaving_object(_2156,_2158)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(meeting(_2156,_2158)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(moving(_2156,_2158)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

grounding(fighting(_2156,_2158)=true) :- 
     id(_2156),id(_2158),_2156@<_2158.

inputEntity(walking(_1918)=true).
inputEntity(disappear(_1912)).
inputEntity(running(_1918)=true).
inputEntity(active(_1918)=true).
inputEntity(abrupt(_1918)=true).
inputEntity(appear(_1912)).
inputEntity(inactive(_1918)=true).
inputEntity(distance(_1918,_1920,_1922)=true).
inputEntity(orientation(_1918)=_1914).
inputEntity(appearance(_1918)=_1914).
inputEntity(coord(_1918,_1920,_1922)=_1914).

outputEntity(person(_2046)=true).
outputEntity(person(_2046)=false).
outputEntity(leaving_object(_2046,_2048)=true).
outputEntity(leaving_object(_2046,_2048)=false).
outputEntity(meeting(_2046,_2048)=true).
outputEntity(meeting(_2046,_2048)=false).
outputEntity(close(_2046,_2048,_2050)=true).
outputEntity(close(_2046,_2048,_2050)=false).
outputEntity(closeSymmetric(_2046,_2048,_2050)=true).
outputEntity(greeting1(_2046,_2048)=true).
outputEntity(greeting2(_2046,_2048)=true).
outputEntity(activeOrInactivePerson(_2046)=true).
outputEntity(moving(_2046,_2048)=true).
outputEntity(fighting(_2046,_2048)=true).

event(disappear(_2186)).
event(appear(_2186)).

simpleFluent(person(_2266)=true).
simpleFluent(person(_2266)=false).
simpleFluent(leaving_object(_2266,_2268)=true).
simpleFluent(leaving_object(_2266,_2268)=false).
simpleFluent(meeting(_2266,_2268)=true).
simpleFluent(meeting(_2266,_2268)=false).

sDFluent(close(_2364,_2366,_2368)=true).
sDFluent(close(_2364,_2366,_2368)=false).
sDFluent(closeSymmetric(_2364,_2366,_2368)=true).
sDFluent(greeting1(_2364,_2366)=true).
sDFluent(greeting2(_2364,_2366)=true).
sDFluent(activeOrInactivePerson(_2364)=true).
sDFluent(moving(_2364,_2366)=true).
sDFluent(fighting(_2364,_2366)=true).
sDFluent(walking(_2364)=true).
sDFluent(running(_2364)=true).
sDFluent(active(_2364)=true).
sDFluent(abrupt(_2364)=true).
sDFluent(inactive(_2364)=true).
sDFluent(distance(_2364,_2366,_2368)=true).
sDFluent(orientation(_2364)=_2360).
sDFluent(appearance(_2364)=_2360).
sDFluent(coord(_2364,_2366,_2368)=_2360).

index(disappear(_2468),_2468).
index(appear(_2468),_2468).
index(person(_2468)=true,_2468).
index(person(_2468)=false,_2468).
index(leaving_object(_2468,_2534)=true,_2468).
index(leaving_object(_2468,_2534)=false,_2468).
index(meeting(_2468,_2534)=true,_2468).
index(meeting(_2468,_2534)=false,_2468).
index(close(_2468,_2534,_2536)=true,_2468).
index(close(_2468,_2534,_2536)=false,_2468).
index(closeSymmetric(_2468,_2534,_2536)=true,_2468).
index(greeting1(_2468,_2534)=true,_2468).
index(greeting2(_2468,_2534)=true,_2468).
index(activeOrInactivePerson(_2468)=true,_2468).
index(moving(_2468,_2534)=true,_2468).
index(fighting(_2468,_2534)=true,_2468).
index(walking(_2468)=true,_2468).
index(running(_2468)=true,_2468).
index(active(_2468)=true,_2468).
index(abrupt(_2468)=true,_2468).
index(inactive(_2468)=true,_2468).
index(distance(_2468,_2534,_2536)=true,_2468).
index(orientation(_2468)=_2528,_2468).
index(appearance(_2468)=_2528,_2468).
index(coord(_2468,_2534,_2536)=_2528,_2468).


cachingOrder2(_2938, close(_2938,_2940,_3056)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_2938),id(_2940),_2938@<_2940.

cachingOrder2(_2916, person(_2916)=true) :- % level in dependency graph: 1, processing order in component: 1
     id(_2916).

cachingOrder2(_3308, close(_3308,_3310,_3426)=false) :- % level in dependency graph: 2, processing order in component: 1
     id(_3308),id(_3310),_3308@<_3310.

cachingOrder2(_3282, closeSymmetric(_3282,_3284,_3550)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_3282),id(_3284),_3282@<_3284.

cachingOrder2(_3260, activeOrInactivePerson(_3260)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_3260).

cachingOrder2(_3236, moving(_3236,_3238)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_3236),id(_3238),_3236@<_3238.

cachingOrder2(_3212, fighting(_3212,_3214)=true) :- % level in dependency graph: 2, processing order in component: 1
     id(_3212),id(_3214),_3212@<_3214.

cachingOrder2(_3994, leaving_object(_3994,_3996)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_3994),id(_3996),_3994@<_3996.

cachingOrder2(_3946, greeting1(_3946,_3948)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_3946),id(_3948),_3946@<_3948.

cachingOrder2(_3922, greeting2(_3922,_3924)=true) :- % level in dependency graph: 3, processing order in component: 1
     id(_3922),id(_3924),_3922@<_3924.

cachingOrder2(_4396, meeting(_4396,_4398)=true) :- % level in dependency graph: 4, processing order in component: 1
     id(_4396),id(_4398),_4396@<_4398.

collectGrounds([walking(_2522)=true, walking(_2522)=true, disappear(_2522), running(_2522)=true, running(_2522)=true, active(_2522)=true, active(_2522)=true, abrupt(_2522)=true, abrupt(_2522)=true, appear(_2522), inactive(_2522)=true, inactive(_2522)=true, orientation(_2522)=_2536, appearance(_2522)=_2536, coord(_2522,_2542,_2544)=_2536],id(_2522)).

dgrounded(person(_3334)=true, id(_3334)).
dgrounded(leaving_object(_3278,_3280)=true, id(_3278)).
dgrounded(leaving_object(_3278,_3280)=true, id(_3280)).
dgrounded(meeting(_3222,_3224)=true, id(_3222)).
dgrounded(meeting(_3222,_3224)=true, id(_3224)).
dgrounded(close(_3164,_3166,24)=true, id(_3164)).
dgrounded(close(_3164,_3166,24)=true, id(_3166)).
dgrounded(close(_3106,_3108,25)=true, id(_3106)).
dgrounded(close(_3106,_3108,25)=true, id(_3108)).
dgrounded(close(_3048,_3050,30)=true, id(_3048)).
dgrounded(close(_3048,_3050,30)=true, id(_3050)).
dgrounded(close(_2990,_2992,34)=true, id(_2990)).
dgrounded(close(_2990,_2992,34)=true, id(_2992)).
dgrounded(close(_2932,_2934,34)=false, id(_2932)).
dgrounded(close(_2932,_2934,34)=false, id(_2934)).
dgrounded(closeSymmetric(_2874,_2876,30)=true, id(_2874)).
dgrounded(closeSymmetric(_2874,_2876,30)=true, id(_2876)).
dgrounded(greeting1(_2818,_2820)=true, id(_2818)).
dgrounded(greeting1(_2818,_2820)=true, id(_2820)).
dgrounded(greeting2(_2762,_2764)=true, id(_2762)).
dgrounded(greeting2(_2762,_2764)=true, id(_2764)).
dgrounded(activeOrInactivePerson(_2730)=true, id(_2730)).
dgrounded(moving(_2674,_2676)=true, id(_2674)).
dgrounded(moving(_2674,_2676)=true, id(_2676)).
dgrounded(fighting(_2618,_2620)=true, id(_2618)).
dgrounded(fighting(_2618,_2620)=true, id(_2620)).
