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


legal_move(State, Past, CitiesCount) :-
% There should be 1 more visited city then city count because we need to included the starting and ending citiy (aka it repeats twice)
  (length(Past, VistedCities),
  writeln("VistedCities > CitiesCount"),
  writeln(Past),
  writeln(VistedCities == CitiesCount),
  VistedCities == CitiesCount,
  last(State, Past));
  not(member(State, Past)).

% sum an array of numbers
sum([Number | RestOfList], Sum) :-
  sum(RestOfList, SubSum), 
  Sum is Number + SubSum.

% Gets the last item in a list
% last(X,[_|Z]) :- 
%   last(X,Z).

% last([X]) :-
%       writeln("Last : "),
%       writeln(X).

% Gets the last item in a list
% Example:
% last(LastItem, [a, b, c, d])
% OutPut:
% LastItem = d
last(Z, [X]) :-
  Z = X.

last(Z, [Y|Tail]) :-
  last(Z, Tail).

goal_test(State, Past) :-
  % start is equal to last move
  writeln("goal test"),
  writeln(State),
  writeln(Past),
  last(State, Past).

solution(Path, RoadNetwork, SolutionCost, SolutionPath) :-
  writeln("function 1:"),
  [State | _Rest] = Path,
  goal_test(State, Path),
  writeln("function 1:"),
  reverse(Path, SolutionPath).

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
  length(RoadNetwork, CitiesCount),
  legal_move(NextState, Path, CitiesCount),
  solution([NextState | Path], RoadNetwork, SolutionCost, SolutionPath).