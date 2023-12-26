len_list([],0).
len_list([_|List],S1):- len_list(List,S), S1 is S+1.