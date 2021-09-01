transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160,d)).
transporte(maria, auto(500, fiat,2015)).
transporte(ana, auto(fiesta, ford, 2014)).
transporte(sofia, auto(uno,fiat, 2013)).
transporte(roberto, auto(qubo, fiat, 2015)).
transporte(carlos, auto(uno,98)).
manejaLento(manuel).
manejaLento(ana).

/* 1) Realizar las consultas que permita conocer quiénes son los que vienen en auto de marca fiat 

?- transporte(Persona,auto(_, fiat, _)).
		Persona = maria;
		Persona = roberto;
		Persona = sofia;
		
*/


/* Queremos conocer quienes viajan en auto,  se verifica si la persona viene caminando o viene en auto y maneja lento. */

viajanEnAuto(Persona):- transporte(Persona, auto(_,_,_)).
viajanEnAuto(Persona):- transporte(Persona, auto(_,_)).


/* 2) para conocer quienes tardan mucho */

tardaMucho(Persona):- transporte(Persona, camina).
tardaMucho(Persona):- manejaLento(Persona), viajanEnAuto(Persona).

/* ?-tardaMucho(Persona).
		Persona = juan;
		Persona = ana;
*/

/* Conocer las personas que tienen el mismo modelo de auto */
mismoModelo(Persona1, Persona2):- transporte(Persona1, Transporte1),  transporte(Persona2, Transporte2),
								modelo(Transporte1, Modelo), modelo(Transporte2, Modelo), 
								Persona1 \= Persona2.

modelo(auto(Mod, _, _), Mod).
modelo(auto(Mod, _), Mod).

/* ?-mismoModelo(Persona, OtraPersona).
		Persona = sofia,
		OtraPersona = carlos ;
		Persona = carlos,
		OtraPersona = sofia ;
*/


%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).


puedeIr(Persona, Lugar, Alojamiento):-puedeGastar(Persona, CantDias, Disponible), 
				lugar(Lugar,  Alojamiento),
				montoDiario(Alojamiento, MontoDia),
				meAlcanzaPara(MontoDia, CantDias, Disponible).
				
montoDiario(hotel(_, Estrellas, MontoDia), MontoDia):- Estrellas >3.
montoDiario(casa(garaje, Monto), Monto).
montoDiario(quinta(_, pileta, Monto), Monto).
montoDiario(carpa(Monto), Monto).

meAlcanzaPara(MontoDia, CantDias, Disponible):- Disponible >= (MontoDia * CantDias).

/* ?- puedeIr(Persona, Lugar, Alojamiento).
Persona = ana,
Lugar = marDelPlata,
Alojamiento = hotel(elViajante, 4, 1500) ;
Persona = ana,
Lugar = tandil,
Alojamiento = quinta(amanecer, pileta, 650) ;
Persona = ana,
Lugar = bariloche,
Alojamiento = carpa(80) ;
Persona = ana,
Lugar = rosario,
Alojamiento = casa(garaje, 400) ;
Persona = hernan,
Lugar = marDelPlata,
Alojamiento = hotel(elViajante, 4, 1500) ;
Persona = hernan,
*/







