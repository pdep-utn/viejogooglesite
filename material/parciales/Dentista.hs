pacientes = [("karl",(10,10,1993), "OSDE", ["Conducto", "Puente"]),
        ("achi",(18,11,1987), "Swiss med", []),
        ("mike",(12,04,1978), "OSDE", ["Limpieza"])] 

precios = 
   [("OSDE", "Conducto", 100), ("OSDE", "Puente", 50),
    ("OSDE", "Limpieza", 60), ("Swiss medical", "Conducto", 30), 
    ("Swiss med", "Puente", 50), ("Swiss med", "Limpieza",60)]

anio (_, _, a) = a

servicios (_, _, _, s) = s
paciente (p, _, _, _) = p	
obraSocial (_, _, os, _) = os
fechaNacimiento (_, f, _, _) = f

find criterio = head . filter criterio

-- PUNTO 1
-- a) Determinar los servicios / tratamientos que recibi� un paciente
-- >serviciosDe "karl" 
-- ["Conducto", "Puente"]
datosDe unPaciente = find ((==) unPaciente . paciente) pacientes


-- b) Conocer el monto de facturaci�n de un paciente,  o sea, 
-- lo que el dentista le factur� a la obra social por los servicios / tratamientos que le dio:
-- >montoFacturacionDe "karl" 
-- 150 (100 del conducto + 50 del puente seg�n paga OSDE)
-- Se cuenta con
cuantoCuesta obraSocial servicio ((obraSocial1, servicio1, costo):servicios) 
    | obraSocial == obraSocial1 && servicio == servicio1 = costo
    | otherwise = cuantoCuesta obraSocial servicio servicios

montoFacturacionDe = montoServicios . datosDe

montoServicios (_, _, obraSocial, servicios) = 
    foldl (\total servicio -> total + cuantoCuesta obraSocial servicio precios) 0 servicios
    
-- 2) Saber si la lista de pacientes est� ordenada en forma creciente por monto de facturaci�n:
pacientesOrdenadosPorFacturacion = estaOrdenado pacientes

estaOrdenado [_] = True
estaOrdenado (paciente1:paciente2:pacientes) = 
    (montoFacturacionDe . paciente) paciente1 < (montoFacturacionDe . paciente) paciente2 && estaOrdenado (paciente2:pacientes)

-- 3) a. Queremos saber cu�les son los pacientes que cumplen un determinado criterio. 
-- Desarrollar esa funci�n.    
quienesCumplen unCriterio = (map paciente . filter unCriterio) pacientes

-- Qu� pacientes nacieron en el a�o 1993
-- quienesCumplen ((== 1993) . anio . fechaNacimiento)  

-- Con qu� pacientes el dentista factur� m�s de 100 pesos
-- quienesCumplen ((> 100) . montoFacturacionDe . paciente)   

-- Qu� pacientes no tuvieron tratamiento/servicio
-- quienesCumplen ((== 0). length . servicios)

-- 4) Queremos conocer qui�n es mejor paciente
mejorPaciente paciente1 paciente2 criterio 
   | resultado paciente1 > resultado paciente2 = paciente1
   | otherwise                                 = paciente2
   where resultado = criterio . datosDe
   
-- mejorPaciente "karl" "achi" (montoFacturacionDe . paciente)    

-- 5) a) Definir cu�nto factur� el dentista a la fecha (considerar todos los
-- servicios practicados a los pacientes)
recaudacionTotal = sum [ montoFacturacionDe paciente | (paciente, _,_,_) <- pacientes ] 

-- 5) b) Agregar un par�metro que permita definir cu�nto factur� el dentista a pacientes 
-- que cumplan n criterios
recaudacionTotal' criterios =
    sum [ (montoFacturacionDe . paciente) unPaciente | unPaciente <- pacientes, all (\criterio -> criterio unPaciente) criterios ] 

-- 5) c)
-- recaudacionTotal' [((==) "OSDE" . obraSocial), ((> 1992) . anio . fechaNacimiento)]

-- 6) Determinar el tipo
funcionHeavy a b (c:cs) | a > c      = funcionHeavy a b cs
                        | otherwise  = b c
-- funcionHeavy::Ord a => a -> (a->b) -> [a] ->b 
