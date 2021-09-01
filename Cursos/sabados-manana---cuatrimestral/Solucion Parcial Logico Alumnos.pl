opcionHoraria(paradigmas, lunes).
opcionHoraria(paradigmas, martes).
opcionHoraria(paradigmas, sabados).
opcionHoraria(algebra, lunes).
opcionHoraria(analisis1, martes).
opcionHoraria(analisis2, martes).

correlativa(paradigmas, algoritmos).
correlativa(paradigmas, algebra).
correlativa(analisis2, analisis1).

cursada(maria,algoritmos,[parcial(5),parcial(7),tp(mundial,bien)]).
cursada(maria,algebra,[parcial(5),parcial(8),tp(geometria,excelente)]).
cursada(maria,analisis1,[parcial(9),parcial(4),tp(gauss,bien), tp(limite,mal)]).
cursada(wilfredo,paradigmas,[parcial(7),parcial(7),parcial(7),tp(objetos,excelente),tp(logico,excelente),tp(funcional,excelente)]).
cursada(wilfredo,analisis2,[parcial(8),parcial(10)]).
cursada(wilfredo,analisis1,[parcial(5),parcial(8)]).

%punto 1
%Se buscan todas las notas de evaluaciones, se suman y se dividen por cantidad.
notaFinal(Evaluaciones, NotaFinal):-
	%Se aprovecha la inversibilidad de member/2 por primer parametro.
	%Con eso se obtienen todos los miembros de la lista.
	%Con findall/3 se arma la lista.
	findall(Nota, (member(E, Evaluaciones), nota(E, Nota)), Notas),
	%Para sumar las notas primero se armo una lista de numeros.
	sumlist(Notas, Suma),
	length(Evaluaciones, Cantidad),
	NotaFinal is Suma / Cantidad.

%Se delega en un predicado auxiliar polimorfico para obtener la nota.
nota(parcial(Nota), Nota).
nota(tp(_,excelente), 10).
nota(tp(_,bien),7).
nota(tp(_,mal),2).

%punto 2
aprobo(Alumno, Materia):-
	%cursada/3 hace de generador por el tema de inversibilidad.
	cursada(Alumno, Materia, Evaluaciones),
	notaFinal(Evaluaciones, NotaFinal),
	NotaFinal >= 4,
	%Fijense como se prueba que no exista ninguno con nota menor a 4.
	not((member(Eval,Evaluaciones), nota(Eval,Nota), Nota <4)).

%punto 3
%Puede cursar todas las materias sin correlativas y que no aprobo.
puedeCursar(Alumno,Materia):- 
	not(correlativa(Materia,_)),
	not(aprobo(Alumno,Materia)).

%Puede cursar todas las materias que no aprobo, pero si aprobo todas las correlativas.
puedeCursar(Alumno,Materia):- 
	not(aprobo(Alumno,Materia)), 
	forall(correlativa(Materia,Correlativa),(aprobo(Alumno,Correlativa))).

%punto 4
opcionesDeCursada(Alumno,Opciones) :-
	%cursada/3 hace de generador por el tema de inversibilidad.
	cursada(Alumno,_,_),
	%Con findall/3 se arma la lista.
	findall(opcion(Mat,Dia), (opcionHoraria(Mat,Dia), puedeCursar(Alumno,Mat)), Opciones).
	
%punto 5

%1era version:
%Cada una de las opciones de cursada (es decir, todas) no debe solaparse con las demas.
sinSuperposiciones(Opciones, Cursada):- 
	subconjunto(Cursada, Opciones),
	forall(member(Opcion, Cursada), not(solapa(Opcion, Cursada))).

%Se puede solapar por dia.
solapa(opcion(Materia, Dia), Sub):-
	member(opcion(Materia, OtroDia), Sub), Dia \= OtroDia.

%Se puede solapar por materia.
solapa(opcion(Materia, Dia), Sub):-
	member(opcion(OtraMateria, Dia), Sub), Materia \= OtraMateria.

/*
%2da version:
sinSuperposiciones(L,Ls):-
		subconjunto(T,L),
		podriaConformarCursada(T,Ls).

podriaConformarCursada([],[]).
podriaConformarCursada([opcion(M,D)|Xs],[opcion(M,D)|Ys]):-
	not(member(opcion(M,_),Xs)),
	not(member(opcion(_,D),Xs)),
	podriaConformarCursada(Xs,Ys).
podriaConformarCursada([opcion(M,D)|Xs],Ys):-
	(member(opcion(M,_),Xs); member(opcion(_,D),Xs)),
	podriaConformarCursada(Xs,Ys).
*/

%Predicado Auxiliar. Confiamos que no devuelve repetidos :-P
subconjunto([],_).
subconjunto([X|Xs],L):-
     sinElemento(X,L,L2),
     subconjunto(Xs,L2).

sinElemento(E,[E|Xs],Xs).
sinElemento(E,[X|Xs],[X|XsSinE]):-
   sinElemento(E,Xs,XsSinE).
