continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

paisContinente(americaDelSur, argentina).
paisContinente(americaDelSur, brasil).
paisContinente(americaDelSur, chile).
paisContinente(americaDelSur, uruguay).
paisContinente(americaDelNorte, alaska).
paisContinente(americaDelNorte, yukon).
paisContinente(americaDelNorte, canada).
paisContinente(americaDelNorte, oregon).
paisContinente(asia, kamtchatka).
paisContinente(asia, china).
paisContinente(asia, siberia).
paisContinente(asia, japon).
paisContinente(oceania,australia).
paisContinente(oceania,sumatra).
paisContinente(oceania,java).
paisContinente(oceania,borneo).

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

% Usar éste para saber si son limítrofes ya que es una relación simétrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(rojo).

ocupa(magenta, argentina).
ocupa(magenta, uruguay).
ocupa(negro, chile).
ocupa(negro, kamtchatka).
ocupa(negro, australia).
ocupa(negro, sumatra).
ocupa(negro, java).
ocupa(negro, borneo).
ocupa(amarillo, brasil).
ocupa(amarillo, alaska).
ocupa(amarillo, yukon).
ocupa(amarillo, canada).
ocupa(amarillo, oregon).
ocupa(amarillo, china).
ocupa(amarillo, siberia).
ocupa(amarillo, japon).

objetivo(amarillo, [ocuparContinente(asia),ocuparPaises(2, americaDelSur)]). 
objetivo(rojo, [destruirJugador(negro)]). 
objetivo(magenta, [destruirJugador(rojo)]). 
objetivo(negro, [ocuparContinente(oceania),ocuparContinente(americaDelSur)]). 

seVanASacarLosOjos(J1, J2):-
	debenOcuparElMismoContinente(J1, J2).
seVanASacarLosOjos(J1, J2):-
	debenDestruirseMutuamente(J1, J2).
	
debenOcuparElMismoContinente(J1, J2):-
	debeOcuparContinente(J1, Continente),
	debeOcuparContinente(J2, Continente),
	J1 \= J2.
	
debeOcuparContinente(Jugador, Continente):- 
	objetivo(Jugador, Objetivos),
	member(ocuparContinente(Continente), Objetivos).
	
debenDestruirseMutuamente(J1, J2):-
	debeDestruirA(J1, J2),
	debeDestruirA(J2, J1),
	J1 \= J2.

debeDestruirA(Jugador, JugadorADestruir):-
	objetivo(Jugador, Objetivos),
	member(destruirJugador(JugadorADestruir), Objetivos).
	
estaPeleado(Continente):- continente(Continente),
	forall(estaEnJuego(Jugador), ocupaAlgunPaisDe(Jugador, Continente)).
	
estaEnJuego(Jugador):- ocupa(Jugador, _).
ocupaAlgunPaisDe(Jugador, Continente):-
	ocupa(Jugador, Pais),
	paisContinente(Continente, Pais).
	
ocupaContinente(Jugador,Continente) :-
	continente(Continente),
	jugador(Jugador),
	forall(paisContinente(Continente,Pais),ocupa(Jugador,Pais)).
	
seAtrinchero(Jugador) :-
	continente(Continente),
	jugador(Jugador),
	forall(ocupa(Jugador,Pais),paisContinente(Continente,Pais)).	
	
%% Para que hagan ustedes: estaEnElHorno/1
	
cantidadDePaises(Jugador,Cantidad) :-
	jugador(Jugador),
	findall(Pais,ocupa(Jugador,Pais),Paises),
	length(Paises,Cantidad).
		
	
capoCannoniere(Jugador) :-
	cantidadDePaises(Jugador,Cantidad),
	forall((cantidadDePaises(Jugador2,Cantidad2),
		Jugador \= Jugador2),Cantidad > Cantidad2).
	
ganador(Jugador) :-
	cantidadDePaises(Jugador,30).
	
ganador(Jugador) :-
	objetivo(Jugador,Objetivos),
	forall(member(Objetivo,Objetivos),
		cumpleObjetivo(Jugador,Objetivo)). %POLIMORFISMO!!! :D
	
cumpleObjetivo(Jugador,ocuparContinente(Continente)) :-
	ocupaContinente(Jugador,Continente).
	
cumpleObjetivo(Jugador,ocuparPaises(Cantidad,Continente)) :-
	cuantosOcupaDeContinente(Jugador,Continente,Cantidad).

% Esta cláusula no es inversible, por ende cumpleObjetivo/3 en general tampoco lo es
% sin embargo para el uso que se le da, no es necesario ya que se consulta de forma individual
cumpleObjetivo(_,destruirJugador(Jugador)) :-
	not(ocupa(Jugador,_)).
	
cuantosOcupaDeContinente(Jugador,Continente,Cantidad) :-
	jugador(Jugador),
	continente(Continente),
	findall(Pais,
		(ocupa(Jugador,Pais),paisContinente(Continente,Pais)),
		Paises),
	length(Paises,Cantidad).

%%%%%%%%%%%%%%%%%%%%
%% UNIVERSO PARALELO
%% Si en vez de tener modelado ocupa(Jugador,Pais) tenemos 
%% ocupaPaises(Jugador, ListaDePaisesQueOcupa) y no se puede usar findall,
%% como se hace cuantosOcupaDeContinente/3 recursivamente?
%%%%%%%%%%%%%%%%%%%