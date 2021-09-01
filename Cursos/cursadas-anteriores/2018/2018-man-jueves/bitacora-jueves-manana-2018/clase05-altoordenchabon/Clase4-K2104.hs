
-- // Orden Superior

--Ejercicios para que resuelvan en clase:

-- 1) Gandalf con su magia cura a los hobbits antes de salir a su expedición (aumenta la salud de cada uno según se indique).
-- 2) Queremos saber cuáles son los hobbits que pueden viajar a Mordor. Solo pueden hacerlo los que son de la comarca.
-- 3) El grupo de hobbits en cuestión, ¿está llevando el anillo único?
-- 4) Los hobbits deben estar saludables. Sabemos que para que estén saludables su salud tiene que ser mayor al nivel de amenaza, el cual ahora es 200.
-- 5) Queremos saber si un grupo es fuerte. Esto sucede cuando el promedio de sus fuerzas es un número impar.


-- Solucion posibles:

-- 1
aumentarSalud vida unHobbit = unHobbit {salud = salud unHobbit + vida}

wololo hobbits = map (aumentarSalud nivelDeAmenaza) hobbits


-- 2
puedenViajar hobbits = filter deLaComarca hobbits


-- 3
tieneElAnilloUnico hobbit = anilloUnico == anillo hobbit

tienenElAnilloUnico hobbits = any tieneElAnilloUnico hobbits


-- 4 
nivelDeAmenaza = 200

esAceptableSuSalud vidaMinima = (>vidaMinima).salud

estanSaludables hobbits = all (esAceptableSuSalud nivelDeAmenaza) hobbits


-- 5
fuerzas hobbits = map fuerza hobbits

promedioDeLasFuerzas hobbits = div ((sum.fuerzas) hobbits) (length hobbits)

esUnGrupoFuerte hobbits = odd (promedioDeLasFuerzas hobbits)



-- // Definiendo nuestras propias funciones de orden superior

----- inicio datas
data Nacion = UnaNacion{
capital :: String,
	poblacion :: Int,
	ejercito :: [Soldado]}
	deriving Show
	
data Soldado = UnSoldado{
tipo :: String,
	fuerza :: Int,
	armadura :: Bool}
	deriving Show
	
----- fin datas

-- constantes
sold = UnSoldado{tipo = "espadachin",fuerza=150,armadura = True}
explorador = UnSoldado{tipo = "espadachin",fuerza=170,armadura = False}
arq = UnSoldado{tipo = "arq",fuerza=100,armadura = False}
ejercitoBlanco = [sold, sold, sold, explorador, explorador, arq, arq, sold, arq]
gondor = UnaNacion{capital = "Gondor",poblacion=500,ejercito = ejercitoBlanco}

orco = UnSoldado{tipo = "lanzero", fuerza=25, armadura=True}
ejercitoRojo = replicate 100 orco

-- Funciones

faramir :: [Soldado] -> [Soldado]
faramir listaSoldados = map restarFuerza listaSoldados

gandalf :: [Soldado] -> [Soldado]
gandalf listaSoldados = map sumarFuerza listaSoldados

pippin :: [Soldado] -> [Soldado]
pippin listaSoldados = filter tieneArmadura listaSoldados


restarFuerza soldado = soldado{fuerza = (fuerza soldado) -2}
sumarFuerza soldado = soldado{fuerza = (fuerza soldado)+200}
tieneArmadura soldado = armadura soldado 

prepararEjercito unaNacion heroe =  heroe (ejercito unaNacion) 

-- Batalla con repeticion de logica
batalla :: Nacion -> [Soldado] -> ([Soldado] -> [Soldado]) -> String
batalla nacion ejercito heroe | sum (map fuerza ejercito) > sum (map fuerza (prepararEjercito nacion heroe)) = "CONQUISTADA"
                    | sum (map fuerza ejercito) == sum (map fuerza (prepararEjercito nacion heroe)) = "EMPATE"
					| otherwise = "GANA DEFENSOR"

-- Batalla Mejorada aplicando mas orden superior
batallaMejorada :: Nacion -> [Soldado] -> ([Soldado] -> [Soldado]) -> String
batallaMejorada nacion ejercito heroe | fuerzaTotal ejercito sum > fuerzaTotal (prepararEjercito nacion heroe) poderDeLosBuenos = "CONQUISTADA" 
 | fuerzaTotal ejercito sum == fuerzaTotal (prepararEjercito nacion heroe) poderDeLosBuenos = "EMPATE" 
 | otherwise = "GANA DEFENSOR"

fuerzaTotal ejercito f = f (map fuerza ejercito)
poderDeLosBuenos lista = sum (map (2*) lista)
valorEjercito ejercito funcion = funcion (map fuerza ejercito)