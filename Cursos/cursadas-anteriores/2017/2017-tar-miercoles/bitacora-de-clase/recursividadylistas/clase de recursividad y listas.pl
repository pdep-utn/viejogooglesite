%% Recursividad

padre(homero, bart).
padre(homero, lisa).
padre(abe, homero).
padre(lisa, rafaJr).
padre(ned, todd).

% Es inversible ya que su caso base lo es y el caso recursivo solo depende de padre que es inversible y de si mismo
ancestro(Ancestro, Descendiente):-
	padre(Ancestro, Descendiente).
ancestro(Ancestro, Descendiente):-
	padre(Padre, Descendiente),
	ancestro(Ancestro, Padre).
	
/*
Factorial: Como seria en Haskell
factorial 0 = 1
factorial n = n * factorial (n-1)
*/

% Solo es inversible para su segundo argumento, porque el > y el is tienen problemas de inversibilidad
factorial(0, 1).
factorial(Numero, Factorial):-
	Numero > 0,
	Anterior is Numero - 1,
	factorial(Anterior, FactorialAnterior),
	Factorial is FactorialAnterior * Numero.
	
%% Listas

% No es inversible para la lista, porque no tiene como generar el contenido
head([X|_], X).

%% equivalente a length/2
% No es inversible para la lista, porque no tiene como generar el contenido
longitud([], 0).
longitud([_|Cola], Longitud):-
	longitud(Cola, LongitudCola),
	Longitud is LongitudCola +1.
	
%% equivalente a member/2
% No es inversible para la lista, porque no tiene como generar el contenido
pertenece(Elem, [Elem|_]).
pertenece(Elem, [_|Cola]):-
	pertenece(Elem, Cola).
	
% No es inversible para la lista, porque no tiene como generar el contenido
% Ademas no es inversible para el elemento buscado, porque el \= tiene problemas de inversibilidad
ocurrencias(_, [], 0 ).
ocurrencias(Elem, [Elem|Cola], Cuantos ):-
	ocurrencias(Elem, Cola, Otros),
	Cuantos is 1 + Otros.
ocurrencias(Elem, [Otro|Cola], Cuantos):-
	Otro \= Elem,
	ocurrencias(Elem, Cola, Cuantos).
	
% Si se quisiera poder usar esta funcionalidad teniendo como incognita tambien al elemento, tal que sea uno de los elementos que contiene la lista, la forma mas simple de hacerlo es teniendo un predicado separado que si sea inversible y use ocurrencias de forma individual.

ocurreciasInversible(Elem, Lista, Ocurrencias):-
	member(Elem, Lista),
	ocurrencias(Elem, Lista, Ocurrencias).
	
%% equivalente a append/3
% Respecto a inversibilidad, es necesario pasar dos de las 3 listas para que pueda deducir cual es la otra.
concatenar([], Lista, Lista).
concatenar([E|Cola], Lista, 
				[E|Concatenada]):-
	concatenar(Cola, Lista, Concatenada).
	
%% Armar listas con findall/3

% Es inversible gracias a que generamos al padre antes del findall. No hay problemas con la cantidad porque findall/3 es inversible respecto a la lista, y length/2 es inversible respecto a la cantidad.
cuantosHijosTiene(Padre, Cantidad):-
	padre(Padre, _),
	findall(Hijo, padre(Padre, Hijo),
				Hijos),
	length(Hijos, Cantidad).
	
%%%%
%%%% Retomando ejercicio de la clase pasada: Harry Potter
%%%%

% Ya teniamos un predicado de este estilo
puedenSerAmigos(harry, hermione).
puedenSerAmigos(hermione, luna).

% Queremos definir cadenaDeAmistad/1 tal que cada mago puede ser amigo del que le sigue
% cadenaDeAmistad([harry, hermione, luna]). true
% cadenaDeAmistad([harry, luna, hermione]). false
% cadenaDeAmistad([harry]). false
	
% Version recursiva
% Es inversible, solo tiene problemas para generar la lista si puedenSerAmigos/2 se cumple tanto para algun A y B como para B y A porque entra en loop infinito.
cadenaDeAmistad([Primero|[Segundo|Resto]]):-
	puedenSerAmigos(Primero, Segundo),
	cadenaDeAmistad([Segundo|Resto]).
cadenaDeAmistad([Primero, Segundo]):-
	puedenSerAmigos(Primero, Segundo).
	
% Version super flashera no recursiva
% No es inversible, sirve solo para validar que sea una cadena correcta
cadenaDeAmistadLoca(Personas):-
	length(Personas, Cantidad),
	Cantidad > 2,
	forall(
		(nth1(IP1, Personas, P1),
		nth1(IP2, Personas, P2),
		IP1 is IP2 -1) ,
		puedenSerAmigos(P1, P2)).
	
% Tambien teniamos de la clase pasada: puntosOtorgados/2 que relaciona una casa con cada puntaje que recibio. Lo definimos asi nomas, para el ejemplo.
puntosOtorgados(gryffindor, 50).
puntosOtorgados(gryffindor, -10).
puntosOtorgados(slytherin, 20).
puntosOtorgados(slytherin, 10).
puntosOtorgados(ravenclaw, 20).
casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

% Queremos definir casaGanadora/1 que se cumple para la casa que haya sumado mas puntos

% Abstraemos totalCasa/2 para saber cual fue el total para cada casa
totalCasa(Casa, PuntosTotales):-
	casa(Casa),
	findall(Puntos, puntosOtorgados(Casa, Puntos), ListaPuntos),
	sumlist(ListaPuntos, PuntosTotales).
	
casaGanadora(Casa):-
	totalCasa(Casa, PuntosMax),
	forall((totalCasa(OtraCasa, Puntos), Casa \= OtraCasa),
			PuntosMax > Puntos).
	
	