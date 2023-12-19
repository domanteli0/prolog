:- module(list, [list_length_fill/3, list_index_elem/3]).

:- use_module(library(clpfd)).

list_length_fill([], 0, _).
list_length_fill([E|Ls], N, E):-
    list_length_fill(Ls, N1, E), N1 #= N - 1.

list_index_elem([El|_], 0, El).
list_index_elem([_|Ls], N, El):-
    list_index_elem(Ls, N1, El), N1 #= N - 1.

?- list_index_elem([0,1,a,3,4], 2, a).
