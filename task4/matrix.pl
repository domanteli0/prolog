:- module(matrix, [matrix_fill/2, matrix_dim_fill/3, matrix_index_elem/3]).

:- use_module(list).

% N - no of rows
% M - no of cols
matrix_fill([[]], _).
matrix_fill(Mx, El):-
    list_fill(L, El),
    list_fill(Mx, L).

matrix_dim_fill([[]], [0, 0], _).
matrix_dim_fill(Mx, [N, M], El) :-
    list_length_fill(L, M, El),
    list_length_fill(Mx, N, L).

matrix_index_elem(Mx, [I, J], El) :-
    list_index_elem(Mx, I, Ls),
    list_index_elem(Ls, J, El).

?- matrix_dim_fill(Board, [4, 3], e), Board = [[e,e,e], [e,e,e], [e,e,e], [e,e,e]].

