:- begin_tests(main).
:- use_module(main).

test(reverse) :-
        reverse([a,b], [b,a]).

test(allTrans0) :-
    Board = [
        [e, e, e],
        [e, e, e],
        [e, e, e]
    ],
    allTransO(Board, Ns),
    Ns = [
        [
            [o, e, e],
            [e, e, e],
            [e, e, e]
        ],
        [
            [e, o, e],
            [e, e, e],
            [e, e, e]
        ],
        [
            [e, e, o],
            [e, e, e],
            [e, e, e]
        ],
        [
            [e, e, e],
            [o, e, e],
            [e, e, e]
        ],
        [
            [e, e, e],
            [e, o, e],
            [e, e, e]
        ],
        [
            [e, e, e],
            [e, e, o],
            [e, e, e]
        ],
        [
            [e, e, e],
            [e, e, e],
            [o, e, e]
        ],
        [
            [e, e, e],
            [e, e, e],
            [e, o, e]
        ],
        [
            [e, e, e],
            [e, e, e],
            [e, e, o]
        ]
    ].

:- end_tests(main).
