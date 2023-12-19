% Domantas Keturakis
% PS III kursas, I gr.
%
% Užduotis:
% 14. [S] Žaidimas "Kryžiukai-nuliukai".
%    Duota stačiakampių langelių lenta iš N eilučių ir M stulpelių (N ir M duoti). Kai kurie iš langelių užpildyti kryžiukais arba nuliukais. Kad laimėtų, komandai reikia iš eilės sudėlioti K (duotas) simbolių. Nustatykite, kaip nuliukai dviem ėjimais laimi prieš kryžiukus.

% [I, J] | [R, C] | [N, M]
% Y axis: I, R, N
% X axis: J, C, M

?- use_module(library(clpfd)).

cell(o). % occupied by O
cell(x). % occupied by X
cell(e). % empty

starting_board([
    [e, e, e],
    [e, e, e],
    [e, e, e]
], N, M) :- N #= 3, M #= 3.

% empty list and matrix generation
list_length_fill([], 0, _).
list_length_fill([E|Ls], N, E):-
    list_length_fill(Ls, N1, E), N1 #= N - 1.

% N - no of rows
% M - no of cols
matrix_dim_fill(Mx, [N, M], El):-
    list_length_fill(Mx, N, Ls),
    list_length_fill(Ls, M, El).

?- matrix_dim_fill(Board, [4, 3], e), Board = [[e,e,e], [e,e,e], [e,e,e], [e,e,e]].

% list and matrix indexing
list_index_elem([El|Ls], 0, El).
list_index_elem([_|Ls], N, El):-
    list_index_elem(Ls, N1, El), N1 #= N - 1.

matrix_index_elem(Mx, [I, J], El):-
    list_index_elem(Mx, I, Ls),
    list_index_elem(Ls, J, El).

?- list_index_elem([0,1,a,3,4], 2, a).

% state transitions
prevL_nextL_index_prevEl_nextEl([PrevEl|Ls], [NextEl|Ls], 0, PrevEl, NextEl).
prevL_nextL_index_prevEl_nextEl([E|PrevL], [E|NextL], I, PrevEl, NextEl):-
    prevL_nextL_index_prevEl_nextEl(PrevL, NextL, I1, PrevEl, NextEl), I1 #= I - 1.

transL(Ps, Ns, I, P, N):- prevL_nextL_index_prevEl_nextEl(Ps, Ns, I, P, N).

transM(Ps, Ns, [I, J], P, N):-
    transL(Ps, Ns, I, Pl, Nl),
    transL(Pl, Nl, J, P, N).

?- transM([[a,a], [a,a]], [[a,a], [a,b]], [1,1], a, b).

%% dr - right
%line_dr(Board, [Row, Col], Depth):-

