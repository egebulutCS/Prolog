% [1,2,3,4]; H = 1, T = [2,3,4]
% [H|T]
% [H,A|T] = [1,2,3,4,5]; H = 1, A = 2, T = [3,4,5]

printList([]).
printList([H|T]):- writeln(H), printList(T).

sumList([],0).
sumList([H|T], S):- sumList(T,S1), S is S1 + H.


% Find All
% likes(a,b).
% likes(a,c).
% findall(X,likes(a,X),R).
% R = [b,c]

% finds all the X answers that satisfy second argument and makes it a result list


% Member
% member(X,[1]).
% gives the members of the list



% Append
% First list + Second list = Final list

% ?- append([a,b], [c], X).
% X = [a,b,c].

% ?- append(X, [Last], [a,b,c]).
% X = [a,b],
% Last = c.

% ?- append([a,b], More, List).
% List = [a,b|More].