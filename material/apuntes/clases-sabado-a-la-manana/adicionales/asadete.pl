% Autor: PDP
% Fecha: 08/10/2011

% define quiénes son amigos de nuestro cliente
amigo(mati).
amigo(pablo).
amigo(fer).
amigo(flor).
amigo(ezequiel).
amigo(marina).
amigo(leo).

% define quiénes no se pueden ver
noSeBanca(leo, flor).
noSeBanca(pablo, fer).
noSeBanca(fer, leo).
noSeBanca(flor, fer).

% define cuáles son las comidas y cómo se componen
% functor achura   contiene nombre, cantidad de calorías
% functor ensalada contiene nombre, lista de ingredientes
% functor morfi    contiene nombre (el morfi es una comida principal)
comida(achura(chori, 200)). % ya sabemos que el chori no es achura
comida(achura(chinchu, 150)).
comida(ensalada(waldorf, [manzana, apio, nuez, mayo])).
comida(ensalada(mixta, [lechuga, tomate, cebolla])).
comida(morfi(vacio)).
comida(morfi(mondiola)).
comida(morfi(asado)).

% relacionamos lo que hubo en ese asado
% cada asado se realizó en una única fecha posible
% functor fecha + comida que se sirvió
asado(fecha(22,9,2011), chori).
asado(fecha(22,9,2011), waldorf).
asado(fecha(22,9,2011), vacio).

asado(fecha(15,9,2011), mixta).
asado(fecha(15,9,2011), mondiola).
asado(fecha(15,9,2011), chinchu).

% relacionamos quiénes asistieron a ese asado
asistio(fecha(15,9,2011), flor).
asistio(fecha(15,9,2011), pablo).
asistio(fecha(15,9,2011), leo).
asistio(fecha(15,9,2011), fer).

asistio(fecha(22,9,2011), marina).
asistio(fecha(22,9,2011), pablo).
asistio(fecha(22,9,2011), flor).
asistio(fecha(22,9,2011), mati).

% definimos qué le gusta a cada persona
leGusta(mati, chori).
leGusta(mati, waldorf).
leGusta(mati, vacio).
leGusta(fer, vacio).
leGusta(fer, mondiola).
leGusta(pablo, asado).
leGusta(flor, mixta).

% NOTA ACLARATORIA: Todos los predicados deben ser inversibles.

% 1
% a) A Ezequiel le gusta lo que le gusta a matias y a fer.
% b) A Marina le gusta todo lo que le gusta a Flor y la mondiola.
% c) A Leo no le gusta la ensalada waldorf. --> Por Principio de Universo Cerrado no hay que agregar nada
%    todo lo que no existe en la base se presume falso
leGusta(ezequiel, Comida):-leGusta(mati, Comida).
leGusta(ezequiel, Comida):-leGusta(fer, Comida).
leGusta(marina, Comida):-leGusta(flor, Comida).
leGusta(marina, mondiola).

% 2
% asadoViolento/1 es la fecha donde hubo un asado donde
% todos los asistentes tuvieron que soportar la presencia de alguien
% que no se bancan
%
asado(Fecha):-asistio(Fecha, _).
% otra opcion es generar el predicado asado/1 en base a asado/2

asadoViolento(FechaAsado):-asado(FechaAsado),
    forall(asistio(FechaAsado, Asistente), (asistio(FechaAsado, Otro), noSeBanca(Asistente, Otro))).
    
% 3
% Relacionar las calorías de una comida
% - Las ensaladas tienen una caloría por ingrediente
% - Las achuras definen su propias calorías
% - El morfi tiene siempre 200 calorías, no importa de qué morfi se trate
calorias(Comida, Calorias):-comida(ensalada(Comida, Ingredientes)), length(Ingredientes, Calorias).
calorias(Comida, Calorias):-comida(achura(Comida, Calorias)).
calorias(Comida, 200):-comida(morfi(Comida)).

% 4
% Relacionar los asados flojitos, son los asados en los que todo lo que hubo
% para comer no supera las 400 calorías
asadoFlojito(FechaAsado):-asado(FechaAsado),
   findall(Caloria, (asado(FechaAsado, Comida), calorias(Comida, Caloria)), Calorias),
   sumlist(Calorias, Cantidad), Cantidad < 400.

% 5
% Al incorporar esta serie de hechos
hablo(fecha(15,09,2011), flor, pablo).
hablo(fecha(15,09,2011), pablo, leo).
hablo(fecha(15,09,2011), leo, fer).
hablo(fecha(22,09,2011), flor, marina).
hablo(fecha(22,09,2011), marina, pablo).

reservado(marina).
% Definir el predicado chismeDe/3, que relaciona la fecha de 
% un asado y dos personas  cuando la primera conoce algún 
% chisme de la segunda, porque 
% - la segunda le contó directamente a la primera o
% - alguien que conoce chismes de la segunda persona le contó a la primera
%   donde la segunda persona conoce algún chisme de esa persona x.
% siempre que la primera persona no sea reservada. 
% El predicado debe funcionar a n niveles posibles. 
% Considerar que en la conversación el primero le cuenta cosas que sabe al segundo. 
habloSinReservas(FechaAsado, Persona2, Persona1):-
   hablo(FechaAsado, Persona1, Persona2), not(reservado(Persona1)).
   
chismeDe(FechaAsado, Persona1, Persona2):-habloSinReservas(FechaAsado, Persona1, Persona2).
chismeDe(FechaAsado, Persona1, Persona2):-habloSinReservas(FechaAsado, Persona1, PersonaAux),
    chismeDe(FechaAsado, PersonaAux, Persona2).

% 6
% disfruto/2, relaciona a una persona que pudo comer
%    al menos 3 cosas que le gustan en un asado al que haya asistido
disfruto(Persona, FechaAsado):-asistio(FechaAsado, Persona),
    findall(Comida, (leGusta(Persona, Comida), asado(FechaAsado, Comida)), Comidas),
    length(Comidas, CantidadComidas),
    CantidadComidas > 2.

% 7
% Explosion combinatoria
% asadosRicos/1, debe armar un asado con comidas ricas
% los morfis son todos ricos
% las ensaladas ricas son las que tienen más de 3 ingredientes
% chori y morci son achuras ricas, el resto no
comidaRica(morfi(_)).
comidaRica(ensalada(_, Ingredientes)):-length(Ingredientes, Cantidad), Cantidad > 3.
comidaRica(achura(morci)).
comidaRica(achura(chori)).

combina([], []).
combina([Posible|Posibles], [Posible|Comidas]):-
   combina(Posibles, Comidas).
combina([_|Posibles], Comidas):-combina(Posibles, Comidas).

asadoRico(Comidas):-findall(Posible, (comida(Posible), comidaRica(Posible)), Posibles),
   combina(Posibles, Comidas), length(Comidas, Cantidad), Cantidad > 0.