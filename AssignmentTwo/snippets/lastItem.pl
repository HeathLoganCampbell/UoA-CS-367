% Gets the last item in a list
% Example:
%   last(LastItem, [a, b, c, d])
%
% OutPut:
%   LastItem = d
last(Z, [X]) :-
  Z = X.

last(Z, [Y|Tail]) :-
  last(Z, Tail).