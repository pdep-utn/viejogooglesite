hijo(lisa,marge).
hijo(maggie,marge).
hijo(bart,marge).
hijo(lisa,homero).
hijo(maggie,homero).
hijo(bart,homero).
hijo(homero,abe).
hijo(herbert,abe).
hijo(marge,madredemarge).
hijo(nelson,madredenelson).	

hijo(tod,flanders).
hijo(rod,flanders).

/*
quilombero(bart).
quilombero(nelson).
deportista(nelson).
deportista(rod).
deportista(tod).
*/

nerd(A):-
	alumno(A),
	not(deportista(A)).
    
    
alumno(A):-
	hijo(A,_).
/*
es(bart,quilombero).
es(nelson,quilombero).
es(nelson,deportista).
*/
hace(bart,quilombo,40).

quilombero(Alguien):-
	Cant > 30,
	hace(Alguien,quilombo,Cant).

%% */

nota(2,A):-
	quilombero(A),
	hijo(A,homero).
nota(10,A):-
	nerd(A).
nota(10,A):-
	hijoUnico(A).
nota(6,A):-
	hijo(_,A).

pareja(marge,homero).


hermano(H1,H2):-
	hijo(H1,Padre),
	hijo(H2,Padre),
	H1 \= H2.

tio(Tio,Sobrino):-
	hijo(Sobrino,Alguien),
	hermano(Alguien,Tio).

hijoUnico(Hijo):-
    hijo(Hijo,_),
	not(hermano(Hijo,_)).


