:- use_module(library(record)).
:- use_module(library(ordsets)).
/*
All I knew whow  to do was satisfyGoal, so I did that :)
*/

/*

working_directory(_,'/Users/heathlogancampbell/Documents/software/workspaces/UniversityWorkSpace/UoA-compsci-367/AssignmentFour').
[problemSolver].
solution(tsp, p00, hZero, SolutionCost, SolutionPath).
*/
/* ******************  load domain ************************
used to load the domain.pl file which contains information about
static and metaLevel predicates and the domain operators
to load the file contains problems
and to load the heuristic
*/

loadDomain(DomainName, ProblemId, HeuristicFile) :-
    string_concat(DomainName, "/domain", DomainPath),
    [DomainPath],
    string_concat(DomainName, "/problems", ProblemPath),
    [ProblemPath],
    ld_problem(ProblemId),
    string_concat(DomainName, "/", DomainDir),
    string_concat(DomainDir, HeuristicFile, HeuristicPath),
    [HeuristicPath].
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*             -- plan --
a plan is list of steps
*/
/*             -- step --
a step is an instantiated operator which has
- opName
- opParams
- stepCost
*/
:- record step(opName, opParams, stepCost).

/*              -- state --
states are ordset lists, they need to be duplicate free so that adding
 * & removing a term to a state is predicatable (if duplicates are
 *allowed then sometimes removing a term may not remove all occurences
 *of that term),  specifically states need to have a
 *canonical (i.e., a unique) representation so that they can be used
 *to access items in the closed list.
*/

make_State(Conditions, State) :-
    list_to_ord_set(Conditions, State).


/* satisfy(+Goals, +State)

Goals is a (possibly empty) list of Goal
each Goal has a GoalPred, an Arity, and Arguments
 
if GoalPred is positive
then if GoalPred is metaLevel
     then we can test it by directly executing its definition
     elseif GoalPred is static 
     then look in initial state
     else look in current state
else Goal = not(InnerGoal)
     test InnerGoal
*/
    

%%% ***** this is where you put your satisfy(+Goals, +State) code *****

% % We start  with the base case, where goal is nothing and we don't care about state
satisfy([], _).

/* satisfyGoal(State)

Tests whether State satisfies this problem's goal
*/

% satisfyGoal(State) :-
satisfyGoal(State) :-
    problem(_, _, Goals),
    satisfy(Goals, State).

%%% ***** this is where you put your satisfyGoal(+State) code *****




/* %%%%%%%%%%%%%%%%%%%%

problem data structure

%%%:- record problem(name, initState, goals).

currently the current problem is stored in the prolog database
so that it is easily accessible from various parts of the program
without needing to pass it as a parameter

*/
make_Problem(Name, InitConds, Goals, problem(Name, InitState, Goals)) :-
    list_to_ord_set(InitConds, InitState).

problem_name(Name) :- problem(Name, _,_).
problem_initState(InitState) :- problem(_,InitState, _).
problem_goals(Goals) :- problem(_,_, Goals).

/* ld_problem(+ProbName)

actually loads the named problem into the prolog database as a problem
 with that name
*/
ld_problem(ProbName) :-
    prob(ProbName, InitState, Goals),
    list_to_ord_set(InitState, OrdInitState),
    retractall(problem(_,_,_)),
    make_Problem(ProbName, OrdInitState, Goals, Prob),
    assert(Prob),
    write('** problem '),
    write(ProbName),
    writeln(' has been loaded.').




/* %%%%%%%%%%%%%%%%%%%%

operators are asserted into the Prolog d/b as op(OperatorDataStructure)

are queried directly using OperatorDataStructure format below

operator OperatorDataStructure format
- name
- params
- preconditions
- effects
- cost
*/
%%:-  op(name, params, preconditions, effects, cost).
op_record(Name, Params, Preconds, Effects, Cost) :-
    op(Name, Params, Preconds, Effects, Cost).

op_name(Name) :- op(Name, _,_,_,_).
op_params(Name, Params) :- op(Name, Params, _, _, _).
op_preconds(Name, Params, Preconds) :- op(Name, Params, Preconds, _, _).
op_effects(Name, Params, Effects) :- op(Name, Params, _, Effects, _).
op_cost(Name, Params, Cost) :- op(Name, Params, _, _, Cost).

op_CleanUp() :-
    retractall(op(_,_,_,_,_)).

op_Load([]).
op_Load([Op | Rest]) :-
	assertz(op(Op)),
	op_Load(Rest).

%% op_Applicable(+State, ?OpName, ?Params)
/*
this code requires that any negated preconditions in an operator get
tested only after all variables have been bound.  This is the responsibility 
of the domain designer, who must order the preconditions so that happens naturally.  
*/



%%% ***** this is where you put your op_Applicable(+State, ?OpName, ?Params) code *****



%% op_ApplyOp(+OldState, +Step, ?NewState)
/* 
NewState is created by appropriately deleting the inner predicates
 of Step's negated effects and adding its positive effects

*/



%%% ***** this is where you put your op_ApplyOp(+OldState, +Step, ?NewState) code *****

