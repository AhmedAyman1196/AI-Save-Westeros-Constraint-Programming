dragon_glass_cnt(0, s0).
dragon_glass(0, 1).
max_dragon_glass(2).
rows(3).
cols(3).
john(0, 0, s0).
walker(1, 2, s0).
walkers_cnt(1, s0).
obstacle(5,5).


delta2(X, Y):-
    (X is 0, Y is 1); (X is 1, Y is 0).

delta(X, Y):-
	(X is 0, Y is 1); (X is 0, Y is -1); (X is -1, Y is 0); (X is 1, Y is 0).

can_kill(S):-
	dragon_glass_cnt(X, S), X \== 0.

valid(R, C):-
	(rows(R1), cols(C1), R is R1 - 1, C is C1 - 1);
    (delta2(DX, DY), valid(R_NXT, C_NXT), R is R_NXT - DX, C is C_NXT - DY, R > -1, C > -1).
    
valid_dragon_glass_cnt(R):-
    (max_dragon_glass(R)); (valid_dragon_glass_cnt(R1), R is R1 - 1, R > -1).

count_walkers_around(X, Y, N1, N2, N3, N4, S, ANS):-
	((X1 is X - 1, Y1 is Y, not(walker(X1, Y1, S)), N1 is 0);
	(X1 is X - 1, Y1 is Y, walker(X1, Y1, S), N1 is 1)),

	((X2 is X + 1, Y2 is Y, not(walker(X2, Y2, S)), N2 is 0);
	(X2 is X + 1, Y2 is Y, walker(X2, Y2, S), N2 is 1)),

	((X3 is X, Y3 is Y - 1, not(walker(X3, Y3, S)), N3 is 0);
	(X3 is X, Y3 is Y - 1, walker(X3, Y3, S), N3 is 1)),

	((X4 is X, Y4 is Y + 1, not(walker(X4, Y4, S)), N4 is 0);
	(X4 is X, Y4 is Y + 1, walker(X4, Y4, S), N4 is 1)),

	ANS is (N1 + N2 + N3 + N4).

john(R, C, result(kill, S)):-
    john(R, C, S), not(obstacle(R,C)). 
    
john(R, C, result(pick, S)):-
	john(R, C, S), not(obstacle(R,C)). 

john(R, C, result(left, S)):-
	valid(R, C), C1 is C + 1, john(R, C1, S), not(obstacle(R,C)). 

john(R, C, result(right, S)):-
	valid(R, C), C1 is C - 1, john(R, C1, S), not(obstacle(R,C)). 

john(R, C, result(up, S)):-
	valid(R, C), R1 is R + 1, john(R1, C, S), not(obstacle(R,C)). 

john(R, C, result(down, S)):-
	valid(R, C), R1 is R - 1, john(R1, C, S), not(obstacle(R,C)). 


walker(R, C, result(kill, S)):-
    walker(R, C, S),
    (not(can_kill(S)); (john(R1, C1, S), forall(delta(DX, DY), ((JR is (R1 + DX), JC is (C1 + DY), (not(JR is R) ; not(JC is C))))))).
  
    
walker(R, C, result(pick, S)):-
	walker(R, C, S).

walker(R, C, result(left, S)):-
	walker(R, C, S).

walker(R, C, result(right, S)):-
	walker(R, C, S).	

walker(R, C, result(up, S)):-
	walker(R, C, S).

walker(R, C, result(down, S)):-
	walker(R, C, S).


dragon_glass_cnt(R, result(kill, S)):-
    valid_dragon_glass_cnt(R), R1 is R + 1, dragon_glass_cnt(R1, S).
    
dragon_glass_cnt(R, result(pick, S)):-
	valid_dragon_glass_cnt(R), john(X, Y, S), dragon_glass(X, Y), R1 is R - 1, dragon_glass_cnt(R1, S).

dragon_glass_cnt(R, result(left, S)):-
	dragon_glass_cnt(R, S).

dragon_glass_cnt(R, result(right, S)):-
	dragon_glass_cnt(R, S).

dragon_glass_cnt(R, result(up, S)):-
	dragon_glass_cnt(R, S).

dragon_glass_cnt(R, result(down, S)):-
	dragon_glass_cnt(R, S).


walkers_cnt(R, result(kill, S)):-
    can_kill(S), walkers_cnt(WAS, S), john(X, Y, S), count_walkers_around(X, Y, _, _, _, _, S, CNT), R is (WAS - CNT).
    
walkers_cnt(R, result(pick, S)):-
	walkers_cnt(R, S).

walkers_cnt(R, result(left, S)):-
	walkers_cnt(R, S).

walkers_cnt(R, result(right, S)):-
	walkers_cnt(R, S).

walkers_cnt(R, result(up, S)):-
	walkers_cnt(R, S).

walkers_cnt(R, result(down, S)):-
	walkers_cnt(R, S).
