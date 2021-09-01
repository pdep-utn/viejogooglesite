flota(Algo):- pesaLoQue(Algo,pato).

esDeMadera(Algo):- flota(Algo).

seQuema(Algo):- esDeMadera(Algo).

esBruja(Algo):- seQuema(Algo).

pesaLoQue(raquel,pato).
pesaLoQue(gus,pato).

esLindo(N):- N>10.
esLindo(3).
esLindo(N):- N<10.

esMuyLindo(gus).

% 1

esPadre(homero,bart).
esPadre(homero,lisa).
esPadre(khan,maggie).
esPadre(homero,hugo).
esPadre(abe,homero).
esPadre(abe,herbert).
esPadre(ned,rod).
esPadre(ned,tod).

esHermano(Hermano1,Hermano2):-
	esPadre(Padre,Hermano1),
	esPadre(Padre,Hermano2),
	Hermano1 \= Hermano2.

tio(Tio,Sobrino):-
	esHermano(Padre,Tio),
	esPadre(Padre,Sobrino).

esHuerfano(Alguien):-
	not(esPadre(_,Alguien)).

ayudaA(gus,alf).
ayudaA(fer,alf).

esTravieso(bart).
esTravieso(yamila).
esTravieso(Alguien):- hijoUnico(Alguien).

hijoUnico(Alguien):-
	not(esHermano(Alguien,_)).

esHombre(bart).
esHombre(rod).
esHombre(tod).
esMujer(Alguien):- not(esHombre(Alguien)).

/*
NOOOOOOOOO MALLLL
Usar pattern matching:

notaTendenciosa(Chico,Nota):-
	esTravieso(Chico),
	esPadre(homero,Chico),
	Nota = 2.*/
	
notaTendenciosa(Chico,2):-
	esTravieso(Chico),
	esPadre(homero,Chico).
notaTendenciosa(Chico,10):-
	esHuerfano(Chico).
notaTendenciosa(Chico,10):-
	esMujer(Chico).
notaTendenciosa(Chico,Nota):-
	esHermano(Alguien,Chico),
	notaTendenciosa(Alguien,OtraNota),
	Nota is OtraNota - 1.
notaTendenciosa(Chico,4):-
	esPadre(Chico,_).
	