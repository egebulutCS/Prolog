power(_,0,1).
power(X,Y,R):- power(X,Y1,R1), Y is Y1 + 1, R is R1 * X.
% power(X,Y,R):- Y > 0, Y1 is Y - 1, power(X,Y1,R1), R is R1 * X.