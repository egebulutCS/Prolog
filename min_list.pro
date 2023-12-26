function([X],X).
function([H,K|T],M):- H =< K, function([H|T],M).
function([H,K|T],M):- H > K, function([K|T],M).	

min_list([X],X).
min_list([H|T],H):- min_list(T,MinT), H =< MinT.
min_list([H|T],MinT):- min_list(T,MinT), H > MinT.

remove_el([],_,[]).
remove_el([H|T],X,T):- H = X.
remove_el([H|T],X,[H|R1]):- H =\= X, remove_el(T,X,R1).

bubble([],[]).
bubble(L,[M|SLS]):- min_list(L,M), remove_el(L,M,LS), bubble(LS,SLS).

% L = List, P = Pivot, SL = Smaller List, BL = Bigger List
divide([],_,[],[]).
divide([H|T],P,[H|SL],BL):- H =< P, divide(T,P,SL,BL).
divide([H|T],P,SL,[H|BL]):- H > P, divide(T,P,SL,BL).

quick_sort([],[]).
quick_sort([H|L],Sorted):- divide(L,H,SL,BL), quick_sort(SL,SLSorted), quick_sort(BL,BLSorted), append(SLSorted,[H|BLSorted],Sorted).