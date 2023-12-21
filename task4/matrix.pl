:- module(matrix, [
    matrix_fill/2,
    matrix_dim_fill/3,
    matrix_index_elem/3,
    corners/2,
    matrix_flip_vertical/2,
    matrix_vertical/2
]).

:- use_module(library(clpfd)).
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

rev2(Goal, A, B) :- call(Goal, B, A).
prefix_revArg(A, B) :- rev2(prefix, A, B).
length_revArg(A, B) :- rev2(length, A, B).
prefix_ofLen(PartLen, Whole, Part) :-
    prefix(Part, Whole),
    length(Part, PartLen).

mysubseq_ofLen(PartLen, Whole, Part) :-
    mysubseq(Whole, Part),
    length(Part, PartLen).

% TODO: possible optimiation:
%corners_ofK(Mx, Cx, K)
% REMINDER: prefix(Part, Whole).
matrix_row_permutations(Mx, Cx) :- prefix(Cx, Mx).
matrix_col_permutations(Mx, Cx) :- maplist(prefix_ofLen(_), Mx, Cx).

matrix_index_vertical_(Mx, J, Vertical) :-
    list_index_elem(Mx, _, El),
    list_index_elem(El, J, Vertical).

matrix_index_vertical(Mx, J, Vertical) :- bagof(V, matrix_index_vertical_(Mx, J, V), Vertical).

matrix_vertical(Mx, Vertical) :-
    length(Mx, Len),
    J #< Len,
    J #>= 0,
    matrix_index_vertical(Mx, J, Vertical).

% These reverses result in non-termination
corners(Mx, Cx) :-
%    reverse(Mx, RMx),
%    !,
%    reverse(Cx, RCx),
%    corners_(RMx, RCx).
    corners_(Mx, Cx).
corners_(Mx, Cx) :-
    prefix(Bx, Mx),
    maplist(prefix_ofLen(_), Bx, Cx).

matrix_flip_vertical(Mx, Fx) :- maplist(reverse, Mx, Fx).
