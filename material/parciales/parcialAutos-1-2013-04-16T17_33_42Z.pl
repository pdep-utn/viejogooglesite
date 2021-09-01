% Autor:  Fernando Dodino
% Fecha: 29/05/2010

% Base de conocimientos
% predicado duenio/2 relaciona una persona con su vehículo
% donde el vehículo puede ser
% - un functor auto(modelo, anio)
% - un functor moto(marca)
% - un functor camion(cantidad kilometros, marca)
duenio(fer, auto(dodge1500, 1980)).
duenio(fer, moto(zanella)).
duenio(mati, auto(gol, 2000)).
duenio(dani, auto(clio, 1997)).
duenio(flor, moto(siambretta)).
duenio(flor, camion(100000, scania)).
duenio(nico, camion(700000, mercedes)).
duenio(pablo, auto(escort, 2004)).

% predicado marca/2 relaciona modelo de un auto con su marca
marca(escort, ford).
marca(orion, ford).
marca(gol, volkswagen).
marca(dodge1500, volkswagen).
marca(clio, renault).

% predicado deOnda/1 define qué motos están "de onda"
deOnda(honda).
deOnda(suzuki).
deOnda(kawasaki).

% 1) Queremos agregar los gustos de una persona
% a Fer le gustan todos los autos que no son renault y las motos suzuki
% a Mati le gustan todos los vehículos que le gustan a Fer
%       y los vehículos de los que es dueño
% a Flor le gustan los autos de marca renault posteriores a 1997
leGusta(fer, auto(Modelo, _)):-marca(Modelo, Marca), Marca \= renault.
leGusta(fer, moto(suzuki)).

leGusta(mati, Vehiculo):-leGusta(fer, Vehiculo).
leGusta(mati, Vehiculo):-duenio(mati, Vehiculo).

leGusta(flor, auto(Modelo, Anio)):-marca(Modelo, renault), Anio > 1997.

% 2) Relacionar si un determinado vehículo es obsoleto
% - es un camion que tiene más de 500.000 kms recorridos
% - o es una moto que no está "de onda"
% - o es un auto marca volkswagen anterior al 1990
% No es necesario que el predicado sea inversible.
% Ejemplos
% ? esObsoleto(auto(1998, volkswagen)).
% No <-- el auto es volkswagen pero el año es posterior al 1990
% ?  esObsoleto(moto(siambretta)).
% Yes <-- la moto no está "de onda"
esObsoleto(auto(Modelo, Anio)):-marca(Modelo, volkswagen), Anio < 1990.
esObsoleto(moto(Marca)):-not(deOnda(Marca)).
esObsoleto(camion(CantidadKms, _)):-CantidadKms > 500000.

% 3) Definir el predicado esPichi/1, que relaciona la persona que
% es dueña de vehículos todos obsoletos
% El predicado debe ser inversible.
% Ejemplo: esPichi(Quien)
% Quien = fer;
% Quien = nico;
% No importa que se repitan las soluciones
esPichi(Persona):-duenio(Persona, _),
   forall(duenio(Persona, Vehiculo), esObsoleto(Vehiculo)).
   
% 4) Relacionar las marcas de vehículos que tiene una persona (sean motos,
%       autos o camiones). Tener en cuenta la estructura de cada functor,
%       o sea, en los camiones y las motos se conoce la marca, mientras
%       que del auto se conoce el modelo.
% El predicado debe ser inversible para ambos argumentos.
% No importa filtrar los repetidos.
% Algunos ejemplos de marcas(Persona, Marcas)
% Persona = fer
% Marcas = [volkswagen, zanella]
%
% Persona = flor
% Marcas = [siambretta, scania]
%
%Persona = mati
% Marcas = [volkswagen]
marcas(Persona, Marcas):-duenio(Persona, _),
    findall(Marca, (duenio(Persona, Vehiculo), definirMarca(Vehiculo, Marca)), Marcas).
    
definirMarca(camion(_, Marca), Marca).
definirMarca(moto(Marca), Marca).
definirMarca(auto(Modelo, _), Marca):-marca(Modelo, Marca).

% 5) Si agregamos en la base de conocimientos esta relación
conoce(fer, dani).
conoce(dani, mati).
conoce(fer, flor).
conoce(flor, pablo).
conoce(dani, nico).
% queremos saber si puede usar un determinado vehículo alguien, que es
% porque es dueño de ese vehículo o
% porque conoce a alguien que se lo puede prestar (todos los que conocen
% a otro le prestan el vehículo).
% El predicado puedeUsar/2 no necesita ser inversible, pero debe contemplar que
% fer pueda usar vehículos de dani, mati, flor, pablo o nico (n niveles
% de conocimiento posibles).
% Ejempo: ?- puedeUsar(dani, Vehiculo).
% Vehiculo = auto(clio, 1997) ;  <-- es dueño de este vehículo
% Vehiculo = auto(gol, 2000) ;   <-- se lo presta mati
% Vehiculo = camion(700000, mercedes) ; <-- se lo presta nico
% Ojo, puedeUsar(fer, Vehiculo) unificaría Vehiculo con todos los vehículos
% definidos en la actual base de conocimientos.
% El predicado debe ser inversible para ambos argumentos.
puedeUsar(Alguien, Vehiculo):-duenio(Alguien, Vehiculo).
puedeUsar(Alguien, Vehiculo):-conoce(Alguien, Otro),
    puedeUsar(Otro, Vehiculo).

% 6) Determinar si una persona es fanática de una marca, cuando todos los
% vehículos que tiene pertenecen a esa marca
% El predicado fanatico/2 debe ser inversible para el primer argumento.
% Ejemplos:
% ?- fanatico(fer, volkswagen).
% No <-- es dueño de un dodge1500 pero también de una zanella
% ?- fanatico(mati, volkswagen).
% Yes
fanatico(Alguien, Marca):-duenio(Alguien, _),
    forall(duenio(Alguien, Vehiculo), definirMarca(Vehiculo, Marca)).

% 7) Determinar si un tipo es cheto, cuando tiene al menos dos vehículos chetos
% - un camion no es cheto
% - una moto es cheta si está de onda
% - un auto es cheto si es del año 2008 ó posterior
% El predicado tipoCheto/1 debe ser inversible
% En nuestro caso no hay tipos chetos.
tipoCheto(Persona):-duenio(Persona, _),
    findall(Vehiculo, (duenio(Persona, Vehiculo), esCheto(Vehiculo)), VehiculosChetos),
    length(VehiculosChetos, Cantidad), Cantidad > 1.

esCheto(moto(Marca)):-deOnda(Marca).
esCheto(auto(_, Anio)):-Anio > 2007.


marcas([volkswagen]).