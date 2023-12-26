flight(london,dublin,aerlingus,500,45,150).
flight(rome,london,ba,1500,150,400).
flight(rome,paris,airfrance,1200,120,500). 
flight(paris,dublin,airfrance,600,60,200).
flight(berlin,moscow,lufthansa,3000,300,900).
flight(paris,amsterdam,airfrance,400,30,100).
flight(berlin,dublin,lufthansa,1200,120,900).
flight(london,newyork,ba,5000,700,1100).
flight(dublin,newyork,aerlingus,4500,360,800).
flight(dublin,cork,ryanair,300,50,50).
flight(dublin,rome,ryanair,2000,150,70).
flight(dublin,chicago,aerlingus,5500,480,890).
flight(amsterdam,hongkong,klm,7000,660,750).
flight(london,hongkong,ba,7500,700,1000).
flight(dublin,amsterdam,ryanair,1000,90,60).
flight(moscow,newyork,aerflot,9000,720,1000).
flight(moscow,hongkong,aerflot,5500,420,500).
flight(newyork,chicago,aa,3000,240,430).
flight(dublin,london,aerlingus,500,45,150).
flight(london,rome,ba,1500,150,400).
flight(paris,rome,airfrance,1200,120,500). 
flight(dublin,paris,airfrance,600,60,200).
flight(moscow,berlin,lufthansa,3000,300,900).
flight(amsterdam,paris,airfrance,400,30,100).
flight(dublin,berlin,lufthansa,1200,120,900).
flight(newyork,london,ba,5000,700,1100).
flight(newyork,dublin,aerlingus,4500,360,800).
flight(cork,dublin,ryanair,300,50,50).
flight(rome,dublin,ryanair,2000,150,70).
flight(chicago,dublin,aerlingus,5500,480,890).
flight(hongkong,amsterdam,klm,7000,660,750).
flight(hongkong,london,ba,7500,700,1000).
flight(amsterdam,dublin,ryanair,1000,90,60).
flight(newyork,moscow,aerflot,9000,720,1000).
flight(hongkong,moscow,aerflot,5500,420,500).
flight(chicago,newyork,aa,3000,240,430).

country(dublin,ireland).
country(cork,ireland).
country(london,uk).
country(rome,italy).
country(moscow,russia).
country(hongkong,china).
country(amsterdam,holland).
country(berlin,germany).
country(paris,france).
country(newyork,usa).
country(chicago,usa).


% PART 1

% 1
% C = City, L = List, Co = Country
list_airport(Co,L):- findall(C,country(C,Co),L).

% 2
% D = Departure, A = Arrival, L = List, T = Transfer, P = Path
trip(D,A,P):- tripPath(D,A,[],P).
tripPath(D,A,L,[D,A]):- flight(D,A,_,_,_,_), not(member(A,L)).
tripPath(D,A,L,[D|P]):- flight(D,T,_,_,_,_), not(member(T,L)), tripPath(T,A,[D|L],P).

% 3
% D = Departure, A = Arrival, L = List, P = Path
all_trip(D,A,L):- findall(P,trip(D,A,P),L).

% 4
% D = Departure, A = Arrival, L = List, T = Transfer, P = Path, Di = Distance
trip_dist(D,A,[P,Di]):- tripDistance(D,A,[],P,Di).
tripDistance(D,A,L,[D,A],Di):- flight(D,A,_,Di,_,_), not(member(A,L)).
tripDistance(D,A,L,[D|P],TotalDi):- flight(D,T,_,Di,_,_), not(member(T,L)), tripDistance(T,A,[D|L],P,NextDi), TotalDi is Di+NextDi.

% 5
% D = Departure, A = Arrival, L = List, T = Transfer, P = Path, C = Cost
trip_cost(D,A,[P,C]):- tripCost(D,A,[],P,C).
tripCost(D,A,L,[D,A],C):- flight(D,A,_,_,_,C), not(member(A,L)).
tripCost(D,A,L,[D|P],TotalC):- flight(D,T,_,_,_,C), not(member(T,L)), tripCost(T,A,[D|L],P,NextC), TotalC is C+NextC.

% 6
% D = Departure, A = Arrival, L = List, T = Transfer, P = Path, I = Change
trip_change(D,A,[P,I]):- tripChange(D,A,[],P,I).
tripChange(D,A,L,[D,A],0):- flight(D,A,_,_,_,_), not(member(A,L)).
tripChange(D,A,L,[D|P],TotalI):- flight(D,T,_,_,_,_), not(member(T,L)), tripChange(T,A,[D|L],P,I), TotalI is I+1.

% 7
% D = Departure, A = Arrival, L = List, T = Transfer, P = Path, AL = Airline, TAL = TargetAirline
trip_airline(D,A,P,TAL):- tripPathAirline(D,A,[],P,TAL).
tripPathAirline(D,A,L,[D,A],TAL):- flight(D,A,AL,_,_,_), not(member(A,L)), TAL \= AL.
tripPathAirline(D,A,L,[D|P],TAL):- flight(D,T,AL,_,_,_), not(member(T,L)), TAL \= AL, tripPathAirline(T,A,[D|L],P,TAL).
all_trip_noairline(D,A,L,TAL):- findall(P,trip_airline(D,A,P,TAL),L).

% 8
% L = List, F = Flight, F1, Flight1, F2 = Flight2, C = Cost, C1 = Cost1, C2 = Cost2
find_min([[F,C]],C,F).
find_min([[F1,C1],[_,C2]|L],C,F):- C1 =< C2, find_min([[F1,C1]|L],C,F).
find_min([[_,C1],[F2,C2]|L],C,F):- C1 > C2, find_min([[F2,C2]|L],C,F).

% D = Departure, A = Arrival, L = List, T = Transfer, P = Path, Ti = Time
trip_time(D,A,[P,Ti]):- tripTime(D,A,[],P,Ti).
tripTime(D,A,L,[D,A],Ti):- flight(D,A,_,_,Ti,_), not(member(A,L)).
tripTime(D,A,L,[D|P],TotalTi):- flight(D,T,_,_,Ti,_), not(member(T,L)), tripTime(T,A,[D|L],P,NextTi), TotalTi is Ti+NextTi.

% D = Departure, A = Arrival, L = List, F = Flight, C = Cost, Di = Distance, T = Time
cheapest(D,A,F,C):- findall([F,C],trip_cost(D,A,[F,C]),L), find_min(L,C,F).
shortest(D,A,F,Di):- findall([F,Di],trip_dist(D,A,[F,Di]),L), find_min(L,Di,F).
fastest(D,A,F,T):- findall([F,T],trip_time(D,A,[F,T]),L), find_min(L,T,F).

% 9
% D = Departure, Co = Country, P = Path, C = City
trip_to_nation(D,Co,P):- country(C,Co), trip(D,C,P).

% 10
% D = Departure, Co = Country, P = Path, PL = Path List, CL = City List, H = Head, T = Tail
allTripNation(_,[],[]).
allTripNation(D,[H|T],[P|PL]):- all_trip(D,H,P), allTripNation(D,T,PL).
all_trip_to_nation(D,Co,PL):- list_airport(Co,CL), allTripNation(D,CL,PL).


% Part 2

% B = [[b,c,f],[a,d,g],[h,e]].

% 1
print_status([[],[],[]]):- write('|'), writeln('').
print_status([[],[],[H|T]]):- write('|'), write(H), print_status([[],[],T]).
print_status([[],[X],P3]):- write('|'), write(X), write('|'), writeln(''), print_status([[],[],P3]).
print_status([[],[H|T],P3]):- write('|'), write(H), print_status([[],T,P3]).
print_status([[X],P2,P3]):- write('|'), write(X), write('|'), writeln(''), print_status([[],P2,P3]).
print_status([[H|T],P2,P3]):- write('|'), write(H), print_status([T,P2,P3]),!.

% 2
count_blocks([[],[],[]],[0,0,0]).
count_blocks([[],[],[_|T]],[0,0,C3]):- count_blocks([[],[],T],[0,0,C]), C3 is C+1.
count_blocks([[],[_|T],P3],[0,C2,C3]):- count_blocks([[],T,P3],[0,C,C3]), C2 is C+1.
count_blocks([[_|T],P2,P3],[C1,C2,C3]):- count_blocks([T,P2,P3],[C,C2,C3]), C1 is C+1.

% 3.1
find_height(X,[X|_],1).
find_height(X,[_|T],H):- find_height(X,T,H1), H is H1+1.
high([P1,_,_],X,H):- member(X,P1), find_height(X,P1,H).
high([_,P2,_],X,H):- member(X,P2), find_height(X,P2,H).
high([_,_,P3],X,H):- member(X,P3), find_height(X,P3,H).

% 3.2
all_same_height([P1,P2,P3],H,L):- findall(X,high([P1,P2,P3],X,H),L).

% 4
same_height([P1,P2,P3],B1,B2):- high([P1,P2,P3],B1,H1), high([P1,P2,P3],B2,H2), H1 = H2.

% 5
update_blocks(B,S1,S2,R1,R2,B2):- S1 == 1, S2 == 2, nth1(3,B,R3), B2 = [R1,R2,R3].
update_blocks(B,S1,S2,R1,R2,B2):- S1 == 2, S2 == 3, nth1(1,B,R3), B2 = [R3,R1,R2].
update_blocks(B,S1,S2,R1,R2,B2):- S1 == 3, S2 == 1, nth1(2,B,R3), B2 = [R2,R3,R1].
update_blocks(B,S1,S2,R1,R2,B2):- S1 == 1, S2 == 3, nth1(2,B,R3), B2 = [R1,R3,R2].
update_blocks(B,S1,S2,R1,R2,B2):- S1 == 3, S2 == 2, nth1(1,B,R3), B2 = [R3,R2,R1].
update_blocks(B,S1,S2,R1,R2,B2):- S1 == 2, S2 == 1, nth1(3,B,R3), B2 = [R2,R1,R3].
moveblock(B,X,S1,S2):- nth1(S1,B,P1), last(P1,X), select(X,P1,R1), nth1(S2,B,P2), append(P2,[X],R2), update_blocks(B,S1,S2,R1,R2,B2), writeln('Before'), print_status(B), writeln('After'), print_status(B2).


% Part 3

print_stacks(SX,X,SY,Y,SZ,Z):- X == 1, Y == 2, Z == 3, print_status([SX,SY,SZ]).
print_stacks(SX,X,SY,Y,SZ,Z):- X == 1, Z == 2, Y == 3, print_status([SX,SZ,SY]).
print_stacks(SX,X,SY,Y,SZ,Z):- Y == 1, X == 2, Z == 3, print_status([SY,SX,SZ]).
print_stacks(SX,X,SY,Y,SZ,Z):- Y == 1, Z == 2, X == 3, print_status([SY,SZ,SX]).
print_stacks(SX,X,SY,Y,SZ,Z):- Z == 1, X == 2, Y == 3, print_status([SZ,SX,SY]).
print_stacks(SX,X,SY,Y,SZ,Z):- Z == 1, Y == 2, X == 3, print_status([SZ,SY,SX]).

order(ground,a).
order(a,b).
order(b,c).
order(ground,d).
order(d,e).
order(e,f).
order(ground,g).
order(g,h).

order_stack2(Z,[X,Y],S_order,N,R,I,SJ,J,SK,K):- Z == x, order(Y,X), S_order = [Y,X], print_stacks([Y,X],I,SJ,J,SK,K), R is N+1.
order_stack2(Z,[X,Y],S_order,N,R,I,SJ,J,SK,K):- Z \== x, order(Y,X), S_order = [Y,X], print_stacks([Z,Y,X],I,SJ,J,SK,K), R is N+1.
order_stack2(_,[X,Y],S_order,N,R,_,_,_,_,_):- order(X,Y), S_order = [X,Y], R is N.

order_stack([X,Y,Z],S_order,N,R,I,SJ,J,SK,K):- order(ground,Z), print_stacks([X,Z,Y],I,SJ,J,SK,K), print_stacks([Z,X,Y],I,SJ,J,SK,K), order_stack2(Z,[X,Y],S1_order,N,R1,I,SJ,J,SK,K), S_order = [Z|S1_order], R is R1+2.
order_stack([X,Y,Z],S_order,N,R,I,SJ,J,SK,K):- order(ground,Y), print_stacks([Y,X,Z],I,SJ,J,SK,K), order_stack2(Y,[X,Z],S1_order,N,R1,I,SJ,J,SK,K), S_order = [Y|S1_order], R is R1+1.
order_stack([X,Y,Z],S_order,N,R,I,SJ,J,SK,K):- order(ground,X), print_stacks([X,Y,Z],I,SJ,J,SK,K), order_stack2(X,[Y,Z],S1_order,N,R1,I,SJ,J,SK,K), S_order = [X|S1_order], R is R1.
order_blocks_count(B,B_order,N,R):-  nth1(1,B,S1), nth1(2,B,S2), nth1(3,B,S3), order_stack(S1,S1_order,N,R1,1,S2,2,S3,3), order_stack(S2,S2_order,R1,R2,2,S1,1,S3,3), order_stack2(x,S3,S3_order,R2,R,3,S1,1,S2,2), B_order = [S1_order,S2_order,S3_order].
order_blocks(B,B_order,N):- order_blocks_count(B,B_order,0,N).