% Autor: PDP
% Entrega 1 - TP Lógico
% Fecha: 25/09/2010

% Punto 1
peli(quebracho,wullicher,1974,[alterio,murua,gene,lincovsky]).
peli(laRaulito,murua,1975,[ross,vaner]).
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
    