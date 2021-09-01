
maxima altura1 altura2 altura3 = max altura1 (max altura2 altura3)

-- Definici�n de maxima utilizando max con notaci�n prefija y notaci�n infija
maxima' altura1 altura2 altura3 =  altura1 `max` (max altura2 altura3)

-- Definici�n de maxima utilizando max con notaci�n infija
maxima'' altura1 altura2 altura3 =  altura1 `max` altura2 `max` altura3


capicua algo = algo == (reverse algo)

pesoPino altura | altura <= 300 = altura * 3
		| otherwise = (altura - 300) * 2 + 900

-- Funcion de orden superior
seleccion :: [Integer] -> (Integer -> Bool) -> [Integer]
seleccion numeros criterio = [ num | num <- numeros, criterio num]

-- Funcion de orden superior
transformar ::[a] -> (a -> b) -> [b]
transformar numeros criterio = [criterio num | num <- numeros]

-- La funci�n suma recibe los elementos de a uno por vez
suma nro1 nro2 nro3 = nro1 + nro2 + nro3

-- La funci�n suma' recibe los elementos en una tupla
suma' (nro1, nro2, nro3) = nro1 + nro2 + nro3