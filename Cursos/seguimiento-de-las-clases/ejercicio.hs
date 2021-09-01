--Defininos Punto con un tipo propio, los constructores tienen argumentos
data Punto = PuntoPlano Float Float | PuntoEspacio Float Float Float

type Distancia = Float

-- Definimos la función distancia usando Pattern Matching
distancia :: Punto -> Punto -> Distancia
distancia (PuntoPlano x y) (PuntoPlano x2 y2) = sqrt((x2 - x)^2 + (y2 - y)^2)
distancia (PuntoEspacio x y z) (PuntoEspacio x2 y2 z2) = sqrt((x2 - x)^2 + (y2 - y)^2 + (z2 - z)^2) 

siguiente :: Integer -> Integer
siguiente nro = nro + 1

suma :: Integer -> Integer -> Integer
suma nro otroNum = nro + otroNum

or' :: Bool -> Bool -> Bool
or' elem otroElem | elem = True
                  | otherwise = otroElem

{- Defininos días de la semana con un tipo propio, en este caso los constructores 
no tienen argumentos -}
data DiasDeSemana = Lunes| Martes | Miercoles | Jueves | Viernes | Sabado | Domingo

or'' :: Bool -> Bool -> Bool
or'' True _ = True
or'' _ elem = elem

and' :: Bool -> Bool -> Bool
and' False _ = False
and' True elem = elem




