flight1(london,dublin,aerlingus,500,45,150).
flight1(istanbul,dublin,aerlingus,500,45,150).
flight1(rome,istanbul,aerlingus,800,50,200).
flight1(rome,london,ba,1500,150,400).
flight1(london,hongkong,ba,7500,700,1000).
flight1(hongkong,dublin,ba,2500,145,350).

trip(D,A,P,TAL):- tripPath(D,A,[],P,TAL).
tripPath(D,A,L,[D,A],TAL):- flight1(D,A,AL,_,_,_), not(member(A,L)), TAL \= AL.
tripPath(D,A,L,[D|P],TAL):- flight1(D,T,AL,_,_,_), not(member(T,L)), TAL \= AL, tripPath(T,A,[D|L],P,TAL).
all_trip_noairline1(D,A,P,TAL):- findall(P,trip(D,A,P,TAL),P).
all_trip_noairline2(D,A,P,TAL):- findall(P,trip(D,A,P,TAL),P).

deleteTest(L,X,R):- delete(L,X,R).