% Este predicado usa los objetivos sin preocuparse por la forma que tienen
% Puede tratarlos POLIMÓRFICAMENTE gracias a cumplioObjetivo/2
gano(Jugador):-
	jugador(Jugador),
	forall(objetivo(Jugador, Objetivo),
			cumplioObjetivo(Jugador, Objetivo)).

% se cumple si el jugador a destruir no ocupa ningún país
cumplioObjetivo(_, destruirJugador(Otro)):-
	not(ocupa(_, Otro)).

% se cumple si el jugador tiene al menos N países en ese continente
cumplioObjetivo(Jugador, ocuparPaises(N, Continente)):-
	cuantosPaisesOcupaEn(Jugador, Continente, CuantosTiene),
	CuantosTiene >= N.
	
% se cumple si ocupa todos los países del continente
cumplioObjetivo(Jugador, ocuparContinente(Continente)):-
	forall(estaEn(Continente, Pais), ocupa(Pais, Jugador)).

	
% BASE DE CONOCIMIENTOS

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