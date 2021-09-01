%% Ejemplito basico con dos predicados (hombre/1 y mortal/1), el ultimo definido con un hecho y una regla. Hay una disyuncion en el predicado mortal/2 porque tiene dos clausulas.
hombre(socrates).
mortal(Alguien):-
	hombre(Alguien).
mortal(sandro).

%% Ejemplo mas complejo donde se ven las ideas de unificacion, conjuncion, disyuncion y recursividad.

padre(homero, bart).
padre(abe, homero).
padre(homero, lisa).
padre(homero, maggie).
padre(ned, todd).
padre(ned, rod).

hermanos(Uno, Otro):-
	padre(Padre, Uno),
	padre(Padre, Otro),
	Uno \= Otro.
	
abuelo(Abuelo, Nieto):-
	padre(Abuelo, Padre),
	padre(Padre, Nieto).
	
ancestro(Ancestro, Descendiente):-
	padre(Padre, Descendiente),
	ancestro(Ancestro, Padre).
ancestro(Ancestro, Descendiente):-
	padre(Ancestro, Descendiente).