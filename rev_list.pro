rev_list([],[]).
rev_list([H|T],Reversed):- rev_list(T,TR), append(TR,[H],Reversed).
% rev_list([X|L],RL):- rev_list(L,LT), append(LT,[X],RL).
% rev_list([X|L],[LT|[X]]):- rev_list(L,LT).