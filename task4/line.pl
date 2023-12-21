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
matrix_length_line(Bx, K, Line) :- diag1(Bx, K, Line).
matrix_length_line(Bx, K, Line) :- diag2(Bx, K, Line).

horizontal([Row|_], K, Horizontal) :-
    mysubseq(Row, Horizontal),
    length(Horizontal, K).
horizontal([_|Rows], K, Horizontal) :-
    horizontal(Rows, K, Horizontal).

vertical(Bx, K, Vertical) :-
    matrix_vertical(Bx, V),
    mysubseq(V, Vertical),
    length(Vertical, K).


diag1([], K, []) :- K #= 0.
diag1([[E|_]|Bx], K, [E|Ds]) :-
    maplist(list_tail, Bx, RBx),
    K1 #= K - 1,
    diag1(RBx, K1, Ds).

list_tail([_|Es], Es).

diag2(Bx, K, Diagonal) :-
    matrix_flip_vertical(Bx, Fx),
    diag1(Fx, K, Diagonal).


