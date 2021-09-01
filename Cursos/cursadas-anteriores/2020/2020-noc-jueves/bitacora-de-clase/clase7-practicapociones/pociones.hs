module Lib where

----------------------------------------------------------------------------------------------------------------------------
-- ESTRUCTURAS
----------------------------------------------------------------------------------------------------------------------------

data Persona = Persona {
   nombrePersona :: String,
   suerte :: Int,
   inteligencia :: Int,
   fuerza :: Int
} deriving (Show, Eq)

data Pocion = Pocion {
   nombrePocion :: String,
   ingredientes :: [Ingrediente]
}

type Efecto = Persona -> Persona

data Ingrediente = Ingrediente {
   nombreIngrediente :: String,
   efectos :: [Efecto]
}

----------------------------------------------------------------------------------------------------------------------------
-- CÓDIGO BASE
----------------------------------------------------------------------------------------------------------------------------

nombresDeIngredientesProhibidos = [
  "sangre de unicornio",
  "veneno de basilisco",
  "patas de cabra",
  "efedrina"]

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun _ [ x ] = x
maximoSegun  f ( x : y : xs)
   | f x > f y = maximoSegun f (x:xs)
   | otherwise = maximoSegun f (y:xs)
   
----------------------------------------------------------------------------------------------------------------------------
-- EJERCICIOS
----------------------------------------------------------------------------------------------------------------------------

-- 1 Definir sin repetir código.

niveles :: Persona -> [Int]
niveles persona = [suerte persona, inteligencia persona, fuerza persona]

-- 1.a
-- "sumaDeNiveles" que suma todos sus niveles.

sumaDeNiveles :: Persona -> Int
sumaDeNiveles persona = suerte persona + inteligencia persona + fuerza persona

sumaDeNiveles' = sum . niveles

-- 1.b
-- "diferenciaDeNiveles" es la diferencia entre el nivel más alto y más bajo.

diferenciaDeNiveles :: Persona -> Int
diferenciaDeNiveles persona = maximoNivel persona - minimoNivel persona
maximoNivel persona = suerte persona `max` inteligencia persona `max` fuerza persona
minimoNivel persona = suerte persona `min` inteligencia persona `min` fuerza persona

diferenciaDeNiveles' persona = maximoNivel' persona - minimoNivel' persona
maximoNivel' = maximum . niveles
minimoNivel' = minimum . niveles

-- 1.c
-- "nivelesMayoresA n", que indica la cantidad de niveles que están por encima del valor dado.

nivelesMayoresA :: Int -> Persona -> Int
nivelesMayoresA n = length . filter (>n) . niveles

-- 2
-- Definir la función "efectosDePocion" que dada una poción devuelve una lista con los efectos de
-- todos sus ingredientes.

efectosDePocion :: Pocion -> [Efecto]
efectosDePocion = concat . map efectos . ingredientes

-- 3.a
-- Los nombres de las pociones hardcore, que son las que tienen al menos 4 efectos.

pocionesHardcore :: [Pocion] -> [String]
pocionesHardcore = map nombrePocion . filter ((>=4) . length . efectosDePocion)

-- 3.b
-- La cantidad de pociones prohibidas, que son aquellas que tienen algún ingrediente cuyo nombre
-- figura en la lista de ingredientes prohibidos.

cantidadDePocionesProhibidas :: [Pocion] -> Int
cantidadDePocionesProhibidas =
    length . filter (any (flip elem nombresDeIngredientesProhibidos . nombreIngrediente) . ingredientes)

-- 3.c
-- Si son todas dulces, lo cual ocurre cuando todas las pociones de la lista tienen algún ingrediente
-- llamado “azúcar”.

todasDulces :: [Pocion] -> Bool
todasDulces = all ( any (("azucar" ==) . nombreIngrediente) . ingredientes)

-- 4
-- Definir la función "tomarPocion" que recibe una poción y una persona, y devuelve como quedaría la
-- persona después de tomar la poción. Cuando una persona toma una poción, se aplican todos los
-- efectos de esta última, en orden.

tomarPocion :: Pocion -> Persona -> Persona
tomarPocion pocion personaInicial =
    (foldl (\persona efecto -> efecto persona) personaInicial . efectosDePocion) pocion

-- 5
-- Definir la función "esAntidotoDe" que recibe dos pociones y una persona, y dice si tomar la segunda
-- poción revierte los cambios que se producen en la persona al tomar la primera.

esAntidoto :: Pocion -> Pocion -> Persona -> Bool
esAntidoto antidoto pocion persona = ((==persona) . tomarPocion antidoto . tomarPocion pocion) persona

-- 6
-- Definir la función personaMasAfectada que recibe una poción, una función cuantificadora (es decir,
-- una función que dada una persona retorna un número) y una lista de personas, y devuelve a la
-- persona de la lista que hace máxima el valor del cuantificador.
-- Mostrar un ejemplo de uso utilizando los cuantificadores definidos en el punto 1.

personaMasAfectada :: Pocion -> (Persona -> Int) -> [Persona] -> Persona
personaMasAfectada pocion criterio = maximoSegun (criterio . tomarPocion pocion)