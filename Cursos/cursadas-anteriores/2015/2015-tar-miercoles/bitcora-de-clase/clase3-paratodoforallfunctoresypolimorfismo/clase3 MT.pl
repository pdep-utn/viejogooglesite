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

ocupa(argentina, magenta).
ocupa(chile, negro).
ocupa(brasil, amarillo).
ocupa(uruguay, magenta).
ocupa(alaska, amarillo).
ocupa(yukon, amarillo).
ocupa(canada, amarillo).
ocupa(oregon, amarillo).
ocupa(kamtchatka, negro).
ocupa(china, amarillo).
ocupa(siberia, amarillo).
ocupa(japon, amarillo).
ocupa(australia, negro).
ocupa(sumatra, negro).
ocupa(java, negro).
ocupa(borneo, negro).

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

objetivo(amarillo, ocuparContinente(asia)).
objetivo(amarillo,ocuparPaises(2, americaDelSur)). 
objetivo(rojo, destruirJugador(negro)). 
objetivo(magenta, destruirJugador(rojo)). 
objetivo(negro, ocuparContinente(oceania)).
objetivo(negro,ocuparContinente(americaDelSur)). 

cuantosPaisesOcupaEn(amarillo, americaDelSur, 1).
cuantosPaisesOcupaEn(amarillo, americaDelNorte, 4).
cuantosPaisesOcupaEn(amarillo, asia, 3).
cuantosPaisesOcupaEn(amarillo, oceania, 0).
cuantosPaisesOcupaEn(magenta, americaDelSur, 2).
cuantosPaisesOcupaEn(magenta, americaDelNorte, 0).
cuantosPaisesOcupaEn(magenta, asia, 0).
cuantosPaisesOcupaEn(magenta, oceania, 0).
cuantosPaisesOcupaEn(negro, americaDelSur, 1).
cuantosPaisesOcupaEn(negro, americaDelNorte, 0).
cuantosPaisesOcupaEn(negro, asia, 1).
cuantosPaisesOcupaEn(negro, oceania, 4).

ocupaContinente(Jugador, Continente):-
	jugador(Jugador),
	continente(Continente),
	forall(estaEn(Continente, Pais), ocupa(Pais, Jugador)).

estaPeleado(Continente):-
	continente(Continente),
	forall(jugador(Jugador),
		(estaEn(Continente, Pais), ocupa(Pais, Jugador))).

/* Alternativa
estaPeleado(Continente):-
	continente(Continente),
	forall(jugador(Jugador),
		(cuantosPaisesOcupaEn(Jugador, Continente, N), N>0)).
*/

seAtrinchero(Jugador):-
	jugador(Jugador), 
	continente(Continente),
	forall(ocupa(Pais, Jugador), estaEn(Continente, Pais)).

estaEnElHorno(Pais):-
	ocupa(Pais, Jugador),
	forall(sonLimitrofes(Pais, OtroPais),
			(ocupa(OtroPais, OtroJugador),
			Jugador \= OtroJugador)).

cumpleObjetivos(Jugador):-
	jugador(Jugador),
	forall(objetivo(Jugador, Objetivo),
		cumplio(Jugador, Objetivo)).
		
cumplio(Jugador, ocuparContinente(Continente)):-
	ocupaContinente(Jugador, Continente).
	
cumplio(Jugador, ocuparPaises(Cant, Continente)):-
	cuantosPaisesOcupaEn(Jugador, Continente, LoQueTiene),
	LoQueTiene >= Cant.
	
cumplio(_, destruirJugador(OtroJugador)):-
	objetivo(OtroJugador, _),
	not(ocupa(_, OtroJugador)).


