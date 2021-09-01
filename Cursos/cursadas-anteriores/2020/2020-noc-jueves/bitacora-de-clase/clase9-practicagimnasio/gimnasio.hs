module Lib where

----------------------------------------------------------------------------------------------------------------------------
-- TIPOS DE DATO
----------------------------------------------------------------------------------------------------------------------------

type Peso = Int
type Tiempo = Int
type Grados = Int

data Gimnasta = Gimnasta {
    peso :: Int,
    tonificacion :: Int
} deriving(Eq, Show)

data Rutina = Rutina {
  nombre :: String,
  duracionTotal :: Tiempo,
  ejercicios :: [Ejercicio]
}
   
----------------------------------------------------------------------------------------------------------------------------
-- EJERCICIOS
----------------------------------------------------------------------------------------------------------------------------

-- 1
-- Modelar a los Gimnastas y las operaciones necesarias para hacerlos ganar tonificación y quemar
-- calorías considerando que por cada 500 calorías quemadas se baja 1 kg de peso.

tonificar :: Int -> Gimnasta -> Gimnasta
tonificar n gimnasta = gimnasta{ tonificacion = tonificacion gimnasta + n }

quemarCalorias :: Int -> Gimnasta -> Gimnasta
quemarCalorias kcal gimnasta  = gimnasta{peso = peso gimnasta - kcal `div` 500}
      
-- 2

type Ejercicio = Tiempo -> Gimnasta -> Gimnasta

-- 2.a
-- La cinta es una de las máquinas más populares entre los socios que quieren perder peso.
-- Los gimnastas simplemente corren sobre la cinta y queman calorías en función de la velocidad
-- promedio alcanzada (quemando 10 calorías por la velocidad promedio por minuto).

cinta :: Int -> Ejercicio
cinta velocidad tiempo = quemarCalorias (tiempo * velocidad * 10)

-- 2.a.i
-- La caminata es un ejercicio en cinta con velocidad constante de 5 km/h.

caminata :: Ejercicio
caminata = cinta 5

-- 2.a.ii
-- El pique arranca en 20 km/h y cada minuto incrementa la velocidad en 1 km/h, con lo cual la
-- velocidad promedio depende de los minutos de entrenamiento.

pique  :: Ejercicio
pique tiempo = cinta (tiempo `div` 2 + 20) tiempo

-- 2.b
-- Las pesas son el equipo preferido de los que no quieren perder peso, sino ganar musculatura.
-- Una sesión de levantamiento de pesas de más de 10 minutos hace que el gimnasta gane una
-- tonificación equivalente a los kilos levantados. Por otro lado, una sesión de menos de 10 minutos
-- es demasiado corta, y no causa ningún efecto en el gimnasta.

pesas :: Peso -> Ejercicio
pesas peso tiempo | tiempo > 10 = tonificar peso
                  | otherwise   = id
                  
-- 2.c
-- La colina es un ejercicio que consiste en ascender y descender sobre una superficie inclinada y
-- quema 2 calorías por minuto multiplicado por la inclinación con la que se haya montado la
-- superficie.

colina :: Grados -> Ejercicio
colina inclinacion tiempo = quemarCalorias (2 * tiempo * inclinacion)

-- Los gimnastas más experimentados suelen preferir otra versión de este ejercicio: la montaña, que
-- consiste en 2 colinas sucesivas (asignando a cada una la mitad del tiempo total), donde la segunda
-- colina se configura con una inclinación de 5 grados más que la inclinación de la primera. Además
-- de la pérdida de peso por las calorías quemadas en las colinas, la montaña incrementa en 3 unidades
-- la tonificación del gimnasta.

montaña :: Grados -> Ejercicio
montaña inclinacion tiempo = tonificar 3 . colina (inclinacion + 5) (tiempo `div` 2). colina inclinacion (tiempo `div` 2)

-- 3
-- Implementar una función realizarRutina, que dada una rutina y un gimnasta retorna el gimnasta
-- resultante de realizar todos los ejercicios de la rutina, repartiendo el tiempo total de la rutina
-- en partes iguales. Mostrar un ejemplo de uso con una rutina que incluya todos los ejercicios del
-- punto anterior.

tiempoParaEjercicio :: Rutina -> Tiempo
tiempoParaEjercicio rutina = (div (duracionTotal rutina) . length . ejercicios) rutina

realizarRutina :: Gimnasta -> Rutina -> Gimnasta
realizarRutina gimnastaInicial rutina =
    foldl (\gimnasta ejercicio -> ejercicio (tiempoParaEjercicio rutina) gimnasta) gimnastaInicial (ejercicios rutina)
    
ejemploPunto3 = realizarRutina (Gimnasta 90 0) (Rutina "Mi Rutina" 30 [caminata, pique, pesas 5, colina 30, montaña 30])

-- 4.a
-- ¿Qué cantidad de ejercicios tiene la rutina con más ejercicios?

mayorCantidadDeEjercicios :: [Rutina] -> Int
mayorCantidadDeEjercicios = maximum . map (length . ejercicios)



-- 4.b
-- ¿Cuáles son los nombres de las rutinas que hacen que un gimnasta dado gane tonificación?

nombresDeRutinasTonificantes :: Gimnasta -> [Rutina] -> [String]
nombresDeRutinasTonificantes gimnasta = map nombre . filter ( (> tonificacion gimnasta) . tonificacion . realizarRutina gimnasta)

-- 4.c
-- ¿Hay alguna rutina peligrosa para cierto gimnasta? Decimos que una rutina es peligrosa para
-- alguien si lo hace perder más de la mitad de su peso.
hayPeligrosas :: Gimnasta -> [Rutina] -> Bool
hayPeligrosas gimnasta = any ((< peso gimnasta `div` 2) . peso . (realizarRutina gimnasta))