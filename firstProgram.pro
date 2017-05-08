lobster(bob). 			%%complex terms
chef(jerry).

cooks(jerry, X):-
	largerThan2lbs(X), 
	lobster(X),
	tasty(X).

happy(vincent).
listens2Music(butch). 
playsAirGuitar(vincent):-
	listens2Music(vincent), 
	happy(vincent).


playsAirGuitar(butch):-
	listens2Music(butch). 
playsAirGuitar(butch):-
	happy(butch);
	listens2Music(butch).