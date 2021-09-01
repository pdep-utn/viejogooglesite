-- Enunciado: https://docs.google.com/document/d/1jQS2FZiANo_Qq-lJmgEd7SDBSJltbfxLGt0PJvxf1-E/edit

module Netflis where

-- Data del Enunciado

data Serie = UnaSerie {
    nombre :: String,
    genero :: String,
    duracion :: Int,
    cantTemporadas :: Int,
    calificaciones :: [Int],
    esOriginalDeNetflis :: Bool
} deriving (Eq, Show)

tioGolpetazo = UnaSerie {
    -- floja
    nombre = "One punch man",
    genero = "Monito chino",
    duracion = 24,
    cantTemporadas = 1,
    calificaciones = [5],
    esOriginalDeNetflis = False
}
 
cosasExtranias = UnaSerie {
    -- NO floja, 
    nombre = "Stranger things",
    genero = "Misterio",
    duracion = 50,
    cantTemporadas = 2,
    calificaciones = [3,3],
    esOriginalDeNetflis = True
}

dbs = UnaSerie {
    -- NO floja, 
    nombre = "Dragon ball supah",
    genero = "Monito chino",
    duracion = 150,
    cantTemporadas = 5,
    calificaciones = [],
    esOriginalDeNetflis = False
}

espejoNegro = UnaSerie {
    -- NO floja
    nombre = "Black mirror",
    genero = "Suspenso",
    duracion = 123,
    cantTemporadas = 4,
    calificaciones = [2],
    esOriginalDeNetflis = True
}

rompiendoMalo = UnaSerie {
    -- NO floja
    nombre = "Breaking Bad",
    genero = "Drama",
    duracion = 200,
    cantTemporadas = 5,
    calificaciones = [],
    esOriginalDeNetflis = False
}

treceRazonesPorque = UnaSerie {
    -- floja
    nombre = "13 reasons why",
    genero = "Drama",
    duracion = 50,
    cantTemporadas = 1,
    calificaciones = [3,3,3],
    esOriginalDeNetflis = True
}

-- Series agregadas 

cerditoRosa = UnaSerie {
    -- NO floja, es popular, vale la pena
    nombre = "Peppa Pig",
    genero = "Infantil",
    duracion = 30,
    cantTemporadas = 12,
    calificaciones = [4,3,1],
    esOriginalDeNetflis = True
}
lucasJaula = UnaSerie {
    -- floja, es popular, no vale la pena
    nombre = "Luke Cage",
    genero = "Infantil",
    duracion = 30,
    cantTemporadas = 1,
    calificaciones = [4,3,1,2],
    esOriginalDeNetflis = True
}

-- Maratones de ejemplo

type Maraton = [Serie]

maratonTotal = [tioGolpetazo, cosasExtranias, dbs, espejoNegro, rompiendoMalo, treceRazonesPorque]
maratonGigante = [tioGolpetazo, cosasExtranias, dbs, espejoNegro, rompiendoMalo, treceRazonesPorque, cerditoRosa, lucasJaula]
maratonFloja = [treceRazonesPorque, tioGolpetazo, lucasJaula]

maratonDeMaratones = [maratonTotal, maratonGigante, maratonFloja]

-- PARTE 3: CRITICOS

data Critico = UnCritico {
    cualesCalificar :: (Serie -> Bool),
    comoCambiaCalificacion :: (Serie -> Serie)
}

criticar :: Critico -> Maraton -> Maraton
criticar (UnCritico cualesCalificar comoCambiaCalificacion) maraton = 
    map (evaluarSerie cualesCalificar comoCambiaCalificacion ) maraton

evaluarSerie :: (Serie -> Bool) -> (Serie -> Serie) -> Serie -> Serie
evaluarSerie criterio cambio serie  | criterio serie = cambio serie
                                    | otherwise = serie 

{-
Exquisito: Prefiere las series que valen la pena. 
Sustittuye todas sus calificaciones recibidas por un nueva lista con una única calificación,
que es el promedio de calificaciones más uno. 
-}

exquisito = UnCritico {
    cualesCalificar = valeLaPenaSerie,
    comoCambiaCalificacion = promedioMasUno
}

valeLaPenaSerie :: Serie -> Bool
valeLaPenaSerie serie = cantTemporadas serie > 1 && esPopular serie

esPopular :: Serie -> Bool
esPopular serie = cantidadCalificaciones serie >= 3

cantidadCalificaciones :: Serie -> Int
cantidadCalificaciones serie = length (calificaciones serie)

promedioMasUno :: Serie -> Serie
promedioMasUno serie = serie { calificaciones = [calificacionNoMayorA5 ( (calificacion serie) + 1) ] }

calificacionNoMayorA5 :: Int -> Int
calificacionNoMayorA5 calificacion = min calificacion 5

calificacion :: Serie -> Int
calificacion serie | null (calificaciones serie) = 0
                   | otherwise = div (sum (calificaciones serie)) (cantidadCalificaciones serie)

-- En la consola, lo usamos así:
-- Prelude> criticar exquisito maratonTotal 


{-
  D. Moleitor: Se especializa en series flojitas, 
  elimina todas sus calificaciones mayores a 3,
  si hubiera alguna, y agrega una calificacion 1 al final. 
-}


dmoleitor = UnCritico {
    cualesCalificar = serieFloja, 
    comoCambiaCalificacion = demoler
}

serieFloja :: Serie -> Bool
serieFloja serie = ((==1).cantTemporadas) serie

demoler :: Serie -> Serie
demoler = (agregarUnoAlFinal.eliminarCalificacionesAltas) 

eliminarCalificacionesAltas :: Serie -> Serie
eliminarCalificacionesAltas serie = serie { calificaciones = filter (<3) (calificaciones serie) }

agregarUnoAlFinal :: Serie -> Serie
agregarUnoAlFinal serie = calificar 1 serie

calificar:: Int -> Serie -> Serie
calificar calificacion serie  = serie { calificaciones = (calificaciones serie) ++ [calificacion] }

-- En la consola, lo usamos así:
-- Prelude> criticar dmoleitor maratonTotal 


{-
    Hypeador: A todas las series que se pueden hypear, 
    las hypea (como se explicó anteriormente).
-}

hypeador = UnCritico {
    comoCambiaCalificacion = hypear,
    cualesCalificar = esHypeable
}

esHypeable :: Serie -> Bool
esHypeable = not.(elem 1).calificaciones

hypear :: Serie -> Serie
hypear serie = serie { calificaciones = (hypearFinal .hypearInicio) (calificaciones serie) }

hypearFinal :: [Int] -> [Int]
hypearFinal calificaciones = init calificaciones ++ [aumentarEnDos (last calificaciones)]

hypearInicio :: [Int] -> [Int]
hypearInicio calificaciones = (aumentarEnDos (head calificaciones)) : tail calificaciones

aumentarEnDos :: Int -> Int
aumentarEnDos calificacion = calificacionNoMayorA5 (calificacion + 2)

-- En la consola, lo usamos así:
-- Prelude> criticar hypeador maratonTotal 