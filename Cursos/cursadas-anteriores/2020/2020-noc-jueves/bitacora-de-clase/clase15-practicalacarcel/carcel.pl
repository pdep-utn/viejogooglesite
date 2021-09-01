%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASE INICIAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% guardia(Nombre)
% ...

% prisionero(Nombre, Crimen)
% ...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RESOLUCIÓN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1) Indicar si controla/2 es inversible

controla(piper, alex).
controla(bennett, dayanara).
controla(Guardia, Otro):- prisionero(Otro,_), guardia(Guardia), not(controla(Otro, Guardia)).

% ----------------------------------------------------------------------------------------------------------------------------------------------------------------

% 2) conflictoDeIntereses/2
%    Relaciona a dos personas distintas si no se controlan mutuamente y existe algún tercero al cual ambos controlan.

    conflictoDeIntereses(Uno, Otro):-
        controla(Uno, Tercero),
        controla(Otro, Tercero),
        not(controla(Uno, Otro)),
        not(controla(Otro, Uno)),
        Uno \= Otro.

% ----------------------------------------------------------------------------------------------------------------------------------------------------------------

% 3) peligroso/1
%    Se cumple para un preso que sólo cometió crímenes graves.
%      - Un robo nunca es grave.
%      - Un homicidio siempre es grave.
%      - Un delito de narcotráfico es grave cuando incluye al menos 5 drogas a la vez, o incluye metanfetaminas.

    peligroso(Prisionero):-
        prisionero(Prisionero, _),
        forall(prisionero(Prisionero, Crimen), grave(Crimen)).

    grave(homicidio(_)).
    grave(narcotráfico(Drogas)):- member(metanfetaminas, Drogas).
    grave(narcotráfico(Drogas)):- length(Drogas, Cantidad), Cantidad >= 5.

% ----------------------------------------------------------------------------------------------------------------------------------------------------------------

% 4) ladronDeGuanteBlanco
%    Aplica a un prisionero si sólo cometió robos y todos fueron por más de $100.000.

    monto(robo(Monto), Monto).

    ladronDeGuanteBlanco(Prisionero):-
        prisionero(Prisionero, _),
        forall(prisionero(Prisionero, Crimen), (monto(Crimen, Monto), Monto > 100000)).

% ----------------------------------------------------------------------------------------------------------------------------------------------------------------

% 5) condena/2
%    Relaciona a un prisionero con la cantidad total de años de condena que debe cumplir.
%      - La cantidad de dinero robado dividido 10.000.
%      - 7 años por cada homicidio cometido, más 2 años extra si la víctima era un guardia.
%      - 2 años por cada droga que haya traficado.

    pena(robo(Monto), Pena):- Pena is Monto / 10000.
    pena(homicidio(Persona), 9):- guardia(Persona).
    pena(homicidio(Persona), 7):- not(guardia(Persona)).
    pena(narcotráfico(Drogas), Pena):- length(Drogas, Cantidad), Pena is Cantidad * 2.

    condena(Prisionero, Condena):-
        prisionero(Prisionero, _),
        findall(Pena, (prisionero(Prisionero, Crimen), pena(Crimen, Pena)), Penas),
        sumlist(Penas, Condena).

% ----------------------------------------------------------------------------------------------------------------------------------------------------------------

% 6) capo/1
%    Se dice que un preso es el capo de todos los capos cuando nadie lo controla, pero todas las personas de la cárcel
%    (guardias o prisioneros) son controlados por él, o por alguien a quien él controla (directa o indirectamente).


    persona(Persona):- prisionero(Persona,_).
    persona(Persona):- guardia(Persona).

    controlaDirectaOIndirectamente(Uno, Otro):- controla(Uno, Otro).
    controlaDirectaOIndirectamente(Uno, Otro):- controla(Uno, Tercero), controlaDirectaOIndirectamente(Tercero, Otro).
    
    capo(Capo):-
        prisionero(Capo, _),
        not(controla(_, Capo)),
        forall((persona(Persona), Capo \= Persona), controlaDirectaOIndirectamente(Capo, Persona)).
