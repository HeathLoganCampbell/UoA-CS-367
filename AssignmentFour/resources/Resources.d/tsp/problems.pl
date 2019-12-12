prob(p00,
     [at(a)],
     [at(a), not(unVisited(_))]).

prob(p01,
     [at(a), unVisited(a)],
     [at(a), not(unVisited(_))]).


prob(p02,
     [at(a), unVisited(a), unVisited(b), edge(a,b,2), edge(b,a,1)],
     [at(a), not(unVisited(_))]).

/* tours from chapter6-part6.pdf */
prob(example5,
     [at(a), unVisited(a), unVisited(b), unVisited(c), unVisited(d),
      edge(a,b,12), edge(b,a,12), edge(a,c,14), edge(c,a,14),
      edge(a,d,17), edge(d,a,17), edge(b,c,15), edge(c,b,15),
      edge(b,d,18), edge(d,b,18), edge(c,d,29), edge(d,c, 29)],
     [at(a), not(unVisited(_))]).
