type Persona = (Integer, Integer, Integer)
--		edad	peso 	coeficiente de tonificacion
pancho = (40,	120,	1)
andres = (22,	80,		6)

type Ejercicio = Integer -> Persona -> Persona

relax :: Ejercicio
relax minutos persona = persona

tonificacion (_, _, ct) = ct
peso (_, p, _) = p
edad (e, _, _) = e

--1
saludable persona = not (esObeso persona) && tonificacion persona > 5

saludable' persona = (not.esObeso) persona && ((> 5).tonificacion) persona 

--abstracción importante!
esObeso = (> 100).peso

--2
quemarCalorias:: Persona -> Integer -> Persona
quemarCalorias persona calorias
	|esObeso persona = bajarDePeso persona (calorias `div` 150)
	|calorias > 200 && edad persona > 30 = bajarDePeso persona 1
	|otherwise = bajarDePeso persona (calorias `div` fromIntegral (peso persona * edad persona))

--abstracción importante!
bajarDePeso :: Persona -> Integer -> Persona
bajarDePeso (edad, peso, tonificacion) cantidad = (edad, peso - cantidad, tonificacion)

--3

--abstracción importante!
cinta :: Integer -> Ejercicio
cinta velocidadPromedio tiempo persona = quemarCalorias persona (velocidadPromedio * tiempo)

caminata :: Ejercicio
caminata = cinta 5

entrenamientoEnCinta :: Ejercicio
entrenamientoEnCinta tiempo = cinta ((6 + (6+tiempo `div` 5)) `div` 2) tiempo

pesas :: Integer -> Ejercicio
pesas kilos tiempo persona
	| tiempo > 10 = tonificar (kilos `div` 10) persona
	| otherwise = persona
	
--abstracción importante!
tonificar :: Integer -> Persona -> Persona
tonificar cant (e, p, tonif) = (e, p, tonif + cant)

colina :: Integer -> Ejercicio
colina inclinacion tiempo persona = quemarCalorias persona (2*tiempo*inclinacion)

montaña :: Integer -> Ejercicio
montaña inclinacion tiempo = tonificar 1.colina (3+inclinacion) tiempoColina.colina inclinacion tiempoColina
	where tiempoColina = (tiempo `div` 2)

-- 4
type Rutina = (String, Integer, [Ejercicio])

realizarRutina :: Rutina -> Persona -> Persona
realizarRutina (_, tiempoTotal, ejercicios) persona = 
	hacerEjercicios (tiempoTotal `div` fromIntegral (length ejercicios)) persona ejercicios
	
-- diferentes versiones de la función auxiliar con recursividad y con fold
hacerEjercicios tiempo persona [] = persona
hacerEjercicios tiempo persona (e:es) 
	= e tiempo (hacerEjercicios tiempo persona es)

hacerEjercicios' tiempo	= foldl (ejercitar tiempo)
ejercitar tiempo persona ejercicio =  ejercicio tiempo persona 

hacerEjercicios'' tiempo = foldl (\per ej -> ej tiempo per)

nombre (n, _,_) = n
resumenDeRutina persona rutina = (nombre rutina, pesoPerdido, tonificacionGanada)
	where 
		pesoPerdido = delta peso rutina persona
		tonificacionGanada = delta tonificacion rutina persona
		
delta f rutina persona = abs(f (realizarRutina rutina persona) - f persona)	

-- 5
resumenDeLasQueLoHacenSaludable persona = map (resumenDeRutina persona).filter(saludable.flip realizarRutina persona)

