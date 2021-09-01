valor (x,_,_) = x
dificultad (_,x,_) = x
duracion (_,_,x) = x

sinRepetidos [] = []
sinRepetidos (x:xs) | elem x xs = sinRepetidos xs
			  | otherwise = x : sinRepetidos xs

contratos = [("Don Rosco", (400,5,12)),("Dr. Miedo", (1000,10,48)),("Don Rosco", (100,1,6)),("IBN", (60,5,48))]

empleados = [jose, arnold, hermanosCohen 3, tito, hermanosCohen 2]

--1
esCorto = (< 12).duracion
esFacil caracteristicas = dificultad caracteristicas * duracion caracteristicas < 340
pagaMasDe monto = (> monto).valor

--2
jose = pagaMasDe 200
arnold = not.esFacil
tito caracteristicas = esCorto caracteristicas && esFacil caracteristicas
hermanosCohen cantidad caracteristicas = dificultad caracteristicas < duracion caracteristicas && pagaMasDe (300*cantidad) caracteristicas

loQuiere (_,caracteristicas) empleado = empleado caracteristicas

--3a
-- con orden superior
podemosResolverlo contrato = any (loQuiere contrato)

--con recursividad y guardas (sólo por que se pide, podría reemplazarse por un ||)
podemosResolverlo' contrato [] = False
podemosResolverlo' contrato (empleado : empleados) = loQuiere contrato empleado || podemosResolverlo' contrato empleados
	
--otra con recursividad y guardas en vez de pattern matching (sólo por que se pide usar guardas :P)
podemosResolverlo'' contrato empleados
	| length empleados == 0 = False
	| otherwise = loQuiere contrato (head empleados) || podemosResolverlo'' contrato (tail empleados)
	
-- orden superior y reduccion
podemosResolverlo''' contrato = foldl (\bool emp -> bool || loQuiere contrato emp) False

--3b
-- composicion
pagoTotal empleados = sum.map (valor.caracteristicasContrato).filter (flip podemosResolverlo empleados)

-- listas por comprension
pagoTotal' empleados contratos = sum [ (valor.caracteristicasContrato) contrato | contrato <- contratos , podemosResolverlo contrato empleados]

--4
elHombreIndicado contrato empleado = (&& loQuiere contrato empleado).all (not.loQuiere contrato)
-- alternativa usando podemosResolverlo
elHombreIndicado' contrato empleado = (&& loQuiere contrato empleado).not.podemosResolverlo contrato

-- clientesQueCumplen::((Int,Int,Int)->Bool)->[(String,(Int,Int,Int))]->[String]
clientesQueCumplen criterio = sinRepetidos.map nombre.filter (criterio.caracteristicasContrato)
nombre = fst
caracteristicasContrato = snd

--5
-- nombres de los clientes tacaños
-- > clientesQueCumplen (not.pagaMasDe 100) contratos

-- nombres de los clientes con contratos que le interesan a arnold
-- > clientesQueCumplen arnold contratos

-- 6
funLoca t u v = foldr (\x y -> (x u, fst y : snd y)) (0, v) t

-- siendo foldr :: (a -> b -> b) -> b -> [a] -> b

-- funLoca :: tipo de t -> tipo de u -> tipo de v -> tipo de lo que retorna el foldr totalmente aplicado

-- tipo de t: Num b => [ a -> b ] 
-- es una lista (por ser el 3er parámetro del foldr), y los elementos de la lista son los valores que va a tomar x en la lambda
-- como x recibe un parámetro es una función, y su imagen tiene que ser un número porque tiene que ser del mismo tipo que el 0 que se usa en el valor inicial del foldr

-- tipo de u: a
-- es el parámetro de los elementos de t, no tiene ninguna otra restricción

-- tipo de v: [b]
-- se usa en el valor inicial del foldr, tiene que ser del mismo tipo que fst y : snd y, por ende es una lista
-- además como y en la primer iteración va a tomar el valor (0, v), la lista v tiene que tener elementos del mismo tipo que el 0 y que la imagen de x
-- ya que esos valores van a formar parte de la lista resultante si t suficientes elementos, por eso sus elementos son del tipo numérico b

-- tipo de lo que retorna el foldr : (b, [b])
-- es el mismo tipo que (0, v)

-- entonces el tipo de funLoca queda
-- Num b => [ a -> b ] -> a -> [b] -> (b, [b])