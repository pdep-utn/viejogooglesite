opcionHoraria(paradigmas, lunes).
opcionHoraria(paradigmas, martes).
opcionHoraria(paradigmas, sabados).
opcionHoraria(algebra, lunes).


correlativa(paradigmas, algoritmos).
correlativa(paradigmas, algebra).
correlativa(analisis2, analisis1).

cursada(maria,algoritmos,[parcial(5),parcial(7),tp(mundial,bien)]).
cursada(maria,algebra,[parcial(5),parcial(8),tp(geometria,excelente)]).
cursada(maria,analisis1,[parcial(9),parcial(4),tp(gauss,bien), tp(limite,mal)]).
cursada(wilfredo,paradigmas,[parcial(7),parcial(7),parcial(7),tp(objetos,excelente),tp(logico,excelente),tp(funcional,excelente)]).
cursada(wilfredo,analisis2,[parcial(8),parcial(10)]).


%punto 1
notaFinal(Es,N):-
	findall(Nota, (member(E, Es),nota(E,Nota)), Ns),
	sumlist(Ns, T),
	length(Es, C),
	N is T / C.
	
nota(parcial(N),N).
nota(tp(_,excelente),10).
nota(tp(_,bien),7).
nota(tp(_,mal),2).

%punto 2
aprobo(P,M):-
	cursada(P,M,Es),
	notaFinal(Es,N),
	N >= 4,
	not((member(E,Es),nota(E,Nota),Nota <4)).
	
%punto 3
puedeCursar(A,M):- not(correlativa(M,_)), not(aprobo(A,M)).
puedeCursar(A,M):- not(aprobo(A,M)), forall(correlativa(M,C),(aprobo(A,C))).


%punto 4
opcionesDeCursada(A,Os) :-
	cursada(A,_,_),
	findall(opcion(M,D),(opcionHoraria(M,D), puedeCursar(A,M)), Os).
	
%punto 5
sinSuperposiciones(L,Ls):-
		subconjunto(T,L),
		podriaConformarCursada(T,Ls).

podriaConformarCursada([],[]).
podriaConformarCursada([opcionHoraria(M,D)|Xs],[opcionHoraria(M,D)|Ys]):-
	not(member(opcionHoraria(M,_),Xs)),
	not(member(opcionHoraria(_,D),Xs)),
	podriaConformarCursada(Xs,Ys).
podriaConformarCursada([opcionHoraria(M,D)|Xs],Ys):-
	(member(opcionHoraria(M,_),Xs); member(opcionHoraria(_,D),Xs)),
	podriaConformarCursada(Xs,Ys).

	
subconjunto([],_).
subconjunto([X|Xs],L):-
     sinElemento(X,L,L2),
     subconjunto(Xs,L2).

sinElemento(E,[E|Xs],Xs).
sinElemento(E,[X|Xs],[X|XsSinE]):-
   sinElemento(E,Xs,XsSinE).

