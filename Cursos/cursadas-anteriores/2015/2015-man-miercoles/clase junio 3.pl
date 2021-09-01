%%%%%%%%%%%%%%%%%%%%%
%VIOLENCIA
%

esViolento(Alguien):-
	rompeAlambrado(Alguien),
	quemaManga(Alguien).

esViolento(Alguien):-
	tiraGasPimienta(Alguien).

esViolento(Alguien):-
	recibeDenuncia(Alguien),
	acusaMafia(Alguien,conmebol).

esViolento(panadero).

rompeAlambrado(panadero).
rompeAlambrado(soldador).
tiraGasPimienta(policia).
tiraGasPimienta(panadero).
quemaManga(panadero).
quemaManga(piromano).

acusaMafia(maradona,blater).
acusaMafia(osvaldo,conmebol).
acusaMafia(panadero,conmebol).
recibeDenuncia(osvaldo).
recibeDenuncia(panadero).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LLANTOS
%
quiereLlorar(Alguien,CuantoLlora,cocina):-
	cortaCebolla(Alguien,Unidades),
	not(usaAntiparras(Alguien)),
	poderDeLlanto(Unidades,CuantoLlora).

usaAntiparras(meolans).
cortaCebolla(caruso,5).

poderDeLlanto(5,poco).
poderDeLlanto(6,intermedio).
poderDeLlanto(X,mucho):-X>6,X<10.
poderDeLlanto(X,nada):-X<5.

/*
quiereLlorar(Alguien,mucho,Lugar):-
	descalificaro(Equipo),
	hincha(Alguien,Equipo),
	juega(Equipo,Lugar),
	tiranGasPimienta(Lugar).

quiereLlorar(Alguien, mucho, casa):-
	parejea(Alguien,Otro),
	esViolento(Otro).
*/



%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PROFESORES Y ESTUDIANTES
%

aproboParcial(Alguien):-
	fueAlParcial(Alguien),
	esInteligente(Alguien),
	not(faltoAClases(Alguien)).


faltoAClases(pedro).
faltoAClases(juan).
fueAlParcial(lucas).
fueAlParcial(mariano).
iq(mariano,200).
iq(lucas,80).
promedio(mariano,malo).
promedio(lucas,bueno).

esInteligente(Alguien):-promedio(Alguien,bueno).
esInteligente(einstein).
esInteligente(UnaPersona):-
	iq(UnaPersona,Indice),
	Indice > 100.

corregirParcial(Profe,Alguien):-
		tieneEnergia(Profe),
		esBuenAlumno(Alguien).

tieneEnergia(jessica).
esBuenAlumno(felipe).

seLlevaBien(Alumno, Profesor):-
	corregirParcial(Profesor,Alumno),
	aproboParcial(Alumno).

seLlevaBien(Alumno, _):-
	aportaIdeasEnClase(Alumno).
% En clase hicimos seLlevaBien(Alumno, Profesor) y daba un warning, con
% la variable anonima lo evitamos. (Profesor no se usa para nada)

aportaIdeasEnClase(juan).
aportaIdeasEnClase(mariano).


%%%%%%%%%%%%%%%%%%%%%%%%
%RENUNCIAS
%
%
/* Faltan los hechos
tieneCargo(joseph,presidenteFifa).
tieneCargo(cristina,presidenteArg).

renuncioA(Cargo,Personaje):-
	esCorrupto(Personaje),
	esSucio(Cargo),
	paganPoco(Personaje),
	tieneCargo(Personaje,Cargo).

paganPoco(Alguien):-
	sueldo(Alguien,Plata),
	Plata < 1000000.
*/

















