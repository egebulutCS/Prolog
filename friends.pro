friend(john,mary).
friend(mary,paul).
friend(mary,karl).
friend(karl,mary).
friend(karl,joe).
friend(joe,alan).
friend(joe,martha).
friend(joe,mary).
% friend_sim(X,Y):- friend(X,Y), friend(Y,X).

% Friends of Friends
fof(X,Y):- friend(X,Y).
fof(X,Y):- friend(X,Z), fof(Z,Y).

% Friends of friends with distance
fofd(X,Y,1):- friend(X,Y).
fofd(X,Y,D):- friend(X,Z), fofd(Z,Y,D1), D is D1 + 1.

% findall([X,D], fofd(mary,X,D), X).

fofp(X,Y,[X,Y]):- friend(X,Y).
fofp(X,Y,[X|P]):- friend(X,Z), fofp(Z,Y,P).
% fofp(X,Y,P):- friend(X,Z), fofp(Z,Y,P1), append([X],P1,P).

fof_cycles(X,Y):- fof_c(X,Y,[]).
fof_c(X,Y,V):- friend(X,Y), not(member(Y,V)).
fof_c(X,Y,V):- friend(X,Z), not(member(Z,V)), fof_c(Z,Y,[Z|V]).

fof_cycles_path(X,Y,P):- fof_c_p(X,Y,[],P).
fof_c_p(X,Y,V,[X,Y]):- friend(X,Y), not(member(Y,V)).
fof_c_p(X,Y,V,[X|P]):- friend(X,Z), not(member(Z,V)), fof_c_p(Z,Y,[Z|V],P).