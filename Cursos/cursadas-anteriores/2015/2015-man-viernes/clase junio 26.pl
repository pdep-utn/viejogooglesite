%%%%%%%%%%%%%% FUNCTORES Y POLIMORFISMO

voto(legajo(56344,8),franja).
voto(doc(le,34225634),claveroja).
voto(doc(lc,334),ues).
voto(doc(dni,334),19).
voto(pasaporte(5634,francia,2018),unete).

especialidad(X):-persona(_,_,X).

persona(legajo(56344,8),juan,sistemas).
persona(doc(dni,34565634),juan,civil).
persona(doc(lc,334),ana,industrial).
persona(doc(dni,334),sofia,industrial).
persona(pasaporte(5634,francia,2018),charles,industrial).


votoCarrera(Partido,Especialidad):-
	voto(Documento,Partido),
	persona(Documento,_,Especialidad).


noVoto(Alguien):-
	persona(Alguien,_,_),
	not(voto(Alguien,_)).

fraude:-
	voto(Alguien,_),
	not(persona(Alguien,_,_)).

votoTodoElPadron:-
	forall(persona(Alguien,_,_),voto(Alguien,_)).

votoTodoElPadronEspecialidad(Esp):-
	especialidad(Esp),
	forall(persona(Alguien,_,Esp),voto(Alguien,_)).


votoTodoElPadron2:-
	not(noVoto(_)).


recaudacion(Total,Importes):-
    findall(Importe,(persona(Documento,_,_),arancel(Documento,Importe)),Importes),
    sumlist(Importes,Total).


arancel(pasaporte(_,Pais,_),Monto):-tarifa(Pais,Monto).
arancel(doc(dni,_),40).
arancel(doc(le,_),50).
arancel(doc(lc,_),10).
arancel(legajo(_,N),M):-M is N*100.


tarifa(peru,500).
tarifa(brasil,300).
tarifa(francia,50000).



%%%%%%%%%%%%%%%%% LISTAS Y RECURSIVIDAD

head([X|_],X).

tail([_|XS],XS).

largo([],0).
largo([_|XS],Longitud):-
	largo(XS,Algo),
	Longitud is Algo+1.

ascendente([_]).
ascendente([X,Y|Cola]):-
	X<Y,
	ascendente([Y|Cola]).


hijo(bart,homero).
hijo(lisa,homero).
hijo(homero,abraham).
hijo(abraham,donsimpson).
hijo(herbert,abraham).

nieto(Nieto,Abuelo):-
	hijo(Nieto,Alguien),
	hijo(Alguien,Abuelo).

descendiente(Persona,Antepasado):-
	hijo(Persona,Antepasado).
descendiente(Persona,Antepasado):-
	hijo(Persona,Alguien),
	descendiente(Alguien,Antepasado).


