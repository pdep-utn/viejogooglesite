%% Partiendo del mismo ejemplo de la clase anterior...

padre(homero, bart).
padre(abe, homero).
padre(homero, lisa).
padre(homero, maggie).
padre(ned, todd).
padre(ned, rod).

%% Agregamos mas informacion a la base de conocimientos:
edad(bart, 10).
edad(lisa, 8).
edad(maggie, 1).
edad(ned, 36).
edad(todd, 8).
edad(rod, 11).
edad(nelson, 13).

problematico(bart).
problematico(nelson).

%% Lo que queremos definir es un predicado estaTranquilo/1 que se verifica para una persona
%% si cumple con alguna de estas condiciones:
%% - no tiene hijos
%% - es padre pero ninguno de sus hijos es problematico
%% - al menos uno de sus hijos no es adolescente.
%% Decimos que alguien es adolescente si tiene entre 11 y 19 años

estaTranquilo(Persona):-
	persona(Persona), %% generamos una persona para que sea inversible
	not(padre(Persona, _)).
	
estaTranquilo(Persona):-
	padre(Persona, _), %% generamos alguien que sea padre, y a la vez aseguramos que sea inversible
	not((padre(Persona, Hijo), problematico(Hijo))).
	
estaTranquilo(Persona):-
	padre(Persona, Hijo),
	not(adolescente(Hijo)). %% delegamos este problema a otro predicado, es una abstraccion importante!
	
adolescente(Persona):-
	edad(Persona, Edad),
	between(11, 19, Edad).
	
%% faltaria definir el predicado persona/1, elegimos hacerlo usando el predicado padre/2
persona(Persona):- padre(Persona, _).
persona(Persona):- padre(_, Persona).

%% un detalle que no mencionamos en clase, que pasa con nelson? no es persona tambien?
%% No sabemos quien es su padre, pero como no tiene hijos deberia ser una respuesta posible para estaTranquilo/1,
%% pero con lo definido hasta ahora no lo es.
%% Como es un caso excepcional, se escapa de nuestra regla general para saber quienes son personas, podemos agregar un hecho:
persona(nelson).

%% ---- CAMBIO DRASTICO DE DOMINIO ---- %%

%% Sabiendo que el factorial de un numero es ese mismo numero multiplicado por el factorial del anterior,
%% que el factorial de 0 es 1 y ademas que solo se puede calcular el factorial de un numero positivo...

factorial(0, 1).
factorial(N, Factorial):-
	N > 0, %% esto evita que loopee infinito al tratar de buscar el factorial de un numero negativo
	Anterior is N - 1, %% usamos is para hacer cuentas, no =
	factorial(Anterior, FactorialAnterior),
	Factorial is N * FactorialAnterior.
	
/* Vemos que esto funciona correctamente y es inversible respecto al segundo argumento al hacer la siguiente prueba:
?- factorial(5, X).
X = 120 ;
false.

Este predicado no es inversible respecto a su primer argumento, porque las dos primeras consultas que se hacen
en la segunda clausula necesitan que N este ligada.
?- factorial(X, F).
X = 0,
F = 1 ;
ERROR: >/2: Arguments are not sufficiently instantiated

*/