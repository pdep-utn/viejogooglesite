ganoOscar(starWarsIV).
ganoOscar(indianaJonesI).
ganoOscar(elPadrino).
ganoOscar(laListaDeSchindler).

laDirigio(georgeLucas,indianaJonesI).
laDirigio(georgeLucas,starWarsII).
laDirigio(georgeLucas,starWarsIII).

laDirigio(stevenSpielberg,laListaDeSchindler).
laDirigio(quentinTarantino,perrosDeLaCalle).
laDirigio(quentinTarantino,pulpFiction).
laDirigio(quentinTarantino,killBill).
laDirigio(quentinTarantino,killBill2).
laDirigio(quentinTarantino,bastardosSinGloria).
laDirigio(quentinTarantino,djangoSinCadenas).
laDirigio(francisCoppola,elPadrino).

continuacion(starWarsII,starWarsIII).
continuacion(killBill,killBill2).

actua(brad,bastardosSinGloria).
actua(harrison,indianaJonesI).
actua(liam,starWarsII).
actua(natalie,starWarsII).
actua(ewan,starWarsII).
actua(liam,starWarsIII).
actua(natalie,starWarsIII).
actua(ewan,starWarsIII).
actua(marlon,elPadrino).
actua(al,elPadrino).
actua(quentin,perrosDeLaCalle).
actua(michael,perrosDeLaCalle).
actua(quentin,pulpFiction).
actua(bruce,pulpFiction).
actua(uma,pulpFiction).
actua(uma,killBill).
actua(uma,killBill2).

laLevantaEnPala(UnDirector):- 	
	esDirector(UnDirector),
	forall(laDirigio(UnDirector,Peli),ganoOscar(Peli)).	
				
elCrack(UnDirector):- laDirigio(UnDirector,_),
					  forall(ganoOscar(UnaPeli),laDirigio(UnDirector,UnaPeli)).

preferidoDe(UnActor,UnDirector):-
	esDirector(UnDirector),
	esActor(UnActor),
	forall(laDirigio(UnDirector,UnaPeli),actua(UnActor,UnaPeli)).

esDirector(UnDirector):-laDirigio(UnDirector,_).
esActor(UnActor):-actua(UnActor,_).

medioPelo(UnActor):- 
	esActor(UnActor),
	not((actua(UnActor,UnaPeli), not(peliFloja(UnaPeli)))).
					
peliFloja(UnaPeli):-not(ganoOscar(UnaPeli)).
peliFloja(UnaPeli):-continuacion(_,UnaPeli).					

toBeContinued(UnaPeli):-
						ganoOscar(UnaPeli),
						not(continuacion(UnaPeli,_)).
						
tieneProblemitas(UnDirector):-
			esDirector(UnDirector),
			UnDirector\=stevenSpielberg.
			
formato(indianaJonesI,vhs(1981)).
formato(indianaJonesI,torrent(pirateBay,2000)).
formato(starWarsII,torrent(isoHunt,200)).
formato(starWarsII,torrent(pirateBay,500)).
formato(starWarsII,dvd(60,fecha(2002,10,04))).
formato(starWarsIII,dvd(10,fecha(2004,10,04))).
formato(pulpFiction,vhs(1992)).
formato(pulpFiction,dvd(100,fecha(2010,10,04))).
formato(pulpFiction,torrent(pirateBay,2500)).

% esto es valido: estaAntes(UnaFecha,OtraFecha)
estaAntes(fecha(A1,M1,D1),fecha(A2,M2,D2)):-
	A1 < A2.
estaAntes(fecha(A,M1,D1),fecha(A,M2,D2)):-
	M1 < M2.
estaAntes(fecha(A,M,D1),fecha(A,M,D2)):-
	D1 < D2.






/*
estanBuenasSusPelis(UnDirector):-
	forall(laDirigio(UnDirector,UnaPeli),ganoOscar(UnaPeli)).

noSeCebaConLasExplosiones(UnDirector):- UnDirector \= michaelBay .

toBeContinued(UnaPelicula):-
	not(continuacion(UnaPelicula,_),
	ganoOscar(UnaPelicula).*/