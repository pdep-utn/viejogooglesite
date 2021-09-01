campeon(boca,2017).
campeon(lanus,2016).
puntos(boca,2017,59).
puntos(banfield,2017,54).
puntos(sanlorenzo,2017,52).
puntos(newells,2017,52).
puntos(boca,2016,30).
puntos(banfield,2016,40).
puntos(lanus,2016,50).
comproReferi(boca,2017).
comproReferi(lanus,2016).
jugador(benedeto,boca).


leFueMejor(E1,E2,T):- 
     puntos(E1,T,P1),
	 puntos(E2,T,P2),
	 P1 > P2.
	 
campeonPorAfano(E):-
	campeon(E,T),
	puntos(E,T,P1),
	puntos(_,T,P2),
	P1 > P2 * 1.5. 

campeonPorAfano(E):-
	campeon(E,T),
	comproReferi(E,T).
	
campeonPorAfano(river).

