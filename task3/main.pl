% Domantas Keturakis
% PS III kursas, I gr.
% 1.12; 2.2; 3.5; 4.3
% Apibrėžkite paskirtus keturis predikatus pagal nurodytas sąlygas. Nors kai kurių užduočių formulavimas yra procedūrinis, reikia siekti, kiek įmanoma, deklaratyvios programos. Nenaudokite Prolog darbo su sąrašais predikatų. Pasiaiškinkite, kaip taikomas atkirtos (!) operatorius ir kur jį galima būtų panaudoti Jūsų predikatuose.

?- use_module(library(clpfd)).

% 1. Paprasti predikatai su sveikųjų skaičių sąrašais:
%   1.12. skirk_teig_neig(S,R1,R2) - pradinis skaičių sąrašas S išskirstytas į du sąrašus: teigiamų - R1 - ir neigiamų - R2. Pavyzdžiui:
          %?- skirk_teig_neig([5,-1,-4,3,0],R1,R2).
          %R1 = [5,3], R2 = [-1,-4].

skirk_teig_neig([], [], []).
skirk_teig_neig([F|Full], [F|Ps], Ns) :-
    F #> 0,
    !,
    skirk_teig_neig(Full, Ps, Ns).

skirk_teig_neig([F|Full], Ps, [F|Ns]) :-
    F #< 0,
    !,
    skirk_teig_neig(Full, Ps, Ns).

skirk_teig_neig([_|Full], Ps, Ns) :- skirk_teig_neig(Full, Ps, Ns).

?- skirk_teig_neig([5,-1,-4,3,0],R1,R2), R1 = [5,3], R2 = [-1,-4].
% skirk_teig_neig([-1, 0, 1],R1,R2).

% 2. Paprasti nearitmetiniai predikatai:
%   2.2. apjungti(SS,R) - sąrašas R gaunamas iš duotojo sąrašų sąrašo SS, sujungus pastarojo sąrašus į bendrą sąrašą. Giliuosius sąrašus apdoroti nėra būtina. Pavyzdžiui:
         %?- apjungti([[a,b],[c],[d,[e,f], g]],R).
         %R = [a,b,c,d,[e,f],g].

concat([], Rs, Rs).
concat([E|Ls], Rs, [E|Fs]) :- concat(Ls, Rs, Fs), !.

apjungti([], []).
apjungti([S|Ss], R) :-
    apjungti(Ss, R1),
    !,
    concat(S, R1, R).

?- apjungti([[a,b],[c],[d,[e,f], g]],R), R = [a,b,c,d,[e,f],g].
% apjungti(I, [a, b]).               % Cut

% 3. Sudėtingesni predikatai:
%   3.5. skirtumas(S1,S2,R) - sąrašas R susideda iš duotojo sąrašo S1 elementų, kurie nepriklauso kitam duotajam sąrašui S2. Pavyzdžiui:
         %?- skirtumas([a,b,c,d],[d,e],R).
         %R = [a,b,c].

el_in_list(E, [E|_]).
el_in_list(E, [X|Ls]) :- el_in_list(E, Ls), X \= E.

el_not_in_list(E, [X|Ls]) :- X \= E, el_not_in_list(E, Ls).
el_not_in_list(_, []).

skirtumas([], _, []).
skirtumas([S|S1], S2, [S|R]) :-
    el_not_in_list(S, S2),
    !,
    skirtumas(S1, S2, R).

skirtumas([S|S1], S2, R) :-
    el_in_list(S, S2),
    !,
    skirtumas(S1, S2, R).

?- skirtumas([a,b,c,d],[d,e],R), R = [a,b,c].
?- skirtumas([a,b,c,d],[e],R), R = [a,b,c,d].
?- skirtumas([a,b,c,d],[a],R), R = [b,c,d].
% skirtumas([a, b, c, d], S2, [a, b, c]).

% 4. Operacijos su natūraliaisiais skaičiais, išreikštais skaitmenų sąrašais. Skaitmenų sąrašo elementai turi būti natūralūs skaičiai nuo 0 iki 9 (ne simboliai '0', '1',...). Nenaudokite Prolog konvertavimo tarp sąrašo ir skaičiaus predikatų (number_chars/2, number_codes/2 ir kt...):
%   4.3. suma(S1,S2,Sum) - S1 ir S2 yra skaičiai vaizduojami skaitmenų sąrašais. Sum - tų skaičių suma vaizduojama skaitmenų sąrašu. Pavyzdžiui:
       %?- suma([9,4,6,1,3,4],[2,8],Sum).
       %Sum = [9,4,6,1,6,2].

%rev__([X|Xs], Ys, Zs).
rev__([], R, R).
rev__([X|Xs], R, Acc) :- rev__(Xs, R, [X|Acc]), !.

rev(Xs, Rs) :-
    rev__(Xs, Rs, []).

% suma([9,4,6,1,3,4], A, [9,4,6,1,6,2]).
suma(A, B, C) :-
    rev(A, Ar),
    rev(B, Br),
    !,
    suma_(Ar, Br, Cr, 0),
    !,
    rev(C, Cr).

suma_(X, [], X, 0).
suma_([], X, X, 0).
suma_(Xs, [], Ys, 1) :-
    suma_(Xs, [0], Ys, 1).
suma_([], Xs, Ys, 1) :-
    suma_(Xs, [0], Ys, 1).

suma_([X|Xs], [Y|Ys], [Z|Zs], C) :-
    Z #= X + Y + C,
    Z #< 10,
    !,
    suma_(Xs, Ys, Zs, 0).

suma_([X|Xs], [Y|Ys], [Z|Zs], C) :-
    S #= X + Y + C,
    Z #= S - 10,
    !,
    suma_(Xs, Ys, Zs, 1).

?- suma([9,4,6,1,3,4],[2,8],Sum), Sum = [9,4,6,1,6,2].
?- suma([2,8],[9,4,6,1,3,4],Sum), Sum = [9,4,6,1,6,2].
?- suma([6],[9,4,6,1,3,5],Sum), Sum = [9, 4, 6, 1, 4, 1].
?- suma([9,4,6,1,3,5],[6],Sum), Sum = [9, 4, 6, 1, 4, 1].
?- suma([9,9,9],[1],Sum), Sum = [1, 0, 0, 0].


