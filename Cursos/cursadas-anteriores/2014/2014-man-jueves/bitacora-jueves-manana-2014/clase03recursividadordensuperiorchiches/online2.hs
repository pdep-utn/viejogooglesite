factorial 0 = 1
factorial nro = nro * factorial (nro - 1)

longitud (_:cola) = 1 + longitud cola
longitud [] = 0

data PilaDeMetal = CPilaDeMetal Int Int deriving(Show)
data Canion = CCanion Int Int deriving(Show)
data Tanque= CTanque String Int Canion deriving(Show)

armarTanque:: String -> Canion -> PilaDeMetal  -> Tanque
armarTanque nombre canion metal  = CTanque nombre (blindaje metal) canion

blindaje :: PilaDeMetal -> Int
blindaje metal = (cantidad metal) * (calidad metal)

cantidad (CPilaDeMetal cantidad _) = cantidad
calidad (CPilaDeMetal _ calidad) = calidad

danio (CCanion danio _) = danio
cantMuniciones (CCanion _ cant) = cant

canion (CTanque _ _ canion) = canion
--armarEnSerie :: [PilaDeMetal] -> [Tanque]
--armarEnSerie [] = []
--armarEnSerie (unaPila : cola) = armarTiger unaPila : armarEnSerie cola

--dobles [] = []
--dobles (x:xs) = duplicar x : dobles xs



-- Utilizando Orden Superior
-- Orden Superior (en Haskell) como la capacidad de mandar por parámetro una función.
-- Corolario: Las funciones son DATOS en Haskell. (Así como lo son los enteros ó las listas).

--armarEnSerie' :: [PilaDeMetal] -> [Tanque]
armarEnSerie' metales = map (armarTanque "Tiger" (CCanion 50 20)) metales

dobles' :: [Int] -> [Int]
dobles' numeros = map (2*) numeros




esGroso tanque = sublindaje tanque > 1000
sublindaje (CTanque _ b _ ) = b

-------------------------------
alemanes = ["Panzer", "Panzer2"]
esAleman tanque = elem (nombre tanque) alemanes
nombre (CTanque nombre _ _) = nombre
pierdeHP (CTanque nombre vidaHP (CCanion blindaje canion)) = (CTanque nombre (div (vidaHP*75)100) (CCanion blindaje canion)) 

inviernoRuso tanques = map pierdeHP (filter esAleman tanques)
----------------------------------
-- Aplicación Parcial
--duplicar  =  (* 2) -- sí es aplicación parcial
--esPar = even -- no es aplicación parcial


--armarTiger = armarTanque "Tiger" (CCanion 50 20) -- recibe una pila de metal
------------------------------------------------------
-- Composición de funciones
cantMunionesDelTanque tanque = (cantMuniciones.canion) tanque

-- en matemática se escribe así:
-- h(x) = fog(x)
-- h(34) = f (g(34))

-- lo que devuelva g es lo que recibe f
-- (la imagen de g debe ser el dominio de f).
-- lo que devuelve h es lo mismo que devuelve f
-- (la imagen de h es la misma que la imagen de f)
-- lo que recibe h es lo mismo que recibe g
-- (el dominio de h es el mismo que el dominio de g).

-- en haskell se escribe así:
-- h x = (f.g) x
-- h 34 = f (g 34)