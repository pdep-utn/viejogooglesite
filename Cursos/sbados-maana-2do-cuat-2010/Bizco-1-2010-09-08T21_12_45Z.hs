-- información básica
recetaTradicional = (20, 20, 20, 20, 2)
recetaPromo = (10, 10, 10, 2, 5)

-- PUNTO 1
-- Funciones auxiliares
harina (h, _, _, _, _) = h
azucar (_, a, _, _, _) = a 
leche (_, _, l, _, _) = l
aceite (_, _, _, a, _) = a
huevos (_, _, _, _, h) = h

nombre (n, _, _, _) = n
receta (_, r, _, _) = r
cantidad (_, _, c, _) = c
cancelada (_, _, _, c) = c

-- PUNTO 2
vaASalirBien receta = noAceitoso receta && cantidadJustaDeHuevos receta && esProporcional receta

noAceitoso = (<= 30) . aceite
cantidadJustaDeHuevos receta = (huevos receta * 10) == (harina receta)
cantidadJustaDeHuevos' (harina, _, _, _, huevos) = huevos * 10 == harina
esProporcional receta = ((even . leche) receta) && ((even . azucar) receta) && ((even . harina) receta)

-- PUNTO 3
ordenesNoCanceladas ordenes = [ orden | orden <- ordenes, (not . cancelada) orden ]

cantidadOrdenesNoCanceladas = length . ordenesNoCanceladas 

ordenesNoCanceladas' [] = []
ordenesNoCanceladas' (orden:ordenes) 
      | (not . cancelada) orden = orden: (ordenesNoCanceladas' ordenes)
      | otherwise               = ordenesNoCanceladas' ordenes


-- PUNTO 4
quienPidio ordenes = sinRepetidos [ nombre x | x <- ordenes]

sinRepetidos [] = []
sinRepetidos (x:xs)
     | elem x xs = sinRepetidos xs
     | otherwise = x:sinRepetidos xs

---------------------------------------------------------------
-- SEGUNDA ENTREGA
---------------------------------------------------------------
ordenPepe  = ("pepe",recetaTradicional,2,False)
ordenPepe2 = ("pepe",recetaPromo,20,True)
ordenPepe3 = ("pepe",(15,5,25,9,8),4,False)
ordenPepe4 = ("pepe",recetaPromo,3,False)
ordenRoque = ("roque",(0,1,1,2,3),5,True)

pepe = ("pepe",constante)
guille = ("guille",mucha)
roque = ("roque",(lineal 5))
laura = ("laura",(lineal 1))

ordenesPasteleria = [ordenPepe, ordenRoque, ordenPepe2, ordenPepe3, ordenPepe4]   

-- PUNTO 1
constante ordenes = 8

lineal cantidadHoras ordenes = cantidadHoras + ordenesBienHecho ordenes

mucha ordenes | cantidadDeTortas < 3 = 2
              | otherwise            = 3 * cantidadDeTortas
   where cantidadDeTortas = ordenesBienHecho ordenes
   
-- Si queremos que funcione segun ejemplo 
-- ordenesBienHecho = length    

-- Si lo queremos hacer bien
ordenesBienHecho = sum . map cantidad
-- ordenesBienHecho = foldl (\acum (_, _, cantidad, _) -> acum + cantidad) 0

-- PUNTO 2
ordenesPedidasPor persona ordenes = filter ((==) persona . nombre) ordenes

cuantoPuedoTardar (cliente, criterio) = (criterio . ordenesPedidasPor cliente) ordenesPasteleria

-- PUNTO 3
tienePocoTrabajo ordenes = (((< 10) . cantidadOrdenesNoCanceladas) ordenes) ||
                           (all (vaASalirBien . receta) ordenes)
                           
-- PUNTO 4
cuantoSeNecesita fnIngrediente = (sum . map (ingredienteParaReceta' fnIngrediente) . ordenesNoCanceladas) ordenesPasteleria

ingredienteParaReceta fnIngrediente (_, receta, cantidad, _) = fnIngrediente receta * cantidad
ingredienteParaReceta' fnIngrediente (_, receta, cantidad, _) = ((* cantidad) . fnIngrediente) receta

cuantoSeNecesita2 fnIngrediente = foldl (\acum bizcochuelo -> acum + ingredienteParaReceta' fnIngrediente bizcochuelo) 0 (ordenesNoCanceladas ordenesPasteleria)
