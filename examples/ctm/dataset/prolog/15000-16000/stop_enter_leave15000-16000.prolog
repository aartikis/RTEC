 
updateSDE( stop_enter_leave, '1p_all', 15000, 16000 ) :-
assertz( happensAtIE( stop_enter(75, bus, 0015007, scheduled), 15008) ),
assertz( happensAtIE( stop_leave(75, bus, 0015007, early), 15009) ),
assertz( happensAtIE( stop_enter(75, bus, 0015011, early), 15012) ),
assertz( happensAtIE( stop_leave(75, bus, 0015011, early), 15014) ),
assertz( happensAtIE( stop_enter(76, bus, 0015023, late), 15023) ),
assertz( happensAtIE( stop_leave(76, bus, 0015023, late), 15025) ),
assertz( happensAtIE( stop_enter(77, bus, 0015027, early), 15032) ),
assertz( happensAtIE( stop_leave(77, bus, 0015027, scheduled), 15033) ),
assertz( happensAtIE( stop_enter(78, bus, 0015036, early), 15037) ),
assertz( happensAtIE( stop_leave(78, bus, 0015036, scheduled), 15039) ),
assertz( happensAtIE( stop_enter(79, bus, 0015046, late), 15044) ),
assertz( happensAtIE( stop_leave(79, bus, 0015046, early), 15048) ),
assertz( happensAtIE( stop_enter(79, bus, 0015056, late), 15055) ),
assertz( happensAtIE( stop_leave(79, bus, 0015056, scheduled), 15057) ),
assertz( happensAtIE( stop_enter(80, bus, 0015060, early), 15058) ),
assertz( happensAtIE( stop_leave(80, bus, 0015060, scheduled), 15061) ),
assertz( happensAtIE( stop_enter(81, bus, 0015072, late), 15069) ),
assertz( happensAtIE( stop_leave(81, bus, 0015072, early), 15071) ),
assertz( happensAtIE( stop_enter(82, bus, 0015081, early), 15080) ),
assertz( happensAtIE( stop_leave(82, bus, 0015081, late), 15081) ),
assertz( happensAtIE( stop_enter(83, bus, 0015089, scheduled), 15082) ),
assertz( happensAtIE( stop_leave(83, bus, 0015089, early), 15084) ),
assertz( happensAtIE( stop_enter(83, bus, 0015092, scheduled), 15093) ),
assertz( happensAtIE( stop_leave(83, bus, 0015092, late), 15095) ),
assertz( happensAtIE( stop_enter(84, bus, 0015103, late), 15100) ),
assertz( happensAtIE( stop_leave(84, bus, 0015103, early), 15104) ),
assertz( happensAtIE( stop_enter(85, bus, 0015107, early), 15111) ),
assertz( happensAtIE( stop_leave(85, bus, 0015107, early), 15113) ),
assertz( happensAtIE( stop_enter(86, bus, 0015115, scheduled), 15116) ),
assertz( happensAtIE( stop_leave(86, bus, 0015115, early), 15121) ),
assertz( happensAtIE( stop_enter(87, bus, 0015124, late), 15124) ),
assertz( happensAtIE( stop_leave(87, bus, 0015124, early), 15126) ),
assertz( happensAtIE( stop_enter(87, bus, 0015136, scheduled), 15133) ),
assertz( happensAtIE( stop_leave(87, bus, 0015136, early), 15137) ),
assertz( happensAtIE( stop_enter(88, bus, 0015140, late), 15144) ),
assertz( happensAtIE( stop_leave(88, bus, 0015140, scheduled), 15145) ),
assertz( happensAtIE( stop_enter(89, bus, 0015148, early), 15148) ),
assertz( happensAtIE( stop_leave(89, bus, 0015148, early), 15150) ),
assertz( happensAtIE( stop_enter(90, bus, 0015160, scheduled), 15157) ),
assertz( happensAtIE( stop_leave(90, bus, 0015160, early), 15161) ),
assertz( happensAtIE( stop_enter(91, bus, 0015164, early), 15168) ),
assertz( happensAtIE( stop_leave(91, bus, 0015164, early), 15169) ),
assertz( happensAtIE( stop_enter(91, bus, 0015173, early), 15173) ),
assertz( happensAtIE( stop_leave(91, bus, 0015173, scheduled), 15175) ),
assertz( happensAtIE( stop_enter(92, bus, 0015180, scheduled), 15181) ),
assertz( happensAtIE( stop_leave(92, bus, 0015180, early), 15183) ),
assertz( happensAtIE( stop_enter(93, bus, 0015193, scheduled), 15190) ),
assertz( happensAtIE( stop_leave(93, bus, 0015193, early), 15191) ),
assertz( happensAtIE( stop_enter(94, bus, 0015198, scheduled), 15196) ),
assertz( happensAtIE( stop_leave(94, bus, 0015198, scheduled), 15201) ),
assertz( happensAtIE( stop_enter(95, bus, 0015204, late), 15205) ),
assertz( happensAtIE( stop_leave(95, bus, 0015204, late), 15207) ),
assertz( happensAtIE( stop_enter(95, bus, 0015213, late), 15213) ),
assertz( happensAtIE( stop_leave(95, bus, 0015213, late), 15216) ),
assertz( happensAtIE( stop_enter(96, bus, 0015225, late), 15218) ),
assertz( happensAtIE( stop_leave(96, bus, 0015225, early), 15221) ),
assertz( happensAtIE( stop_enter(97, bus, 0015231, scheduled), 15228) ),
assertz( happensAtIE( stop_leave(97, bus, 0015231, late), 15230) ),
assertz( happensAtIE( stop_enter(98, bus, 0015240, early), 15240) ),
assertz( happensAtIE( stop_leave(98, bus, 0015240, early), 15241) ),
assertz( happensAtIE( stop_enter(99, bus, 0015248, scheduled), 15248) ),
assertz( happensAtIE( stop_leave(99, bus, 0015248, scheduled), 15249) ),
assertz( happensAtIE( stop_enter(99, bus, 0015252, late), 15252) ),
assertz( happensAtIE( stop_leave(99, bus, 0015252, early), 15254) ),
assertz( happensAtIE( stop_enter(100, bus, 0015261, scheduled), 15260) ),
assertz( happensAtIE( stop_leave(100, bus, 0015261, late), 15262) ),
assertz( happensAtIE( stop_enter(101, bus, 0015273, early), 15270) ),
assertz( happensAtIE( stop_leave(101, bus, 0015273, early), 15273) ),
assertz( happensAtIE( stop_enter(102, bus, 0015276, late), 15274) ),
assertz( happensAtIE( stop_leave(102, bus, 0015276, scheduled), 15277) ),
assertz( happensAtIE( stop_enter(103, bus, 0015285, scheduled), 15286) ),
assertz( happensAtIE( stop_leave(103, bus, 0015285, late), 15288) ),
assertz( happensAtIE( stop_enter(103, bus, 0015297, late), 15290) ),
assertz( happensAtIE( stop_leave(103, bus, 0015297, late), 15295) ),
assertz( happensAtIE( stop_enter(104, bus, 0015304, late), 15299) ),
assertz( happensAtIE( stop_leave(104, bus, 0015304, scheduled), 15305) ),
assertz( happensAtIE( stop_enter(105, bus, 0015313, scheduled), 15306) ),
assertz( happensAtIE( stop_leave(105, bus, 0015313, scheduled), 15307) ),
assertz( happensAtIE( stop_enter(106, bus, 0015317, scheduled), 15317) ),
assertz( happensAtIE( stop_leave(106, bus, 0015317, late), 15320) ),
assertz( happensAtIE( stop_enter(107, bus, 0015329, scheduled), 15326) ),
assertz( happensAtIE( stop_leave(107, bus, 0015329, scheduled), 15329) ),
assertz( happensAtIE( stop_enter(107, bus, 0015332, late), 15332) ),
assertz( happensAtIE( stop_leave(107, bus, 0015332, scheduled), 15333) ),
assertz( happensAtIE( stop_enter(108, bus, 0015342, late), 15340) ),
assertz( happensAtIE( stop_leave(108, bus, 0015342, late), 15344) ),
assertz( happensAtIE( stop_enter(109, bus, 0015351, early), 15351) ),
assertz( happensAtIE( stop_leave(109, bus, 0015351, early), 15353) ),
assertz( happensAtIE( stop_enter(110, bus, 0015361, scheduled), 15354) ),
assertz( happensAtIE( stop_leave(110, bus, 0015361, scheduled), 15355) ),
assertz( happensAtIE( stop_enter(111, bus, 0015366, late), 15363) ),
assertz( happensAtIE( stop_leave(111, bus, 0015366, scheduled), 15364) ),
assertz( happensAtIE( stop_enter(111, bus, 0015375, scheduled), 15375) ),
assertz( happensAtIE( stop_leave(111, bus, 0015375, late), 15376) ),
assertz( happensAtIE( stop_enter(112, bus, 0015383, scheduled), 15383) ),
assertz( happensAtIE( stop_leave(112, bus, 0015383, scheduled), 15385) ),
assertz( happensAtIE( stop_enter(113, bus, 0015387, scheduled), 15392) ),
assertz( happensAtIE( stop_leave(113, bus, 0015387, scheduled), 15393) ),
assertz( happensAtIE( stop_enter(114, bus, 0015398, early), 15398) ),
assertz( happensAtIE( stop_leave(114, bus, 0015398, late), 15401) ),
assertz( happensAtIE( stop_enter(115, bus, 0015402, early), 15407) ),
assertz( happensAtIE( stop_leave(115, bus, 0015402, late), 15408) ),
assertz( happensAtIE( stop_enter(115, bus, 0015416, late), 15410) ),
assertz( happensAtIE( stop_leave(115, bus, 0015416, early), 15417) ),
assertz( happensAtIE( stop_enter(116, bus, 0015419, scheduled), 15424) ),
assertz( happensAtIE( stop_leave(116, bus, 0015419, early), 15425) ),
assertz( happensAtIE( stop_enter(117, bus, 0015430, late), 15430) ),
assertz( happensAtIE( stop_leave(117, bus, 0015430, scheduled), 15433) ),
assertz( happensAtIE( stop_enter(118, bus, 0015434, late), 15435) ),
assertz( happensAtIE( stop_leave(118, bus, 0015434, late), 15440) ),
assertz( happensAtIE( stop_enter(119, bus, 0015443, early), 15444) ),
assertz( happensAtIE( stop_leave(119, bus, 0015443, early), 15445) ),
assertz( happensAtIE( stop_enter(119, bus, 0015452, scheduled), 15452) ),
assertz( happensAtIE( stop_leave(119, bus, 0015452, scheduled), 15456) ),
assertz( happensAtIE( stop_enter(120, bus, 0015462, early), 15462) ),
assertz( happensAtIE( stop_leave(120, bus, 0015462, late), 15464) ),
assertz( happensAtIE( stop_enter(121, bus, 0015466, scheduled), 15471) ),
assertz( happensAtIE( stop_leave(121, bus, 0015466, early), 15473) ),
assertz( happensAtIE( stop_enter(122, bus, 0015477, early), 15477) ),
assertz( happensAtIE( stop_leave(122, bus, 0015477, late), 15478) ),
assertz( happensAtIE( stop_enter(123, bus, 0015487, scheduled), 15484) ),
assertz( happensAtIE( stop_leave(123, bus, 0015487, late), 15489) ),
assertz( happensAtIE( stop_enter(123, bus, 0015495, late), 15495) ),
assertz( happensAtIE( stop_leave(123, bus, 0015495, early), 15496) ),
assertz( happensAtIE( stop_enter(124, bus, 0015503, late), 15501) ),
assertz( happensAtIE( stop_leave(124, bus, 0015503, early), 15503) ),
assertz( happensAtIE( stop_enter(125, bus, 0015512, early), 15512) ),
assertz( happensAtIE( stop_leave(125, bus, 0015512, late), 15513) ),
assertz( happensAtIE( stop_enter(126, bus, 0015520, early), 15520) ),
assertz( happensAtIE( stop_leave(126, bus, 0015520, early), 15521) ),
assertz( happensAtIE( stop_enter(127, bus, 0015524, late), 15522) ),
assertz( happensAtIE( stop_leave(127, bus, 0015524, scheduled), 15526) ),
assertz( happensAtIE( stop_enter(127, bus, 0015532, late), 15532) ),
assertz( happensAtIE( stop_leave(127, bus, 0015532, early), 15534) ),
assertz( happensAtIE( stop_enter(128, bus, 0015543, late), 15543) ),
assertz( happensAtIE( stop_leave(128, bus, 0015543, scheduled), 15545) ),
assertz( happensAtIE( stop_enter(129, bus, 0015548, early), 15546) ),
assertz( happensAtIE( stop_leave(129, bus, 0015548, late), 15553) ),
assertz( happensAtIE( stop_enter(130, bus, 0015555, early), 15556) ),
assertz( happensAtIE( stop_leave(130, bus, 0015555, scheduled), 15558) ),
assertz( happensAtIE( stop_enter(131, bus, 0015565, early), 15565) ),
assertz( happensAtIE( stop_leave(131, bus, 0015565, late), 15568) ),
assertz( happensAtIE( stop_enter(131, bus, 0015577, scheduled), 15576) ),
assertz( happensAtIE( stop_leave(131, bus, 0015577, late), 15577) ),
assertz( happensAtIE( stop_enter(132, bus, 0015585, scheduled), 15578) ),
assertz( happensAtIE( stop_leave(132, bus, 0015585, early), 15579) ),
assertz( happensAtIE( stop_enter(133, bus, 0015590, early), 15587) ),
assertz( happensAtIE( stop_leave(133, bus, 0015590, early), 15592) ),
assertz( happensAtIE( stop_enter(134, bus, 0015599, late), 15599) ),
assertz( happensAtIE( stop_leave(134, bus, 0015599, late), 15601) ),
assertz( happensAtIE( stop_enter(135, bus, 0015603, early), 15608) ),
assertz( happensAtIE( stop_leave(135, bus, 0015603, early), 15609) ),
assertz( happensAtIE( stop_enter(135, bus, 0015614, late), 15614) ),
assertz( happensAtIE( stop_leave(135, bus, 0015614, early), 15616) ),
assertz( happensAtIE( stop_enter(136, bus, 0015618, late), 15623) ),
assertz( happensAtIE( stop_leave(136, bus, 0015618, early), 15625) ),
assertz( happensAtIE( stop_enter(137, bus, 0015629, late), 15629) ),
assertz( happensAtIE( stop_leave(137, bus, 0015629, late), 15633) ),
assertz( happensAtIE( stop_enter(138, bus, 0015635, early), 15636) ),
assertz( happensAtIE( stop_leave(138, bus, 0015635, early), 15638) ),
assertz( happensAtIE( stop_enter(139, bus, 0015644, early), 15645) ),
assertz( happensAtIE( stop_leave(139, bus, 0015644, late), 15647) ),
assertz( happensAtIE( stop_enter(139, bus, 0015657, scheduled), 15654) ),
assertz( happensAtIE( stop_leave(139, bus, 0015657, scheduled), 15657) ),
assertz( happensAtIE( stop_enter(140, bus, 0015660, late), 15658) ),
assertz( happensAtIE( stop_leave(140, bus, 0015660, early), 15661) ),
assertz( happensAtIE( stop_enter(141, bus, 0015672, late), 15670) ),
assertz( happensAtIE( stop_leave(141, bus, 0015672, scheduled), 15672) ),
assertz( happensAtIE( stop_enter(142, bus, 0015681, early), 15674) ),
assertz( happensAtIE( stop_leave(142, bus, 0015681, late), 15679) ),
assertz( happensAtIE( stop_enter(143, bus, 0015689, late), 15688) ),
assertz( happensAtIE( stop_leave(143, bus, 0015689, early), 15689) ),
assertz( happensAtIE( stop_enter(143, bus, 0015694, early), 15693) ),
assertz( happensAtIE( stop_leave(143, bus, 0015694, early), 15696) ),
assertz( happensAtIE( stop_enter(144, bus, 0015698, early), 15703) ),
assertz( happensAtIE( stop_leave(144, bus, 0015698, scheduled), 15705) ),
assertz( happensAtIE( stop_enter(145, bus, 0015707, late), 15708) ),
assertz( happensAtIE( stop_leave(145, bus, 0015707, early), 15709) ),
assertz( happensAtIE( stop_enter(146, bus, 0015715, early), 15716) ),
assertz( happensAtIE( stop_leave(146, bus, 0015715, late), 15718) ),
assertz( happensAtIE( stop_enter(147, bus, 0015728, early), 15725) ),
assertz( happensAtIE( stop_leave(147, bus, 0015728, late), 15729) ),
assertz( happensAtIE( stop_enter(147, bus, 0015737, scheduled), 15736) ),
assertz( happensAtIE( stop_leave(147, bus, 0015737, late), 15737) ),
assertz( happensAtIE( stop_enter(148, bus, 0015740, scheduled), 15740) ),
assertz( happensAtIE( stop_leave(148, bus, 0015740, late), 15745) ),
assertz( happensAtIE( stop_enter(149, bus, 0015748, late), 15749) ),
assertz( happensAtIE( stop_leave(149, bus, 0015748, early), 15751) ),
assertz( happensAtIE( stop_enter(150, bus, 0015758, early), 15758) ),
assertz( happensAtIE( stop_leave(150, bus, 0015758, early), 15760) ),
assertz( happensAtIE( stop_enter(151, bus, 0015762, early), 15762) ),
assertz( happensAtIE( stop_leave(151, bus, 0015762, late), 15763) ),
assertz( happensAtIE( stop_enter(151, bus, 0015774, scheduled), 15771) ),
assertz( happensAtIE( stop_leave(151, bus, 0015774, early), 15776) ),
assertz( happensAtIE( stop_enter(152, bus, 0015783, early), 15783) ),
assertz( happensAtIE( stop_leave(152, bus, 0015783, early), 15785) ),
assertz( happensAtIE( stop_enter(153, bus, 0015787, early), 15792) ),
assertz( happensAtIE( stop_leave(153, bus, 0015787, late), 15793) ),
assertz( happensAtIE( stop_enter(154, bus, 0015795, late), 15795) ),
assertz( happensAtIE( stop_leave(154, bus, 0015795, late), 15796) ),
assertz( happensAtIE( stop_enter(155, bus, 0015803, early), 15803) ),
assertz( happensAtIE( stop_leave(155, bus, 0015803, scheduled), 15805) ),
assertz( happensAtIE( stop_enter(155, bus, 0015815, scheduled), 15813) ),
assertz( happensAtIE( stop_leave(155, bus, 0015815, scheduled), 15817) ),
assertz( happensAtIE( stop_enter(156, bus, 0015824, early), 15824) ),
assertz( happensAtIE( stop_leave(156, bus, 0015824, late), 15825) ),
assertz( happensAtIE( stop_enter(157, bus, 0015828, scheduled), 15829) ),
assertz( happensAtIE( stop_leave(157, bus, 0015828, late), 15831) ),
assertz( happensAtIE( stop_enter(158, bus, 0015840, early), 15837) ),
assertz( happensAtIE( stop_leave(158, bus, 0015840, early), 15841) ),
assertz( happensAtIE( stop_enter(159, bus, 0015847, late), 15847) ),
assertz( happensAtIE( stop_leave(159, bus, 0015847, early), 15849) ),
assertz( happensAtIE( stop_enter(159, bus, 0015852, late), 15856) ),
assertz( happensAtIE( stop_leave(159, bus, 0015852, early), 15857) ),
assertz( happensAtIE( stop_enter(160, bus, 0015863, scheduled), 15863) ),
assertz( happensAtIE( stop_leave(160, bus, 0015863, late), 15865) ),
assertz( happensAtIE( stop_enter(161, bus, 0015866, late), 15867) ),
assertz( happensAtIE( stop_leave(161, bus, 0015866, late), 15872) ),
assertz( happensAtIE( stop_enter(162, bus, 0015875, early), 15876) ),
assertz( happensAtIE( stop_leave(162, bus, 0015875, early), 15878) ),
assertz( happensAtIE( stop_enter(163, bus, 0015885, scheduled), 15884) ),
assertz( happensAtIE( stop_leave(163, bus, 0015885, early), 15887) ),
assertz( happensAtIE( stop_enter(163, bus, 0015895, scheduled), 15893) ),
assertz( happensAtIE( stop_leave(163, bus, 0015895, scheduled), 15897) ),
assertz( happensAtIE( stop_enter(164, bus, 0015904, early), 15904) ),
assertz( happensAtIE( stop_leave(164, bus, 0015904, late), 15905) ),
assertz( happensAtIE( stop_enter(165, bus, 0015909, scheduled), 15906) ),
assertz( happensAtIE( stop_leave(165, bus, 0015909, late), 15910) ),
assertz( happensAtIE( stop_enter(166, bus, 0015918, scheduled), 15918) ),
assertz( happensAtIE( stop_leave(166, bus, 0015918, late), 15920) ),
assertz( happensAtIE( stop_enter(167, bus, 0015922, late), 15922) ),
assertz( happensAtIE( stop_leave(167, bus, 0015922, scheduled), 15928) ),
assertz( happensAtIE( stop_enter(167, bus, 0015930, early), 15932) ),
assertz( happensAtIE( stop_leave(167, bus, 0015930, scheduled), 15933) ),
assertz( happensAtIE( stop_enter(168, bus, 0015940, scheduled), 15940) ),
assertz( happensAtIE( stop_leave(168, bus, 0015940, early), 15942) ),
assertz( happensAtIE( stop_enter(169, bus, 0015950, scheduled), 15947) ),
assertz( happensAtIE( stop_leave(169, bus, 0015950, late), 15951) ),
assertz( happensAtIE( stop_enter(170, bus, 0015959, early), 15959) ),
assertz( happensAtIE( stop_leave(170, bus, 0015959, late), 15961) ),
assertz( happensAtIE( stop_enter(171, bus, 0015963, early), 15963) ),
assertz( happensAtIE( stop_leave(171, bus, 0015963, scheduled), 15965) ),
assertz( happensAtIE( stop_enter(171, bus, 0015972, early), 15972) ),
assertz( happensAtIE( stop_leave(171, bus, 0015972, early), 15973) ),
assertz( happensAtIE( stop_enter(172, bus, 0015982, early), 15983) ),
assertz( happensAtIE( stop_leave(172, bus, 0015982, early), 15985) ),
assertz( happensAtIE( stop_enter(173, bus, 0015991, late), 15991) ),
assertz( happensAtIE( stop_leave(173, bus, 0015991, scheduled), 15993) ),
assertz( happensAtIE( stop_enter(174, bus, 0015995, early), 15998) ),
assertz( happensAtIE( stop_leave(174, bus, 0015995, early), 15999) ).
