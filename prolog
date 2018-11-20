dragon_glass_cnt(0, s0).
dragon_glass(0, 2).
max_dragon_glass(2).
rows(2).
cols(3).
john(0, 0, s0).
not_walker(0, 0, s0).
not_walker(0, 1, s0).
not_walker(0, 2, s0).
not_walker(1, 0, s0).
not_walker(1, 2, s0).

delta2(X, Y):-
    (X is 0, Y is 1); (X is 1, Y is 0).

delta(X, Y):-
	(X is 0, Y is 1); (X is 0, Y is -1); (X is -1, Y is 0); (X is 1, Y is 0).

can_kill(S):-
	dragon_glass_cnt(X, S), X \== 0.

valid(R, C):-
	rows(R1), cols(C1),
    (R is R1 - 1, C is C1 - 1);
    (delta2(DX, DY), valid(R_NXT, C_NXT), R is R_NXT - DX, C is C_NXT - DY).
    
valid_dragon_glass_cnt(R):-
    integer(R), R > -1, max_dragon_glass(X), R < X.

john(R, C, result(kill(R, C), S)):-
    valid(R, C), john(R, C, S).
    
john(R, C, result(pick, S)):-
	valid(R, C), john(R, C, S).

john(R, C, result(left, S)):-
	valid(R, C), C1 is C + 1, john(R, C1, S).

john(R, C, result(right, S)):-
	valid(R, C), C1 is C - 1, john(R, C1, S).

john(R, C, result(up, S)):-
	valid(R, C), R1 is R + 1, john(R1, C, S).

john(R, C, result(down, S)):-
	valid(R, C), R1 is R - 1, john(R1, C, S).


not_walker(R, C, result(kill, S)):-
    valid(R, C), 
    (
    	not_walker(R, C, S);
    	(can_kill(S), (john(R1, C1, S), delta(DX, DY), (JR is (R1 + DX), JC is (C1 + DY), (JR is R , JC is C))))
    ).
    
not_walker(R, C, result(pick, S)):-
	valid(R, C), dragon_glass(R, C), not_walker(R, C, S).

not_walker(R, C, result(left, S)):-
	valid(R, C), not_walker(R, C, S).

not_walker(R, C, result(right, S)):-
	valid(R, C), not_walker(R, C, S).	

not_walker(R, C, result(up, S)):-
	valid(R, C), not_walker(R, C, S).

not_walker(R, C, result(down, S)):-
	valid(R, C), not_walker(R, C, S).


dragon_glass_cnt(R, result(kill, S)):-
    valid_dragon_glass_cnt(R), R1 is R + 1, dragon_glass_cnt(R1, S).
    
dragon_glass_cnt(R, result(pick, S)):-
	valid_dragon_glass_cnt(R), john(X, Y, S), dragon_glass(X, Y), R1 is R - 1, dragon_glass_cnt(R1, S).

dragon_glass_cnt(R, result(left, S)):-
	valid_dragon_glass_cnt(R), dragon_glass_cnt(R, S).

dragon_glass_cnt(R, result(right, S)):-
	valid_dragon_glass_cnt(R), dragon_glass_cnt(R, S).

dragon_glass_cnt(R, result(up, S)):-
	valid_dragon_glass_cnt(R), dragon_glass_cnt(R, S).

dragon_glass_cnt(R, result(down, S)):-
	valid_dragon_glass_cnt(R), dragon_glass_cnt(R, S).
