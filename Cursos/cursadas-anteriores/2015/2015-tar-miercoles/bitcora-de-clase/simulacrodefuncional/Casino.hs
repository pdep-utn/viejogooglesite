data Persona = CPersona String Float Int [(String,Int)] deriving(Show)

nico = (CPersona "Nico" 100.0 30 [("amuleto", 3),("manos magicas",100)])
maiu = (CPersona "Maiu" 100.0 42 [("inteligencia",55), ("paciencia",50)])



--1
suerte (CPersona _ _ s _) = s

suerteTotal persona
	| tiene "amuleto" persona = valorDeFactor "amuleto" persona * suerte persona
	| otherwise = suerte persona

valorDeFactor factor (CPersona _ _ _ factores)
	| any esFactor factores = (snd.head.filter esFactor) factores
	| otherwise = 0
	where esFactor unFactor = fst unFactor == factor

tiene factor = (> 0).valorDeFactor factor

-- 2
data Juego = CJuego String (Float -> Float) [Persona -> Bool]

ruleta = CJuego "Ruleta" (*37) [(>80).suerteTotal]
maquinita jackpot = CJuego "Maquinita" (+ jackpot) [((>95).suerteTotal), tiene "paciencia"]

-- 3

puedeGanar persona = all (\cond -> cond persona).condicionesParaGanar
condicionesParaGanar (CJuego _ _ condiciones) = condiciones

--4.

--a. con funciones de orden superior, aplicación parcial y composición
totalQuePodriaGanar jugador apuesta = foldl dineroAGanar apuesta.filter (puedeGanar jugador)
dineroAGanar apuesta (CJuego _ cuantoGana _) = cuantoGana apuesta

--b. con recursividad
totalQuePodriaGanar' jugador apuesta [] = apuesta
totalQuePodriaGanar' jugador apuesta (j : js)
	| puedeGanar jugador j = totalQuePodriaGanar' jugador (dineroAGanar apuesta j) js
	| otherwise = totalQuePodriaGanar' jugador apuesta js

-- 5
vuelvenSinUnMango juegos = map nombre.filter (not.flip puedeGanarAlguno juegos)
puedeGanarAlguno jugador = any (puedeGanar jugador)

nombre (CPersona n _ _ _) = n

-- 6
apostar juego apuesta = jugar juego apuesta.gastar apuesta

jugar juego apuesta persona  
    | puedeGanar persona juego = gana juego apuesta persona
    | otherwise = persona

gana juego apuesta (CPersona nomb dine suerte fact) = (CPersona nomb (dine + (dineroAGanar apuesta juego)) suerte fact)

gastar apuesta (CPersona nomb din suerte fact) = (CPersona nomb (din - apuesta) suerte fact)

--6. Inferir la siguiente función
elCocoEstaEnLaCasa x y z = all ((>z).(+42)).foldl (\a (b,c) -> y c ++ b a) (snd x)

-- elCocoEstaEnLaCasa
--  :: (Num b, Ord b) =>
--     (a, [b]) -> (t -> [b]) -> b -> [([b] -> [b], t)] -> Bool