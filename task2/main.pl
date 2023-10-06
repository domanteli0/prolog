% Apibrėžkite paskirtus du predikatus pagal nurodytas sąlygas. Atkreipkite dėmesį į amžino ciklo galimybę vykdymo metu. Nustatykite, kokioms laisvų ir suvaržytų kintamųjų kombinacijoms gali būti užduodami tikslai. Pirmajam paskirtajam predikatui (1.x arba 2.x užduoties variantui) pateikite paaiškinantį brėžinį: 1.x variantui - kelių žemėlapį, 2.x variantui - studentų amžiaus sąryšio diagramą. Brėžinį braižyti galima ir popieriuje arba kuria nors kompiuterių programa (pvz., Gimp). Atkreipkite dėmesį, kad ir nubraižytą brėžinį reikia įkelti į virtualią mokymosi aplinką. Mokėkite paaiškinti, kaip Prolog vykdo programą, kaip vykdoma paieška. Mokėkite naudoti ir paaiškinti trasavimą (trace.).

% 1. Duotas miestus jungiančių kelių tinklas. Keliai vienakrypčiai, nesudarantys ciklų. Kiekvienas kelias turi savo ilgį. Ši informacija išreiškiama faktais kelias(Miestas1, Miestas2, Atstumas). Apibrėžkite predikatą „galima nuvažiuoti iš miesto X į miestą Y“:
%   1.5. pravažiavus lygiai N tarpinių miestų.

% 4. Duotas natūrinis skaičius N. Naudodami rekursyvųjį algoritmą, raskite:
%   4.3. N-ąjį Pelo skaičių. Pavyzdžiui:
         % ?- pell(10,Pel).
         % Pel = 2378.

pell(0, 0).
pell(1, 1).
pell(N, Pell) :-
    \+ N is 0,
    \+ N is 1,
    N1 is N - 1,
    N2 is N - 2,
    pell(N1, N_1),
    pell(N2, N_2),
    Pell is 2*N_1 + N_2.

