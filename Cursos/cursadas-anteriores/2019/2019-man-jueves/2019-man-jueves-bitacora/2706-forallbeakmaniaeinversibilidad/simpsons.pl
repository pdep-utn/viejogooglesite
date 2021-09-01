hijeDe(homero, abe).
hijeDe(herbert, abe).
hijeDe(bart, homero).
hijeDe(lisa, homero).
hijeDe(maggie, homero).
hijeDe(bart, marge).
hijeDe(lisa, marge).
hijeDe(maggie, marge).
hijeDe(tod, ned).
hijeDe(rod, ned).

esPadreDe(Padre, Hijo) :-
    hijeDe(Hijo, Padre).

sonHermanos(UnHermano, OtroHermano) :-
    hijeDe(UnHermano, Padre),
    hijeDe(OtroHermano, Padre),
    UnHermano \= OtroHermano.

tio(Tio, Sobrino) :-
    sonHermanos(Tio, Padre),
    hijeDe(Sobrino, Padre).
tio(moe, maggie).


ancestre(Ancestro, Persona) :-
    hijeDe(Persona, Padre),
    ancestre(Ancestro, Padre).
ancestre(Ancestro, Persona) :-
    hijeDe(Persona, Ancestro).


criadoPorSiMismo(Persona) :-
    hijeDe(Persona, _),
    not(tieneDosPadres(Persona)).

tieneDosPadres(Persona) :-
    hijeDe(Persona, Padre),
    hijeDe(Persona, OtroPadre),
    Padre \= OtroPadre.
    
hijeUnico(Persona) :-
    hijeDe(Persona, _),
    not(sonHermanos(Persona, _)).


quilombero(nelson).
quilombero(bart).

deportista(nelson).
deportista(rod).
deportista(tod).

persona(Persona) :- hijeDe(Persona, _).
persona(Persona) :- hijeDe(_, Persona).
persona(nelson).
persona(moe).

nerd(Persona) :-
    persona(Persona),
    not(deportista(Persona)),
    not(quilombero(Persona)).

fanDelDeporte(Persona) :-
    hijeDe(_, Persona),
    forall(hijeDe(Hije, Persona), deportista(Hije)).
    
parejaSoniada(Persona, Pareja) :-
    hijeDe(_, Persona),
    hijeDe(_, Pareja),
    forall(hijeDe(Hije, Persona), hijeDe(Hije, Pareja)).