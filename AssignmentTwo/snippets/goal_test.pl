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
goal_test(VisistedCities, CitiesCount) :-
  length(VisistedCities, VCitiesCount),
  VCitiesCount > CitiesCount,
  [LastVistedCity | _] = VisistedCities,
  last(LastVistedCity, VisistedCities).
