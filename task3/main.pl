% Domantas Keturakis
% PS III kursas, I gr.
% 1.12; 2.2; 3.5; 4.3
% Apibrėžkite paskirtus keturis predikatus pagal nurodytas sąlygas. Nors kai kurių užduočių formulavimas yra procedūrinis, reikia siekti, kiek įmanoma, deklaratyvios programos. Nenaudokite Prolog darbo su sąrašais predikatų. Pasiaiškinkite, kaip taikomas atkirtos (!) operatorius ir kur jį galima būtų panaudoti Jūsų predikatuose.

?- use_module(library(clpfd)).

% 1. Paprasti predikatai su sveikųjų skaičių sąrašais:
%   1.12. skirk_teig_neig(S,R1,R2) - pradinis skaičių sąrašas S išskirstytas į du sąrašus: teigiamų - R1 - ir neigiamų - R2. Pavyzdžiui:
          %?- skirk_teig_neig([5,-1,-4,3,0],R1,R2).
          %R1 = [5,3], R2 = [-1,-4].

gt_0(A) :- A #> 0.
lt_0(A) :- A #< 0.

full_good_bad(_, _, [], [], []).
full_good_bad(GoodPred, BadPred, [A|Full], [A|Gs], Bs) :-
    call(GoodPred, A),
    length(Full, _),
%    length(Gs, Gl),
%    length(Bs, Bl),
%    Fl #= Gl + Bl,
    full_good_bad(GoodPred, BadPred, Full, Gs, Bs).

full_good_bad(GoodPred, BadPred, [A|Full], Gs, [A|Bs]) :-
    call(BadPred, A),
    length(Full, _),
%    length(Gs, Gl),
%    length(Bs, Bl),
%    Fl #= Gl + Bl,
    full_good_bad(GoodPred, BadPred, Full, Gs, Bs).

full_good_bad(GoodPred, BadPred, [_|Full], [G|Gs], [B|BS]) :-
    \+ call(GoodPred, G),
    \+ call(BadPred, B),
    length(Full, _),
    full_good_bad(GoodPred, BadPred, Full, [G|Gs], [B|BS]).

skirk_teig_neig([], [], []).
skirk_teig_neig([F|Full], [F|Ps], Ns) :-
    F #> 0,
    length(Full, _),
    skirk_teig_neig(Full, Ps, Ns).
skirk_teig_neig([F|Full], Ps, [F|Ns]) :-
    F #< 0,
    length(Full, _),
    skirk_teig_neig(Full, Ps, Ns).

skirk_teig_neig([F|Full], Ps, Ns) :-
    F #= 0,
    length(Full, _),
    skirk_teig_neig(Full, Ps, Ns).

?- skirk_teig_neig([5,-1,-4,3,0],R1,R2), R1 = [5,3], R2 = [-1,-4].

% 2. Paprasti nearitmetiniai predikatai:
%   2.2. apjungti(SS,R) - sąrašas R gaunamas iš duotojo sąrašų sąrašo SS, sujungus pastarojo sąrašus į bendrą sąrašą. Giliuosius sąrašus apdoroti nėra būtina. Pavyzdžiui:
         %?- apjungti([[a,b],[c],[d,[e,f], g]],R).
         %R = [a,b,c,d,[e,f],g].

prefix_list([], _).
prefix_list([A|As], [A|Bs]) :- prefix_list(As, Bs).

list_suffix(_, []).
list_suffix(Ls, [_|Ss]) :- list_suffix(Ls, Ss).

concat([], Rs, Rs).
concat([E|Ls], Rs, [E|Fs]) :- concat(Ls, Rs, Fs).

apjungti([], []).
apjungti([S], S).
apjungti([S|Ss], R) :-
    apjungti(Ss, R1),
    concat(S, R1, R).

?- apjungti([[a,b],[c],[d,[e,f], g]],R), R = [a,b,c,d,[e,f],g].

% 3. Sudėtingesni predikatai:
%   3.5. skirtumas(S1,S2,R) - sąrašas R susideda iš duotojo sąrašo S1 elementų, kurie nepriklauso kitam duotajam sąrašui S2. Pavyzdžiui:
         %?- skirtumas([a,b,c,d],[d,e],R).
         %R = [a,b,c].

el_in_list(E, [X|Ls]) :- el_in_list(E, Ls), X \= E.
el_in_list(E, [E|_]).
el_in_list(_, []) :- false.

el_not_in_list(E, [E|_]) :- false.
el_not_in_list(E, [X|Ls]) :- el_not_in_list(E, Ls), X \= E.
el_not_in_list(_, []).

% 4. Operacijos su natūraliaisiais skaičiais, išreikštais skaitmenų sąrašais. Skaitmenų sąrašo elementai turi būti natūralūs skaičiai nuo 0 iki 9 (ne simboliai '0', '1',...). Nenaudokite Prolog konvertavimo tarp sąrašo ir skaičiaus predikatų (number_chars/2, number_codes/2 ir kt...):
%   4.3. suma(S1,S2,Sum) - S1 ir S2 yra skaičiai vaizduojami skaitmenų sąrašais. Sum - tų skaičių suma vaizduojama skaitmenų sąrašu. Pavyzdžiui:
       %?- suma([9,4,6,1,3,4],[2,8],Sum).
       %Sum = [9,4,6,1,6,2].

base_exponent_result(_, 0, C) :- C #= 1.
base_exponent_result(A, 1, C) :- C #= A.
base_exponent_result(A, B, C) :-
    B #\= 0, B #\= 1,
    B1 #= B - 1,
    C  #= A * C1,
    base_exponent_result(A, B1, C1).

overflow(A, B) :- A + B #> 9.
not_overflow(A, B) :- A + B  #< 10.

min_list(As, Bs, Ls) :-
    length(As, Al),
    length(Bs, Bl),
    Al #=< Bl,
    As = Ls.
min_list(As, Bs, Ls) :-
    length(As, Al),
    length(Bs, Bl),
    Al #> Bl,
    Bs = Ls.

?- min_list([a, b], [v], [v]).
?- min_list([a, b, c], [v, a, b, c], [a, b, c]).

add_([A], [B], [C], D) :-
    (
        ( A + B #< 10, C #= A + B, D = 0 ) ;
        ( A + B #>= 10, C #= A + B - 10, D = 1 )
    ).
add_([A|As], [B|Bs], [C|Cs], D) :-
    add_(As, Bs, Cs, D1),
    (
        ( A + B + D1 #< 10, C #= A + B + D1, D = 0 ) ;
        ( A + B + D1 #>= 10, C #= A + B + D1 - 10, D = 1 )
    ).

?- add_([1, 2], [3, 9], C, 0), C = [5, 1].
