intakas(neris, nemunas).
intakas(merkys, nemunas).
intakas(nevezis, nemunas).
intakas(sesupe, nemunas).
intakas(zeimena, neris).
intakas(sventoji, neris).
intakas(vilnele, neris).
intakas(jara, sventoji).

kaimynes(Upe1, Upe2) :- intakas(Upe1, UpeD), intakas(Upe2, UpeD).

turi_intaka(Upe) :- intakas(_, Upe).

priklauso_baseinui(Upe1, Upe2) :- priklauso_baseinui(TUpe, Upe2), intakas(Upe1, TUpe).


% adsjkfgajsfgjahsg
