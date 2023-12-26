up(b,ground).
up(a,b).
up(e,a).
up(c,e).
up(f,c).
up(d,f).

higher(X,Y):- up(X,Y).
higher(X,Y):- up(X,Z), higher(Z,Y).

lower(X,Y):- up(Y,X).
lower(X,Y):- up(Y,Z), lower(X,Z).