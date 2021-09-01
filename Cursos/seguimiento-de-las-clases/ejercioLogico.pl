
tieneAuto(sofia).
tieneAuto(nicolas).

viveEn(sofia, almagro).
viveEn(mario, almagro).
viveEn(nicolas, caballito).
viveEn(julia, caballito).

sonVecinos(Persona1,Persona2):-
				viveEn(Persona1, Barrio), 
		        viveEn(Persona2, Barrio),
				Persona1 \= Persona2.
								
								
puedeAlcanzar(Persona1, Persona2):- 
					tieneAuto(Persona1),
					sonVecinos(Persona1, Persona2), 
					not(tieneAuto(Persona2)).

madre(mona, homero).
madre(mona, herbert).
madre(jaqueline, marge).
madre(marge, maggie).
madre(marge, bart).
madre(marge, lisa).
padre(homero, maggie).
padre(homero, bart).
padre(homero, lisa).	
padre(abraham, herbert).
padre(abraham, homero).				
					
hermano(Hermano1, OtroHermano):- 
					mismaMadre(Hermano1, OtroHermano), 
					mismoPadre(Hermano1, OtroHermano), 
					Hermano1 \= OtroHermano.
					

					
					
mismaMadre(Persona1, Persona2):- 
						madre(Madre, Persona1), 
						madre(Madre, Persona2), 
						Persona1 \= Persona2.

mismoPadre(Persona1, Persona2):-
						padre(Padre, Persona1),
						padre(Padre, Persona2),
						Persona1 \= Persona2.
						
medioHermano(Persona1,Persona2):-
				mismaMadre(Persona1, Persona2), 
				not(hermano(Persona1, Persona2)).
				

medioHermano(Persona1, Persona2):-
				mismoPadre(Persona1, Persona2), 
				not(hermano(Persona1, Persona2)).				


hijoUnico(Persona):- esHijo(Persona), 
				    not(medioHermano(Persona, _)),
					not(hermano(Persona, _)).
					
					
esHijo(Persona):- madre(_, Persona).
esHijo(Persona):- padre(_, Persona).

tio(Tio, Sobrino):-padre(Padre, Sobrino), 
				hermano(Padre, Tio).
tio(Tio, Sobrino):-madre(Madre, Sobrino), 
					hermano(Madre, Tio).

				



					
					
					
					