autos = [("karl", "gtm066", 2000, "Volkswagen Gol"),
         ("achi", "fhu468", 2009, "Ford Focus"),
         ("mike", "rvm363", 1979, "Dodge 1500"), 
         ("pato", "edi807", 2004, "Ford Ka"),
         ("rodri", "dfy642", 2006, "Volkswagen Gol")]

precios = [(400, ["Volkswagen Gol", "Ford Focus"]),
           (560, ["Dodge 1500", "Ford Falcon", "Renault 4"]),
            (260, ["Ford Ka", "Suzuki Fun"])]

modelo (_, _, _, m) = m
cliente (c, _, _, _) = c
anio (_, _, a, _) = a
patente (_, p, _, _) = p

find criterio = head . filter criterio

-- 1a) Conocer el precio de un modelo
-- >precioDe "Volkswagen Gol" 
-- 400  
precioDe unModelo = (fst . find (elem unModelo . snd)) precios

-- 1b) 
-- cuantoLeCobroA "karl"

cuantoLeCobroA unCliente = (precioDe . modelo . find ((== unCliente) . cliente)) autos 

-- 2) Quien es el dueño del auto más viejo
quienEsElMasRaton = elMasRaton autos

elMasRaton [(cliente, _, _, _)] = cliente
elMasRaton (cliente1:cliente2:clientes) 
    = elMasRaton (masRaton cliente1 cliente2:clientes)

masRaton cliente1 cliente2 | anio cliente1 < anio cliente2 = cliente1
                           | otherwise                     = cliente2  

-- 3) a) Quienes cumplen un criterio
quienesCumplen unCriterio = (map patente . filter unCriterio) autos

-- Qué autos fueron patentados en el año 2000
-- quienesCumplen ((== 2000) . anio)

-- Qué autos pagan más de 500 $ mensuales de cochera 
-- quienesCumplen ((> 500) . cuantoLeCobroA . cliente)

-- Qué autos no son de “achi”
-- quienesCumplen (not . (== "achi") . cliente)
-- ["gtm066","rvm363","edi807","dfy642"]     

-- Qué autos tienen un dueño cuyo nombre es de más de 5 letras
-- quienesCumplen ((> 5) . length . cliente)

-- 4) Queremos saber cuánto recauda el garaje 
-- (para eso hay que saber cuánto le cobra a cada cliente)
recaudacionTotal = 
    sum [cuantoLeCobroA cliente | (cliente, _, _, _) <- autos ]

recaudacionTotal' = 
    foldl (\acum (cliente, _, _, _) -> acum + cuantoLeCobroA cliente)
          0 autos   

-- 5) Ahora nos interesa conocer la recaudación discriminando 
-- por modelo
recaudacionPorModelo = 
  [(modelo, totalModelo modelo autos) | modelo <- (sinRepetidos . map modelo) autos ]

totalModelo unModelo autos = sum [ cuantoLeCobroA cliente | (cliente, _, _, modelo) <- autos, unModelo == modelo ]

sinRepetidos [] = []
sinRepetidos (x:xs) | elem x xs = sinRepetidos xs
                    | otherwise = x:sinRepetidos xs

-- 6) Definir una función que permita determinar si todos los 
-- clientes que le paso como parámetro tienen 0 km (el auto tiene
-- que ser modelo 2010)
todosSon0Km autosAVerificar = 
    all (\auto -> ((== 2010) . anio) auto) autosAVerificar

-- 7) Definir el tipo de la siguiente función
funcionHeavy a b c d | length a > c b = d
                     | otherwise      = 0

-- esperado que contesten
-- funcionHeavy :: [a] -> b -> (b -> Int) -> Int -> Int
-- si ponen Num en lugar de Int se considera ok
-- lo que dice Haskell
-- funcionHeavy :: Num a => [b] -> c -> (c -> Int) -> a -> a