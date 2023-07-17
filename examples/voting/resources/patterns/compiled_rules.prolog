:- dynamic person/1.

initiatedAt(status(_1900)=null, _1910, -1, _1918) :-
     _1910=< -1,
     -1<_1918.

initiatedAt(status(_1910)=proposed, _1956, _1880, _1962) :-
     happensAtIE(propose(_1914,_1910),_1880),_1956=<_1880,_1880<_1962,
     holdsAtCyclic(_1910,status(_1910)=null,_1880).

initiatedAt(status(_1910)=voting, _1956, _1880, _1962) :-
     happensAtIE(second(_1914,_1910),_1880),_1956=<_1880,_1880<_1962,
     holdsAtCyclic(_1910,status(_1910)=proposed,_1880).

initiatedAt(status(_1910)=voted, _1968, _1880, _1974) :-
     happensAtIE(close_ballot(_1914,_1910),_1880),_1968=<_1880,_1880<_1974,
     role_of(_1914,chair),
     holdsAtCyclic(_1910,status(_1910)=voting,_1880).

initiatedAt(status(_1910)=null, _1970, _1880, _1976) :-
     happensAtIE(declare(_1914,_1910,_1918),_1880),_1970=<_1880,_1880<_1976,
     role_of(_1914,chair),
     holdsAtCyclic(_1910,status(_1910)=voted,_1880).

initiatedAt(voted(_1910,_1912)=_1886, _1954, _1880, _1960) :-
     happensAtIE(vote(_1910,_1912,_1886),_1880),_1954=<_1880,_1880<_1960,
     holdsAtProcessedSimpleFluent(_1912,status(_1912)=voting,_1880).

initiatedAt(voted(_1910,_1912)=null, _1938, _1880, _1944) :-
     happensAtProcessedSimpleFluent(_1912,start(status(_1912)=null),_1880),
     _1938=<_1880,
     _1880<_1944.

initiatedAt(outcome(_1910)=_1886, _1964, _1880, _1970) :-
     happensAtIE(declare(_1914,_1910,_1886),_1880),_1964=<_1880,_1880<_1970,
     holdsAtProcessedSimpleFluent(_1910,status(_1910)=voted,_1880),
     role_of(_1914,chair).

initiatedAt(auxPerCloseBallot(_1910)=true, _1936, _1880, _1942) :-
     happensAtProcessedSimpleFluent(_1910,start(status(_1910)=voting),_1880),
     _1936=<_1880,
     _1880<_1942.

initiatedAt(auxPerCloseBallot(_1910)=false, _1936, _1880, _1942) :-
     happensAtProcessedSimpleFluent(_1910,start(status(_1910)=proposed),_1880),
     _1936=<_1880,
     _1880<_1942.

initiatedAt(per(close_ballot(_1914,_1916))=true, _1964, _1880, _1970) :-
     happensAtProcessedSimpleFluent(_1916,end(auxPerCloseBallot(_1916)=true),_1880),_1964=<_1880,_1880<_1970,
     holdsAtProcessedSimpleFluent(_1916,status(_1916)=voting,_1880).

initiatedAt(per(close_ballot(_1914,_1916))=false, _1942, _1880, _1948) :-
     happensAtProcessedSimpleFluent(_1916,start(status(_1916)=voted),_1880),
     _1942=<_1880,
     _1880<_1948.

initiatedAt(obl(declare(_1914,_1916,carried))=true, _1936, _1880, _1942) :-
     happensAtProcessed(_1916,auxMotionOutcomeEvent(_1916,carried),_1880),
     _1936=<_1880,
     _1880<_1942.

initiatedAt(obl(declare(_1914,_1916,carried))=false, _1944, _1880, _1950) :-
     happensAtProcessedSimpleFluent(_1916,start(status(_1916)=null),_1880),
     _1944=<_1880,
     _1880<_1950.

initiatedAt(sanctioned(_1910)=true, _1960, _1880, _1966) :-
     happensAtIE(close_ballot(_1910,_1916),_1880),_1960=<_1880,_1880<_1966,
     \+holdsAtProcessedSimpleFluent(_1910,per(close_ballot(_1910,_1916))=true,_1880).

initiatedAt(sanctioned(_1910)=true, _1990, _1880, _1996) :-
     happensAtProcessedSimpleFluent(_1924,end(status(_1924)=voted),_1880),_1990=<_1880,_1880<_1996,
     \+happensAtIE(declare(_1910,_1924,carried),_1880),
     holdsAtProcessedSimpleFluent(_1910,obl(declare(_1910,_1924,carried))=true,_1880).

initiatedAt(sanctioned(_1910)=true, _1994, _1880, _2000) :-
     happensAtProcessedSimpleFluent(_1924,end(status(_1924)=voted),_1880),_1994=<_1880,_1880<_2000,
     \+happensAtIE(declare(_1910,_1924,not_carried),_1880),
     \+holdsAtProcessedSimpleFluent(_1910,obl(declare(_1910,_1924,carried))=true,_1880).

terminatedAt(outcome(_1910)=_1886, _1936, _1880, _1942) :-
     happensAtProcessedSimpleFluent(_1910,start(status(_1910)=proposed),_1880),
     _1936=<_1880,
     _1880<_1942.

holdsForSDFluent(pow(propose(_1914,_1916))=true,_1880) :-
     holdsForProcessedSimpleFluent(_1916,status(_1916)=null,_1880).

holdsForSDFluent(pow(second(_1914,_1916))=true,_1880) :-
     holdsForProcessedSimpleFluent(_1916,status(_1916)=proposed,_1880).

holdsForSDFluent(pow(vote(_1914,_1916))=true,_1880) :-
     holdsForProcessedSimpleFluent(_1916,status(_1916)=voting,_1880).

holdsForSDFluent(pow(close_ballot(_1914,_1916))=true,_1880) :-
     holdsForProcessedSimpleFluent(_1916,status(_1916)=voting,_1880).

holdsForSDFluent(pow(declare(_1914,_1916))=true,_1880) :-
     holdsForProcessedSimpleFluent(_1916,status(_1916)=voted,_1880).

happensAtEv(auxMotionOutcomeEvent(_1898,carried),_1880) :-
     happensAtProcessedSimpleFluent(_1898,start(status(_1898)=voted),_1880),
     findall(_1936,holdsAtProcessedSimpleFluent(_1936,voted(_1936,_1898)=aye,_1880),_1946),
     length(_1946,_1952),
     findall(_1936,holdsAtProcessedSimpleFluent(_1936,voted(_1936,_1898)=nay,_1880),_1978),
     length(_1978,_1984),
     _1952>=_1984.

maxDuration(status(_1914)=proposed,status(_1914)=null,10):-
     grounding(status(_1914)=proposed),
     grounding(status(_1914)=null).

maxDuration(status(_1914)=voting,status(_1914)=voted,10):-
     grounding(status(_1914)=voting),
     grounding(status(_1914)=voted).

maxDuration(status(_1914)=voted,status(_1914)=null,10):-
     grounding(status(_1914)=voted),
     grounding(status(_1914)=null).

maxDuration(auxPerCloseBallot(_1914)=true,auxPerCloseBallot(_1914)=false,8):-
     grounding(auxPerCloseBallot(_1914)=true),
     grounding(auxPerCloseBallot(_1914)=false).

maxDuration(sanctioned(_1914)=true,sanctioned(_1914)=false,4):-
     grounding(sanctioned(_1914)=true),
     grounding(sanctioned(_1914)=false).

grounding(propose(_2218,_2220)) :- 
     person(_2218),motion(_2220).

grounding(second(_2218,_2220)) :- 
     person(_2218),motion(_2220).

grounding(vote(_2218,_2220,_2222)) :- 
     person(_2218),motion(_2220).

grounding(close_ballot(_2218,_2220)) :- 
     person(_2218),motion(_2220).

grounding(declare(_2218,_2220,_2222)) :- 
     person(_2218),motion(_2220).

grounding(status(_2224)=null) :- 
     queryMotion(_2224).

grounding(status(_2224)=proposed) :- 
     queryMotion(_2224).

grounding(status(_2224)=voting) :- 
     queryMotion(_2224).

grounding(status(_2224)=voted) :- 
     queryMotion(_2224).

grounding(voted(_2224,_2226)=aye) :- 
     person(_2224),role_of(_2224,voter),queryMotion(_2226).

grounding(voted(_2224,_2226)=nay) :- 
     person(_2224),role_of(_2224,voter),queryMotion(_2226).

grounding(auxMotionOutcomeEvent(_2218,_2220)) :- 
     queryMotion(_2218).

grounding(outcome(_2224)=carried) :- 
     queryMotion(_2224).

grounding(outcome(_2224)=not_carried) :- 
     queryMotion(_2224).

grounding(auxPerCloseBallot(_2224)=true) :- 
     queryMotion(_2224).

grounding(per(close_ballot(_2228,_2230))=true) :- 
     person(_2228),role_of(_2228,chair),queryMotion(_2230).

grounding(obl(declare(_2228,_2230,carried))=true) :- 
     person(_2228),role_of(_2228,chair),queryMotion(_2230).

grounding(sanctioned(_2224)=true) :- 
     person(_2224),role_of(_2224,chair).

grounding(auxPerCloseBallot(_2224)=false) :- 
     queryMotion(_2224).

grounding(per(close_ballot(_2228,_2230))=false) :- 
     person(_2228),role_of(_2228,chair),queryMotion(_2230).

grounding(obl(declare(_2228,_2230,carried))=false) :- 
     person(_2228),role_of(_2228,chair),queryMotion(_2230).

grounding(sanctioned(_2224)=false) :- 
     person(_2224),role_of(_2224,chair).

inputEntity(propose(_1934,_1936)).
inputEntity(second(_1934,_1936)).
inputEntity(close_ballot(_1934,_1936)).
inputEntity(declare(_1934,_1936,_1938)).
inputEntity(vote(_1934,_1936,_1938)).

outputEntity(status(_2026)=proposed).
outputEntity(status(_2026)=voting).
outputEntity(status(_2026)=voted).
outputEntity(status(_2026)=null).
outputEntity(voted(_2026,_2028)=aye).
outputEntity(voted(_2026,_2028)=nay).
outputEntity(voted(_2026,_2028)=null).
outputEntity(outcome(_2026)=carried).
outputEntity(outcome(_2026)=not_carried).
outputEntity(auxPerCloseBallot(_2026)=true).
outputEntity(auxPerCloseBallot(_2026)=false).
outputEntity(per(close_ballot(_2030,_2032))=true).
outputEntity(per(close_ballot(_2030,_2032))=false).
outputEntity(obl(declare(_2030,_2032,_2034))=true).
outputEntity(obl(declare(_2030,_2032,_2034))=false).
outputEntity(sanctioned(_2026)=true).
outputEntity(sanctioned(_2026)=false).
outputEntity(pow(propose(_2030,_2032))=true).
outputEntity(pow(second(_2030,_2032))=true).
outputEntity(pow(vote(_2030,_2032))=true).
outputEntity(pow(close_ballot(_2030,_2032))=true).
outputEntity(pow(declare(_2030,_2032))=true).
outputEntity(auxMotionOutcomeEvent(_2020,_2022)).

event(auxMotionOutcomeEvent(_2214,_2216)).
event(propose(_2214,_2216)).
event(second(_2214,_2216)).
event(close_ballot(_2214,_2216)).
event(declare(_2214,_2216,_2218)).
event(vote(_2214,_2216,_2218)).

simpleFluent(status(_2312)=proposed).
simpleFluent(status(_2312)=voting).
simpleFluent(status(_2312)=voted).
simpleFluent(status(_2312)=null).
simpleFluent(voted(_2312,_2314)=aye).
simpleFluent(voted(_2312,_2314)=nay).
simpleFluent(voted(_2312,_2314)=null).
simpleFluent(outcome(_2312)=carried).
simpleFluent(outcome(_2312)=not_carried).
simpleFluent(auxPerCloseBallot(_2312)=true).
simpleFluent(auxPerCloseBallot(_2312)=false).
simpleFluent(per(close_ballot(_2316,_2318))=true).
simpleFluent(per(close_ballot(_2316,_2318))=false).
simpleFluent(obl(declare(_2316,_2318,_2320))=true).
simpleFluent(obl(declare(_2316,_2318,_2320))=false).
simpleFluent(sanctioned(_2312)=true).
simpleFluent(sanctioned(_2312)=false).

sDFluent(pow(propose(_2474,_2476))=true).
sDFluent(pow(second(_2474,_2476))=true).
sDFluent(pow(vote(_2474,_2476))=true).
sDFluent(pow(close_ballot(_2474,_2476))=true).
sDFluent(pow(declare(_2474,_2476))=true).

index(auxMotionOutcomeEvent(_2502,_2556),_2502).
index(propose(_2502,_2556),_2502).
index(second(_2502,_2556),_2502).
index(close_ballot(_2502,_2556),_2502).
index(declare(_2502,_2556,_2558),_2502).
index(vote(_2502,_2556,_2558),_2502).
index(status(_2502)=proposed,_2502).
index(status(_2502)=voting,_2502).
index(status(_2502)=voted,_2502).
index(status(_2502)=null,_2502).
index(voted(_2502,_2562)=aye,_2502).
index(voted(_2502,_2562)=nay,_2502).
index(voted(_2502,_2562)=null,_2502).
index(outcome(_2502)=carried,_2502).
index(outcome(_2502)=not_carried,_2502).
index(auxPerCloseBallot(_2502)=true,_2502).
index(auxPerCloseBallot(_2502)=false,_2502).
index(per(close_ballot(_2502,_2566))=true,_2502).
index(per(close_ballot(_2502,_2566))=false,_2502).
index(obl(declare(_2502,_2566,_2568))=true,_2502).
index(obl(declare(_2502,_2566,_2568))=false,_2502).
index(sanctioned(_2502)=true,_2502).
index(sanctioned(_2502)=false,_2502).
index(pow(propose(_2502,_2566))=true,_2502).
index(pow(second(_2502,_2566))=true,_2502).
index(pow(vote(_2502,_2566))=true,_2502).
index(pow(close_ballot(_2502,_2566))=true,_2502).
index(pow(declare(_2502,_2566))=true,_2502).

cyclic(status(_2844)=proposed).
cyclic(status(_2844)=voting).
cyclic(status(_2844)=voted).
cyclic(status(_2844)=null).

cachingOrder2(_3010, status(_3010)=proposed) :- % level: 1
     queryMotion(_3010).

cachingOrder2(_2994, status(_2994)=voting) :- % level: 1
     queryMotion(_2994).

cachingOrder2(_2978, status(_2978)=voted) :- % level: 1
     queryMotion(_2978).

cachingOrder2(_2962, status(_2962)=null) :- % level: 1
     queryMotion(_2962).

cachingOrder2(_4142, voted(_4142,_4144)=aye) :- % level: 2
     person(_4142),role_of(_4142,voter),queryMotion(_4144).

cachingOrder2(_4124, voted(_4124,_4126)=nay) :- % level: 2
     person(_4124),role_of(_4124,voter),queryMotion(_4126).

cachingOrder2(_4090, outcome(_4090)=carried) :- % level: 2
     queryMotion(_4090).

cachingOrder2(_4074, outcome(_4074)=not_carried) :- % level: 2
     queryMotion(_4074).

cachingOrder2(_4058, auxPerCloseBallot(_4058)=true) :- % level: 2
     queryMotion(_4058).

cachingOrder2(_4040, per(close_ballot(_4040,_4042))=false) :- % level: 2
     person(_4040),role_of(_4040,chair),queryMotion(_4042).

cachingOrder2(_4016, obl(declare(_4016,_4018,carried))=false) :- % level: 2
     person(_4016),role_of(_4016,chair),queryMotion(_4018).

cachingOrder2(_3884, auxMotionOutcomeEvent(_3884,_3886)) :- % level: 2
     queryMotion(_3884).

cachingOrder2(_7028, auxPerCloseBallot(_7028)=false) :- % level: 3
     queryMotion(_7028).

cachingOrder2(_7010, per(close_ballot(_7010,_7012))=true) :- % level: 3
     person(_7010),role_of(_7010,chair),queryMotion(_7012).

cachingOrder2(_6986, obl(declare(_6986,_6988,carried))=true) :- % level: 3
     person(_6986),role_of(_6986,chair),queryMotion(_6988).

cachingOrder2(_7718, sanctioned(_7718)=true) :- % level: 4
     person(_7718),role_of(_7718,chair).

cachingOrder2(_7986, sanctioned(_7986)=false) :- % level: 5
     person(_7986),role_of(_7986,chair).

collectGrounds([propose(_2200,_2214), second(_2200,_2214), close_ballot(_2200,_2214), declare(_2200,_2214,_2216), vote(_2200,_2214,_2216)],person(_2200)).

dgrounded(voted(_2834,_2836)=aye, person(_2834)).
dgrounded(voted(_2778,_2780)=nay, person(_2778)).
dgrounded(per(close_ballot(_2594,_2596))=true, person(_2594)).
dgrounded(per(close_ballot(_2534,_2536))=false, person(_2534)).
dgrounded(obl(declare(_2472,_2474,carried))=true, person(_2472)).
dgrounded(obl(declare(_2410,_2412,carried))=false, person(_2410)).
dgrounded(sanctioned(_2362)=true, person(_2362)).
dgrounded(sanctioned(_2318)=false, person(_2318)).
