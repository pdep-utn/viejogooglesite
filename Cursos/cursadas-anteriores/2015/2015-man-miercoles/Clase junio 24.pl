personalidad(sanmartin,fecha(20,27,1789),yapeyu,fecha(17,8,1850),boulogne).
personalidad(gardel,fecha(20,5,1889),argentina,fecha(24,6,1935),colombia).
personalidad(belgrano,fecha(12,11,1795),argentina,fecha(20,6,1820),argentina).
personalidad(maestroyoda,siglo(-1),endor,siglo(25),dondevosquieras).
personalidad(maestroyoda2,siglo(7),endor,siglo(62),dondevosquieras).

personalidad(mirtha,bigban,argentina,findelmundo,argentina).

personalidad(pedroPicapiedras,era(paleolitica),petropolis,era(neolitica),petropolis).

esFechaValida(fecha(D,M,_)):-between(1,31,D),between(1,12,M).
esFechaValida(siglo(N)):-N>0.

personajeValido(Nombre):-
	personalidad(Nombre,FN,_,FM,_),
	esFechaValida(FN),
	esFechaValida(FM).


%esContemporaneo(A,B):-
%	contemporaneo(A,B).
%esContemporaneo(A,B):-
%	contemporaneo(B,A).

contemporaneo(Alguien,Otro):-
	nacioAntesQueElOtroMuera(Alguien,Otro),
	murioDespuesQueElOtroNace(Alguien,Otro).

nacioAntesQueElOtroMuera(Alguien,Otro):-
	personalidad(Alguien,FN,_,_,_),
	personalidad(Otro,_,_,FM1,_),
	fechaAnterior(FN,FM1).

fechaAnterior(_,findelmundo).
fechaAnterior(bigban,_).

fechaAnterior(siglo(S1),siglo(S2)):-S1=<S2.

fechaAnterior(siglo(S1),fecha(_,_,A)):-S1=<A/100+1.
fechaAnterior(fecha(_,_,A),siglo(S1)):-A/100<S1.

fechaAnterior(fecha(_,_,A1),fecha(_,_,A2)):-A1<A2.
fechaAnterior(fecha(_,M1,A),fecha(_,M2,A)):-M1<M2.
fechaAnterior(fecha(D1,M,A),fecha(D2,M,A)):-D1<D2.

murioDespuesQueElOtroNace(Alguien,Otro):-
	personalidad(Alguien,_,_,FM,_),
	personalidad(Otro,FN1,_,_,_),
	fechaAnterior(FN1,FM).

	%FUNCTOR









