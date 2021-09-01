%Base de conocimientos.

superheroe(batman).
superheroe(flash).
superheroe(linternaVerde).
superheroe(ironMan).
superheroe(hulk).
superheroe(spiderman).
superheroe(superman).

fuenteDePoder(batman, millonario(20000000)).
fuenteDePoder(flash, velocista(300000001)).
fuenteDePoder(linternaVerde, artefacto(anillo)).
fuenteDePoder(ironMan, millonario(1000000)).
fuenteDePoder(hulk, radioactivo(gamma, verde)).
fuenteDePoder(spiderman, radioactivo(alpha, arania)).

%Definicion de functor con una lista por extension
fuenteDePoder(superman, multipoder([superfuerza, visionDeRayosX, visionCalorifica, alientoFrio, vuelo, velocidad])).
	
%Definicion de si un heroe es canchero segun su poder (Polimorfismo, Pattern Matching)	
	
esCanchero(Persona):-
	superheroe(Persona),
	fuenteDePoder(Persona,Poder),
	esCancheroPoder(Poder).
	
esCancheroPoder(millonario(Plata)):-
	Plata > 1000000.
	
esCancheroPoder(velocista(Velocidad)):-
	Velocidad > 250000.
	
esCancheroPoder(radiacion(alpha,_)).

esCancheroPoder(multipoder(Poderes)):-
	member(volar,Poderes).
	
esCancheroPoder(multipoder(Poderes)):-
	length(Poderes,10).

%Base de conocimiento ampliada.

integrante(batman, ligaDeLaJusticia). 
integrante(flash, ligaDeLaJusticia). 
integrante(linternaVerde, ligaDeLaJusticia). 
integrante(superman, ligaDeLaJusticia). 
integrante(ironMan, vengadores). 
integrante(hulk, vengadores). 
integrante(spiderman, vengadores). 

esMejorQue(UnEquipo, OtroEquipo):-
	cantidadDeIntegrantes(UnEquipo, CantidadDeUnEquipo),
	cantidadDeIntegrantes(OtroEquipo, CantidadOtroEquipo),
	CantidadDeUnEquipo > CantidadOtroEquipo.
	
esMejorQue(UnEquipo, OtroEquipo):-
	integrante(batman, UnEquipo),
	not(integrante(batman, OtroEquipo)).
	
%Definicion de una lista por comprension (findall)
	
cantidadDeIntegrantes(Equipo, Cantidad):-
	integrante(_, Equipo),
	findall(SuperHeroe,	integrante(SuperHeroe,Equipo), Lista),
	length(Lista, Cantidad).
	
%Ejercitacion de recursividad con el patron de listas.
	
sumatoria([], 0).

sumatoria([X|Xs], Total):-
	sumatoria(Xs, SubTotal),
	Total is X + SubTotal.
	
padre(homero, bart).
padre(abraham, homero).
padre(john, abraham).

%Ejercitacion de recursividad mediante predicados

desciendeDe(Descendiente, Ancestro):-
	padre(Ancestro, Descendiente).

desciendeDe(Descendiente, Ancestro):-
	padre(Ancestro,AncestroMasCercano),
	desciendeDe(Descendiente, AncestroMasCercano).

