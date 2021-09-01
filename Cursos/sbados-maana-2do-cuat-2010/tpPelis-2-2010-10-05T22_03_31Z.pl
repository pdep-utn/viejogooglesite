% Autor: PDP
% Entrega 1 y 2 - TP Lógico
% Fecha: 02/10/2010

% Punto 1
peli(quebracho,wullicher,1974,[alterio,murua,gene,lincovsky]).
peli(laRaulito,murua,1975,[ross,vaner]).
peli(laRaulito2,murua,1995,[ross,vaner]).
nacio(wullicher,1948).
nacio(alterio,1929).
nacio(murua,1926).

% Punto 1
tuvoLaburoEn(Actor, Anio):-actuoEn(Peli, Actor, Anio),
   actuoEn(OtraPeli, Actor, Anio), Peli \= OtraPeli.
   
actuoEn(Peli, Actor, Anio):-peli(Peli, _, Anio, As), member(Actor, As).

% Punto 2
star(Actor):-actor(Actor),
   not((actuoEn(Peli, Actor, _), not(protagonista(Peli, Actor)))).

protagonista(Peli, Actor):-peli(Peli, _, _, [Actor|_]).
protagonista(Peli, Actor):-peli(Peli, _, _, [_,Actor|_]).

actor(vaner).
actor(alterio).
actor(murua).
actor(lincovsky).
actor(ross).
actor(gene).

% Punto 3
starDe(Protagonista, ActorReparto):-
   protagonista(Pelicula, Protagonista),
   actorDeReparto(Pelicula, ActorReparto).
   
actorDeReparto(Pelicula, ActorReparto):-
   actuoEn(Pelicula, ActorReparto, _),
   not(protagonista(Pelicula, ActorReparto)).

% Punto 4
peliculaBizarra(Pelicula):-
    peli(Pelicula, Director, AnioPeli, _),
    nacio(Director, AnioNacimientoDirector),
    Edad is AnioPeli - AnioNacimientoDirector,
    Edad < 25.

peliculaBizarra(Pelicula):-peli(Pelicula, _, 1964, _).

peliculaBizarra(Pelicula):-
    peli(Pelicula, _, _, Actores), length(Actores, Cantidad),
    Cantidad > 8.

peliculaBizarra(Pelicula):-
    peli(Pelicula, Director, _, _),
    protagonista(Pelicula, Protagonista),
    actorDeReparto(Pelicula, ActorReparto),
    nacio(Director, Anio),
    nacio(Protagonista, Anio),
    nacio(ActorReparto, Anio).

% ************************************************
% ENTREGA 2
% ************************************************
% Punto 1
actorTuvoLaburoEn(Actor, Anio):-
   actor(Actor),    % si te molesta repetir los actores
   actuoEn(_, Actor, Anio),
   findall(Peli, actuoEn(Peli, Actor, Anio), Pelis),
   length(Pelis, CantidadPeliculas), CantidadPeliculas > 1.
   
actorStar(Actor):-actor(Actor),
   forall(actuoEn(Peli, Actor, _), protagonista(Peli, Actor)).

% Punto 2
duracionCarrera(Director, CantidadAnios):-
   findall(Anio, peli(_, Director, Anio, _), Anios),
   menor(Anios, AnioPrimeraPelicula),
   mayor(Anios, AnioUltimaPelicula),
   CantidadAnios is AnioUltimaPelicula - AnioPrimeraPelicula.
   
menor([Menor], Menor).
menor([X|Xs], Menor):-menor(Xs, MenorCola), Menor is min(X, MenorCola).

mayor([Menor], Menor).
mayor([X|Xs], Menor):-mayor(Xs, MenorCola), Menor is max(X, MenorCola).

% mayor3 con forall
mayor3(Lista, Menor):-member(Menor, Lista),
    forall(member(Elemento, Lista), Elemento >= Menor).

% Otra opción es ordenar la lista
duracionCarrera2(Director, CantidadAnios):-
   findall(Anio, peli(_, Director, Anio, _), Anios),
   sort(Anios, [AnioPrimeraPelicula|_]),
   reverse(Anios, [AnioUltimaPelicula|_]),
   CantidadAnios is AnioUltimaPelicula - AnioPrimeraPelicula.

% Otra opción
duracionCarrera3(Director, CantidadAnios):-
   findall(Anio, peli(_, Director, Anio, _), Anios),
   sort(Anios, AniosOrdenados),
   nth1(1, AniosOrdenados, AnioPrimeraPelicula),
   last(AniosOrdenados, AnioUltimaPelicula), % evitamos length(AniosOrdenados, C), nth1(C, AniosOrdenados, AnioUltimaPelicula)
   CantidadAnios is AnioUltimaPelicula - AnioPrimeraPelicula.

% Punto 3
cadenaDireccion(Director, Actor):-dirigio(Director, Alguien), dirigio(Alguien, Actor).

cadenaDireccion(Director, Actor):-dirigio(Director, ActorDirector),
   cadenaDireccion(ActorDirector, Actor).
   
dirigio(Director, Actor):-peli(_, Director, _, Actores), member(Actor, Actores).

% Punto 4
polifacetico(Tipo):-dirigio(Tipo, _), protagonista(_, Tipo), actorDeReparto(_, Tipo).
