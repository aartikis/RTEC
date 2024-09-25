updateSDE(maritime_1) :-
        assertz(happensAtIE(entersArea(1234500, natura_27490), 2)),
        assertz(happensAtIE(stop_start(1234500), 4)),
        assertz(happensAtIE(stop_end(1234500), 11)),
        assertz(happensAtIE(leavesArea(1234500, natura_27490), 13)).

updateSDE(maritime_2, 0, 10) :-
        assertz(happensAtIE(entersArea(1234500, natura_27490), 2)),
        assertz(happensAtIE(stop_start(1234500), 4)).

updateSDE(maritime_2, 10, 20) :-
        assertz(happensAtIE(stop_end(1234500), 11)),
        assertz(happensAtIE(leavesArea(1234500, natura_27490), 13)).

updateSDE(maritime_3) :-
        assertz(happensAtIE(entersArea(1234500, nearCoast_27041), 2)),
        assertz(happensAtIE(velocity(1234500, 6, 45, 60), 5)),
        assertz(happensAtIE(velocity(1234500, 3, 42, 70), 12)),
        assertz(happensAtIE(velocity(1234500, 2, 39, 80), 15)),
        assertz(happensAtIE(velocity(1234500, 0, 20, 20), 18)),
        assertz(happensAtIE(leavesArea(1234500, nearCoast_27041), 19)).

updateSDE(maritime_4, 0, 10) :-
        assertz(happensAtIE(entersArea(1234500, nearCoast_27041), 2)),
        assertz(happensAtIE(velocity(1234500, 6, 45, 60), 5)).

updateSDE(maritime_4, 10, 20) :-
        assertz(happensAtIE(velocity(1234500, 3, 42, 70), 12)),
        assertz(happensAtIE(velocity(1234500, 2, 39, 80), 15)),
        assertz(happensAtIE(velocity(1234500, 0, 20, 20), 18)),
        assertz(happensAtIE(leavesArea(1234500, nearCoast_27041), 19)).

updateSDE(maritime_5) :-
        assertz(happensAtIE(entersArea(1234500, nearCoast_27041), 2)),
        assertz(happensAtIE(velocity(1234500, 6, 45, 60), 5)),
        assertz(happensAtIE(velocity(1234500, 8, 39, 80), 10)),
        assertz(happensAtIE(velocity(1234500, 3, 42, 90), 12)),
        assertz(happensAtIE(velocity(1234500, 0, 20, 20), 18)),
        assertz(happensAtIE(leavesArea(1234500, nearCoast_27041), 19)).

updateSDE(maritime_6, 0, 10) :-
        assertz(happensAtIE(entersArea(1234500, nearCoast_27041), 2)),
        assertz(happensAtIE(velocity(1234500, 6, 45, 60), 5)),
        assertz(happensAtIE(velocity(1234500, 8, 39, 80), 10)).

updateSDE(maritime_6, 10, 20) :-
        assertz(happensAtIE(velocity(1234500, 3, 42, 90), 12)),
        assertz(happensAtIE(velocity(1234500, 0, 20, 20), 18)),
        assertz(happensAtIE(leavesArea(1234500, nearCoast_27041), 19)).
     
updateSDE(maritime_7) :-
        assertz(happensAtIE(change_in_speed_start(1234500), 3)),
        assertz(happensAtIE(velocity(1234500, 20, 45, 60), 3)),
        assertz(happensAtIE(change_in_speed_end(1234500), 14)),
        assertz(happensAtIE(velocity(1234500, 0, 20, 20), 18)).

updateSDE(maritime_8, 0, 10) :-
        assertz(happensAtIE(change_in_speed_start(1234500), 3)),
        assertz(happensAtIE(velocity(1234500, 18, 45, 60), 3)).

updateSDE(maritime_8, 10, 20) :-
        assertz(happensAtIE(change_in_speed_end(1234500), 14)),
        assertz(happensAtIE(velocity(1234500, 0, 20, 20), 18)).

updateSDE(maritime_9) :-
        assertz(happensAtIE(entersArea(1234500, nearPorts_27016), 2)),
        assertz(happensAtIE(stop_start(1234500), 7)),
        assertz(happensAtIE(stop_end(1234500), 12)),
        assertz(happensAtIE(leavesArea(1234500, nearPorts_27016), 17)).

updateSDE(maritime_10, 0, 10) :-
        assertz(happensAtIE(entersArea(1234500, nearPorts_27016), 2)),
        assertz(happensAtIE(stop_start(1234500), 7)).

updateSDE(maritime_10, 10, 20) :-
        assertz(happensAtIE(stop_end(1234500), 12)),
        assertz(happensAtIE(leavesArea(1234500, nearPorts_27016), 17)).

updateSDE(maritime_11) :-
        assertz(happensAtIE(entersArea(1234500, anchorage_27001), 2)),
        assertz(happensAtIE(stop_start(1234500), 4)),
        assertz(happensAtIE(stop_end(1234500), 16)),
        assertz(happensAtIE(leavesArea(1234500, anchorage_27001), 17)).

updateSDE(maritime_12, 0, 10) :-
        assertz(happensAtIE(entersArea(1234500, anchorage_27001), 2)),
        assertz(happensAtIE(stop_start(1234500), 4)).

updateSDE(maritime_12, 10, 20) :-
        assertz(happensAtIE(stop_end(1234500), 16)),
        assertz(happensAtIE(leavesArea(1234500, anchorage_27001), 17)).



