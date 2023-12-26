add1(0,Y,Y).
add1(X,Y,R):- add1(X1,Y,R1), X is X1+1, R is R1+1.


add2(X,Y,R):- R is X+Y.
add3(A,B,C,R):- add(A,B,M), add(M,C,R).