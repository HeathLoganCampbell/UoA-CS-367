:- use_module(library(lists)).

:- ensure_loaded(a2).

pvtRunTest(Index) :-
    testCase(Index, Starts, Network, Expected),
    writeln(Index),
    findall((Cost,  Path), (solution([Start], Network, Cost, Path), member(Start, Starts)), Solutions),
    % intersection(Expected, Solutions, Check),
    sort(Expected, SortedExpected),
    sort(Solutions, SortedSolutions),
    (
        % length(Check, L), length(Expected, L), length(Solutions, L) ->
        SortedExpected = SortedSolutions ->
        writeln('Test Passed'),
        writeln('Found:'),
        writeln(SortedSolutions),
        writeln('Expected:'),
        writeln(SortedExpected),
        writeln('')
        ;    
        writeln('Test Failed'),
        writeln('Found:'),
        writeln(SortedSolutions),
        writeln('Expected:'),
        writeln(SortedExpected),
        writeln(''),
        fail
    ).

runTests() :-
    findall(Index, testCase(Index, _, _, _), Tests),
    length(Tests, TotalTests),
    findall(Success, pvtRunTest(Success), GoodTests),
    length(GoodTests, TotalPassed),
    subtract(Tests, GoodTests, BadTests),
    writeln('Report'),
    write(TotalPassed),
    write(' / '),
    writeln(TotalTests),
    writeln('Passed:'),
    writeln(GoodTests),
    writeln('Failures:'),
    writeln(BadTests),
    (
        \+ TotalPassed = TotalTests ->
        fail
        ;
        true
    ).

testCase(
    1,
    [a, b, c, d],
    [(a, [(b, 12), (c, 13), (d, 1)]), (b, [(a, 8), (c, 16), (d, 15)]), (c, [(a, 12), (b, 9), (d, 15)]), (d, [(a, 11), (b, 18), (c, 6)])],
    [
        (54, [a, b, c, d, a]),
        (54, [b, a, c, d, b]),
        (45, [c, a, b, d, c]),
        (48, [a, c, b, d, a]),
        (47, [b, c, a, d, b]),
        (24, [c, b, a, d, c]),
        (48, [c, b, d, a, c]),
        (54, [b, c, d, a, b]),
        (24, [d, c, b, a, d]),
        (54, [c, d, b, a, c]),
        (45, [b, d, c, a, b]),
        (47, [d, b, c, a, d]),
        (48, [d, a, c, b, d]),
        (24, [a, d, c, b, a]),
        (54, [c, d, a, b, c]),
        (45, [d, c, a, b, d]),
        (54, [a, c, d, b, a]),
        (47, [c, a, d, b, c]),
        (24, [b, a, d, c, b]),
        (45, [a, b, d, c, a]),
        (54, [d, b, a, c, d]),
        (48, [b, d, a, c, b]),
        (47, [a, d, b, c, a]),
        (54, [d, a, b, c, d])
    ]
).

testCase(
    2,
    [a, b, c, d],
    [(a, [(b, 16), (c, 4)]), (b, [(a, 9), (c, 4), (d, 3)]), (c, [(a, 19), (b, 8), (d, 17)]), (d, [(b, 19), (c, 4)])],
    [
        (49, [b, a, c, d, b]),
        (42, [c, a, b, d, c]),
        (49, [c, d, b, a, c]),
        (42, [b, d, c, a, b]),
        (42, [d, c, a, b, d]),
        (49, [a, c, d, b, a]),
        (42, [a, b, d, c, a]),
        (49, [d, b, a, c, d])
    ]
).

testCase(
    3,
    [a, b, c, d],
    [(a, [(b, 9), (d, 3)]), (b, [(a, 2), (c, 10), (d, 15)]), (c, [(b, 17), (d, 3)]), (d, [(a, 11), (b, 13), (c, 10)])],
    [
        (33, [a, b, c, d, a]),
        (32, [c, b, a, d, c]),
        (33, [b, c, d, a, b]),
        (32, [d, c, b, a, d]),
        (32, [a, d, c, b, a]),
        (33, [c, d, a, b, c]),
        (32, [b, a, d, c, b]),
        (33, [d, a, b, c, d])
    ]
).

testCase(
    4,
    [a, b, c, d],
    [(a, [(b, 19)]), (b, [(a, 20), (c, 6), (d, 17)]), (c, [(b, 15), (d, 14)]), (d, [(b, 16), (c, 8)])],
    [
    ]
).

testCase(
    5,
    [a, b, c, d],
    [(a, [(b, 1)]), (b, [(a, 17), (d, 0)]), (c, [(d, 2)]), (d, [(b, 12), (c, 20)])],
    [
    ]
).

testCase(
    6,
    [a, b, c, d],
    [(a, [(b, 0)]), (b, [(a, 19), (d, 15)]), (c, []), (d, [(a, 10), (b, 7)])],
    [
    ]
).

testCase(
    7,
    [a, b, c, d],
    [(a, [(b, 10)]), (b, [(a, 2), (c, 6), (d, 18)]), (c, [(b, 7)]), (d, [(b, 7)])],
    [
    ]
).

testCase(
    8,
    [a, b, c, d],
    [(a, [(b, 4)]), (b, [(a, 17)]), (c, []), (d, [])],
    [
    ]
).

testCase(
    9,
    [a, b, c, d],
    [(a, []), (b, []), (c, []), (d, [])],
    [
    ]
).

testCase(
    10,
    [a, b, c, d],
    [(a, [(b, 14), (d, 2)]), (b, [(a, 2), (c, 10), (d, 16)]), (c, [(d, 15)]), (d, [(a, 3), (b, 9), (c, 17)])],
    [
        (42, [a, b, c, d, a]),
        (42, [b, c, d, a, b]),
        (42, [c, d, a, b, c]),
        (42, [d, a, b, c, d])
    ]
).

testCase(
    11,
    [a, b, c, d],
    [(a, [(b, 9), (c, 3)]), (b, [(a, 17), (c, 10), (d, 17)]), (d, [(b, 6), (c, 19)])],
    [
    ]
).

testCase(
    12,
    [a, b, c, d],
    [(a, [(b, 17), (c, 18), (d, 9)]), (b, [(d, 14)]), (c, [(a, 2)]), (d, [(b, 19), (c, 12)])],
    [
        (45, [c, a, b, d, c]),
        (45, [b, d, c, a, b]),
        (45, [d, c, a, b, d]),
        (45, [a, b, d, c, a])
    ]
).
testCase(
    13,
    [a],
    [(a, [(b, 5), (f, 6)]), (b, [(a, 5), (e, 1), (c, 4)]), (c, [(b, 4), (f, 9), (d, 2)]), (d, [(e, 3), (c, 2), (f, 7)]), (e, [(b, 1), (d, 2)]), (f, [(a, 6), (c, 9), (d, 7)])],
    [
        (25, [a, b, e, d, c, f, a]),
        (26, [a, f, c, d, e, b, a])
    ]
).
testCase(
    14,
    [a],
    [(a, [(b, 2)]), (b, [(a, 1)])],
    [
        (3, [a, b, a])
    ]
).
testCase(
    15,
    [a],
    [(a, [(b, 2), (c, 1)]), (b, [(c, 2), (a, 2)]), (c, [(a, 1), (b, 1)])],
    [
        (5, [a, b, c, a]),
        (4, [a, c, b, a])
    ]
).
testCase(
    16,
    [a],
    [(a, [])],
    [
        (0, [a, a])
    ]
).
testCase(
    17,
    [a],
    [(a, [(b,2)])],
    []
).
testCase(
    18,
    [a],
    [(a, [(b,2)]), (b, [])],
    []
).