john(0, 0, s0).
john(R, C, result(kill(R, C, S))):-
    john(R, C, S).
    
john(R, C, result(pick(R, C, S))):-
	john(R, C, S).

john(R, C, result(left(R, C1, S))):-
	john(R, C1, S), C is C1 - 1.

john(R, C, result(right(R, C1, S))):-
	john(R, C1, S), C is C1 + 1.

john(R, C, result(up(R1, C, S))):-
	john(R1, C, S), R is R1 - 1.

john(R, C, result(down(R1, C, S))):-
	john(R1, C, S), R is R1 + 1.