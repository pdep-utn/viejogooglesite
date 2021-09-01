discotequers = [("fer", 500, 10, [("Coca cola", 1), ("Sprite Zero", 1)]),
          ("mati", 1670, 2000, [("Cerveza", 2)]),
          ("german", 40000, 200000, [("Grog XD", 25), ("Cerveza", 1)]), 
          ("flor", 5000, 15, [("Grapa", 1)])] 


bebidas = [("Coca cola", 0),
    ("Grog XD", 350),
    ("Sprite Zero", 0),
    ("Cerveza", 10),
    ("Grapa", 40)]

nombre (n, _, _, _) = n
levante (_, l, _, _) = l
aguante (_, _, a, _) = a	
tragos (_, _, _, t) = t

bebida = fst
graduacion = snd 

find criterio = head . filter criterio

-- 1
-- a
datosDe unNombre = find ((== unNombre) . nombre) discotequers

-- b
graduacionAlcoholica unTrago = graduacion . find ((== unTrago) . bebida) $ bebidas

-- el $ permite evitar esta otra definición
graduacionAlcoholica2 unTrago = (graduacion . find ((== unTrago) . bebida)) bebidas

-- c
alcoholEnSangreDe = sum . map (\(bebida, vasos) -> graduacionAlcoholica bebida * vasos) . tragos . datosDe  

-- o 
alcoholEnSangre2 unaPersona = sum [ graduacionAlcoholica bebida * vasos | (bebida, vasos) <- (tragos . datosDe) unaPersona ]

-- 2a
estaBorracho unNombre = alcoholEnSangreDe unNombre > ((aguante . datosDe) unNombre)

-- 2b
nivelLevanteReal unNombre | estaBorracho unNombre = nivelLevanteBase - alcoholEnSangre 
                          | otherwise             = nivelLevanteBase + alcoholEnSangre
           where nivelLevanteBase = ((levante . datosDe) unNombre)
                 alcoholEnSangre = alcoholEnSangreDe unNombre
-- 3a
quienEsMejor criterio nom1 nom2 | fn nom1 > fn nom2 = nom1
                                | otherwise         = nom2
           where fn = criterio . datosDe
    
-- 3b    
-- quienEsMejor (length . tragos) "fer" "mati"                                 
-- quienEsMejor (sum . map snd . tragos) "fer" "mati"
-- quienEsMejor (length . filter ((== 0) . graduacionAlcoholica . fst) . tragos) "fer" "mati"

-- 4
estaOrdenada criterio [_] = True
estaOrdenada criterio (persona1:persona2:personas) = criterio persona1 <= criterio persona2 
       && estaOrdenada criterio (persona2:personas)
       
-- 5a 
estaRoto unNombre = (> 1) . length . filter ((> 0) . graduacionAlcoholica . fst) . tragos . datosDe $ unNombre
-- o
estaRoto2 = (> 1) . length . filter ((> 0) . graduacionAlcoholica . fst) . tragos . datosDe 

-- 5b
estoEsUnDescontrol = all (estaRoto . nombre)

-- 6
-- funcionHeavy::Eq a => a -> [a] -> (a -> Bool) -> (a -> a) -> [a]
funcionHeavy w x y z | elem w x  = filter y x 
                     | otherwise = map z x

