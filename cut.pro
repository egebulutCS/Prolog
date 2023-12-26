a(paul).
% a(jane):- !.
a(jane).
b(rachel).
b(susan).
c(alex).
c(mary).
d(mark).
d(john).

% a(Y):- b(Y),c(_).
a(Y):- b(Y),c(_),!.
a(Z):- d(Z).