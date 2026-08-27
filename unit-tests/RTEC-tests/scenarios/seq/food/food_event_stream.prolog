updateSDE(food_1, 0, 10) :-
        assertz(happensAtIE(turnsOn(oven), 1)),
        assertz(happensAtIE(turnsOn(stove), 2)),
        assertz(happensAtIE(place(steak, stove), 3)),
        assertz(happensAtIE(place(potatoes, stove), 5)),
        assertz(happensAtIE(remove(steak, stove), 9)).

updateSDE(food_1, 10, 20) :-
        assertz(happensAtIE(remove(potatoes, stove), 12)),
        assertz(happensAtIE(place(steak, oven), 14)),
        assertz(happensAtIE(place(potatoes, oven), 16)),
        assertz(happensAtIE(remove(steak, oven), 18)),
        assertz(happensAtIE(remove(potatoes, oven), 19)).

updateSDE(food_1, 20, 30) :-
        assertz(happensAtIE(place(steak, plate), 21)),
        assertz(happensAtIE(place(potatoes, plate), 22)).


updateSDE(food_2, 0, 5) :-
        assertz(happensAtIE(turnsOn(oven), 1)),
        assertz(happensAtIE(turnsOn(stove), 2)),
        assertz(happensAtIE(place(steak, stove), 3)),
        assertz(happensAtIE(place(potatoes, stove), 5)).

updateSDE(food_2, 5, 10) :-        
        assertz(happensAtIE(remove(steak, stove), 9)).

updateSDE(food_2, 10, 15) :-
        assertz(happensAtIE(remove(potatoes, stove), 12)),
        assertz(happensAtIE(place(steak, oven), 14)).

updateSDE(food_2, 15, 20) :-     
        assertz(happensAtIE(place(potatoes, oven), 16)),
        assertz(happensAtIE(remove(steak, oven), 18)),
        assertz(happensAtIE(remove(potatoes, oven), 19)).

updateSDE(food_2, 20, 25) :-
        assertz(happensAtIE(place(steak, plate), 21)),
        assertz(happensAtIE(place(potatoes, plate), 22)).

