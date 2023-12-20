:- module(list, [list_fill/2, list_length_fill/3, list_index_elem/3, mysubseq/2]).

:- use_module(library(clpfd)).

list_fill([], _).
list_fill([E|Ls], E) :- list_fill(Ls, E).

list_length_fill(Ls, N, E) :- length(Ls, N), list_fill(Ls, E).

list_index_elem([El|_], 0, El).
list_index_elem([_|Ls], N, El) :-
    list_index_elem(Ls, N1, El), N1 #= N - 1.

?- list_index_elem([0,1,a,3,4], 2, a).

mysubseq([W|Whole], [P|Part]) :-
    prefix(Part, Whole).
mysubseq([W|Whole], [P|Part]) :-
    P \= W,
    mysubseq(Whole, Part).
