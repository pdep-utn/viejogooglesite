
continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

aliados(X,Y):- alianza(X,Y).
aliados(X,Y):- alianza(Y,X).
alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).


% Punto 1
puedenAtacarse(Jug1, Jug2) :-
	sonLimitrofes(Pais1,Pais2),
	ocupa(Pais1, Jug1, _),
	ocupa(Pais2, Jug2,_),
	Jug1 \= Jug2.

% Punto 2
estaTodoBien(Jug1,Jug2):- 
	aliados(Jug1,Jug2).
estaTodoBien(Jug1,Jug2):- 
	jugador(Jug1),
	jugador(Jug2),
	not(puedenAtacarse(Jug1,Jug2)).

% Punto 3
loLiquidaron(Jugador):-
	jugador(Jugador),
	not(ocupa(_,Jugador,_)).

% paratodo estaEn(Continente,Pais) se cumple que ocupa(Pais,Jugador,_).

% Punto 4
ocupaContinente(Jugador,Continente):-
	continente(Continente),
	jugador(Jugador),
	forall(estaEn(Continente,Pais),ocupa(Pais,Jugador,_)).

% Punto 5
estaPeleado(Continente):-
	continente(Continente),
	forall(jugador(Jugador), ocupaPaisDeContinente(Jugador,Continente)).

ocupaPaisDeContinente(Jugador,Continente):-
	ocupa(Pais,Jugador,_),
	estaEn(Continente,Pais).

% Punto 9
juntan(Pais1, Pais2, Cantidad):-
	ocupa(Pais1,_,Cant1),
	ocupa(Pais2,_,Cant2),
	Cantidad is Cant1 + Cant2.

seguroGanaContra(Pais1,Pais2):-
	ocupa(Pais1,Jug1,Cant1),
	ocupa(Pais2,Jug2,Cant2),
	sonLimitrofes(Pais1,Pais2),
	Jug1 \= Jug2,
	Cant1 > 2 * Cant2.
	
%%%%%%%%%%% 
% Estos no los hicimos en clase, pero los ponemos por completitud.
%%%%%%%%%%%

%6
seAtrinchero(Jugador):-
	jugador(Jugador),
	continente(Continente),
	forall(ocupa(Pais2,Jugador,_),estaEn(Continente,Pais2)).

%7
puedeConquistar(Jugador,Continente):-
	jugador(Jugador),continente(Continente),
	not(ocupaContinente(Jugador,Continente)),
	esConquistablePor(Jugador,Continente).

esConquistablePor(Jugador,Continente):-
	forall(
	    (estaEn(Continente,Pais),not(ocupa(Jugador,Pais,_))),
	    paisAtacable(Pais,Jugador)).

paisAtacable(Pais,Jugador):-
	ocupa(Pais2,Jugador,_),
	sonLimitrofes(Pais,Pais2),
	ocupa(Pais,Enemigo,_),
	not(aliados(Jugador,Enemigo)).

%8
elQueTieneMasEjercitos(Jugador,Pais):-
	ocupa(Pais,Jugador,Ejercitos),
	forall(
	    (ocupa(Pais2,_,Ejercitos2),Pais\=Pais2),
	    Ejercitos>Ejercitos2).

% Otra forma de hacerlo:
elQueTieneMasEjercitos2(Jugador,Pais):-
	ocupa(Pais,Jugador,Ejercitos),
	forall(ocupa(_,_,Ejercitos2),Ejercitos>=Ejercitos2).

% OOootra forma más:
elQueTieneMasEjercitos3(Jugador,Pais):-
	ocupa(Pais,Jugador,Ejercitos),
	not((ocupa(_,_,Ejercitos2),Ejercitos<Ejercitos2)).


% Punto 11) ¡Prolog es feo para aritmética!

cuantoAgregaParaGanarSeguro(Pais1, Pais2, Cant):-
	ocupa(Pais1,_,CantVieja),
	ocupa(Pais2,_,CantOponente),
	CantNueva is CantVieja + Cant,
	ganaCon(Pais1,Pais2,CantNueva,CantOponente).

% Modifico para no repetir código:
seguroGanaContra2(Pais1,Pais2):-
	ocupa(Pais1,_,Cant1),
	ocupa(Pais2,_,Cant2),
	ganaCon(Pais1,Pais2,Cant1,Cant2).

ganaCon(Pais1,Pais2,Cant1,Cant2):-
	ocupa(Pais1,Jug1,_),
	ocupa(Pais2,Jug2,_),
	sonLimitrofes(Pais1,Pais2),
	Jug1 \= Jug2,
	Cant1 > 2 * Cant2.


% Ojo, no es inversible por el tercer parámetro, podríamos generar la Cant con un between.
