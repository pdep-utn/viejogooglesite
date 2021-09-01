import Text.Show.Functions

data Persona = Persona {
    nombrePersona :: String,
    suerte :: Int,
    convencimiento :: Int,
    fuerza :: Int
} deriving (Show, Ord, Eq)

data Pocion = Pocion {
    nombrePocion :: String,
    ingredientes :: [Ingrediente]
} deriving Show

type Efecto = Persona -> Persona

data Ingrediente = Ingrediente {
    nombreIngrediente :: String,
    efectos :: [Efecto]
} deriving Show

-- funciones

aplicar :: (Int -> Int) -> Efecto
aplicar f p = p { suerte = (f.suerte) p, convencimiento = (f.convencimiento) p, fuerza = (f.fuerza) p }

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs)
    | elem x xs = sinRepetidos xs
    | otherwise = x : sinRepetidos xs

maximoF :: Ord a => (b -> a) -> [b] -> b
maximoF _ [ x ] = x
maximoF  f ( x : y : xs)
    | f x > f y = maximoF f (x:xs)
    | otherwise = maximoF f (y:xs)

-- Tratar de que ellos planteen estas funciones

f1 :: Efecto
f1 p = p { suerte = ((+1).suerte) p, convencimiento = ((+2).convencimiento) p, fuerza = ((+3).fuerza) p }

f2 :: Int -> Efecto
f2 n = aplicar (max n)

f3 :: Efecto
f3 persona
    | suerte persona >= 8 = persona { fuerza = ((+5).fuerza) persona }
    | otherwise = persona { fuerza = fuerza persona - 3 }

-- Ejemplo de efecto que reciba un parametro para que se tenga que aplicar
-- parcialmente para ponerlos en un ingrediente

-- Algunos datos ejemplo para poder probar.

personas :: [Persona]
personas = [
        Persona "Harry" 11 5 4,
        Persona "Ron" 6 4 6,
        Persona "Hermione" 8 12 2,
        Persona "Draco" 7 9 6
    ]

misPociones :: [Pocion]
misPociones = [
        Pocion "Felix Felices" [
            Ingrediente "Escarabajos Machacados" [f1,f2 7],
            Ingrediente "Ojo de Tigre Sucio" [f3]
        ],
        Pocion "Multijugos" [
            Ingrediente "Cuerno de Bicornio en Polvo" [invertir, (\(Persona n s _ f) -> Persona n s f f],
            Ingrediente "Sanguijuela hormonal" [(aplicar (*2)), (\(Persona n s _ f) -> Persona n s s f]
        ],
        Pocion "Flores de Bach" [
            Ingrediente "Orquidea Salvaje" [f3],
            Ingrediente "Rosita" [f1] 
        ]
    ]

--1)

sumaNiveles :: Persona -> Int
sumaNiveles (Persona _ suerte convencimiento fuerza) = suerte+convencimiento+fuerza

diferenciaNiveles :: Persona -> Int
diferenciaNiveles (Persona _ s c f) = max (max s c) f - min (min s c) f

--2)

efectosDePocion :: Pocion -> [Efecto]
efectosDePocion = concat.map efectos.ingredientes

--3)

pocionesHeavies :: [Pocion] -> [String]
pocionesHeavies = map nombrePocion.filter ((>=4).length.efectosDePocion)

--4)

incluyeA :: Eq a => [a] -> [a] -> Bool
incluyeA [] _ = True
incluyeA (x:xs) ys = elem x ys && incluyeA xs ys

-- Cambio en el enunciado para sacar el tema de cantidades?

esPocionMagica :: Pocion -> Bool
esPocionMagica p = any (incluyeA "aeiou".nombreIngrediente) (ingredientes p) &&
                   all (even.length.efectos) (ingredientes p)

--5)

-- Aca convendría que el tipo se vea Pocion -> Efecto o Pocion -> Persona -> Persona?
-- el segundo hace que se vea mas facil la transformacion 🤔

tomarPocion :: Pocion -> Efecto
tomarPocion pocion persona = foldr ($) persona (efectosDePocion pocion)

-- Plantear esto: "Que pasaria si cambiasemos el orden de parametros? como se ve abajo"
tomarPocion' :: Persona -> Pocion -> Persona
tomarPocion' persona = foldr ($) persona . efectosDePocion

--6)

esAntidoto :: Pocion -> Pocion -> Persona -> Bool
esAntidoto veneno antidoto persona = (tomarPocion antidoto.tomarPocion veneno) persona == persona

--7)

personaMasAfectada :: Pocion -> (Persona -> Int) -> [Persona] -> Persona
personaMasAfectada pocion ponderacion = maximoF (ponderacion.tomarPocion pocion)