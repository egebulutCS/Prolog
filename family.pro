/* Knowledge Base for exercise 1 */
male(john).
male(peter).
male(mike).
male(paul).
male(bill).
male(ralph).
male(mark).
male(joe).
male(sam).
male(jack).
male(james).
male(zac).

female(mary).
female(martha).
female(anna).
female(sue).
female(jane).
female(olga).
female(laura).
female(meg).
female(jill).
female(eva).
female(lucy).
female(ruth).

parents(anna,john,mary).
parents(sue,john,mary).
parents(bill,john,mary).
parents(jane,peter,martha).
parents(olga,peter,martha).
parents(mark,mike,anna).
parents(joe,paul,sue).
parents(eva,paul,sue).
parents(luke,paul,sue).
parents(sam,bill,jane).
parents(meg,bill,jane).
parents(jack,bill,jane).
parents(jill,ralph,olga).
parents(lucy,ralph,olga).
parents(ruth,ralph,olga).

married(john,mary).
married(peter,martha).
married(ralph,olga).
married(james,eva).
married(sam,laura).
married(mike,anna).
married(paul,sue).
married(bill,jane).
married(zac,lucy).

brother(X,Y):- parents(X,F,M), parents(Y,F,M), male(Y), X\==Y.
sister(X,Y):- parents(X,F,M), parents(Y,F,M), female(Y), X\==Y.
father(X,Y):- male(Y), parents(X,Y,_).
mother(X,Y):- female(Y), parents(X,_,Y).
aunt(X,Y):- parents(X,_,M), sister(M,Y).
aunt(X,Y):- parents(X,F,_), sister(F,Y).
nephew(X,Y):- male(Y), parents(Y,_,M), brother(X,M).
nephew(X,Y):- male(Y), parents(Y,F,_), brother(X,F).
nephew(X,Y):- male(Y), parents(Y,_,M), sister(X,M).
nephew(X,Y):- male(Y), parents(Y,F,_), sister(X,F).