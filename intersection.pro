inter(L1,L2,I):- findall(X,(member(X,L1), member(X,L2)),I).