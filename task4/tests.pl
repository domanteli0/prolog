:- begin_tests(main).
:- use_module(main).

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

% uncomment this no to time query
%test(chain_all_posibilites, all(length(Ls, _))) :-
%    Board = [
%        [o, e, e],
%        [e, e, e],
%        [e, e, e]
%    ],
%    chain(Board, _, Ls, o).

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

test(horizontal) :-
    Board = [
        [x, x, e],
        [e, o, o],
        [e, e, e]
    ],
    win(Board, 2, o).

:- end_tests(main).
