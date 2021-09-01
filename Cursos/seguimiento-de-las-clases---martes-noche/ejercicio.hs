maximo :: Integer -> Integer -> Integer
maximo nro otroNum | nro >= otroNum = nro
                   | otherwise = otroNum
				   
--Sinónimo de tipo CoordenaX
type CoordenaX = Integer				   
				   
--Definimos un sinónimo de tipo PuntoEspacio usando tuplas		   
type PuntoEspacio = (Integer, Integer, Integer)

-- Definimos un sinónimo de tipo PuntoPlano usando tuplas
type PuntoPlano = (Integer, Integer)

{- Como PuntoEspacio es de distinto tipo que PuntoPlano, para conocer
la coordenada x necesitamos definir 2 funciones diferentes. 
Por eso definimos la función primeroPlano y la función primeroEspacio -}

primeroPlano (nro, _) = nro
primeroEspacio (nro, _,_) = nro

{- Peeero como queremos tener una única función y nos permita aplicarla tanto 
para puntos en el plano como puntos en el espacio. 
Para resolver este problema, necesitamos definir un tipo propio Point 
y además decirle como se construyen los puntos.

Es decir esto definimos 2 constructores..uno para contruir el punto en el plano y otro
para construir los puntos en el espacio. -}

data Point = PuntoPlano Integer Integer | PuntoEspacio Integer Integer Integer

{- Definimos una función primeroX que devuelve la coordenada x de un punto 
de plano o de un punto de espacio -}
  
primeroX :: Point -> CoordenaX
primeroX (PuntoPlano nro _) = nro
primeroX (PuntoEspacio nro _ _) = nro




 



