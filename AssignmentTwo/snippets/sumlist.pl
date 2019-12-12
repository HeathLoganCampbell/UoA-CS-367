% Will add up a list of numbers
% Example
%   sum([1,2,3,4,5], Total)
% Output
%   15
sum([], 0).
sum([H|T], Sum) :-
   sum(T, Rest),
   Sum is H + Rest.