%:- module(line, [matrix_length_line/3]).
:- module(line_test, [
    matrix_length_line/3,
    horizontal/3,
    vertical/3,
    diag1/3,
    diag2/3
]).

:- use_module(library(clpfd)).
:- use_module(matrix).
:- use_module(list).

matrix_length_line(Bx, K, Line) :- horizontal(Bx, K, Line).
matrix_length_line(Bx, K, Line) :- vertical(Bx, K, Line).
%matrix_length_line(Bx, K, Line) :- diag1(Bx, K, Line).
%matrix_length_line(Bx, K, Line) :- diag2(Bx, K, Line).

horizontal([Row|_], K, Horizontal) :-
    mysubseq(Row, Horizontal),
    length(Horizontal, K).
horizontal([_|Rows], K, Horizontal) :-
    horizontal(Rows, K, Horizontal).

vertical(Bx, K, Vertical) :-
    matrix_vertical(Bx, V),
    mysubseq(V, Vertical),
    length(Vertical, K).


diag1_(_, 0, []).
diag1_([[B|_]|Bs], K1, [B|Acc]) :-
    K1 #> 0,
    K1 #= K + 1,
    diag1_(Bs, K, Acc).

diag1(Bx, K, Diagonal) :-
    corners(Bx, Cx),
    diag1_(Cx, K, Diagonal),
    length(Diagonal, K).

diag2(Bx, K, Diagonal) :-
    matrix_flip_vertical(Bx, Fx),
    diag1(Fx, K, Diagonal).


