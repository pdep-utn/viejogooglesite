% Ejemplos para predicados iniciales

jugador(rojo).
ubicadoEn(argentina, américaDelSur).
aliados(rojo, amarillo).
ocupa(rojo, argentina).
limítrofes(argentina, brasil).

% tienePresenciaEn/2: Relaciona un jugador con un continente del cual ocupa, al menos, un país.

tienePresenciaEn(Jugador, Continente):-
    ocupa(Jugador,País),
    ubicadoEn(País, Continente).

% puedenAtacarse/2: Relaciona dos jugadores si uno ocupa al menos un país limítrofe a algún país ocupado por el otro.

puedenAtacarse(UnJugador, OtroJugador):-
    ocupa(UnJugador, UnPaís),
    ocupa(OtroJugador, OtroPaís),
    limítrofes(UnPaís, OtroPaís).

% sinTensiones/2: Relaciona dos jugadores que, o bien no pueden atacarse, o son aliados.

sinTensiones(UnJugador, OtroJugador):-
    jugador(UnJugador), jugador(OtroJugador),
    not(puedenAtacarse(UnJugador, OtroJugador)).
sinTensiones(UnJugador, OtroJugador):- aliados(UnJugador, OtroJugador).

% perdió/1: Se cumple para un jugador que no ocupa ningún país.

perdió(Jugador):-
    jugador(Jugador),
    not(ocupa(Jugador,_)).

% controla/2: Relaciona un jugador con un continente si ocupa todos los países del mismo.

controla(Jugador, Continente):-
    jugador(Jugador), ubicadoEn(_, Continente),
    forall(ubicadoEn(País, Continente), ocupa(Jugador, País)).
controla2(Jugador, Continente):-
    jugador(Jugador), ubicadoEn(_, Continente),
    not((ubicadoEn(País, Continente), not(ocupa(Jugador, País)))).

% reñido/1: Se cumple para los continentes donde todos los jugadores ocupan algún país.

reñido(Continente):-
     ubicadoEn(_, Continente),
    forall(jugador(Jugador), (ocupa(Jugador, País), ubicadoEn(País, Continente))).

reñido2(Continente):-
    ubicadoEn(_, Continente),
    not((jugador(Jugador), not((ocupa(Jugador, País), ubicadoEn(País, Continente))))).

% atrincherado/1: Se cumple para los jugadores que ocupan países en un único continente.

atrincherado(Jugador):-
    ocupa(Jugador, País), ubicadoEn(País, Continente),
    forall(ocupa(Jugador, OtroPaís), ubicadoEn(OtroPaís, Continente)).

atrincherado2(Jugador):-
    ocupa(Jugador, País), ubicadoEn(País, Continente),
    not((ocupa(Jugador, OtroPaís), not(ubicadoEn(OtroPaís, Continente)))).

% puedeConquistar/2: Relaciona un jugador con un continente si no lo controla, pero todos los países del continente que le falta ocupar son limítrofes a alguno que sí ocupa y pertenecen a alguien que no es su aliado.

puedeConquistar(Jugador, Continente):-
    jugador(Jugador), ubicadoEn(_, Continente),
    not(controla(Jugador, Continente)),
    forall(
        (ubicadoEn(País, Continente), not(ocupa(Jugador, País))),
        puedeAtacar(Jugador, País)
    ).

puedeAtacar(Jugador, País):-
  limitrofes(País, OtroPaís), 
  ocupa(Jugador, OtroPaís), 
  not((ocupa(OtroJugador, País), aliados(OtroJugador, Jugador))).