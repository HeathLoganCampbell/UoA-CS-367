:- [dataStructures].
:- [counter].
:- [planning].
/*
heuristic arbitrary cost  search
*/

/*
solution(+DomainName, +ProblemId, +HeuristicFile, ?SolutionCost, ?Solution)


DomainName is the name of the subdirectory containing the files with:
HeuristicFile.pl: the name of the file where the heuristic h/2 (h(+State, ?HValue) is located
domains.pl: the names of the special (static and metaLevel) predicates and the operators
problems.pl the name of the file containing the problems

ProblemId is the problem id (name) of the problem to be solved

DomainName/HeuristicFile is the file where h/2 is defined

*/

solution(DomainName, ProblemId, HeuristicFile, SolutionCost, SolutionPath) :-
    empty_OpenList(EmptyOpenList),
    loadDomain(DomainName, ProblemId, HeuristicFile),
    problem(_,InitState,Goal),
    h(InitState, InitHValue),
    fluentsOutFrom(InitState, InitStateFluents),
    make_openNode([state(InitStateFluents), step(nil), fValue(InitHValue),
		   gValue(0), hValue(InitHValue), parent(nil)], InitNode),
    openNode_fValue(InitNode, Priority),
    add_OpenList(EmptyOpenList, Priority, InitNode, OpenList),
    empty_ClosedList(EmptyClosedList),
    removeCounter(expanded),
    initialiseCounter(expanded),
    (satisfy(Goal, InitState) ->
	 (SolutionCost = 0,
	  SolutionPath = [ ])
    ;    solution(OpenList, EmptyClosedList, SolutionCost, SolutionPath)),
    counter(expanded, Expanded),
    write('Nodes expanded = '),
    writeln(Expanded).

/*
solution(+OpenList, +ClosedList, -SolutionCost, -SolutionPath)
*/
/* base case */
solution(OpenList, ClosedList, SolutionCost, SolutionPath) :-
    min_OpenList(OpenList, SolutionCost, OpenNodeReached),
    openNode_state(OpenNodeReached, CurrentState),
    satisfyGoal(CurrentState),
    extractSolution_ClosedList(ClosedList, OpenNodeReached, SolutionCost, SolutionPath).



/* recursive case 
remove best node, ParentOpenNode, from open list
ParentState <- ParentOpenNode.state
if ParentState in closed list
then new closed <- old closed
     new open <- updated open
else new closed <- old closed + parentnode
     children <- expand(parentnode)
     new open list <- updated open list + children
*/

solution(OpenList, ClosedList, SolutionCost, SolutionPath) :-
   get_OpenList(OpenList, _, ParentOpenNode, ParentRemovedOpenList),
   openNode_state(ParentOpenNode, ParentState),
   (in_ClosedList(ClosedList, ParentState, ClosedNode) ->
	(NewClosedList = ClosedList,
	 NewOpenList = ParentRemovedOpenList)
   ;    (openNode_to_ClosedNode(ParentOpenNode, ClosedNode),
	 add_ClosedList(ClosedList, ParentState, ClosedNode, NewClosedList),
	 expand_OpenNode(ParentOpenNode, ChildrenNodes),
	 %% this is where duplicate state pruning should go
	 filter_out_duplicates(ChildrenNodes,ClosedList, NewChildrenNodes),
	 addList_OpenList(NewChildrenNodes, ParentRemovedOpenList, NewOpenList))),
   solution(NewOpenList, NewClosedList, SolutionCost, SolutionPath).
