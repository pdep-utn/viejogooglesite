mago(harry, mestiza, [coraje, amistad, orgullo,inteligencia]).
mago(ron, pura, [amistad, diversion, coraje]).
mago(hermione, impura, [inteligencia, coraje,responsabilidad, amistad, orgullo]).
mago(hannahAbbott, mestiza, [amistad, diversion]).
mago(draco, pura, [inteligencia, orgullo]).
mago(lunaLovegood, mestiza, [inteligencia,responsabilidad, amistad, coraje]).

odia(harry,slytherin).
odia(draco,hufflepuff).

casa(gryffindor).
casa(hufflepuff).
casa(ravenclaw).
casa(slytherin).
caracteriza(gryffindor,amistad).
caracteriza(gryffindor,coraje).
caracteriza(slytherin,orgullo).
caracteriza(slytherin,inteligencia).
caracteriza(ravenclaw,inteligencia).
caracteriza(ravenclaw,responsabilidad).
caracteriza(hufflepuff,amistad).
caracteriza(hufflepuff,diversion).
%%%%%

permiteEntrar(Casa, Mago):-
	casa(Casa),
	mago(Mago,_,_),
	Casa \= slytherin.
	
% Alternativa 1
permiteEntrar(slytherin, Mago):-
	mago(Mago,_,_),
	not(mago(Mago, impura,_)).
	
% Alternativa 2
% permiteEntrar(slytherin, Mago):-
%	mago(Mago, Sangre, _),
%	Sangre \= impura.
	
tieneCaracter(Mago, Casa):-
	mago(Mago, _, _),
	casa(Casa),
	forall(caracteriza(Casa, Caracteristica),
			tieneCaracteristica(Mago,Caracteristica)).
			
% Abstracción útil
tieneCaracteristica(Mago,Caracteristica):- 
	mago(Mago, _, Caracteristicas),
	member(Caracteristica, Caracteristicas).
	
casaPosible(Mago, Casa):-
	permiteEntrar(Casa, Mago),
	tieneCaracter(Mago, Casa),
	not(odia(Mago, Casa)).
	
% Abstracciones muy útiles
amigable(Mago):- tieneCaracteristica(Mago, amistad).
puedenEstarEnLaMismaCasa(Mago1, Mago2):-
	casaPosible(Mago1, Casa),
	casaPosible(Mago2, Casa).
	
% Versión 1: Todo recursivo
% cadenaDeAmistades([Mago1, Mago2 | Magos]):-
%	amigable(Mago1),
%	amigable(Mago2),
%	puedenEstarEnLaMismaCasa(Mago1, Mago2),
%	cadenaDeAmistades([Mago2|Magos]).
% cadenaDeAmistades([_]).
% Caso base extra por si nos interesa que diga verdadero la consulta con lista vacía. No es necesario sino.
% cadenaDeAmistades([]).

% Versión 2: Separando los problemas, aparece forall
cadenaDeAmistades(Magos):-
	forall(member(Mago, Magos), amigable(Mago)),
	cadenaDeCasas(Magos).

% cadenaDeCasas/1 Alternativa recursiva
cadenaDeCasas([Mago1, Mago2 | Magos]):-
	puedenEstarEnLaMismaCasa(Mago1, Mago2),
	cadenaDeCasas([Mago2|Magos]).
cadenaDeCasas([_]).
% Caso base extra por si nos interesa que diga verdadero la consulta con lista vacía
cadenaDeCasas([]).

% cadenaDeCasas/1 Alternativa no recursiva
% esta definición dice verdadero si la lista está vacía o tiene un elemento también, como consecuencia del forall con antecedente sin respuestas
cadenaDeCasas(Magos):-
	forall(parConsecutivo(Mago1, Mago2, Magos),
		puedenEstarEnLaMismaCasa(Mago1, Mago2)).

parConsecutivo(X, Y, Lista):-
	nth1(N, Lista, X),
	nth1(M, Lista, Y),
	M is N + 1.
%%%%%

lugarProhibido(bosque, 50).
lugarProhibido(seccionRestringida,10).
lugarProhibido(tercerPiso,75).
alumnoFavorito(flitwick, hermione).
alumnoFavorito(snape, draco).
alumnoOdiado(snape, harry).

hizo(ron, buenaAccion(jugarAlAjedrez, 50)).
hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, responder("Donde se encuentra un
Bezoar", 15, snape)).
hizo(draco, responder("Donde se encuentra un
Bezoar", 15, snape)).
hizo(hermione, responder("Wingardium Leviosa", 25,
flitwick)).
hizo(ron, irA(bosque)).
hizo(draco, irA(mazmorras)).
hizo(harry, buenaAccion(valentia, 100)).

esBuenAlumno(Alumno):-
	hizo(Alumno, _),
	forall(hizo(Alumno, Accion), not(malaAccion(Accion, Alumno))).
	
%%% Basado en el puntaje, como dice el enunciado.
malaAccion(Accion, Mago):-
	puntaje(Accion, Mago,Puntaje),
	Puntaje < 0.

%%% Alternativa sin depender del puntaje, pero con un poco de repetición
%%% malaAccion(fueraDeCama).
%%% malaAccion(irA(Lugar)):- lugarProhibido(Lugar, _).

%% Aridad 3 por polimorfismo con las de responder que necesitan al mago que hizo la acción
puntaje(fueraDeCama,_, -50).
puntaje(irA(Lugar), _,Puntaje):-
	lugarProhibido(Lugar, PuntajeResta),
	Puntaje is PuntajeResta * -1.
puntaje(buenaAccion(_, Puntaje),_, Puntaje).

puntaje(responder(_, Dificultad, Profesor),Mago,Puntaje):-
	alumnoFavorito(Profesor, Mago),
	Puntaje is Dificultad * 2.
puntaje(responder(_, Dificultad, Profesor), Mago, Dificultad):-
	not(alumnoFavorito(Profesor, Mago)),
	not(alumnoOdiado(Profesor, Mago)).
	
%% A propósito no definimos puntaje para responder de alumnos odiados y de ir a lugares no prohibidos. En vez de relacionar con 0 podemos pensarlo como que no tienen un puntaje, total en los lugares en los que se usa puntaje sólo interesan los que restan y los que suman nada más.

esDe(harry, gryffindor).
esDe(ron, gryffindor).
esDe(hermione, gryffindor).
esDe(draco, slytherin).

puntajeConseguido(Mago, Puntaje):-
	hizo(Mago, Accion),
	puntaje(Accion, Mago, Puntaje).
puntosDeCasa(Casa, PuntajeTotal):-
	casa(Casa),
	findall(Puntaje, (esDe(Mago, Casa), puntajeConseguido(Mago, Puntaje)), Puntajes),
	sumlist(Puntajes, PuntajeTotal).
	
casaGanadora(Casa):-
	puntosDeCasa(Casa, PuntajeTotal),
	forall((puntosDeCasa(OtraCasa, OtroTotal), OtraCasa \= Casa),
		OtroTotal < PuntajeTotal).
	
	