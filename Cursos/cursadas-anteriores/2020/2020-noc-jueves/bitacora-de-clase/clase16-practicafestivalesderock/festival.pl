%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASE DE CONOCIMIENTO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipódromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipódromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipódromoSanIsidro, zona1, 1500).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EJERCICIOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1) Itinerante/1
% Se cumple para los festivales que ocurren en más de un lugar, con el mismo nombre y las mismas bandas.

itinerante(Festival):-
  festival(Festival, Bandas, UnLugar),
  festival(Festival, Bandas, OtroLugar),
  UnLugar \= OtroLugar.

% ----------------------------------------------------------------------------------------------------------------------

% 2) careta/1
% Decimos que un festival es careta si no tiene campo o si es el personalFest.

careta(personalFest).
careta(Festival):-
  festival(Festival,_,_),
  not(entradaVendida(Festival,campo)).

% ----------------------------------------------------------------------------------------------------------------------

% 3) nacAndPop/1
% Un festival es nac&pop si no es careta y las bandas que tocan en él son todas argentinas con popularidad mayor a 1000.

nacAndPop(Festival):-
  festival(Festival,Bandas,_),
  forall(member(Banda, Bandas), (banda(Banda, ar, Popularidad), Popularidad > 100)),
  not(careta(Festival)).

% ----------------------------------------------------------------------------------------------------------------------

% 4) sobrevendido/1
% Se cumple para los festivales que vendieron más entradas que la capacidad del lugar donde se realizan.
% Nota: no hace falta contemplar si es un festival itinerante.

sobrevendido(Festival):-
  festival(Festival,_,Lugar),
  lugar(Lugar, Capacidad, _),
  findall(Entrada, entradaVendida(Festival, Entrada), EntradasVendidas),
  length(EntradasVendidas, CantidadDeEntradasVendidas),
  CantidadDeEntradasVendidas > Capacidad.

% ----------------------------------------------------------------------------------------------------------------------

% 5) recaudaciónTotal/2
% Relaciona un festival con el total recaudado con la venta de entradas.
% Cada tipo de entrada se vende a un precio diferente:
%   - El precio del campo es el precio base del lugar donde se realiza el festival.
%   - La platea general es el precio base del lugar más el plus que se aplica a la zona. 
%   - Las plateas numeradas salen el triple del precio base para las filas de atrás (>10) y 6 veces para las 10 primeras.
% Nota: no hace falta contemplar si es un festival itinerante.

recaudaciónTotal(Festival, Recaudación):-
  festival(Festival, _, Lugar),
  findall(Precio, (entradaVendida(Festival, Entrada), precio(Entrada, Lugar, Precio)), Precios),
  sumlist(Precios, Recaudación).
  
  
precio(campo, Lugar, Precio):- lugar(Lugar,_,Precio).

precio(plateaGeneral(Zona), Lugar, Precio):-
  lugar(Lugar,_,PrecioBase),
  plusZona(Lugar, Zona, Plus),
  Precio is PrecioBase + Plus.

precio(plateaNumerada(Fila), Lugar, Precio):-
  Fila =< 10,
  lugar(Lugar,_,PrecioBase),
  Precio is PrecioBase * 6.

precio(plateaNumerada(Fila), Lugar, Precio):-
  Fila > 10,
  lugar(Lugar,_,PrecioBase),
  Precio is PrecioBase * 3.

% ----------------------------------------------------------------------------------------------------------------------

% 6) delMismoPalo/2
% Relaciona dos bandas si tocaron juntas en algún recital o si una de ellas tocó con una banda del mismo palo que la otra, pero más popular.

delMismoPalo(UnaBanda, OtraBanda):- tocoCon(UnaBanda, OtraBanda).
delMismoPalo(UnaBanda, OtraBanda):-
  tocoCon(UnaBanda, TercerBanda),
  delMismoPalo(TercerBanda, OtraBanda),
  banda(TerceraBanda ,_ ,PopularidadDeLaTercera),
  banda(TerceraBanda ,_ ,PopularidadDeLaOtra),
  PopularidadDeLaTercera > PopularidadDeLaOtra.

tocoCon(UnaBanda, OtraBanda):-
  festival(_, Bandas, _),
  member(UnaBanda, Bandas),
  member(OtraBanda, Bandas),
  UnaBanda \= OtraBanda.
