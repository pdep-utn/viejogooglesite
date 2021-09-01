-- Enunciado: https://docs.google.com/document/d/1jQS2FZiANo_Qq-lJmgEd7SDBSJltbfxLGt0PJvxf1-E/edit


import Text.Show.Functions 


data Serie = UnaSerie {
    nombre :: String,
    genero :: String,
    duracion :: Int,
    cantTemporadas :: Int,
    calificaciones :: [Int],
    esOriginalDeNetflis :: Bool
} deriving (Eq, Show)

tioGolpetazo = UnaSerie {
    nombre = "One punch man",
    genero = "Monito chino",
    duracion = 24,
    cantTemporadas = 1,
    calificaciones = [5],
    esOriginalDeNetflis = False
}
 
cosasExtranias = UnaSerie {
    nombre = "Stranger things",
    genero = "Misterio",
    duracion = 50,
    cantTemporadas = 2,
    calificaciones = [3,3],
    esOriginalDeNetflis = True
}

dbs = UnaSerie {
    nombre = "Dragon ball supah",
    genero = "Monito chino",
    duracion = 150,
    cantTemporadas = 5,
    calificaciones = [],
    esOriginalDeNetflis = False
}

espejoNegro = UnaSerie {
    nombre = "Black mirror",
    genero = "Suspenso",
    duracion = 123,
    cantTemporadas = 4,
    calificaciones = [2],
    esOriginalDeNetflis = True
}

rompiendoMalo = UnaSerie {
    nombre = "Breaking Bad",
    genero = "Drama",
    duracion = 200,
    cantTemporadas = 5,
    calificaciones = [],
    esOriginalDeNetflis = False
}

treceRazonesPorque = UnaSerie {
    nombre = "13 reasons why",
    genero = "Drama",
    duracion = 50,
    cantTemporadas = 1,
    calificaciones = [3,3,3],
    esOriginalDeNetflis = True
}

--Parte 1

maratonEjemplo = [tioGolpetazo, cosasExtranias, dbs, espejoNegro, rompiendoMalo, treceRazonesPorque ]

cantidadDeSeries maraton = length maraton

cantidadCalificaciones serie = length (calificaciones serie)

esPopular serie = cantidadCalificaciones serie >= 3

valeLaPenaSerie serie = cantTemporadas serie > 1 && esPopular serie

valeLaPenaMaraton maraton = valenLaPenaPrimeraYUltima maraton || contieneBreakingBad maraton

valenLaPenaPrimeraYUltima maraton =  valeLaPenaSerie (head maraton) && valeLaPenaSerie (last maraton)

contieneBreakingBad maraton = elem rompiendoMalo maraton

duracionDeLaPrimeraMitad maraton = div (length maraton) 2

primeraParte maraton = take (duracionDeLaPrimeraMitad  maraton) maraton

segundaParte maraton = drop (duracionDeLaPrimeraMitad  maraton) maraton

repuntaAlFinal maraton = (not.valeLaPenaMaraton.primeraParte) maraton && (valeLaPenaMaraton.segundaParte) maraton 

calificacion serie |null (calificaciones serie) = 0
                   |otherwise = div (sum (calificaciones serie)) (cantidadCalificaciones serie)

dispersionCalifiaciones serie = maximum (calificaciones serie) - minimum (calificaciones serie)

calificar serie calificacion = UnaSerie {calificaciones = calificaciones serie ++ [calificacion]}

--hypear serie

--Parte 2

seriesDeMonitosChinosEn maraton = filter esDeMonitosChinos maraton
esDeMonitosChinos serie = genero serie == "Monitos Chinos"


promedioSegun criterio maraton = div (sum(map criterio maraton)) (length maraton)

promedioDuracion::[Serie] -> Int
promedioDuracion maraton = promedioSegun duracion maraton

promedioCalificaciones maraton = promedioSegun calificacion maraton

promedioCalificacionMaraton maratones = promedioSegun promedioCalificaciones maratones

criticar critico serie | (preferencia critico) serie = (critica critico) serie
                       | otherwise = serie


data Critico = UnCritico {nombreCritico::String,preferencia::(Serie->Bool),critica::Critica} deriving Show
type Critica = Serie -> Serie

demoleitor = UnCritico "Demoleitor" esFlojita demoler 

esFlojita serie = cantTemporadas serie == 1

demoler::Critica
demoler serie = (agregarCalificacion1AlFinal.eliminarCalificacionesMayoresA3) serie

eliminarCalificacionesMayoresA3 serie = serie {calificaciones = filter (<= 3) (calificaciones serie)}

agregarCalificacion1AlFinal serie = serie {calificaciones = calificaciones serie ++ [1]}

hypeador = UnCritico "Hypeador" esHypeable criticaHypear

esHypeable serie =  not(elem  1 (calificaciones serie))

criticaHypear::Critica
criticaHypear serie = serie{calificaciones=[sumo2 (head (calificaciones serie))] ++ loDelMedio (calificaciones serie) ++ [sumo2 (last (calificaciones serie))]}
                    
sumo2 numero = min (numero + 2) 5  

loDelMedio calificaciones = (init.drop 1) calificaciones                






