:- [tsp/problems].

satisfyGoal([_ | TailState]) :-
  [_ | Last] = TailState,
  [Goal] = Last,
  print(Goal),
  prob(_, _, Goal).
