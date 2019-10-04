 
updateSDE( stop_enter_leave, '1p_all', 7000, 8000 ) :-
assert( happensAtIE( stop_enter(75, bus, 007002, early), 7007) ),
assert( happensAtIE( stop_leave(75, bus, 007002, late), 7008) ),
assert( happensAtIE( stop_enter(75, bus, 007015, early), 7012) ),
assert( happensAtIE( stop_leave(75, bus, 007015, early), 7016) ),
assert( happensAtIE( stop_enter(76, bus, 007019, scheduled), 7024) ),
assert( happensAtIE( stop_leave(76, bus, 007019, early), 7025) ),
assert( happensAtIE( stop_enter(77, bus, 007027, late), 7028) ),
assert( happensAtIE( stop_leave(77, bus, 007027, late), 7033) ),
assert( happensAtIE( stop_enter(78, bus, 007036, scheduled), 7037) ),
assert( happensAtIE( stop_leave(78, bus, 007036, scheduled), 7039) ),
assert( happensAtIE( stop_enter(79, bus, 007048, early), 7045) ),
assert( happensAtIE( stop_leave(79, bus, 007048, early), 7049) ),
assert( happensAtIE( stop_enter(79, bus, 007055, scheduled), 7055) ),
assert( happensAtIE( stop_leave(79, bus, 007055, scheduled), 7057) ),
assert( happensAtIE( stop_enter(80, bus, 007060, early), 7058) ),
assert( happensAtIE( stop_leave(80, bus, 007060, late), 7061) ),
assert( happensAtIE( stop_enter(81, bus, 007069, scheduled), 7069) ),
assert( happensAtIE( stop_leave(81, bus, 007069, late), 7072) ),
assert( happensAtIE( stop_enter(82, bus, 007074, early), 7079) ),
assert( happensAtIE( stop_leave(82, bus, 007074, early), 7081) ),
assert( happensAtIE( stop_enter(83, bus, 007083, scheduled), 7083) ),
assert( happensAtIE( stop_leave(83, bus, 007083, scheduled), 7089) ),
assert( happensAtIE( stop_enter(83, bus, 007092, early), 7092) ),
assert( happensAtIE( stop_leave(83, bus, 007092, late), 7094) ),
assert( happensAtIE( stop_enter(84, bus, 007100, late), 7101) ),
assert( happensAtIE( stop_leave(84, bus, 007100, early), 7103) ),
assert( happensAtIE( stop_enter(85, bus, 007112, late), 7109) ),
assert( happensAtIE( stop_leave(85, bus, 007112, late), 7113) ),
assert( happensAtIE( stop_enter(86, bus, 007116, late), 7120) ),
assert( happensAtIE( stop_leave(86, bus, 007116, scheduled), 7121) ),
assert( happensAtIE( stop_enter(87, bus, 007125, early), 7125) ),
assert( happensAtIE( stop_leave(87, bus, 007125, early), 7128) ),
assert( happensAtIE( stop_enter(87, bus, 007130, early), 7135) ),
assert( happensAtIE( stop_leave(87, bus, 007130, scheduled), 7137) ),
assert( happensAtIE( stop_enter(88, bus, 007138, scheduled), 7139) ),
assert( happensAtIE( stop_leave(88, bus, 007138, late), 7140) ),
assert( happensAtIE( stop_enter(89, bus, 007147, early), 7148) ),
assert( happensAtIE( stop_leave(89, bus, 007147, early), 7150) ),
assert( happensAtIE( stop_enter(90, bus, 007160, early), 7157) ),
assert( happensAtIE( stop_leave(90, bus, 007160, scheduled), 7161) ),
assert( happensAtIE( stop_enter(91, bus, 007167, early), 7166) ),
assert( happensAtIE( stop_leave(91, bus, 007167, early), 7169) ),
assert( happensAtIE( stop_enter(91, bus, 007171, early), 7176) ),
assert( happensAtIE( stop_leave(91, bus, 007171, scheduled), 7177) ),
assert( happensAtIE( stop_enter(92, bus, 007182, late), 7182) ),
assert( happensAtIE( stop_leave(92, bus, 007182, early), 7185) ),
assert( happensAtIE( stop_enter(93, bus, 007186, scheduled), 7187) ),
assert( happensAtIE( stop_leave(93, bus, 007186, late), 7193) ),
assert( happensAtIE( stop_enter(94, bus, 007195, scheduled), 7196) ),
assert( happensAtIE( stop_leave(94, bus, 007195, early), 7198) ),
assert( happensAtIE( stop_enter(95, bus, 007204, early), 7205) ),
assert( happensAtIE( stop_leave(95, bus, 007204, early), 7207) ),
assert( happensAtIE( stop_enter(95, bus, 007214, early), 7212) ),
assert( happensAtIE( stop_leave(95, bus, 007214, scheduled), 7216) ),
assert( happensAtIE( stop_enter(96, bus, 007224, late), 7224) ),
assert( happensAtIE( stop_leave(96, bus, 007224, scheduled), 7225) ),
assert( happensAtIE( stop_enter(97, bus, 007228, scheduled), 7226) ),
assert( happensAtIE( stop_leave(97, bus, 007228, late), 7230) ),
assert( happensAtIE( stop_enter(98, bus, 007238, scheduled), 7238) ),
assert( happensAtIE( stop_leave(98, bus, 007238, early), 7240) ),
assert( happensAtIE( stop_enter(99, bus, 007242, scheduled), 7247) ),
assert( happensAtIE( stop_leave(99, bus, 007242, late), 7249) ),
assert( happensAtIE( stop_enter(99, bus, 007251, scheduled), 7251) ),
assert( happensAtIE( stop_leave(99, bus, 007251, late), 7257) ),
assert( happensAtIE( stop_enter(100, bus, 007260, scheduled), 7261) ),
assert( happensAtIE( stop_leave(100, bus, 007260, late), 7263) ),
assert( happensAtIE( stop_enter(101, bus, 007267, early), 7267) ),
assert( happensAtIE( stop_leave(101, bus, 007267, early), 7269) ),
assert( happensAtIE( stop_enter(102, bus, 007279, early), 7277) ),
assert( happensAtIE( stop_leave(102, bus, 007279, late), 7281) ),
assert( happensAtIE( stop_enter(103, bus, 007289, early), 7288) ),
assert( happensAtIE( stop_leave(103, bus, 007289, early), 7289) ),
assert( happensAtIE( stop_enter(103, bus, 007295, early), 7295) ),
assert( happensAtIE( stop_leave(103, bus, 007295, early), 7297) ),
assert( happensAtIE( stop_enter(104, bus, 007299, early), 7304) ),
assert( happensAtIE( stop_leave(104, bus, 007299, scheduled), 7305) ),
assert( happensAtIE( stop_enter(105, bus, 007309, early), 7309) ),
assert( happensAtIE( stop_leave(105, bus, 007309, late), 7310) ),
assert( happensAtIE( stop_enter(106, bus, 007315, early), 7315) ),
assert( happensAtIE( stop_leave(106, bus, 007315, scheduled), 7317) ),
assert( happensAtIE( stop_enter(107, bus, 007326, late), 7324) ),
assert( happensAtIE( stop_leave(107, bus, 007326, early), 7328) ),
assert( happensAtIE( stop_enter(107, bus, 007336, scheduled), 7336) ),
assert( happensAtIE( stop_leave(107, bus, 007336, scheduled), 7337) ),
assert( happensAtIE( stop_enter(108, bus, 007340, scheduled), 7340) ),
assert( happensAtIE( stop_leave(108, bus, 007340, late), 7342) ),
assert( happensAtIE( stop_enter(109, bus, 007349, late), 7349) ),
assert( happensAtIE( stop_leave(109, bus, 007349, scheduled), 7351) ),
assert( happensAtIE( stop_enter(110, bus, 007361, scheduled), 7358) ),
assert( happensAtIE( stop_leave(110, bus, 007361, late), 7359) ),
assert( happensAtIE( stop_enter(111, bus, 007366, late), 7364) ),
assert( happensAtIE( stop_leave(111, bus, 007366, scheduled), 7369) ),
assert( happensAtIE( stop_enter(111, bus, 007371, late), 7372) ),
assert( happensAtIE( stop_leave(111, bus, 007371, scheduled), 7374) ),
assert( happensAtIE( stop_enter(112, bus, 007384, late), 7381) ),
assert( happensAtIE( stop_leave(112, bus, 007384, early), 7385) ),
assert( happensAtIE( stop_enter(113, bus, 007393, late), 7386) ),
assert( happensAtIE( stop_leave(113, bus, 007393, early), 7389) ),
assert( happensAtIE( stop_enter(114, bus, 007396, early), 7397) ),
assert( happensAtIE( stop_leave(114, bus, 007396, scheduled), 7399) ),
assert( happensAtIE( stop_enter(115, bus, 007409, scheduled), 7406) ),
assert( happensAtIE( stop_leave(115, bus, 007409, late), 7408) ),
assert( happensAtIE( stop_enter(115, bus, 007410, late), 7411) ),
assert( happensAtIE( stop_leave(115, bus, 007410, late), 7416) ),
assert( happensAtIE( stop_enter(116, bus, 007425, early), 7420) ),
assert( happensAtIE( stop_leave(116, bus, 007425, scheduled), 7421) ),
assert( happensAtIE( stop_enter(117, bus, 007430, early), 7428) ),
assert( happensAtIE( stop_leave(117, bus, 007430, scheduled), 7432) ),
assert( happensAtIE( stop_enter(118, bus, 007440, scheduled), 7440) ),
assert( happensAtIE( stop_leave(118, bus, 007440, early), 7441) ),
assert( happensAtIE( stop_enter(119, bus, 007444, early), 7442) ),
assert( happensAtIE( stop_leave(119, bus, 007444, late), 7449) ),
assert( happensAtIE( stop_enter(119, bus, 007452, scheduled), 7453) ),
assert( happensAtIE( stop_leave(119, bus, 007452, late), 7455) ),
assert( happensAtIE( stop_enter(120, bus, 007461, scheduled), 7461) ),
assert( happensAtIE( stop_leave(120, bus, 007461, late), 7463) ),
assert( happensAtIE( stop_enter(121, bus, 007473, late), 7470) ),
assert( happensAtIE( stop_leave(121, bus, 007473, early), 7471) ),
assert( happensAtIE( stop_enter(122, bus, 007474, scheduled), 7474) ),
assert( happensAtIE( stop_leave(122, bus, 007474, late), 7475) ),
assert( happensAtIE( stop_enter(123, bus, 007486, early), 7484) ),
assert( happensAtIE( stop_leave(123, bus, 007486, late), 7486) ),
assert( happensAtIE( stop_enter(123, bus, 007496, late), 7496) ),
assert( happensAtIE( stop_leave(123, bus, 007496, scheduled), 7497) ),
assert( happensAtIE( stop_enter(124, bus, 007504, scheduled), 7503) ),
assert( happensAtIE( stop_leave(124, bus, 007504, early), 7505) ),
assert( happensAtIE( stop_enter(125, bus, 007506, early), 7507) ),
assert( happensAtIE( stop_leave(125, bus, 007506, scheduled), 7510) ),
assert( happensAtIE( stop_enter(126, bus, 007520, scheduled), 7517) ),
assert( happensAtIE( stop_leave(126, bus, 007520, late), 7518) ),
assert( happensAtIE( stop_enter(127, bus, 007526, late), 7525) ),
assert( happensAtIE( stop_leave(127, bus, 007526, late), 7527) ),
assert( happensAtIE( stop_enter(127, bus, 007533, late), 7534) ),
assert( happensAtIE( stop_leave(127, bus, 007533, scheduled), 7536) ),
assert( happensAtIE( stop_enter(128, bus, 007544, late), 7541) ),
assert( happensAtIE( stop_leave(128, bus, 007544, late), 7545) ),
assert( happensAtIE( stop_enter(129, bus, 007553, scheduled), 7546) ),
assert( happensAtIE( stop_leave(129, bus, 007553, scheduled), 7547) ),
assert( happensAtIE( stop_enter(130, bus, 007558, scheduled), 7555) ),
assert( happensAtIE( stop_leave(130, bus, 007558, early), 7559) ),
assert( happensAtIE( stop_enter(131, bus, 007567, scheduled), 7567) ),
assert( happensAtIE( stop_leave(131, bus, 007567, early), 7569) ),
assert( happensAtIE( stop_enter(131, bus, 007571, early), 7576) ),
assert( happensAtIE( stop_leave(131, bus, 007571, early), 7577) ),
assert( happensAtIE( stop_enter(132, bus, 007581, scheduled), 7581) ),
assert( happensAtIE( stop_leave(132, bus, 007581, early), 7582) ),
assert( happensAtIE( stop_enter(133, bus, 007588, scheduled), 7589) ),
assert( happensAtIE( stop_leave(133, bus, 007588, early), 7591) ),
assert( happensAtIE( stop_enter(134, bus, 007599, scheduled), 7596) ),
assert( happensAtIE( stop_leave(134, bus, 007599, late), 7601) ),
assert( happensAtIE( stop_enter(135, bus, 007608, late), 7608) ),
assert( happensAtIE( stop_leave(135, bus, 007608, late), 7609) ),
assert( happensAtIE( stop_enter(135, bus, 007614, scheduled), 7611) ),
assert( happensAtIE( stop_leave(135, bus, 007614, scheduled), 7612) ),
assert( happensAtIE( stop_enter(136, bus, 007623, scheduled), 7623) ),
assert( happensAtIE( stop_leave(136, bus, 007623, early), 7624) ),
assert( happensAtIE( stop_enter(137, bus, 007632, late), 7632) ),
assert( happensAtIE( stop_leave(137, bus, 007632, late), 7633) ),
assert( happensAtIE( stop_enter(138, bus, 007641, late), 7634) ),
assert( happensAtIE( stop_leave(138, bus, 007641, scheduled), 7636) ),
assert( happensAtIE( stop_enter(139, bus, 007645, scheduled), 7645) ),
assert( happensAtIE( stop_leave(139, bus, 007645, late), 7647) ),
assert( happensAtIE( stop_enter(139, bus, 007655, late), 7652) ),
assert( happensAtIE( stop_leave(139, bus, 007655, late), 7657) ),
assert( happensAtIE( stop_enter(140, bus, 007664, scheduled), 7664) ),
assert( happensAtIE( stop_leave(140, bus, 007664, early), 7665) ),
assert( happensAtIE( stop_enter(141, bus, 007668, scheduled), 7668) ),
assert( happensAtIE( stop_leave(141, bus, 007668, late), 7673) ),
assert( happensAtIE( stop_enter(142, bus, 007677, late), 7677) ),
assert( happensAtIE( stop_leave(142, bus, 007677, scheduled), 7680) ),
assert( happensAtIE( stop_enter(143, bus, 007686, scheduled), 7686) ),
assert( happensAtIE( stop_leave(143, bus, 007686, early), 7689) ),
assert( happensAtIE( stop_enter(143, bus, 007691, early), 7695) ),
assert( happensAtIE( stop_leave(143, bus, 007691, early), 7696) ),
assert( happensAtIE( stop_enter(144, bus, 007701, scheduled), 7701) ),
assert( happensAtIE( stop_leave(144, bus, 007701, late), 7704) ),
assert( happensAtIE( stop_enter(145, bus, 007712, scheduled), 7709) ),
assert( happensAtIE( stop_leave(145, bus, 007712, late), 7711) ),
assert( happensAtIE( stop_enter(146, bus, 007721, late), 7714) ),
assert( happensAtIE( stop_leave(146, bus, 007721, early), 7719) ),
assert( happensAtIE( stop_enter(147, bus, 007723, early), 7723) ),
assert( happensAtIE( stop_leave(147, bus, 007723, early), 7729) ),
assert( happensAtIE( stop_enter(147, bus, 007732, early), 7733) ),
assert( happensAtIE( stop_leave(147, bus, 007732, scheduled), 7735) ),
assert( happensAtIE( stop_enter(148, bus, 007741, late), 7741) ),
assert( happensAtIE( stop_leave(148, bus, 007741, scheduled), 7744) ),
assert( happensAtIE( stop_enter(149, bus, 007746, late), 7750) ),
assert( happensAtIE( stop_leave(149, bus, 007746, early), 7751) ),
assert( happensAtIE( stop_enter(150, bus, 007757, early), 7757) ),
assert( happensAtIE( stop_leave(150, bus, 007757, scheduled), 7759) ),
assert( happensAtIE( stop_enter(151, bus, 007767, scheduled), 7764) ),
assert( happensAtIE( stop_leave(151, bus, 007767, early), 7766) ),
assert( happensAtIE( stop_enter(151, bus, 007776, early), 7776) ),
assert( happensAtIE( stop_leave(151, bus, 007776, scheduled), 7777) ),
assert( happensAtIE( stop_enter(152, bus, 007785, early), 7778) ),
assert( happensAtIE( stop_leave(152, bus, 007785, scheduled), 7785) ),
assert( happensAtIE( stop_enter(153, bus, 007788, late), 7786) ),
assert( happensAtIE( stop_leave(153, bus, 007788, late), 7790) ),
assert( happensAtIE( stop_enter(154, bus, 007797, early), 7798) ),
assert( happensAtIE( stop_leave(154, bus, 007797, scheduled), 7800) ),
assert( happensAtIE( stop_enter(155, bus, 007802, early), 7807) ),
assert( happensAtIE( stop_leave(155, bus, 007802, late), 7809) ),
assert( happensAtIE( stop_enter(155, bus, 007810, late), 7813) ),
assert( happensAtIE( stop_leave(155, bus, 007810, late), 7814) ),
assert( happensAtIE( stop_enter(156, bus, 007820, late), 7821) ),
assert( happensAtIE( stop_leave(156, bus, 007820, scheduled), 7823) ),
assert( happensAtIE( stop_enter(157, bus, 007833, late), 7830) ),
assert( happensAtIE( stop_leave(157, bus, 007833, late), 7833) ),
assert( happensAtIE( stop_enter(158, bus, 007836, scheduled), 7834) ),
assert( happensAtIE( stop_leave(158, bus, 007836, early), 7841) ),
assert( happensAtIE( stop_enter(159, bus, 007844, late), 7845) ),
assert( happensAtIE( stop_leave(159, bus, 007844, late), 7847) ),
assert( happensAtIE( stop_enter(159, bus, 007854, late), 7855) ),
assert( happensAtIE( stop_leave(159, bus, 007854, late), 7856) ),
assert( happensAtIE( stop_enter(160, bus, 007858, late), 7863) ),
assert( happensAtIE( stop_leave(160, bus, 007858, scheduled), 7864) ),
assert( happensAtIE( stop_enter(161, bus, 007867, late), 7867) ),
assert( happensAtIE( stop_leave(161, bus, 007867, early), 7869) ),
assert( happensAtIE( stop_enter(162, bus, 007879, late), 7876) ),
assert( happensAtIE( stop_leave(162, bus, 007879, scheduled), 7878) ),
assert( happensAtIE( stop_enter(163, bus, 007889, early), 7888) ),
assert( happensAtIE( stop_leave(163, bus, 007889, scheduled), 7889) ),
assert( happensAtIE( stop_enter(163, bus, 007897, scheduled), 7890) ),
assert( happensAtIE( stop_leave(163, bus, 007897, scheduled), 7897) ),
assert( happensAtIE( stop_enter(164, bus, 007900, early), 7898) ),
assert( happensAtIE( stop_leave(164, bus, 007900, early), 7902) ),
assert( happensAtIE( stop_enter(165, bus, 007910, scheduled), 7910) ),
assert( happensAtIE( stop_leave(165, bus, 007910, early), 7912) ),
assert( happensAtIE( stop_enter(166, bus, 007914, scheduled), 7919) ),
assert( happensAtIE( stop_leave(166, bus, 007914, late), 7920) ),
assert( happensAtIE( stop_enter(167, bus, 007922, scheduled), 7923) ),
assert( happensAtIE( stop_leave(167, bus, 007922, early), 7928) ),
assert( happensAtIE( stop_enter(167, bus, 007931, late), 7932) ),
assert( happensAtIE( stop_leave(167, bus, 007931, late), 7934) ),
assert( happensAtIE( stop_enter(168, bus, 007941, early), 7942) ),
assert( happensAtIE( stop_leave(168, bus, 007941, early), 7944) ),
assert( happensAtIE( stop_enter(169, bus, 007950, scheduled), 7950) ),
assert( happensAtIE( stop_leave(169, bus, 007950, early), 7952) ),
assert( happensAtIE( stop_enter(170, bus, 007954, late), 7959) ),
assert( happensAtIE( stop_leave(170, bus, 007954, late), 7960) ),
assert( happensAtIE( stop_enter(171, bus, 007965, scheduled), 7965) ),
assert( happensAtIE( stop_leave(171, bus, 007965, late), 7968) ),
assert( happensAtIE( stop_enter(171, bus, 007970, early), 7975) ),
assert( happensAtIE( stop_leave(171, bus, 007970, scheduled), 7976) ),
assert( happensAtIE( stop_enter(172, bus, 007985, scheduled), 7978) ),
assert( happensAtIE( stop_leave(172, bus, 007985, early), 7983) ),
assert( happensAtIE( stop_enter(173, bus, 007993, late), 7987) ),
assert( happensAtIE( stop_leave(173, bus, 007993, early), 7988) ),
assert( happensAtIE( stop_enter(174, bus, 007994, scheduled), 7995) ),
assert( happensAtIE( stop_leave(174, bus, 007994, late), 7996) ).