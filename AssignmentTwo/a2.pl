%
% HEATH LOGAN CAMPBELL
% HCAM630
%
% v3
% 6 +9+2+3+1+5
% six_cities(RoadNetwork) :-
%   [
%     (a, [(b, 5), (f, 6)]),
%     (b, [(a, 5), (e, 1), (c, 4)]),
%     (c, [(b, 4), (f, 9), (d, 2)]),
%     (d, [(e, 3), (c, 2), (f, 7)]),
%     (e, [(b, 1), (d, 2)]),
%     (f, [(a, 6), (c, 9), (d, 7)])
%   ] = RoadNetwork.

% three_cities(RoadNetwork) :-
%   [
%     (a, [(b, 5)]),
%     (b, [(a, 5), (c, 4)]),
%     (c, [(b, 4), (a, 9)])
%   ] = RoadNetwork.

% Gets the last item in a list
% Example:
%   last(LastItem, [a, b, c, d])
%
% OutPut:
%   LastItem = d
last(Z, [X]) :-
  Z = X.

last(Z, [_|Tail]) :-
  last(Z, Tail).

% Will add up a list of numbers
% Step 1, get the next state,
% Step 2, get the weight to the next state
% Step 3, repeat?
% Example
%   weight_sum( [(a, [(b, 5)]),  (b, [(a, 5),  (c, 4)]),  (c, [(b, 4),  (a, 9)]),  (a, [(b, 5)])], [(a, [(b, 5)]),  (b, [(a, 5),  (c, 4)]),  (c, [(b, 4),  (a, 9)])], Total)
% Output
%   
weight_sum([], _, 0).

% Example
%   weight_sum([(c, [(a, 2)]), (a, [(b, 5)])], _, Sum).
% output
%   Sum = 2
weight_sum(Path, _, Sum) :-
  length(Path, PathCount),
  PathCount == 1,
  Sum = 0.


% Example
%   weight_sum([a,b,c,a],[(a,[(b,5)]),  (b,[(a,5),(c,4)]),(c,[(b,4),(a,9)])], Sum)
% Output
%   Sum = 18
weight_sum([H|T], RoadNetwork, Sum) :-
  weight_sum(T, RoadNetwork, ChildSum),
  State = H,
  [H2 | _ ] = T,
  NextState = H2,
  member((State, Weights), RoadNetwork),
  member((NextState, WeightToNext), Weights),
  Sum is WeightToNext + ChildSum.


  %  sum(T, RoadNetwork, Rest),
  %  (State, Childern) = T,
  %  [NextState | _ ] = Childern,

  %  member((State, Edges), RoadNetwork),
  %  Sum is H + Rest.

% This fuction will sum up the total
% weight and path that was used


% Goal condition
%   We want the 
%     - start and end node to be equal
%     - Visited Cities must be length(Cities) + 1 (Because we repeat the starting point)
% Example
%   goal_test([a, b, c, a], 3)
% OutPut:
%   true
%
% Example
%   goal_test([b, b, c, a], 3)
% OutPut:
%   false
% Example
%   goal_test([(a, [(b, 5)]), (c, [(b, 4), (a, 9), (d, 2)]), (b, [(a, 5), (c, 4)]), (a, [(b, 5)])], 3)
% OutPut:
%   false
goal_test(VisistedCities, CitiesCount) :-
  length(VisistedCities, VCitiesCount),
  VCitiesCount > CitiesCount,
  [LastVistedCity | _] = VisistedCities,
  last(LastVistedCity, VisistedCities).

% Base case
%   This is where the logic will hit a dead end
%   and hopefully progate back up
% Example
%   three_cities(Cities), solution([(a, [(b, 5)]), (c, [(b, 4), (a, 9)]), (b, [(a, 5), (c, 4)]), (a, [(b, 5)])], Cities, SolutionCost, SolutionPath)
% Out
%   true
%   not -> (33, [a, b, c, a]),
solution(Path, RoadNetwork, SolutionCost, SolutionPath) :-
  % writeln("Base case"),
  length(RoadNetwork, CitiesCount),
  % writeln(length(RoadNetwork, CitiesCount)),
  % writeln(goal_test(Path, CitiesCount)),
  goal_test(Path, CitiesCount),
  % weight_sum(Path, SolutionCost),
  reverse(Path, SolutionPath),
  % print(weight_sum(SolutionPath, RoadNetwork, SolutionCost)),
  weight_sum(SolutionPath, RoadNetwork, SolutionCost).

% Special case
% Example
%   solution([a], [(a, [])], SolutionCost, SolutionPath).
solution(Path, RoadNetwork, SolutionCost, SolutionPath) :-
  length(RoadNetwork, CityCount),
  CityCount == 1,
  SolutionCost = 0,
  [H | _ ] = Path,
  ((
    member((H, Weights), RoadNetwork),
    length(Weights, WeightCount),
    WeightCount == 0
  );
  (
    not(member((H, Weights), RoadNetwork))
  )),
  SolutionPath = [H, H].

% resurive case
%   this function will keep going deeper until it hits the base case
% Example
%   three_cities(Cities), solution([a], Cities, SolutionCost, SolutionPath).

solution(Path, RoadNetwork, SolutionCost, SolutionPath) :-
  % writeln("resurive case"),
  [State | _Rest] = Path,
  % writeln(Path),
  member((State, Edges), RoadNetwork),
  % writeln("Edges"),
  % writeln(Edges),
  member((NextState, NextWeight), Edges),
  %% Check if it's on the map?
  member((NextState, _), RoadNetwork),
  % member((NextState), Edges),
  % writeln("NextState"),
  % writeln(NextState),
  (
    (
      % writeln(not(member(NextState, Path))),
      not(member(NextState, Path))
    );
    (
      last(NextState, Path),
      length(RoadNetwork, CitiesCount),
      length(Path, VCitiesCount),
      VCitiesCount == CitiesCount
    )
  ),
  solution([NextState | Path], RoadNetwork, SolutionCost, SolutionPath).
