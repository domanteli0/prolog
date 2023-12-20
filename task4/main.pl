% Domantas Keturakis
% PS III kursas, I gr.
%
% Užduotis:
% 14. [S] Žaidimas "Kryžiukai-nuliukai".
%    Duota stačiakampių langelių lenta iš N eilučių ir M stulpelių (N ir M duoti). Kai kurie iš langelių užpildyti kryžiukais arba nuliukais. Kad laimėtų, komandai reikia iš eilės sudėlioti K (duotas) simbolių. Nustatykite, kaip nuliukai dviem ėjimais laimi prieš kryžiukus.

% [I, J] | [R, C] | [N, M]
% Y axis: I, R, N
% X axis: J, C, M
:- module(main, [allTrans/3, chain/4, win/3]).

:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(matrix).
:- use_module(list).
:- use_module(library(lists)).

cell(o). % occupied by O
cell(x). % occupied by X
cell(e). % empty

standard_board([
    [e, e, e],
    [e, e, e],
    [e, e, e]
], N, M) :- N #= 3, M #= 3.

standard_board([
    [e, e, e],
    [e, e, e],
    [e, e, e]
]).

write_line([]) :- write('\n').
write_line([o|Ls]) :- write('O '), write_line(Ls).
write_line([x|Ls]) :- write('X '), write_line(Ls).
write_line([e|Ls]) :- write('. '), write_line(Ls).

write_board([]).
write_board([B|Bs]) :- write_line(B), write_board(Bs).

write_all([]).
write_all([B|Ls]) :- write_board(B), write_all(Ls).

% state transitions
prevL_nextL_index_prevEl_nextEl([PrevEl|Ls], [NextEl|Ls], 0, PrevEl, NextEl).
prevL_nextL_index_prevEl_nextEl([E|PrevL], [E|NextL], I, PrevEl, NextEl) :-
    prevL_nextL_index_prevEl_nextEl(PrevL, NextL, I1, PrevEl, NextEl), I1 #= I - 1.

transL(Ps, Ns, I, P, N) :- prevL_nextL_index_prevEl_nextEl(Ps, Ns, I, P, N).

transM(Ps, Ns, [I, J], P, N) :-
    transL(Ps, Ns, I, Pl, Nl),
    transL(Pl, Nl, J, P, N).

?- transM([[a,a], [a,a]], [[a,a], [a,b]], [1,1], a, b).

?-  matrix_dim_fill(B1, [4, 3], e),
    transM(B1,B2, [1,1], e, o),
    matrix_index_elem(B2, [1,1], o).

% Px - Previous matriX
% Nx - Next matriX
trans(Px, Nx, o) :- transM(Px, Nx, [_, _], e, o).
trans(Px, Nx, x) :- transM(Px, Nx, [_, _], e, x).

allTrans(Px, Nxs, o):- findall(Nx, trans(Px, Nx, o), Nxs).
allTrans(Px, Nxs, x):- findall(Nx, trans(Px, Nx, x), Nxs).

opposite(x, o).
opposite(o, x).

% Mx - Start board
% Ex - end state
% Lx - list of moves
% S  - a side for which a trun is taken (either x or o)
chain(Ex, Ex, [Ex], _).
chain(Mx, Ex, [Mx|Ls], S) :-
    trans(Mx, Sx, S),
    opposite(S, O),
    chain(Sx, Ex, Ls, O),
    Mx \= Ex.


win(Board, K, S) :-
    horizontal(Board, K, S).

% can be optimized with [findnsols](https://www.swi-prolog.org/pldoc/doc_for?object=findnsols/4)
%horizontal(Board, K, S) :-
%    list_length_fill(Win, K, S),
%    any(Board, El, subseq(El, Win, _)).
%
%any([El|List], El, Goal) :- clause(El, Goal), any(List, Goal), !.
%any([_|List], _, Goal)  :- any(List, Goal), !.

horizontal([B|_], K, S) :-
    list_length_fill(Win, K, S),
    subseq(B, Win, _).

horizontal([_|Bs], K, S) :- horizontal(Bs, K, S).



%% dr - right
%line_dr(Board, [Row, Col], Depth):-

