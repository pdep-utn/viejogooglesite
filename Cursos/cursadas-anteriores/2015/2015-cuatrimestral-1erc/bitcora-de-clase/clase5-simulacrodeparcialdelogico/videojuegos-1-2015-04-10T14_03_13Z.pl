juego(minecraft, pc([windows,linux,mac])).
juego(minecraft, playstation(2)).
juego(minecraft, playstation(3)).
juego(superMario, xbox).
juego(superMario, xcube).
juego(saga(finalFantasy, 1), gameboy).
juego(saga(finalFantasy, 2), gameboy).
juego(saga(finalFantasy, 3), gameboy).
juego(saga(finalFantasy, 3), gameboyColor).
juego(saga(finalFantasy, 3), xbox).

usuarios(minecraft,playstation(2), 40000).
usuarios(minecraft, playstation(3), 36700).
usuarios(saga(finalFantasy, 1), gameboy, 400).
usuarios(saga(finalFantasy, 2), gameboy, 220).
usuarios(superMario, xbox, 980).
usuarios(saga(finalFantasy, 3), gameboy, 70).
usuarios(saga(finalFantasy, 3), gameboyColor, 100).

empresa(sony, playstation(_)).
empresa(nintendo, xbox).
empresa(nintendo, xcube).
empresa(nintendo, gameboy).
empresa(lenovo, pc([windows,linux])).
empresa(microsoft, pc([windows])).
empresa(apple, pc([mac])).

portatil(psp).
portatil(gameboy).
portatil(gameboyColor).

%1
tienePlataformaQueSoporta(Empresa, Juego):-
	empresa(Empresa, Plataforma),
	soporta(Plataforma, Juego).
	
soporta(pc(SOs), Juego):- juego(Juego, pc(SistemasSoportados)),
	member(SOs, SistemaOperativo),
	member(SistemasSoportados, SistemaOperativo).
	
soporta(Consola, Juego):- juego(Juego, Consola), Consola \= pc(_).
	
%2
propietario(Empresa, Juego):-
	tienePlataformaQueSoporta(Empresa, Juego),
	not((tienePlataformaQueSoporta(Empresa2, Juego), Empresa \= Empresa2)).
	
%3
prefierenPortatiles(Juego):-
	juego(Juego, PlataformaNoPortatil),
	not(portatil(PlataformaNoPortatil)),
	forall(usuarios(Juego, Plataforma, _), portatil(Plataforma)).
	
%4
nivelFanatismo(Juego, NivelFanatismo):- 
	cantidadDeUsuarios(Juego, CantidadUsuarios),
	NivelFanatismo is CantidadUsuarios / 10000.	
	
cantidadDeUsuarios(Juego, CantidadUsuarios):- juego(Juego, _),
	findall(Usuarios, usuarios(Juego, _, Usuarios), Cantidades),
	sumlist(Cantidades, CantidadUsuarios).
	
%5
esPirateable(Juego):-
	juego(Juego, Plataforma),
	cantidadDeUsuarios(Juego, CantidadUsuarios),
	CantidadUsuarios > 5000,
	esHackeable(Plataforma).
	
esHackeable(psp).
esHackeable(pc(_)).
esHackeable(playstation(N)):- N < 3.
	
%6a
ultimoDeLaSaga(Titulo, saga(Titulo, N)):-
	juego(saga(Titulo, N), _),
	forall(juego(saga(Titulo, M), _), N >= M).

%6b	
buenaSaga(Titulo):- 
	ultimoDeLaSaga(Titulo, Ultimo),
	mantuvoPopularidad(Ultimo).
	
mantuvoPopularidad(saga(_, 1)).
mantuvoPopularidad(saga(Titulo, N)):-
	cantidadDeUsuarios(saga(Titulo, N), CantidadUsuarios),
	Anterior is N - 1, 
	cantidadDeUsuarios(saga(Titulo, Anterior), CantidadUsuariosAnterior),
	CantidadUsuariosAnterior < CantidadUsuarios * 2,
	mantuvoPopularidad(saga(Titulo,Anterior)).