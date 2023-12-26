countdown(0).
countdown(X):- writeln(X), X1 is X - 1, countdown(X1).