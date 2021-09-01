nacio(ana,1905).
nacio(mercedes,1906).
nacio(juan,1933).
nacio(pepe,1939).
nacio(angel,1958).
nacio(mario,1960).
nacio(lucia,1908).
nacio(nuria,1941).
nacio(marcela,1931).
seCasaron(ana,lucas,1932).
seCasaron(lucia,pepe,1961).
seCasaron(nuria,pepe,1966).
seCasaron(marcela,pepe,1967).
murio(juan,1993,mendoza).
murio(mercedes,1934,tucuman).
murio(angel,1986,rosario).
anioActual(2006). 

edad(Persona, Edad):-
	murio(Persona, AnioDeMuerte, _),
	edadQueTeniaEn(Persona, AnioDeMuerte, Edad).
	
edad(Persona, Edad):-
	nacio(Persona, _),
	not(murio(Persona, _,_)),
	anioActual(Anio),
	edadQueTeniaEn(Persona, Anio, Edad).
	
%% Predicado auxiliar para no repetir logica
edadQueTeniaEn(Persona, Anio, Edad):-
	nacio(Persona, AnioNacimiento),
	Edad is Anio - AnioNacimiento.
	
especial(Persona):-
	anioDeCasamiento(Persona, Anio),
	edadQueTeniaEn(Persona, Anio, Edad),
	not(between(18, 50, Edad)).
	
especial(Persona):-
	anioDeCasamiento(Persona, _),
	%% no me importa realmente lo que vaya a incluir en la lista, podria hasta ser una variable anonima en vez de Anio
	findall(Anio, anioDeCasamiento(Persona, Anio), Casamientos), 
	length(Casamientos, VecesQueSeCaso),
	VecesQueSeCaso >= 3.
	
especial(Persona):-
	edad(Persona, Edad),
	Edad > 100.
	
anioDeCasamiento(Persona, Anio):- seCasaron(Persona, _, Anio).
anioDeCasamiento(Persona, Anio):- seCasaron(_, Persona, Anio).

anioConRegistro(Anio):- nacio(_, Anio).
anioConRegistro(Anio):- seCasaron(_,_, Anio).
anioConRegistro(Anio):- murio(_, Anio,_).

anioFeliz(Anio):-
	anioConRegistro(Anio),
	not(murio(_,Anio,_)).
	
%% Este predicado no es inversible respecto a ninguna de sus aridades
%% pero como no lo pide y parece que no es la intencion usarlo para consultas existenciales, podemos dejarlo asi
%% Sin embargo si se quisiera hacer inversible al menos para el anio inicial, podria hacerse usando anioConRegistro
%% La duracion podria ser calculable pero por ahi no vale tanto la pena generarla
haySeguidilla(AnioInicial, Duracion):-
	AnioFinal is AnioInicial + Duracion - 1, 
	forall(between(AnioInicial, AnioFinal, Anio), anioConRegistro(Anio)).
	
%% Aca hay otra alternativa de solucion usando recursividad, sin embargo la anterior es mas copada porque:
%% usa para todo que es uno de los conceptos fuertes del paradigma logico
%% es mas declarativa que la alternativa recursiva
haySeguidillaR(AnioInicial, 1):- anioConRegistro(AnioInicial).
haySeguidillaR(AnioInicial, Duracion):-
	anioConRegistro(AnioInicial),
	AnioSiguiente is AnioInicial + 1,
	DuracionSiguiente is Duracion - 1,
	haySeguidillaR(AnioSiguiente, DuracionSiguiente).