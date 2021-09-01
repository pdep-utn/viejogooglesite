empleadeDelMes(mari).
empleadeDelMes(alf).

%idiomaDeSucursal(Pais, Idioma).
idiomaDeSucursal(mejico, espaniol).
idiomaDeSucursal(espania, espaniol).
idiomaDeSucursal(francia, frances).
idiomaDeSucursal(canada, ingles).
idiomaDeSucursal(canada, frances).

%sabeHablar(Empleade, Idioma).
sabeHablar(alf, espaniol).
sabeHablar(alf, ingles).
sabeHablar(mari, espaniol).
sabeHablar(mari, frances).
sabeHablar(debi, aleman).

%viajoA(Empleade, Pais).
viajoA(alf, mejico).
viajoA(alf, espania).
viajoA(mari, espania).

puedeViajar(Empleade, Pais) :-
    empleadeDelMes(Empleade),
    hablaIdiomaDelPais(Empleade, Pais),
    not(viajoA(Empleade, Pais)).

hablaIdiomaDelPais(Empleade, Pais) :-
    sabeHablar(Empleade, Idioma),
    idiomaDeSucursal(Pais, Idioma).



%%%%%%%%%%%%%%%%%%%%%%%%
mamifero(gato).
mamifero(perro).
mamifero(leon).

ave(golondrina).
ave(paloma).

% El OR se hace definiendo varias cláusulas.
vertebrado(Animal) :-
    mamifero(Animal).

vertebrado(Animal) :-
    ave(Animal).