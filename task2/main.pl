% Domantas Keturakis
% PS III kursas, I gr.
% Užduotys: 1.5, 4.3

% Apibrėžkite paskirtus du predikatus pagal nurodytas sąlygas. Atkreipkite dėmesį į amžino ciklo galimybę vykdymo metu. Nustatykite, kokioms laisvų ir suvaržytų kintamųjų kombinacijoms gali būti užduodami tikslai. Pirmajam paskirtajam predikatui (1.x arba 2.x užduoties variantui) pateikite paaiškinantį brėžinį: 1.x variantui - kelių žemėlapį, 2.x variantui - studentų amžiaus sąryšio diagramą. Brėžinį braižyti galima ir popieriuje arba kuria nors kompiuterių programa (pvz., Gimp). Atkreipkite dėmesį, kad ir nubraižytą brėžinį reikia įkelti į virtualią mokymosi aplinką. Mokėkite paaiškinti, kaip Prolog vykdo programą, kaip vykdoma paieška. Mokėkite naudoti ir paaiškinti trasavimą (trace.).

% 1. Duotas miestus jungiančių kelių tinklas. Keliai vienakrypčiai, nesudarantys ciklų. Kiekvienas kelias turi savo ilgį. Ši informacija išreiškiama faktais kelias(Miestas1, Miestas2, Atstumas). Apibrėžkite predikatą „galima nuvažiuoti iš miesto X į miestą Y“:
%   1.5. pravažiavus lygiai N tarpinių miestų.

kelias(vilnius, kaunas, 100).
kelias(vilnius, panevezys, 200).
kelias(panevezys, kaunas, 150).
kelias(panevezys, siauliai, 90).
kelias(kaunas, klaipeda, 300).
kelias(panevezys, klaipeda, 250).
kelias(klaipeda, gargzdai, 10).
kelias(telsiai, gargzdai, 80).
kelias(siauliai, telsiai, 80).
kelias(siauliai, joniskis, 40).
kelias(joniskis, telsiai, 110).

isXiY(Miestas1, Miestas2) :- kelias(Miestas1, Miestas2, _).
isXiY(Miestas1, Miestas2) :-
    kelias(Miestas1, MiestasN, _),
    isXiY(MiestasN, Miestas2).

?- isXiY(kaunas, klaipeda).
?- \+ isXiY(klaipeda, kaunas).

isXiYN(Miestas1, Miestas2, 0) :- kelias(Miestas1, Miestas2, _).
isXiYN(Miestas1, Miestas2, N) :-
    kelias(Miestas1, MiestasN, _),
    isXiYN(MiestasN, Miestas2, N0),
    N is N0 + 1.

?- isXiYN(panevezys, klaipeda, 1).
?- isXiYN(vilnius, kaunas, 1).
?- isXiYN(joniskis, gargzdai, 1).
?- isXiYN(Miestas1, Miestas2, 0), isXiY(Miestas1, Miestas2).
?- isXiYN(panevezys, gargzdai, 2).

% 4. Duotas natūrinis skaičius N. Naudodami rekursyvųjį algoritmą, raskite:
%   4.3. N-ąjį Pelo skaičių. Pavyzdžiui:
         % ?- pell(10,Pel).
         % Pel = 2378.

?- use_module(library(clpfd)).
pell(0, 0).
pell(1, 1).
pell(N, Pell) :-
    N #\= 0,
    N #\= 1,
    N1 #= N - 1,
    N2 #= N - 2,
    pell(N1, N_1),
    pell(N2, N_2),
    Pell #= 2*N_1 + N_2.

?- pell(10, 2378).
?- pell(5, 29).

pellL([]).
pellL([0]).
pellL([1, 0]).
pellL([Pell,P1,P2|Ps]) :-
    pellL([P1,P2|Ps]),
    Pell #= 2*P1 + P2.

pell_(N, P) :-
    length(Ps, Pl),
    Pl #= N,
    pellL([P|Ps]).

?- pell_(10, 2378).
?- pell_(5, 29).
?- N #= 5, pell_(N, 29).
?- P #= 2378, pell_(10, P).
