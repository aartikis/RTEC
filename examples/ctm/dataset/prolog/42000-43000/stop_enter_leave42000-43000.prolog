 
updateSDE( stop_enter_leave, '1p_all', 42000, 43000 ) :-
assertz( happensAtIE( stop_enter(75, bus, 0042004, late), 42004) ),
assertz( happensAtIE( stop_leave(75, bus, 0042004, scheduled), 42005) ),
assertz( happensAtIE( stop_enter(75, bus, 0042014, scheduled), 42012) ),
assertz( happensAtIE( stop_leave(75, bus, 0042014, early), 42016) ),
assertz( happensAtIE( stop_enter(76, bus, 0042023, scheduled), 42023) ),
assertz( happensAtIE( stop_leave(76, bus, 0042023, late), 42025) ),
assertz( happensAtIE( stop_enter(77, bus, 0042027, scheduled), 42028) ),
assertz( happensAtIE( stop_leave(77, bus, 0042027, early), 42030) ),
assertz( happensAtIE( stop_enter(78, bus, 0042036, late), 42036) ),
assertz( happensAtIE( stop_leave(78, bus, 0042036, scheduled), 42038) ),
assertz( happensAtIE( stop_enter(79, bus, 0042048, early), 42048) ),
assertz( happensAtIE( stop_leave(79, bus, 0042048, late), 42049) ),
assertz( happensAtIE( stop_enter(79, bus, 0042050, early), 42055) ),
assertz( happensAtIE( stop_leave(79, bus, 0042050, early), 42057) ),
assertz( happensAtIE( stop_enter(80, bus, 0042061, scheduled), 42061) ),
assertz( happensAtIE( stop_leave(80, bus, 0042061, late), 42062) ),
assertz( happensAtIE( stop_enter(81, bus, 0042069, early), 42069) ),
assertz( happensAtIE( stop_leave(81, bus, 0042069, late), 42071) ),
assertz( happensAtIE( stop_enter(82, bus, 0042081, late), 42078) ),
assertz( happensAtIE( stop_leave(82, bus, 0042081, scheduled), 42079) ),
assertz( happensAtIE( stop_enter(83, bus, 0042084, scheduled), 42084) ),
assertz( happensAtIE( stop_leave(83, bus, 0042084, scheduled), 42086) ),
assertz( happensAtIE( stop_enter(83, bus, 0042096, scheduled), 42093) ),
assertz( happensAtIE( stop_leave(83, bus, 0042096, late), 42095) ),
assertz( happensAtIE( stop_enter(84, bus, 0042098, early), 42098) ),
assertz( happensAtIE( stop_leave(84, bus, 0042098, early), 42101) ),
assertz( happensAtIE( stop_enter(85, bus, 0042112, scheduled), 42106) ),
assertz( happensAtIE( stop_leave(85, bus, 0042112, early), 42113) ),
assertz( happensAtIE( stop_enter(86, bus, 0042116, early), 42114) ),
assertz( happensAtIE( stop_leave(86, bus, 0042116, early), 42117) ),
assertz( happensAtIE( stop_enter(87, bus, 0042125, scheduled), 42125) ),
assertz( happensAtIE( stop_leave(87, bus, 0042125, scheduled), 42128) ),
assertz( happensAtIE( stop_enter(87, bus, 0042137, scheduled), 42130) ),
assertz( happensAtIE( stop_leave(87, bus, 0042137, late), 42137) ),
assertz( happensAtIE( stop_enter(88, bus, 0042141, scheduled), 42141) ),
assertz( happensAtIE( stop_leave(88, bus, 0042141, late), 42142) ),
assertz( happensAtIE( stop_enter(89, bus, 0042149, early), 42149) ),
assertz( happensAtIE( stop_leave(89, bus, 0042149, late), 42151) ),
assertz( happensAtIE( stop_enter(90, bus, 0042159, late), 42156) ),
assertz( happensAtIE( stop_leave(90, bus, 0042159, early), 42161) ),
assertz( happensAtIE( stop_enter(91, bus, 0042169, early), 42168) ),
assertz( happensAtIE( stop_leave(91, bus, 0042169, late), 42169) ),
assertz( happensAtIE( stop_enter(91, bus, 0042172, scheduled), 42173) ),
assertz( happensAtIE( stop_leave(91, bus, 0042172, scheduled), 42175) ),
assertz( happensAtIE( stop_enter(92, bus, 0042181, scheduled), 42181) ),
assertz( happensAtIE( stop_leave(92, bus, 0042181, early), 42184) ),
assertz( happensAtIE( stop_enter(93, bus, 0042186, scheduled), 42191) ),
assertz( happensAtIE( stop_leave(93, bus, 0042186, early), 42192) ),
assertz( happensAtIE( stop_enter(94, bus, 0042197, late), 42197) ),
assertz( happensAtIE( stop_leave(94, bus, 0042197, late), 42199) ),
assertz( happensAtIE( stop_enter(95, bus, 0042209, scheduled), 42206) ),
assertz( happensAtIE( stop_leave(95, bus, 0042209, scheduled), 42207) ),
assertz( happensAtIE( stop_enter(95, bus, 0042216, late), 42215) ),
assertz( happensAtIE( stop_leave(95, bus, 0042216, early), 42216) ),
assertz( happensAtIE( stop_enter(96, bus, 0042224, late), 42218) ),
assertz( happensAtIE( stop_leave(96, bus, 0042224, early), 42225) ),
assertz( happensAtIE( stop_enter(97, bus, 0042228, scheduled), 42226) ),
assertz( happensAtIE( stop_leave(97, bus, 0042228, late), 42229) ),
assertz( happensAtIE( stop_enter(98, bus, 0042240, scheduled), 42237) ),
assertz( happensAtIE( stop_leave(98, bus, 0042240, scheduled), 42241) ),
assertz( happensAtIE( stop_enter(99, bus, 0042249, scheduled), 42242) ),
assertz( happensAtIE( stop_leave(99, bus, 0042249, early), 42243) ),
assertz( happensAtIE( stop_enter(99, bus, 0042254, late), 42251) ),
assertz( happensAtIE( stop_leave(99, bus, 0042254, early), 42252) ),
assertz( happensAtIE( stop_enter(100, bus, 0042263, scheduled), 42263) ),
assertz( happensAtIE( stop_leave(100, bus, 0042263, early), 42264) ),
assertz( happensAtIE( stop_enter(101, bus, 0042269, early), 42268) ),
assertz( happensAtIE( stop_leave(101, bus, 0042269, scheduled), 42271) ),
assertz( happensAtIE( stop_enter(102, bus, 0042280, scheduled), 42280) ),
assertz( happensAtIE( stop_leave(102, bus, 0042280, late), 42281) ),
assertz( happensAtIE( stop_enter(103, bus, 0042283, early), 42284) ),
assertz( happensAtIE( stop_leave(103, bus, 0042283, scheduled), 42286) ),
assertz( happensAtIE( stop_enter(103, bus, 0042296, late), 42293) ),
assertz( happensAtIE( stop_leave(103, bus, 0042296, late), 42297) ),
assertz( happensAtIE( stop_enter(104, bus, 0042305, late), 42298) ),
assertz( happensAtIE( stop_leave(104, bus, 0042305, scheduled), 42301) ),
assertz( happensAtIE( stop_enter(105, bus, 0042308, early), 42308) ),
assertz( happensAtIE( stop_leave(105, bus, 0042308, early), 42311) ),
assertz( happensAtIE( stop_enter(106, bus, 0042318, late), 42316) ),
assertz( happensAtIE( stop_leave(106, bus, 0042318, scheduled), 42318) ),
assertz( happensAtIE( stop_enter(107, bus, 0042328, early), 42327) ),
assertz( happensAtIE( stop_leave(107, bus, 0042328, late), 42329) ),
assertz( happensAtIE( stop_enter(107, bus, 0042336, early), 42336) ),
assertz( happensAtIE( stop_leave(107, bus, 0042336, late), 42337) ),
assertz( happensAtIE( stop_enter(108, bus, 0042340, late), 42340) ),
assertz( happensAtIE( stop_leave(108, bus, 0042340, late), 42342) ),
assertz( happensAtIE( stop_enter(109, bus, 0042352, late), 42349) ),
assertz( happensAtIE( stop_leave(109, bus, 0042352, late), 42353) ),
assertz( happensAtIE( stop_enter(110, bus, 0042361, late), 42354) ),
assertz( happensAtIE( stop_leave(110, bus, 0042361, early), 42355) ),
assertz( happensAtIE( stop_enter(111, bus, 0042366, early), 42363) ),
assertz( happensAtIE( stop_leave(111, bus, 0042366, late), 42369) ),
assertz( happensAtIE( stop_enter(111, bus, 0042372, early), 42372) ),
assertz( happensAtIE( stop_leave(111, bus, 0042372, early), 42374) ),
assertz( happensAtIE( stop_enter(112, bus, 0042381, late), 42381) ),
assertz( happensAtIE( stop_leave(112, bus, 0042381, scheduled), 42383) ),
assertz( happensAtIE( stop_enter(113, bus, 0042393, scheduled), 42390) ),
assertz( happensAtIE( stop_leave(113, bus, 0042393, early), 42391) ),
assertz( happensAtIE( stop_enter(114, bus, 0042396, late), 42396) ),
assertz( happensAtIE( stop_leave(114, bus, 0042396, scheduled), 42399) ),
assertz( happensAtIE( stop_enter(115, bus, 0042408, early), 42408) ),
assertz( happensAtIE( stop_leave(115, bus, 0042408, scheduled), 42409) ),
assertz( happensAtIE( stop_enter(115, bus, 0042417, scheduled), 42410) ),
assertz( happensAtIE( stop_leave(115, bus, 0042417, late), 42417) ),
assertz( happensAtIE( stop_enter(116, bus, 0042418, scheduled), 42423) ),
assertz( happensAtIE( stop_leave(116, bus, 0042418, late), 42424) ),
assertz( happensAtIE( stop_enter(117, bus, 0042429, late), 42429) ),
assertz( happensAtIE( stop_leave(117, bus, 0042429, late), 42432) ),
assertz( happensAtIE( stop_enter(118, bus, 0042441, late), 42438) ),
assertz( happensAtIE( stop_leave(118, bus, 0042441, early), 42440) ),
assertz( happensAtIE( stop_enter(119, bus, 0042442, early), 42443) ),
assertz( happensAtIE( stop_leave(119, bus, 0042442, late), 42448) ),
assertz( happensAtIE( stop_enter(119, bus, 0042451, early), 42452) ),
assertz( happensAtIE( stop_leave(119, bus, 0042451, scheduled), 42454) ),
assertz( happensAtIE( stop_enter(120, bus, 0042460, scheduled), 42460) ),
assertz( happensAtIE( stop_leave(120, bus, 0042460, early), 42463) ),
assertz( happensAtIE( stop_enter(121, bus, 0042472, scheduled), 42472) ),
assertz( happensAtIE( stop_leave(121, bus, 0042472, late), 42473) ),
assertz( happensAtIE( stop_enter(122, bus, 0042474, scheduled), 42475) ),
assertz( happensAtIE( stop_leave(122, bus, 0042474, late), 42476) ),
assertz( happensAtIE( stop_enter(123, bus, 0042483, scheduled), 42483) ),
assertz( happensAtIE( stop_leave(123, bus, 0042483, early), 42485) ),
assertz( happensAtIE( stop_enter(123, bus, 0042494, early), 42495) ),
assertz( happensAtIE( stop_leave(123, bus, 0042494, scheduled), 42497) ),
assertz( happensAtIE( stop_enter(124, bus, 0042503, early), 42503) ),
assertz( happensAtIE( stop_leave(124, bus, 0042503, scheduled), 42505) ),
assertz( happensAtIE( stop_enter(125, bus, 0042507, late), 42512) ),
assertz( happensAtIE( stop_leave(125, bus, 0042507, scheduled), 42513) ),
assertz( happensAtIE( stop_enter(126, bus, 0042518, scheduled), 42517) ),
assertz( happensAtIE( stop_leave(126, bus, 0042518, early), 42520) ),
assertz( happensAtIE( stop_enter(127, bus, 0042522, scheduled), 42527) ),
assertz( happensAtIE( stop_leave(127, bus, 0042522, early), 42529) ),
assertz( happensAtIE( stop_enter(127, bus, 0042532, early), 42533) ),
assertz( happensAtIE( stop_leave(127, bus, 0042532, scheduled), 42534) ),
assertz( happensAtIE( stop_enter(128, bus, 0042540, scheduled), 42541) ),
assertz( happensAtIE( stop_leave(128, bus, 0042540, early), 42543) ),
assertz( happensAtIE( stop_enter(129, bus, 0042551, early), 42550) ),
assertz( happensAtIE( stop_leave(129, bus, 0042551, early), 42553) ),
assertz( happensAtIE( stop_enter(130, bus, 0042555, scheduled), 42560) ),
assertz( happensAtIE( stop_leave(130, bus, 0042555, early), 42561) ),
assertz( happensAtIE( stop_enter(131, bus, 0042564, early), 42565) ),
assertz( happensAtIE( stop_leave(131, bus, 0042564, late), 42567) ),
assertz( happensAtIE( stop_enter(131, bus, 0042573, late), 42573) ),
assertz( happensAtIE( stop_leave(131, bus, 0042573, early), 42576) ),
assertz( happensAtIE( stop_enter(132, bus, 0042579, scheduled), 42579) ),
assertz( happensAtIE( stop_leave(132, bus, 0042579, late), 42581) ),
assertz( happensAtIE( stop_enter(133, bus, 0042592, late), 42589) ),
assertz( happensAtIE( stop_leave(133, bus, 0042592, scheduled), 42593) ),
assertz( happensAtIE( stop_enter(134, bus, 0042598, scheduled), 42599) ),
assertz( happensAtIE( stop_leave(134, bus, 0042598, late), 42601) ),
assertz( happensAtIE( stop_enter(135, bus, 0042603, scheduled), 42608) ),
assertz( happensAtIE( stop_leave(135, bus, 0042603, early), 42609) ),
assertz( happensAtIE( stop_enter(135, bus, 0042611, late), 42612) ),
assertz( happensAtIE( stop_leave(135, bus, 0042611, scheduled), 42614) ),
assertz( happensAtIE( stop_enter(136, bus, 0042621, late), 42621) ),
assertz( happensAtIE( stop_leave(136, bus, 0042621, late), 42623) ),
assertz( happensAtIE( stop_enter(137, bus, 0042632, scheduled), 42630) ),
assertz( happensAtIE( stop_leave(137, bus, 0042632, early), 42633) ),
assertz( happensAtIE( stop_enter(138, bus, 0042636, late), 42636) ),
assertz( happensAtIE( stop_leave(138, bus, 0042636, scheduled), 42638) ),
assertz( happensAtIE( stop_enter(139, bus, 0042648, late), 42645) ),
assertz( happensAtIE( stop_leave(139, bus, 0042648, late), 42646) ),
assertz( happensAtIE( stop_enter(139, bus, 0042655, early), 42655) ),
assertz( happensAtIE( stop_leave(139, bus, 0042655, late), 42656) ),
assertz( happensAtIE( stop_enter(140, bus, 0042663, late), 42664) ),
assertz( happensAtIE( stop_leave(140, bus, 0042663, scheduled), 42665) ),
assertz( happensAtIE( stop_enter(141, bus, 0042673, late), 42666) ),
assertz( happensAtIE( stop_leave(141, bus, 0042673, early), 42667) ),
assertz( happensAtIE( stop_enter(142, bus, 0042677, scheduled), 42677) ),
assertz( happensAtIE( stop_leave(142, bus, 0042677, late), 42679) ),
assertz( happensAtIE( stop_enter(143, bus, 0042689, scheduled), 42686) ),
assertz( happensAtIE( stop_leave(143, bus, 0042689, scheduled), 42689) ),
assertz( happensAtIE( stop_enter(143, bus, 0042692, late), 42692) ),
assertz( happensAtIE( stop_leave(143, bus, 0042692, late), 42693) ),
assertz( happensAtIE( stop_enter(144, bus, 0042705, late), 42698) ),
assertz( happensAtIE( stop_leave(144, bus, 0042705, scheduled), 42699) ),
assertz( happensAtIE( stop_enter(145, bus, 0042710, early), 42707) ),
assertz( happensAtIE( stop_leave(145, bus, 0042710, late), 42712) ),
assertz( happensAtIE( stop_enter(146, bus, 0042714, late), 42719) ),
assertz( happensAtIE( stop_leave(146, bus, 0042714, early), 42721) ),
assertz( happensAtIE( stop_enter(147, bus, 0042725, late), 42725) ),
assertz( happensAtIE( stop_leave(147, bus, 0042725, late), 42726) ),
assertz( happensAtIE( stop_enter(147, bus, 0042732, scheduled), 42733) ),
assertz( happensAtIE( stop_leave(147, bus, 0042732, early), 42735) ),
assertz( happensAtIE( stop_enter(148, bus, 0042745, early), 42739) ),
assertz( happensAtIE( stop_leave(148, bus, 0042745, early), 42740) ),
assertz( happensAtIE( stop_enter(149, bus, 0042753, late), 42752) ),
assertz( happensAtIE( stop_leave(149, bus, 0042753, scheduled), 42753) ),
assertz( happensAtIE( stop_enter(150, bus, 0042758, scheduled), 42758) ),
assertz( happensAtIE( stop_leave(150, bus, 0042758, scheduled), 42760) ),
assertz( happensAtIE( stop_enter(151, bus, 0042762, early), 42767) ),
assertz( happensAtIE( stop_leave(151, bus, 0042762, early), 42769) ),
assertz( happensAtIE( stop_enter(151, bus, 0042773, late), 42773) ),
assertz( happensAtIE( stop_leave(151, bus, 0042773, scheduled), 42775) ),
assertz( happensAtIE( stop_enter(152, bus, 0042781, scheduled), 42781) ),
assertz( happensAtIE( stop_leave(152, bus, 0042781, late), 42783) ),
assertz( happensAtIE( stop_enter(153, bus, 0042787, early), 42790) ),
assertz( happensAtIE( stop_leave(153, bus, 0042787, early), 42792) ),
assertz( happensAtIE( stop_enter(154, bus, 0042795, early), 42795) ),
assertz( happensAtIE( stop_leave(154, bus, 0042795, scheduled), 42797) ),
assertz( happensAtIE( stop_enter(155, bus, 0042807, late), 42804) ),
assertz( happensAtIE( stop_leave(155, bus, 0042807, early), 42805) ),
assertz( happensAtIE( stop_enter(155, bus, 0042816, scheduled), 42816) ),
assertz( happensAtIE( stop_leave(155, bus, 0042816, early), 42817) ),
assertz( happensAtIE( stop_enter(156, bus, 0042822, scheduled), 42822) ),
assertz( happensAtIE( stop_leave(156, bus, 0042822, early), 42825) ),
assertz( happensAtIE( stop_enter(157, bus, 0042826, scheduled), 42831) ),
assertz( happensAtIE( stop_leave(157, bus, 0042826, late), 42832) ),
assertz( happensAtIE( stop_enter(158, bus, 0042837, scheduled), 42837) ),
assertz( happensAtIE( stop_leave(158, bus, 0042837, late), 42840) ),
assertz( happensAtIE( stop_enter(159, bus, 0042849, late), 42842) ),
assertz( happensAtIE( stop_leave(159, bus, 0042849, late), 42847) ),
assertz( happensAtIE( stop_enter(159, bus, 0042850, late), 42851) ),
assertz( happensAtIE( stop_leave(159, bus, 0042850, early), 42853) ),
assertz( happensAtIE( stop_enter(160, bus, 0042860, late), 42860) ),
assertz( happensAtIE( stop_leave(160, bus, 0042860, late), 42862) ),
assertz( happensAtIE( stop_enter(161, bus, 0042872, late), 42872) ),
assertz( happensAtIE( stop_leave(161, bus, 0042872, early), 42873) ),
assertz( happensAtIE( stop_enter(162, bus, 0042874, late), 42879) ),
assertz( happensAtIE( stop_leave(162, bus, 0042874, scheduled), 42881) ),
assertz( happensAtIE( stop_enter(163, bus, 0042882, late), 42883) ),
assertz( happensAtIE( stop_leave(163, bus, 0042882, early), 42884) ),
assertz( happensAtIE( stop_enter(163, bus, 0042891, late), 42891) ),
assertz( happensAtIE( stop_leave(163, bus, 0042891, scheduled), 42893) ),
assertz( happensAtIE( stop_enter(164, bus, 0042903, early), 42901) ),
assertz( happensAtIE( stop_leave(164, bus, 0042903, early), 42905) ),
assertz( happensAtIE( stop_enter(165, bus, 0042908, scheduled), 42906) ),
assertz( happensAtIE( stop_leave(165, bus, 0042908, early), 42908) ),
assertz( happensAtIE( stop_enter(166, bus, 0042915, late), 42916) ),
assertz( happensAtIE( stop_leave(166, bus, 0042915, scheduled), 42918) ),
assertz( happensAtIE( stop_enter(167, bus, 0042926, late), 42926) ),
assertz( happensAtIE( stop_leave(167, bus, 0042926, late), 42928) ),
assertz( happensAtIE( stop_enter(167, bus, 0042930, early), 42935) ),
assertz( happensAtIE( stop_leave(167, bus, 0042930, late), 42937) ),
assertz( happensAtIE( stop_enter(168, bus, 0042940, scheduled), 42941) ),
assertz( happensAtIE( stop_leave(168, bus, 0042940, early), 42942) ),
assertz( happensAtIE( stop_enter(169, bus, 0042949, early), 42948) ),
assertz( happensAtIE( stop_leave(169, bus, 0042949, late), 42953) ),
assertz( happensAtIE( stop_enter(170, bus, 0042960, late), 42960) ),
assertz( happensAtIE( stop_leave(170, bus, 0042960, late), 42961) ),
assertz( happensAtIE( stop_enter(171, bus, 0042963, early), 42964) ),
assertz( happensAtIE( stop_leave(171, bus, 0042963, scheduled), 42966) ),
assertz( happensAtIE( stop_enter(171, bus, 0042974, scheduled), 42974) ),
assertz( happensAtIE( stop_leave(171, bus, 0042974, scheduled), 42976) ),
assertz( happensAtIE( stop_enter(172, bus, 0042984, late), 42981) ),
assertz( happensAtIE( stop_leave(172, bus, 0042984, early), 42985) ),
assertz( happensAtIE( stop_enter(173, bus, 0042993, early), 42986) ),
assertz( happensAtIE( stop_leave(173, bus, 0042993, late), 42987) ),
assertz( happensAtIE( stop_enter(174, bus, 0042996, scheduled), 42996) ),
assertz( happensAtIE( stop_leave(174, bus, 0042996, late), 42998) ).
