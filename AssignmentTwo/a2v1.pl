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

goal_test(State, Past) :-
  writeln("goal test:"),
  writeln(Past),
  writeln(State),
  writeln("STate in path?"),
  writeln(member(State, Past)),
  not(member(State, Past)).

% solution(Path, RoadNetwork, SolutionCost, SolutionPath, Edges)  :-
%   writeln("function 1:"),
%   [State | _Rest] = Path,
%   goal_test(State, Path),
%   reverse(Path, SolutionPath).

solution(Path, RoadNetwork, SolutionCost, SolutionPath, Edges) :-
  writeln("function 2:"),
  [State | _Rest] = Path,
  writeln(State),
  member((State, Edges), RoadNetwork),
  writeln("Edges:"),
  writeln(Edges),
  member((NextState, NextWeight), Edges),
  goal_test(NextState, Path),
  solution([NextState | Path], RoadNetwork, SolutionCost, SolutionPath, Edges).

% #   length(Path, L),
% #   L < 6,
% #   [State | _Rest] = Path,
% #   successor(State, NextState),
% #   solution([NextState | Path], Solution)

% # % solution([root], Out)