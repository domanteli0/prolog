% 1.12; 2.2; 3.5; 4.3
% Apibrėžkite paskirtus keturis predikatus pagal nurodytas sąlygas. Nors kai kurių užduočių formulavimas yra procedūrinis, reikia siekti, kiek įmanoma, deklaratyvios programos. Nenaudokite Prolog darbo su sąrašais predikatų. Pasiaiškinkite, kaip taikomas atkirtos (!) operatorius ir kur jį galima būtų panaudoti Jūsų predikatuose.

% 1. Paprasti predikatai su sveikųjų skaičių sąrašais:
%   1.12. skirk_teig_neig(S,R1,R2) - pradinis skaičių sąrašas S išskirstytas į du sąrašus: teigiamų - R1 - ir neigiamų - R2. Pavyzdžiui:
          %?- skirk_teig_neig([5,-1,-4,3,0],R1,R2).
          %R1 = [5,3], R2 = [-1,-4].

% 2. Paprasti nearitmetiniai predikatai:
%   2.2. apjungti(SS,R) - sąrašas R gaunamas iš duotojo sąrašų sąrašo SS, sujungus pastarojo sąrašus į bendrą sąrašą. Giliuosius sąrašus apdoroti nėra būtina. Pavyzdžiui:
         %?- apjungti([[a,b],[c],[d,[e,f], g]],R).
         %R = [a,b,c,d,[e,f],g].

% 3. Sudėtingesni predikatai:
%   3.5. skirtumas(S1,S2,R) - sąrašas R susideda iš duotojo sąrašo S1 elementų, kurie nepriklauso kitam duotajam sąrašui S2. Pavyzdžiui:
         %?- skirtumas([a,b,c,d],[d,e],R).
         %R = [a,b,c].

% 4. Operacijos su natūraliaisiais skaičiais, išreikštais skaitmenų sąrašais. Skaitmenų sąrašo elementai turi būti natūralūs skaičiai nuo 0 iki 9 (ne simboliai '0', '1',...). Nenaudokite Prolog konvertavimo tarp sąrašo ir skaičiaus predikatų (number_chars/2, number_codes/2 ir kt...):
%   4.3. suma(S1,S2,Sum) - S1 ir S2 yra skaičiai vaizduojami skaitmenų sąrašais. Sum - tų skaičių suma vaizduojama skaitmenų sąrašu. Pavyzdžiui:
       %?- suma([9,4,6,1,3,4],[2,8],Sum).
       %Sum = [9,4,6,1,6,2].
