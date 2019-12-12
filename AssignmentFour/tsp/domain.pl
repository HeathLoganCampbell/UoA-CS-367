staticPreds([edge/3]).
metaLevelPreds([neq/2]).
neq(X,Y) :- X \== Y.  %% X and Y are not bound to the same value at this time.

/* 
move from city directly back to itself for cost of 0
move from city to another city if there is an edge between them
and it is not an edge back to itself for that edge cost
*/

op(selfVisit, [City],
   [at(City), unVisited(City)],
   [not(unVisited(City))],
   0).

op(move, [FromCity, Cost, ToCity],
   [at(FromCity), edge(FromCity, ToCity, Cost),
    unVisited(ToCity), neq(FromCity,ToCity)],
   [not(at(FromCity)), not(unVisited(ToCity)), at(ToCity)],
   Cost).
