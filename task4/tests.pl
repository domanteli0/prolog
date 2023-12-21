:- begin_tests(main).
:- use_module(main).
:- use_module(line).

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

test(diag_simple) :-
    Board = [
        [x, x, e],
        [e, x, o],
        [e, e, e]
    ],
    diag1(Board, 2, Acc),
    Acc = [x, e].

% This is kinda a bad test
% since it relies on
% order of the lines
%test(lines) :-
%    Board = [
%        [a, b, c],
%        [d, e, f],
%        [g, h, i],
%        [j, k, l]
%    ],
%    bagof(L, matrix_length_line(Board, 2, L), Lines),
%    Lines = [
%        [a, b],
%        [b, c],
%        [d, e],
%        [e, f],
%        [g, h],
%        [h, i],
%        [j, k],
%        [k, l]
%    ].

test(find_win_1) :-
    standard_board(Board, _, _),
    chain(Board, WinForO, States, o),
    % 1 - starting board
    % 2 - O plays
    % 3 - X plays
    % 4 - O plays
    % 5 - X plays
    % 6 - O plays
    length(States, 6),
    win(WinForO, 3, o).

test(find_win_2) :-
    Board = [
        [e, e, e],
        [e, e, e],
        [e, o, x],
        [e, e, e]
    ],
    chain(Board, WinForO, States, o),
    length(States, 4),
    win(WinForO, 3, o).

:- end_tests(main).
