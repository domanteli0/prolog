% Domantas Keturakis
% PS III kursas, I gr.
% Užduotys: 11, 22, 30, 33

% # Užduoties sąlyga
% Duomenų bazėje saugomi duomenys apie asmenis ir jų giminystės ryšius faktais:
% ```
% asmuo(Vardas, Lytis, Amžius, Pomėgis);
% mama(Mama, Vaikas);
% pora(Vyras, Žmona).
% ```
% Kad būtų paprasčiau, faktų aibė sudaroma atsižvelgiant į šias prielaidas:
% * Kiekvienas asmuo vienareikšmiškai identifikuojamas vardu;
% * Kiekvienoje šeimoje vaikai skirtingo amžiaus;
% * Kiekvieno vaiko tėtis yra jo mamos vyras;
% * Jeigu vaikas turi mamą, tai jis būtinai turi ir tėtį ir atvirkščiai;
% Detales, neapibrėžtas užduoties sąlygoje, studentas gali interpretuoti savo nuožiūra.
% Pastaba: jeigu parinksite faktus iliustruojančius Jūsų (ar kurį nors kitą Jums gerai žinomą) genealoginį medį, tai Jums patiems bus lengviau tikrinti programos teisingumą. Kita vertus, tai nėra būtina.
% 
% 11. teta(Teta, SunenasDukterecia) - Pirmasis asmuo (Teta) yra antrojo (SunenasDukterecia) teta (tėčio ar mamos sesuo);
% 22. zentas(Zentas, UosvisUosve) - Pirmasis asmuo (Zentas) yra antrojo (UosvisUosve) žentas (dukros vyras);
% 30. nepilnametis(Nepilnametis) - Asmuo Nepilnametis yra jaunesnis, nei 18 metų;
% 33. daugiavaike(Motina) - Asmuo Motina yra daugiavaikė motina: turi ne mažiau kaip 3 vaikus;

asmuo(ona, m, 80, jodinejimas).
asmuo(petras, v, 81, siuvimas).
asmuo(janina, m, 50, saudymas).
asmuo(alesius, v, 52, astronomija).
asmuo(itanas, v, 24, sokiai).
asmuo(ruta, m, 26, sokiai).
asmuo(mantas, v, 3, verkimas).
asmuo(ieva, m, 17, astronomija).
asmuo(giedre, m, 17, programavimas).
asmuo(gerda, m, 56, sodininkyste).
asmuo(juozepas, v, 53, stalo_zaidimai).
asmuo(juozapina, m, 54, masinos).
asmuo(jonas, v, 59, alus).

mama(ona, janina).
mama(janina, itanas).
mama(ruta, mantas).
mama(janina, giedre).
mama(janina, ieva).
mama(ona, gerda).
mama(ona, juozepas).
mama(ona, jonas).

pora(ona, petras).
pora(alesius, janina).
pora(ruta, itanas).
pora(juozapina, juozepas).
pora_(Asmuo1, Asmuo2) :- pora(Asmuo1, Asmuo2).
pora_(Asmuo1, Asmuo2) :- pora(Asmuo2, Asmuo1).


tevas(Tevas, Vaikas) :-
    mama(Mama, Vaikas), pora_(Mama, Tevas), asmuo(Tevas, _, _, _), asmuo(Vaikas, _, _, _).

vaikas(Vaikas, TevasArMama) :- tevas_ar_mama(TevasArMama, Vaikas).
dukra(Dukra, TevasArMama) :- tevas_ar_mama(TevasArMama, Dukra), asmuo(Dukra, m, _, _).

yra_vyras(Asmuo) :- asmuo(Asmuo, v, _, _).
yra_moteris(Asmuo) :- asmuo(Asmuo, m, _, _).

sese_ar_brolis(Asmuo1, Asmuo2) :-
    mama(TevasArMama, Asmuo1),
    mama(TevasArMama, Asmuo2).

% --- [TASKS] ---


tevas_ar_mama(TevasArMama, Vaikas) :- tevas(TevasArMama, Vaikas).
tevas_ar_mama(TevasArMama, Vaikas) :- mama(TevasArMama, Vaikas).

% [TASK] 11. teta(Teta, SunenasDukterecia) - Pirmasis asmuo (Teta) yra antrojo (SunenasDukterecia) teta (tėčio ar mamos sesuo);
teta(Teta, SunenasDukterecia) :-
    yra_moteris(Teta),
    tevas_ar_mama(TM, SunenasDukterecia),
    sese_ar_brolis(TM, Teta),
    % Mama nėra teta
    mama(Mama, SunenasDukterecia), Mama \= Teta.

?- tevas(alesius, itanas).   % true
?- teta(gerda, itanas).      % true
?- teta(ieva, mantas).       % true
?- teta(giedre, mantas).     % true
?- \+ teta(janina, itanas).  % false


% 22. zentas(Zentas, UosvisUosve) - Pirmasis asmuo (Zentas) yra antrojo (UosvisUosve) žentas (dukros vyras);
zentas(Zentas, UosvisUosve) :-
    dukra(Dukra, UosvisUosve),
    pora_(Dukra, Zentas).

?- \+ zentas(petras, juozepas).     % false
?- findall(Ona, zentas(juozepas, Ona), N), N = [].
?- \+ zentas(juozepas, petras).     % false
?- zentas(alesius, petras).         % true

% 33. daugiavaike(Motina) - Asmuo Motina yra daugiavaikė motina: turi ne mažiau kaip 3 vaikus;

% vaikai(Motina, Vaikai) :- findall(Vaikas, mama(Motina, Vaikas), Vaikai).
% daugiavaike(Motina) :- vaikai(Motina, Vs), length(Vs, N), N >= 3.

daugiavaike(Motina) :- mama(Motina, X), mama(Motina, Y), mama(Motina, Z), X \= Y, Y \= Z, Z \= X.

% [TASK] 30. nepilnametis(Nepilnametis) - Asmuo Nepilnametis yra jaunesnis, nei 18 metų;
nepilnametis(Asmuo) :- asmuo(Asmuo, _, Amzius, _), Amzius < 18.

?- findall(Nepilnametis, nepilnametis(Nepilnametis), Nepilnameciai), Nepilnameciai = [mantas, ieva, giedre].
?- \+ nepilnametis(ona).


kaina(A, K):- A < 7,  !, K = 0.
kaina(A, K):- A < 18, !, K = 1.  %Mokinys
kaina(A, K):- A < 30, !, K = 10. %Studijuoja
kaina(A, K):- A > 80, !, K = 0.  %Pensininkas
kaina(A, K):-
   /* A >= 30 , A <= 80 */, K = 0.  %Pensininkas

max(X, Y, M):- X >= Y, !, M = X.
max(X, Y, Y).
