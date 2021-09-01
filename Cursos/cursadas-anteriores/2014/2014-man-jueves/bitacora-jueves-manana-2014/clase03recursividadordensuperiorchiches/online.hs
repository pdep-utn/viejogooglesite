factorial 0 = 1
factorial nro = nro * factorial (nro - 1)

longitud (_:cola) = 1 + longitud cola
longitud [] = 0

data PilaDeMetal = CPilaDeMetal Int Int deriving(Show)
data Canion = CCanion Int Int deriving(Show)
data Tanque= CTanque String Int Canion deriving(Show)

armarTanque:: String -> PilaDeMetal -> Canion -> Tanque
armarTanque nombre metal canion = CTanque nombre (blindaje metal)  canion

blindaje :: PilaDeMetal -> Int
blindaje metal = (cantidad metal) * (calidad metal)

cantidad (CPilaDeMetal cantidad _) = cantidad
calidad (CPilaDeMetal _ calidad) = calidad

armarEnSerie :: [PilaDeMetal] -> [Tanque]
armarEnSerie [] = []
armarEnSerie (unaPila : cola) = armarTiger unaPila : armarEnSerie cola

dobles [] = []
dobles (x:xs) = duplicar x : dobles xs

duplicar nro = nro * 2

armarTiger unaPila = armarTanque "Tiger" unaPila (CCanion 50 20) 

-- Utilizando Orden Superior
-- Orden Superior (en Haskell) como la capacidad de mandar por parámetro una función.
-- Corolario: Las funciones son DATOS en Haskell. (Así como lo son los enteros ó las listas).

armarEnSerie' :: [PilaDeMetal] -> [Tanque]
armarEnSerie' metales = map armarTiger metales

dobles' :: [Int] -> [Int]
dobles' numeros = map duplicar numeros

esGroso tanque = sublindaje tanque > 1000
sublindaje (CTanque _ b _ ) = b