 
updateSDE( stop_enter_leave, '1p_all', 30000, 31000 ) :-
assertz( happensAtIE( stop_enter(75, bus, 0030005, late), 30006) ),
assertz( happensAtIE( stop_leave(75, bus, 0030005, early), 30009) ),
assertz( happensAtIE( stop_enter(75, bus, 0030011, early), 30016) ),
assertz( happensAtIE( stop_leave(75, bus, 0030011, late), 30017) ),
assertz( happensAtIE( stop_enter(76, bus, 0030025, scheduled), 30022) ),
assertz( happensAtIE( stop_leave(76, bus, 0030025, scheduled), 30024) ),
assertz( happensAtIE( stop_enter(77, bus, 0030026, early), 30026) ),
assertz( happensAtIE( stop_leave(77, bus, 0030026, late), 30032) ),
assertz( happensAtIE( stop_enter(78, bus, 0030035, late), 30036) ),
assertz( happensAtIE( stop_leave(78, bus, 0030035, late), 30037) ),
assertz( happensAtIE( stop_enter(79, bus, 0030044, early), 30044) ),
assertz( happensAtIE( stop_leave(79, bus, 0030044, early), 30048) ),
assertz( happensAtIE( stop_enter(79, bus, 0030054, early), 30054) ),
assertz( happensAtIE( stop_leave(79, bus, 0030054, scheduled), 30056) ),
assertz( happensAtIE( stop_enter(80, bus, 0030058, scheduled), 30063) ),
assertz( happensAtIE( stop_leave(80, bus, 0030058, late), 30065) ),
assertz( happensAtIE( stop_enter(81, bus, 0030067, late), 30068) ),
assertz( happensAtIE( stop_leave(81, bus, 0030067, early), 30070) ),
assertz( happensAtIE( stop_enter(82, bus, 0030076, scheduled), 30077) ),
assertz( happensAtIE( stop_leave(82, bus, 0030076, early), 30079) ),
assertz( happensAtIE( stop_enter(83, bus, 0030089, scheduled), 30086) ),
assertz( happensAtIE( stop_leave(83, bus, 0030089, late), 30087) ),
assertz( happensAtIE( stop_enter(83, bus, 0030092, scheduled), 30092) ),
assertz( happensAtIE( stop_leave(83, bus, 0030092, scheduled), 30094) ),
assertz( happensAtIE( stop_enter(84, bus, 0030104, early), 30104) ),
assertz( happensAtIE( stop_leave(84, bus, 0030104, late), 30105) ),
assertz( happensAtIE( stop_enter(85, bus, 0030110, scheduled), 30109) ),
assertz( happensAtIE( stop_leave(85, bus, 0030110, early), 30112) ),
assertz( happensAtIE( stop_enter(86, bus, 0030121, scheduled), 30118) ),
assertz( happensAtIE( stop_leave(86, bus, 0030121, late), 30119) ),
assertz( happensAtIE( stop_enter(87, bus, 0030124, scheduled), 30125) ),
assertz( happensAtIE( stop_leave(87, bus, 0030124, early), 30127) ),
assertz( happensAtIE( stop_enter(87, bus, 0030137, scheduled), 30134) ),
assertz( happensAtIE( stop_leave(87, bus, 0030137, scheduled), 30136) ),
assertz( happensAtIE( stop_enter(88, bus, 0030145, scheduled), 30138) ),
assertz( happensAtIE( stop_leave(88, bus, 0030145, scheduled), 30145) ),
assertz( happensAtIE( stop_enter(89, bus, 0030149, scheduled), 30146) ),
assertz( happensAtIE( stop_leave(89, bus, 0030149, scheduled), 30150) ),
assertz( happensAtIE( stop_enter(90, bus, 0030157, early), 30157) ),
assertz( happensAtIE( stop_leave(90, bus, 0030157, late), 30159) ),
assertz( happensAtIE( stop_enter(91, bus, 0030169, scheduled), 30166) ),
assertz( happensAtIE( stop_leave(91, bus, 0030169, scheduled), 30169) ),
assertz( happensAtIE( stop_enter(91, bus, 0030172, early), 30172) ),
assertz( happensAtIE( stop_leave(91, bus, 0030172, late), 30173) ),
assertz( happensAtIE( stop_enter(92, bus, 0030180, late), 30180) ),
assertz( happensAtIE( stop_leave(92, bus, 0030180, early), 30182) ),
assertz( happensAtIE( stop_enter(93, bus, 0030192, scheduled), 30190) ),
assertz( happensAtIE( stop_leave(93, bus, 0030192, late), 30193) ),
assertz( happensAtIE( stop_enter(94, bus, 0030196, early), 30194) ),
assertz( happensAtIE( stop_leave(94, bus, 0030196, scheduled), 30198) ),
assertz( happensAtIE( stop_enter(95, bus, 0030205, early), 30206) ),
assertz( happensAtIE( stop_leave(95, bus, 0030205, late), 30208) ),
assertz( happensAtIE( stop_enter(95, bus, 0030216, early), 30213) ),
assertz( happensAtIE( stop_leave(95, bus, 0030216, scheduled), 30215) ),
assertz( happensAtIE( stop_enter(96, bus, 0030225, scheduled), 30224) ),
assertz( happensAtIE( stop_leave(96, bus, 0030225, scheduled), 30225) ),
assertz( happensAtIE( stop_enter(97, bus, 0030233, early), 30227) ),
assertz( happensAtIE( stop_leave(97, bus, 0030233, scheduled), 30228) ),
assertz( happensAtIE( stop_enter(98, bus, 0030237, late), 30235) ),
assertz( happensAtIE( stop_leave(98, bus, 0030237, late), 30239) ),
assertz( happensAtIE( stop_enter(99, bus, 0030247, scheduled), 30247) ),
assertz( happensAtIE( stop_leave(99, bus, 0030247, scheduled), 30249) ),
assertz( happensAtIE( stop_enter(99, bus, 0030251, late), 30256) ),
assertz( happensAtIE( stop_leave(99, bus, 0030251, early), 30257) ),
assertz( happensAtIE( stop_enter(100, bus, 0030258, early), 30261) ),
assertz( happensAtIE( stop_leave(100, bus, 0030258, scheduled), 30262) ),
assertz( happensAtIE( stop_enter(101, bus, 0030267, late), 30268) ),
assertz( happensAtIE( stop_leave(101, bus, 0030267, late), 30270) ),
assertz( happensAtIE( stop_enter(102, bus, 0030280, scheduled), 30277) ),
assertz( happensAtIE( stop_leave(102, bus, 0030280, late), 30281) ),
assertz( happensAtIE( stop_enter(103, bus, 0030283, late), 30288) ),
assertz( happensAtIE( stop_leave(103, bus, 0030283, late), 30289) ),
assertz( happensAtIE( stop_enter(103, bus, 0030295, early), 30295) ),
assertz( happensAtIE( stop_leave(103, bus, 0030295, late), 30297) ),
assertz( happensAtIE( stop_enter(104, bus, 0030299, scheduled), 30304) ),
assertz( happensAtIE( stop_leave(104, bus, 0030299, late), 30305) ),
assertz( happensAtIE( stop_enter(105, bus, 0030309, scheduled), 30309) ),
assertz( happensAtIE( stop_leave(105, bus, 0030309, early), 30313) ),
assertz( happensAtIE( stop_enter(106, bus, 0030315, early), 30315) ),
assertz( happensAtIE( stop_leave(106, bus, 0030315, late), 30317) ),
assertz( happensAtIE( stop_enter(107, bus, 0030327, early), 30324) ),
assertz( happensAtIE( stop_leave(107, bus, 0030327, late), 30328) ),
assertz( happensAtIE( stop_enter(107, bus, 0030336, scheduled), 30336) ),
assertz( happensAtIE( stop_leave(107, bus, 0030336, late), 30337) ),
assertz( happensAtIE( stop_enter(108, bus, 0030340, early), 30338) ),
assertz( happensAtIE( stop_leave(108, bus, 0030340, early), 30342) ),
assertz( happensAtIE( stop_enter(109, bus, 0030352, scheduled), 30349) ),
assertz( happensAtIE( stop_leave(109, bus, 0030352, late), 30351) ),
assertz( happensAtIE( stop_enter(110, bus, 0030360, early), 30354) ),
assertz( happensAtIE( stop_leave(110, bus, 0030360, early), 30361) ),
assertz( happensAtIE( stop_enter(111, bus, 0030362, late), 30367) ),
assertz( happensAtIE( stop_leave(111, bus, 0030362, late), 30368) ),
assertz( happensAtIE( stop_enter(111, bus, 0030373, scheduled), 30373) ),
assertz( happensAtIE( stop_leave(111, bus, 0030373, early), 30375) ),
assertz( happensAtIE( stop_enter(112, bus, 0030385, late), 30382) ),
assertz( happensAtIE( stop_leave(112, bus, 0030385, scheduled), 30384) ),
assertz( happensAtIE( stop_enter(113, bus, 0030386, early), 30387) ),
assertz( happensAtIE( stop_leave(113, bus, 0030386, scheduled), 30392) ),
assertz( happensAtIE( stop_enter(114, bus, 0030394, late), 30395) ),
assertz( happensAtIE( stop_leave(114, bus, 0030394, scheduled), 30397) ),
assertz( happensAtIE( stop_enter(115, bus, 0030407, scheduled), 30404) ),
assertz( happensAtIE( stop_leave(115, bus, 0030407, scheduled), 30408) ),
assertz( happensAtIE( stop_enter(115, bus, 0030416, early), 30416) ),
assertz( happensAtIE( stop_leave(115, bus, 0030416, scheduled), 30417) ),
assertz( happensAtIE( stop_enter(116, bus, 0030418, early), 30418) ),
assertz( happensAtIE( stop_leave(116, bus, 0030418, late), 30419) ),
assertz( happensAtIE( stop_enter(117, bus, 0030430, early), 30428) ),
assertz( happensAtIE( stop_leave(117, bus, 0030430, late), 30429) ),
assertz( happensAtIE( stop_enter(118, bus, 0030440, scheduled), 30439) ),
assertz( happensAtIE( stop_leave(118, bus, 0030440, scheduled), 30440) ),
assertz( happensAtIE( stop_enter(119, bus, 0030448, early), 30448) ),
assertz( happensAtIE( stop_leave(119, bus, 0030448, late), 30449) ),
assertz( happensAtIE( stop_enter(119, bus, 0030457, scheduled), 30450) ),
assertz( happensAtIE( stop_leave(119, bus, 0030457, scheduled), 30451) ),
assertz( happensAtIE( stop_enter(120, bus, 0030461, early), 30461) ),
assertz( happensAtIE( stop_leave(120, bus, 0030461, early), 30463) ),
assertz( happensAtIE( stop_enter(121, bus, 0030473, scheduled), 30470) ),
assertz( happensAtIE( stop_leave(121, bus, 0030473, scheduled), 30472) ),
assertz( happensAtIE( stop_enter(122, bus, 0030474, early), 30475) ),
assertz( happensAtIE( stop_leave(122, bus, 0030474, scheduled), 30480) ),
assertz( happensAtIE( stop_enter(123, bus, 0030483, late), 30484) ),
assertz( happensAtIE( stop_leave(123, bus, 0030483, scheduled), 30486) ),
assertz( happensAtIE( stop_enter(123, bus, 0030497, early), 30496) ),
assertz( happensAtIE( stop_leave(123, bus, 0030497, late), 30497) ),
assertz( happensAtIE( stop_enter(124, bus, 0030499, late), 30504) ),
assertz( happensAtIE( stop_leave(124, bus, 0030499, late), 30505) ),
assertz( happensAtIE( stop_enter(125, bus, 0030510, early), 30510) ),
assertz( happensAtIE( stop_leave(125, bus, 0030510, late), 30513) ),
assertz( happensAtIE( stop_enter(126, bus, 0030514, scheduled), 30519) ),
assertz( happensAtIE( stop_leave(126, bus, 0030514, scheduled), 30521) ),
assertz( happensAtIE( stop_enter(127, bus, 0030523, late), 30524) ),
assertz( happensAtIE( stop_leave(127, bus, 0030523, early), 30529) ),
assertz( happensAtIE( stop_enter(127, bus, 0030531, late), 30532) ),
assertz( happensAtIE( stop_leave(127, bus, 0030531, early), 30534) ),
assertz( happensAtIE( stop_enter(128, bus, 0030542, late), 30540) ),
assertz( happensAtIE( stop_leave(128, bus, 0030542, late), 30544) ),
assertz( happensAtIE( stop_enter(129, bus, 0030551, late), 30551) ),
assertz( happensAtIE( stop_leave(129, bus, 0030551, late), 30553) ),
assertz( happensAtIE( stop_enter(130, bus, 0030556, scheduled), 30555) ),
assertz( happensAtIE( stop_leave(130, bus, 0030556, late), 30558) ),
assertz( happensAtIE( stop_enter(131, bus, 0030567, scheduled), 30565) ),
assertz( happensAtIE( stop_leave(131, bus, 0030567, scheduled), 30567) ),
assertz( happensAtIE( stop_enter(131, bus, 0030577, early), 30576) ),
assertz( happensAtIE( stop_leave(131, bus, 0030577, scheduled), 30577) ),
assertz( happensAtIE( stop_enter(132, bus, 0030585, late), 30579) ),
assertz( happensAtIE( stop_leave(132, bus, 0030585, scheduled), 30580) ),
assertz( happensAtIE( stop_enter(133, bus, 0030587, scheduled), 30587) ),
assertz( happensAtIE( stop_leave(133, bus, 0030587, scheduled), 30589) ),
assertz( happensAtIE( stop_enter(134, bus, 0030597, early), 30594) ),
assertz( happensAtIE( stop_leave(134, bus, 0030597, early), 30598) ),
assertz( happensAtIE( stop_enter(135, bus, 0030606, scheduled), 30606) ),
assertz( happensAtIE( stop_leave(135, bus, 0030606, late), 30609) ),
assertz( happensAtIE( stop_enter(135, bus, 0030611, scheduled), 30615) ),
assertz( happensAtIE( stop_leave(135, bus, 0030611, early), 30617) ),
assertz( happensAtIE( stop_enter(136, bus, 0030620, early), 30621) ),
assertz( happensAtIE( stop_leave(136, bus, 0030620, early), 30623) ),
assertz( happensAtIE( stop_enter(137, bus, 0030632, early), 30629) ),
assertz( happensAtIE( stop_leave(137, bus, 0030632, late), 30633) ),
assertz( happensAtIE( stop_enter(138, bus, 0030641, scheduled), 30634) ),
assertz( happensAtIE( stop_leave(138, bus, 0030641, early), 30635) ),
assertz( happensAtIE( stop_enter(139, bus, 0030646, late), 30643) ),
assertz( happensAtIE( stop_leave(139, bus, 0030646, early), 30647) ),
assertz( happensAtIE( stop_enter(139, bus, 0030653, early), 30653) ),
assertz( happensAtIE( stop_leave(139, bus, 0030653, scheduled), 30655) ),
assertz( happensAtIE( stop_enter(140, bus, 0030665, late), 30662) ),
assertz( happensAtIE( stop_leave(140, bus, 0030665, early), 30664) ),
assertz( happensAtIE( stop_enter(141, bus, 0030673, early), 30666) ),
assertz( happensAtIE( stop_leave(141, bus, 0030673, scheduled), 30668) ),
assertz( happensAtIE( stop_enter(142, bus, 0030676, scheduled), 30676) ),
assertz( happensAtIE( stop_leave(142, bus, 0030676, early), 30678) ),
assertz( happensAtIE( stop_enter(143, bus, 0030688, scheduled), 30685) ),
assertz( happensAtIE( stop_leave(143, bus, 0030688, scheduled), 30689) ),
assertz( happensAtIE( stop_enter(143, bus, 0030690, late), 30690) ),
assertz( happensAtIE( stop_leave(143, bus, 0030690, scheduled), 30691) ),
assertz( happensAtIE( stop_enter(144, bus, 0030701, early), 30701) ),
assertz( happensAtIE( stop_leave(144, bus, 0030701, scheduled), 30705) ),
assertz( happensAtIE( stop_enter(145, bus, 0030708, late), 30709) ),
assertz( happensAtIE( stop_leave(145, bus, 0030708, late), 30711) ),
assertz( happensAtIE( stop_enter(146, bus, 0030717, late), 30717) ),
assertz( happensAtIE( stop_leave(146, bus, 0030717, late), 30719) ),
assertz( happensAtIE( stop_enter(147, bus, 0030729, late), 30726) ),
assertz( happensAtIE( stop_leave(147, bus, 0030729, scheduled), 30727) ),
assertz( happensAtIE( stop_enter(147, bus, 0030732, early), 30732) ),
assertz( happensAtIE( stop_leave(147, bus, 0030732, late), 30734) ),
assertz( happensAtIE( stop_enter(148, bus, 0030744, scheduled), 30744) ),
assertz( happensAtIE( stop_leave(148, bus, 0030744, scheduled), 30745) ),
assertz( happensAtIE( stop_enter(149, bus, 0030753, late), 30746) ),
assertz( happensAtIE( stop_leave(149, bus, 0030753, late), 30753) ),
assertz( happensAtIE( stop_enter(150, bus, 0030760, early), 30760) ),
assertz( happensAtIE( stop_leave(150, bus, 0030760, early), 30761) ),
assertz( happensAtIE( stop_enter(151, bus, 0030763, early), 30764) ),
assertz( happensAtIE( stop_leave(151, bus, 0030763, late), 30766) ),
assertz( happensAtIE( stop_enter(151, bus, 0030776, late), 30773) ),
assertz( happensAtIE( stop_leave(151, bus, 0030776, scheduled), 30777) ),
assertz( happensAtIE( stop_enter(152, bus, 0030785, early), 30778) ),
assertz( happensAtIE( stop_leave(152, bus, 0030785, late), 30779) ),
assertz( happensAtIE( stop_enter(153, bus, 0030789, scheduled), 30787) ),
assertz( happensAtIE( stop_leave(153, bus, 0030789, early), 30788) ),
assertz( happensAtIE( stop_enter(154, bus, 0030799, scheduled), 30799) ),
assertz( happensAtIE( stop_leave(154, bus, 0030799, late), 30800) ),
assertz( happensAtIE( stop_enter(155, bus, 0030807, early), 30808) ),
assertz( happensAtIE( stop_leave(155, bus, 0030807, late), 30809) ),
assertz( happensAtIE( stop_enter(155, bus, 0030815, late), 30814) ),
assertz( happensAtIE( stop_leave(155, bus, 0030815, early), 30817) ),
assertz( happensAtIE( stop_enter(156, bus, 0030818, early), 30819) ),
assertz( happensAtIE( stop_leave(156, bus, 0030818, scheduled), 30821) ),
assertz( happensAtIE( stop_enter(157, bus, 0030831, late), 30828) ),
assertz( happensAtIE( stop_leave(157, bus, 0030831, late), 30833) ),
assertz( happensAtIE( stop_enter(158, bus, 0030840, early), 30840) ),
assertz( happensAtIE( stop_leave(158, bus, 0030840, scheduled), 30841) ),
assertz( happensAtIE( stop_enter(159, bus, 0030844, early), 30844) ),
assertz( happensAtIE( stop_leave(159, bus, 0030844, early), 30845) ),
assertz( happensAtIE( stop_enter(159, bus, 0030852, scheduled), 30852) ),
assertz( happensAtIE( stop_leave(159, bus, 0030852, early), 30854) ),
assertz( happensAtIE( stop_enter(160, bus, 0030864, early), 30861) ),
assertz( happensAtIE( stop_leave(160, bus, 0030864, scheduled), 30865) ),
assertz( happensAtIE( stop_enter(161, bus, 0030871, early), 30871) ),
assertz( happensAtIE( stop_leave(161, bus, 0030871, scheduled), 30873) ),
assertz( happensAtIE( stop_enter(162, bus, 0030875, late), 30875) ),
assertz( happensAtIE( stop_leave(162, bus, 0030875, late), 30877) ),
assertz( happensAtIE( stop_enter(163, bus, 0030887, scheduled), 30884) ),
assertz( happensAtIE( stop_leave(163, bus, 0030887, early), 30886) ),
assertz( happensAtIE( stop_enter(163, bus, 0030896, early), 30896) ),
assertz( happensAtIE( stop_leave(163, bus, 0030896, scheduled), 30897) ),
assertz( happensAtIE( stop_enter(164, bus, 0030905, scheduled), 30904) ),
assertz( happensAtIE( stop_leave(164, bus, 0030905, early), 30905) ),
assertz( happensAtIE( stop_enter(165, bus, 0030910, early), 30910) ),
assertz( happensAtIE( stop_leave(165, bus, 0030910, late), 30912) ),
assertz( happensAtIE( stop_enter(166, bus, 0030919, late), 30916) ),
assertz( happensAtIE( stop_leave(166, bus, 0030919, late), 30921) ),
assertz( happensAtIE( stop_enter(167, bus, 0030923, scheduled), 30928) ),
assertz( happensAtIE( stop_leave(167, bus, 0030923, scheduled), 30929) ),
assertz( happensAtIE( stop_enter(167, bus, 0030932, scheduled), 30933) ),
assertz( happensAtIE( stop_leave(167, bus, 0030932, early), 30935) ),
assertz( happensAtIE( stop_enter(168, bus, 0030944, late), 30941) ),
assertz( happensAtIE( stop_leave(168, bus, 0030944, early), 30945) ),
assertz( happensAtIE( stop_enter(169, bus, 0030953, early), 30952) ),
assertz( happensAtIE( stop_leave(169, bus, 0030953, early), 30953) ),
assertz( happensAtIE( stop_enter(170, bus, 0030959, late), 30958) ),
assertz( happensAtIE( stop_leave(170, bus, 0030959, late), 30961) ),
assertz( happensAtIE( stop_enter(171, bus, 0030968, scheduled), 30967) ),
assertz( happensAtIE( stop_leave(171, bus, 0030968, late), 30968) ),
assertz( happensAtIE( stop_enter(171, bus, 0030976, late), 30976) ),
assertz( happensAtIE( stop_leave(171, bus, 0030976, scheduled), 30977) ),
assertz( happensAtIE( stop_enter(172, bus, 0030979, late), 30980) ),
assertz( happensAtIE( stop_leave(172, bus, 0030979, early), 30982) ),
assertz( happensAtIE( stop_enter(173, bus, 0030986, scheduled), 30987) ),
assertz( happensAtIE( stop_leave(173, bus, 0030986, late), 30988) ),
assertz( happensAtIE( stop_enter(174, bus, 0030997, early), 30995) ),
assertz( happensAtIE( stop_leave(174, bus, 0030997, early), 30998) ).
