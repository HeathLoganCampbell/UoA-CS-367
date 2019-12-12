six_cities(RoadNetwork) :-
  [
    (a, [(b, 5), (f, 6)]),
    (b, [(a, 5), (e, 1), (c, 4)]),
    (c, [(b, 4), (f, 9), (d, 2)]),
    (d, [(e, 3), (c, 2), (f, 7)]),
    (e, [(b, 1), (d, 2)]),
    (f, [(a, 6), (c, 6), (d, 7)])
  ] = RoadNetwork.
% We want all paths and their costs

% We start somewhere and we want to end at the same place

% sum an array of numbers
sum([Number | RestOfList], Sum) :-
  sum(RestOfList, SubSum), 
  Sum is Number + SubSum.

legal_move(State, Past, MaxSize) :-
  length(Past, MaxSize);
  not(member(State, Past)).

% [a] = A, six_cities(R), solution(A, R, Cost, Path).
solution(Path, RoadNetwork, SolutionCost, SolutionPath) :-
  [State | _Rest] = Path,
  writeln('====================='),
  writeln('State:'),
  writeln(State),
  writeln('Path:'),
  writeln(Path),
  member((State, Edges), RoadNetwork),
  writeln('Edges:'),
  writeln(Edges),
  member((NextState, NextWeight), Edges),
  length(RoadNetwork, MaxSize),
  legal_move(NextState, Path, MaxSize),
  solution([NextState | Path], RoadNetwork, SolutionCost, SolutionPath).

% #   length(Path, L),
% #   L < 6,
% #   [State | _Rest] = Path,
% #   successor(State, NextState),
% #   solution([NextState | Path], Solution)

% # % solution([root], Out)