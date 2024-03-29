 
updateSDE( stop_enter_leave, '1p_all', 28000, 29000 ) :-
assertz( happensAtIE( stop_enter(75, bus, 0028009, early), 28006) ),
assertz( happensAtIE( stop_leave(75, bus, 0028009, early), 28009) ),
assertz( happensAtIE( stop_enter(75, bus, 0028012, scheduled), 28012) ),
assertz( happensAtIE( stop_leave(75, bus, 0028012, scheduled), 28017) ),
assertz( happensAtIE( stop_enter(76, bus, 0028020, late), 28020) ),
assertz( happensAtIE( stop_leave(76, bus, 0028020, late), 28022) ),
assertz( happensAtIE( stop_enter(77, bus, 0028032, scheduled), 28029) ),
assertz( happensAtIE( stop_leave(77, bus, 0028032, early), 28033) ),
assertz( happensAtIE( stop_enter(78, bus, 0028036, scheduled), 28040) ),
assertz( happensAtIE( stop_leave(78, bus, 0028036, early), 28041) ),
assertz( happensAtIE( stop_enter(79, bus, 0028044, late), 28044) ),
assertz( happensAtIE( stop_leave(79, bus, 0028044, scheduled), 28045) ),
assertz( happensAtIE( stop_enter(79, bus, 0028052, early), 28052) ),
assertz( happensAtIE( stop_leave(79, bus, 0028052, early), 28054) ),
assertz( happensAtIE( stop_enter(80, bus, 0028064, late), 28062) ),
assertz( happensAtIE( stop_leave(80, bus, 0028064, early), 28065) ),
assertz( happensAtIE( stop_enter(81, bus, 0028068, scheduled), 28068) ),
assertz( happensAtIE( stop_leave(81, bus, 0028068, late), 28070) ),
assertz( happensAtIE( stop_enter(82, bus, 0028080, early), 28077) ),
assertz( happensAtIE( stop_leave(82, bus, 0028080, scheduled), 28079) ),
assertz( happensAtIE( stop_enter(83, bus, 0028089, early), 28082) ),
assertz( happensAtIE( stop_leave(83, bus, 0028089, late), 28087) ),
assertz( happensAtIE( stop_enter(83, bus, 0028096, late), 28091) ),
assertz( happensAtIE( stop_leave(83, bus, 0028096, late), 28097) ),
assertz( happensAtIE( stop_enter(84, bus, 0028100, late), 28098) ),
assertz( happensAtIE( stop_leave(84, bus, 0028100, scheduled), 28101) ),
assertz( happensAtIE( stop_enter(85, bus, 0028109, early), 28109) ),
assertz( happensAtIE( stop_leave(85, bus, 0028109, late), 28111) ),
assertz( happensAtIE( stop_enter(86, bus, 0028121, scheduled), 28118) ),
assertz( happensAtIE( stop_leave(86, bus, 0028121, scheduled), 28121) ),
assertz( happensAtIE( stop_enter(87, bus, 0028123, late), 28124) ),
assertz( happensAtIE( stop_leave(87, bus, 0028123, scheduled), 28125) ),
assertz( happensAtIE( stop_enter(87, bus, 0028132, scheduled), 28132) ),
assertz( happensAtIE( stop_leave(87, bus, 0028132, scheduled), 28135) ),
assertz( happensAtIE( stop_enter(88, bus, 0028144, late), 28141) ),
assertz( happensAtIE( stop_leave(88, bus, 0028144, scheduled), 28145) ),
assertz( happensAtIE( stop_enter(89, bus, 0028151, early), 28151) ),
assertz( happensAtIE( stop_leave(89, bus, 0028151, scheduled), 28153) ),
assertz( happensAtIE( stop_enter(90, bus, 0028155, scheduled), 28156) ),
assertz( happensAtIE( stop_leave(90, bus, 0028155, late), 28158) ),
assertz( happensAtIE( stop_enter(91, bus, 0028167, scheduled), 28165) ),
assertz( happensAtIE( stop_leave(91, bus, 0028167, late), 28167) ),
assertz( happensAtIE( stop_enter(91, bus, 0028177, late), 28176) ),
assertz( happensAtIE( stop_leave(91, bus, 0028177, scheduled), 28177) ),
assertz( happensAtIE( stop_enter(92, bus, 0028185, late), 28178) ),
assertz( happensAtIE( stop_leave(92, bus, 0028185, late), 28181) ),
assertz( happensAtIE( stop_enter(93, bus, 0028189, late), 28188) ),
assertz( happensAtIE( stop_leave(93, bus, 0028189, scheduled), 28191) ),
assertz( happensAtIE( stop_enter(94, bus, 0028201, late), 28198) ),
assertz( happensAtIE( stop_leave(94, bus, 0028201, late), 28201) ),
assertz( happensAtIE( stop_enter(95, bus, 0028202, early), 28207) ),
assertz( happensAtIE( stop_leave(95, bus, 0028202, early), 28209) ),
assertz( happensAtIE( stop_enter(95, bus, 0028211, late), 28212) ),
assertz( happensAtIE( stop_leave(95, bus, 0028211, early), 28217) ),
assertz( happensAtIE( stop_enter(96, bus, 0028220, early), 28221) ),
assertz( happensAtIE( stop_leave(96, bus, 0028220, early), 28223) ),
assertz( happensAtIE( stop_enter(97, bus, 0028230, early), 28229) ),
assertz( happensAtIE( stop_leave(97, bus, 0028230, early), 28232) ),
assertz( happensAtIE( stop_enter(98, bus, 0028241, scheduled), 28234) ),
assertz( happensAtIE( stop_leave(98, bus, 0028241, late), 28235) ),
assertz( happensAtIE( stop_enter(99, bus, 0028246, early), 28243) ),
assertz( happensAtIE( stop_leave(99, bus, 0028246, early), 28248) ),
assertz( happensAtIE( stop_enter(99, bus, 0028255, scheduled), 28255) ),
assertz( happensAtIE( stop_leave(99, bus, 0028255, early), 28257) ),
assertz( happensAtIE( stop_enter(100, bus, 0028265, late), 28262) ),
assertz( happensAtIE( stop_leave(100, bus, 0028265, late), 28264) ),
assertz( happensAtIE( stop_enter(101, bus, 0028267, early), 28267) ),
assertz( happensAtIE( stop_leave(101, bus, 0028267, scheduled), 28272) ),
assertz( happensAtIE( stop_enter(102, bus, 0028275, late), 28275) ),
assertz( happensAtIE( stop_leave(102, bus, 0028275, late), 28277) ),
assertz( happensAtIE( stop_enter(103, bus, 0028287, late), 28284) ),
assertz( happensAtIE( stop_leave(103, bus, 0028287, early), 28289) ),
assertz( happensAtIE( stop_enter(103, bus, 0028296, scheduled), 28296) ),
assertz( happensAtIE( stop_leave(103, bus, 0028296, early), 28297) ),
assertz( happensAtIE( stop_enter(104, bus, 0028299, scheduled), 28301) ),
assertz( happensAtIE( stop_leave(104, bus, 0028299, late), 28303) ),
assertz( happensAtIE( stop_enter(105, bus, 0028306, late), 28307) ),
assertz( happensAtIE( stop_leave(105, bus, 0028306, late), 28308) ),
assertz( happensAtIE( stop_enter(106, bus, 0028318, scheduled), 28318) ),
assertz( happensAtIE( stop_leave(106, bus, 0028318, early), 28320) ),
assertz( happensAtIE( stop_enter(107, bus, 0028322, scheduled), 28327) ),
assertz( happensAtIE( stop_leave(107, bus, 0028322, scheduled), 28329) ),
assertz( happensAtIE( stop_enter(107, bus, 0028332, early), 28333) ),
assertz( happensAtIE( stop_leave(107, bus, 0028332, late), 28335) ),
assertz( happensAtIE( stop_enter(108, bus, 0028340, early), 28341) ),
assertz( happensAtIE( stop_leave(108, bus, 0028340, early), 28343) ),
assertz( happensAtIE( stop_enter(109, bus, 0028353, late), 28350) ),
assertz( happensAtIE( stop_leave(109, bus, 0028353, late), 28351) ),
assertz( happensAtIE( stop_enter(110, bus, 0028356, late), 28356) ),
assertz( happensAtIE( stop_leave(110, bus, 0028356, early), 28358) ),
assertz( happensAtIE( stop_enter(111, bus, 0028366, early), 28366) ),
assertz( happensAtIE( stop_leave(111, bus, 0028366, scheduled), 28368) ),
assertz( happensAtIE( stop_enter(111, bus, 0028373, scheduled), 28374) ),
assertz( happensAtIE( stop_leave(111, bus, 0028373, scheduled), 28376) ),
assertz( happensAtIE( stop_enter(112, bus, 0028378, late), 28383) ),
assertz( happensAtIE( stop_leave(112, bus, 0028378, early), 28384) ),
assertz( happensAtIE( stop_enter(113, bus, 0028389, scheduled), 28389) ),
assertz( happensAtIE( stop_leave(113, bus, 0028389, early), 28392) ),
assertz( happensAtIE( stop_enter(114, bus, 0028401, late), 28398) ),
assertz( happensAtIE( stop_leave(114, bus, 0028401, scheduled), 28400) ),
assertz( happensAtIE( stop_enter(115, bus, 0028402, late), 28402) ),
assertz( happensAtIE( stop_leave(115, bus, 0028402, early), 28408) ),
assertz( happensAtIE( stop_enter(115, bus, 0028417, late), 28416) ),
assertz( happensAtIE( stop_leave(115, bus, 0028417, late), 28417) ),
assertz( happensAtIE( stop_enter(116, bus, 0028422, early), 28422) ),
assertz( happensAtIE( stop_leave(116, bus, 0028422, early), 28424) ),
assertz( happensAtIE( stop_enter(117, bus, 0028426, scheduled), 28431) ),
assertz( happensAtIE( stop_leave(117, bus, 0028426, scheduled), 28433) ),
assertz( happensAtIE( stop_enter(118, bus, 0028437, late), 28437) ),
assertz( happensAtIE( stop_leave(118, bus, 0028437, scheduled), 28439) ),
assertz( happensAtIE( stop_enter(119, bus, 0028447, scheduled), 28444) ),
assertz( happensAtIE( stop_leave(119, bus, 0028447, late), 28449) ),
assertz( happensAtIE( stop_enter(119, bus, 0028457, early), 28456) ),
assertz( happensAtIE( stop_leave(119, bus, 0028457, early), 28457) ),
assertz( happensAtIE( stop_enter(120, bus, 0028459, late), 28459) ),
assertz( happensAtIE( stop_leave(120, bus, 0028459, early), 28460) ),
assertz( happensAtIE( stop_enter(121, bus, 0028467, late), 28468) ),
assertz( happensAtIE( stop_leave(121, bus, 0028467, late), 28470) ),
assertz( happensAtIE( stop_enter(122, bus, 0028480, early), 28477) ),
assertz( happensAtIE( stop_leave(122, bus, 0028480, late), 28481) ),
assertz( happensAtIE( stop_enter(123, bus, 0028489, late), 28482) ),
assertz( happensAtIE( stop_leave(123, bus, 0028489, early), 28483) ),
assertz( happensAtIE( stop_enter(123, bus, 0028492, late), 28490) ),
assertz( happensAtIE( stop_leave(123, bus, 0028492, scheduled), 28493) ),
assertz( happensAtIE( stop_enter(124, bus, 0028503, early), 28503) ),
assertz( happensAtIE( stop_leave(124, bus, 0028503, early), 28504) ),
assertz( happensAtIE( stop_enter(125, bus, 0028512, late), 28511) ),
assertz( happensAtIE( stop_leave(125, bus, 0028512, scheduled), 28513) ),
assertz( happensAtIE( stop_enter(126, bus, 0028515, scheduled), 28520) ),
assertz( happensAtIE( stop_leave(126, bus, 0028515, late), 28521) ),
assertz( happensAtIE( stop_enter(127, bus, 0028526, early), 28526) ),
assertz( happensAtIE( stop_leave(127, bus, 0028526, scheduled), 28528) ),
assertz( happensAtIE( stop_enter(127, bus, 0028530, scheduled), 28535) ),
assertz( happensAtIE( stop_leave(127, bus, 0028530, early), 28536) ),
assertz( happensAtIE( stop_enter(128, bus, 0028544, early), 28538) ),
assertz( happensAtIE( stop_leave(128, bus, 0028544, late), 28545) ),
assertz( happensAtIE( stop_enter(129, bus, 0028548, scheduled), 28552) ),
assertz( happensAtIE( stop_leave(129, bus, 0028548, scheduled), 28553) ),
assertz( happensAtIE( stop_enter(130, bus, 0028558, scheduled), 28558) ),
assertz( happensAtIE( stop_leave(130, bus, 0028558, late), 28561) ),
assertz( happensAtIE( stop_enter(131, bus, 0028562, scheduled), 28563) ),
assertz( happensAtIE( stop_leave(131, bus, 0028562, scheduled), 28568) ),
assertz( happensAtIE( stop_enter(131, bus, 0028571, early), 28572) ),
assertz( happensAtIE( stop_leave(131, bus, 0028571, scheduled), 28574) ),
assertz( happensAtIE( stop_enter(132, bus, 0028580, late), 28581) ),
assertz( happensAtIE( stop_leave(132, bus, 0028580, early), 28583) ),
assertz( happensAtIE( stop_enter(133, bus, 0028590, early), 28588) ),
assertz( happensAtIE( stop_leave(133, bus, 0028590, late), 28592) ),
assertz( happensAtIE( stop_enter(134, bus, 0028594, scheduled), 28599) ),
assertz( happensAtIE( stop_leave(134, bus, 0028594, late), 28601) ),
assertz( happensAtIE( stop_enter(135, bus, 0028605, scheduled), 28605) ),
assertz( happensAtIE( stop_leave(135, bus, 0028605, scheduled), 28606) ),
assertz( happensAtIE( stop_enter(135, bus, 0028613, late), 28613) ),
assertz( happensAtIE( stop_leave(135, bus, 0028613, scheduled), 28615) ),
assertz( happensAtIE( stop_enter(136, bus, 0028624, early), 28624) ),
assertz( happensAtIE( stop_leave(136, bus, 0028624, early), 28625) ),
assertz( happensAtIE( stop_enter(137, bus, 0028627, early), 28628) ),
assertz( happensAtIE( stop_leave(137, bus, 0028627, scheduled), 28630) ),
assertz( happensAtIE( stop_enter(138, bus, 0028638, late), 28635) ),
assertz( happensAtIE( stop_leave(138, bus, 0028638, scheduled), 28639) ),
assertz( happensAtIE( stop_enter(139, bus, 0028647, scheduled), 28647) ),
assertz( happensAtIE( stop_leave(139, bus, 0028647, late), 28649) ),
assertz( happensAtIE( stop_enter(139, bus, 0028651, early), 28651) ),
assertz( happensAtIE( stop_leave(139, bus, 0028651, early), 28653) ),
assertz( happensAtIE( stop_enter(140, bus, 0028663, early), 28660) ),
assertz( happensAtIE( stop_leave(140, bus, 0028663, early), 28662) ),
assertz( happensAtIE( stop_enter(141, bus, 0028672, early), 28672) ),
assertz( happensAtIE( stop_leave(141, bus, 0028672, scheduled), 28673) ),
assertz( happensAtIE( stop_enter(142, bus, 0028681, early), 28680) ),
assertz( happensAtIE( stop_leave(142, bus, 0028681, late), 28681) ),
assertz( happensAtIE( stop_enter(143, bus, 0028684, late), 28684) ),
assertz( happensAtIE( stop_leave(143, bus, 0028684, scheduled), 28686) ),
assertz( happensAtIE( stop_enter(143, bus, 0028694, late), 28692) ),
assertz( happensAtIE( stop_leave(143, bus, 0028694, scheduled), 28696) ),
assertz( happensAtIE( stop_enter(144, bus, 0028704, late), 28704) ),
assertz( happensAtIE( stop_leave(144, bus, 0028704, early), 28705) ),
assertz( happensAtIE( stop_enter(145, bus, 0028708, late), 28712) ),
assertz( happensAtIE( stop_leave(145, bus, 0028708, late), 28713) ),
assertz( happensAtIE( stop_enter(146, bus, 0028717, scheduled), 28717) ),
assertz( happensAtIE( stop_leave(146, bus, 0028717, late), 28719) ),
assertz( happensAtIE( stop_enter(147, bus, 0028725, early), 28725) ),
assertz( happensAtIE( stop_leave(147, bus, 0028725, early), 28728) ),
assertz( happensAtIE( stop_enter(147, bus, 0028730, early), 28735) ),
assertz( happensAtIE( stop_leave(147, bus, 0028730, late), 28736) ),
assertz( happensAtIE( stop_enter(148, bus, 0028741, late), 28741) ),
assertz( happensAtIE( stop_leave(148, bus, 0028741, late), 28743) ),
assertz( happensAtIE( stop_enter(149, bus, 0028750, late), 28748) ),
assertz( happensAtIE( stop_leave(149, bus, 0028750, early), 28749) ),
assertz( happensAtIE( stop_enter(150, bus, 0028760, scheduled), 28760) ),
assertz( happensAtIE( stop_leave(150, bus, 0028760, early), 28761) ),
assertz( happensAtIE( stop_enter(151, bus, 0028768, late), 28768) ),
assertz( happensAtIE( stop_leave(151, bus, 0028768, scheduled), 28769) ),
assertz( happensAtIE( stop_enter(151, bus, 0028772, scheduled), 28770) ),
assertz( happensAtIE( stop_leave(151, bus, 0028772, early), 28774) ),
assertz( happensAtIE( stop_enter(152, bus, 0028782, early), 28782) ),
assertz( happensAtIE( stop_leave(152, bus, 0028782, early), 28784) ),
assertz( happensAtIE( stop_enter(153, bus, 0028786, early), 28791) ),
assertz( happensAtIE( stop_leave(153, bus, 0028786, early), 28793) ),
assertz( happensAtIE( stop_enter(154, bus, 0028801, late), 28796) ),
assertz( happensAtIE( stop_leave(154, bus, 0028801, scheduled), 28797) ),
assertz( happensAtIE( stop_enter(155, bus, 0028804, scheduled), 28804) ),
assertz( happensAtIE( stop_leave(155, bus, 0028804, early), 28806) ),
assertz( happensAtIE( stop_enter(155, bus, 0028816, scheduled), 28813) ),
assertz( happensAtIE( stop_leave(155, bus, 0028816, late), 28817) ),
assertz( happensAtIE( stop_enter(156, bus, 0028819, early), 28820) ),
assertz( happensAtIE( stop_leave(156, bus, 0028819, early), 28825) ),
assertz( happensAtIE( stop_enter(157, bus, 0028828, late), 28829) ),
assertz( happensAtIE( stop_leave(157, bus, 0028828, late), 28831) ),
assertz( happensAtIE( stop_enter(158, bus, 0028837, late), 28837) ),
assertz( happensAtIE( stop_leave(158, bus, 0028837, late), 28840) ),
assertz( happensAtIE( stop_enter(159, bus, 0028849, early), 28846) ),
assertz( happensAtIE( stop_leave(159, bus, 0028849, early), 28847) ),
assertz( happensAtIE( stop_enter(159, bus, 0028850, scheduled), 28851) ),
assertz( happensAtIE( stop_leave(159, bus, 0028850, early), 28852) ),
assertz( happensAtIE( stop_enter(160, bus, 0028863, early), 28862) ),
assertz( happensAtIE( stop_leave(160, bus, 0028863, scheduled), 28863) ),
assertz( happensAtIE( stop_enter(161, bus, 0028871, scheduled), 28871) ),
assertz( happensAtIE( stop_leave(161, bus, 0028871, late), 28873) ),
assertz( happensAtIE( stop_enter(162, bus, 0028880, late), 28880) ),
assertz( happensAtIE( stop_leave(162, bus, 0028880, early), 28881) ),
assertz( happensAtIE( stop_enter(163, bus, 0028887, early), 28887) ),
assertz( happensAtIE( stop_leave(163, bus, 0028887, late), 28889) ),
assertz( happensAtIE( stop_enter(163, bus, 0028891, scheduled), 28896) ),
assertz( happensAtIE( stop_leave(163, bus, 0028891, late), 28897) ),
assertz( happensAtIE( stop_enter(164, bus, 0028898, early), 28899) ),
assertz( happensAtIE( stop_leave(164, bus, 0028898, early), 28900) ),
assertz( happensAtIE( stop_enter(165, bus, 0028907, early), 28908) ),
assertz( happensAtIE( stop_leave(165, bus, 0028907, early), 28910) ),
assertz( happensAtIE( stop_enter(166, bus, 0028919, scheduled), 28916) ),
assertz( happensAtIE( stop_leave(166, bus, 0028919, scheduled), 28921) ),
assertz( happensAtIE( stop_enter(167, bus, 0028928, early), 28928) ),
assertz( happensAtIE( stop_leave(167, bus, 0028928, early), 28929) ),
assertz( happensAtIE( stop_enter(167, bus, 0028932, scheduled), 28933) ),
assertz( happensAtIE( stop_leave(167, bus, 0028932, late), 28935) ),
assertz( happensAtIE( stop_enter(168, bus, 0028944, early), 28941) ),
assertz( happensAtIE( stop_leave(168, bus, 0028944, late), 28945) ),
assertz( happensAtIE( stop_enter(169, bus, 0028951, late), 28951) ),
assertz( happensAtIE( stop_leave(169, bus, 0028951, late), 28953) ),
assertz( happensAtIE( stop_enter(170, bus, 0028955, scheduled), 28960) ),
assertz( happensAtIE( stop_leave(170, bus, 0028955, scheduled), 28961) ),
assertz( happensAtIE( stop_enter(171, bus, 0028966, early), 28966) ),
assertz( happensAtIE( stop_leave(171, bus, 0028966, early), 28968) ),
assertz( happensAtIE( stop_enter(171, bus, 0028970, early), 28975) ),
assertz( happensAtIE( stop_leave(171, bus, 0028970, scheduled), 28976) ),
assertz( happensAtIE( stop_enter(172, bus, 0028983, early), 28983) ),
assertz( happensAtIE( stop_leave(172, bus, 0028983, late), 28985) ),
assertz( happensAtIE( stop_enter(173, bus, 0028987, early), 28992) ),
assertz( happensAtIE( stop_leave(173, bus, 0028987, early), 28993) ),
assertz( happensAtIE( stop_enter(174, bus, 0028997, early), 28997) ),
assertz( happensAtIE( stop_leave(174, bus, 0028997, early), 28999) ).
