:- module(matrix, [matrix_dim_fill/3, matrix_index_elem/3]).

:- use_module(list).

% N - no of rows
% M - no of cols
matrix_dim_fill(Mx, [N, M], El):-
    list_length_fill(Mx, N, Ls),
    list_length_fill(Ls, M, El).

matrix_index_elem(Mx, [I, J], El):-
    list_index_elem(Mx, I, Ls),
    list_index_elem(Ls, J, El).

?- matrix_dim_fill(Board, [4, 3], e), Board = [[e,e,e], [e,e,e], [e,e,e], [e,e,e]].

