% Domantas Keturakis
% PS III kursas, I gr.
%
% Užduotis:
% 14. [S] Žaidimas "Kryžiukai-nuliukai".
%    Duota stačiakampių langelių lenta iš N eilučių ir M stulpelių (N ir M duoti). Kai kurie iš langelių užpildyti kryžiukais arba nuliukais. Kad laimėtų, komandai reikia iš eilės sudėlioti K (duotas) simbolių. Nustatykite, kaip nuliukai dviem ėjimais laimi prieš kryžiukus.

% [I, J] | [R, C] | [N, M]
% Y axis: I, R, N
% X axis: J, C, M

:- use_module(library(clpfd)).
:- use_module(matrix).


cell(o). % occupied by O
cell(x). % occupied by X
cell(e). % empty

%starting_board([
%    [e, e, e],
%    [e, e, e],
%    [e, e, e]
%], N, M) :- N #= 3, M #= 3.

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

