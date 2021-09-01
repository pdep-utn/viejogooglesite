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

% mayor3 con forall
mayor3(Lista, Menor):-member(Menor, Lista),
    forall(member(Elemento, Lista), Elemento >= Menor).

% Otra opción (usando predicados de orden superior, fuera de alcance de la materia
fold([Menor], Menor, _).
fold([X|Xs], Menor, Pred):-fold(Xs, MenorCola, Pred), call(Pred, X, MenorCola, Menor).

minimo(A, B, A):- A < B.
minimo(A, B, B):- not(A < B).

maximo(A, B, A):- A > B.
maximo(A, B, B):- not(A > B).

% Eso permite
% fold([2,5,4,3], Menor, minimo).
% Menor = 2
% fold([2,5,4,3], Mayor, maximo).
% Mayor = 5
% y nos quedaría
menor2(Lista, Menor):-fold(Lista, Menor, minimo).
mayor2(Lista, Mayor):-fold(Lista, Mayor, maximo).

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

% ************************************************
% ENTREGA 3
% ************************************************
pasan(quebracho,cineCadena(hoyts,abasto,3)).
pasan(quebracho,cineCadena(hoyts,caballito,10)).
pasan(quebracho,cineCadena(cinemark,madero,4)).
pasan(quebracho,cine(lorca)).
barrioCine(lorca,centro).

estaCerca(abasto,centro).
barriosCercanos(B1,B2):- estaCerca(B1,B2).
barriosCercanos(B1,B2):- estaCerca(B2,B1).

anioActual(2008).

director(Director):-peli(_, Director, _, _).

% punto 1
enDondeDirigioA(Director, Actor, Pelis):- director(Director),
   actor(Actor), findall(Pelicula, (peli(Pelicula, Director, _, Actores), member(Actor, Actores)), Pelis),
   % opcional
   length(Pelis, Cantidad), Cantidad > 0.    

% punto 2   
seDaEnBarrio(Pelicula, Barrio):-pasan(Pelicula, cineCadena(_, Barrio, _)).
seDaEnBarrio(Pelicula, Barrio):-pasan(Pelicula, cine(Cine)), barrioCine(Cine, Barrio).

% punto 3
barrioClasico(Barrio):-barrio(Barrio), forall(seDaEnBarrio(Pelicula, Barrio), esClasica(Pelicula)).

barrio(Barrio):-seDaEnBarrio(_, Barrio).

esClasica(Pelicula):-peli(Pelicula, _, Anio, _), anioActual(AnioActual),
   Diferencia is AnioActual - Anio, Diferencia > 20.
   
% punto 4
cadenaMisticaParaPeli(Cadena, Pelicula):-peli(Pelicula, _, _, _),
   cadena(Cadena),
   findall(Sala, pasan(Pelicula, cineCadena(Cadena, _, Sala)), Salas),
   sumlist(Salas, Total), Total \= 0, 0 is Total rem 13.
   
cadena(hoyts).
cadena(cinemark).

% punto 5
cubre(Cadena1, Cadena2):-cadena(Cadena1), cadena(Cadena2),
   forall(pasan(Pelicula, cineCadena(Cadena2, Barrio, _)), cadenaPasa(Cadena1, Pelicula, Barrio)).
   
cadenaPasa(Cadena, Pelicula, Barrio):-
   pasan(Pelicula, cineCadena(Cadena, Barrio, _)).
   
cadenaPasa(Cadena, Pelicula, Barrio):-
   barriosCercanos(Barrio, OtroBarrio),
   pasan(Pelicula, cineCadena(Cadena, OtroBarrio, _)).
   