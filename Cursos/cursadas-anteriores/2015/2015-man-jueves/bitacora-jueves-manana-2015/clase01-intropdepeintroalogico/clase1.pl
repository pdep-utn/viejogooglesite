esBruja(Alguien) :- esDeMadera(Alguien).
esBruja(rasta).
esDeMadera(Alguien) :- flota(Alguien).
flota(Alguien) :- pesaLoMismoQueUnPato(Alguien).
flota(alf).
flota(rasta).
pesaLoMismoQueUnPato(pato).
pesaLoMismoQueUnPato(rowailer).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
padre(abe, homero).
padre(abe, herbert).
padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).
padre(homero, hugo).
padre(marge, bart).
padre(marge, lisa).
padre(marge, maggie).
padre(marge, hugo).
padre(ned, rod).
padre(ned, tod).


hermanos(UnaPersona, OtraPersona) :-
	padre(Alguien, UnaPersona),
	padre(Alguien, OtraPersona),
	UnaPersona \= OtraPersona.
	
tio(Tio, Sobrino) :-
	hermanos(Tio, Alguien),
	padre(Alguien, Sobrino).
	
esHijoUnico(Alguien) :-
	persona(Alguien),
	not(hermanos(Alguien, _)).
	
persona(Alguien) :- padre(Alguien, _).
persona(Alguien) :- padre(_, Alguien).





/*
DECLARATIVIDAD - QUE? Y NO COMO?
	SE LOGRA CON ABSTRACCIONES.
EXPRESIVIDAD - PODER ENTENDER LO QUE LEO.

EFECTO - ALGO CAMBIE

UNIVERSO CERRADO - BASE DE CONOCIMIENTO SOLO CON VERDADES
	PUEDEN SER HECHOS O REGLAS (SE DEDUCEN)
		DEFINEN PREDICADOS
		SI TIENE UN PARAMETRO => PROPIEDAD
		SINO => RELACION
		
INVERSIBILIDAD! - SABER EJEMPLOS QUE HACER V LA CONSULTA
, -> Y
ASDSD.  \
         -> O
ASDASD. /



VAMOS CON EL TP1 !!! */