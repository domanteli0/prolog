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
    allTrans(Board, Ns, o),
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

test(chain_one_hop) :-
    Board = [
        [e, e, e],
        [e, o, e],
        [e, e, e]
    ],
    chain(Board, Next, _, x),
    Next = [
        [e, e, e],
        [e, o, e],
        [e, e, x]
    ].

:- end_tests(main).
