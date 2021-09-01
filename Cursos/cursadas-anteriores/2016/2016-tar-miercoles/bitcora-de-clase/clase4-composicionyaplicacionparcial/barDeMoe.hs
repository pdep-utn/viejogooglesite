data Bebida = UnaBebida {
	temperatura::Int, 
	ingredientes::[Ingrediente]} deriving (Eq, Show)

data Ingrediente = UnIngrediente {
	nombre :: String,
	cantidad :: Int,
	cantidadAlcohol :: Int} deriving (Eq, Show)
	
-- función que abstraemos por encontrar lógica repetida en su versión inicial
sumatoriaSegun' bebida cuantificador = sum ( map cuantificador ( ingredientes bebida )) 
	
sumatoriaSegun::(Ingrediente -> Int) -> (Bebida->Int)	
-- así queda luego de usar composición y aplicación parcial, y ya que estamos, point-free
sumatoriaSegun cuantificador = sum . map cuantificador . ingredientes
	
cantidadTotal :: Bebida -> Int
cantidadTotal = sumatoriaSegun cantidad 

alcoholTotal :: Bebida -> Int
alcoholTotal = sumatoriaSegun cantidadAlcohol

graduacionAlcoholica :: Bebida -> Int
-- no se puede point-free, bebida se usa más de una vez
graduacionAlcoholica bebida = div (alcoholTotal bebida) (cantidadTotal bebida)

esAlcoholica::Bebida->Bool
esAlcoholica' bebida = graduacionAlcoholica bebida > 0
esAlcoholica = (>0).graduacionAlcoholica

-- salteamos un par por falta de tiempo (esFlambeado, esLight), pueden hacerlos ustedes :)

-- esto lo agregamos después, para enfatizar que hay un tipo común al que se puede llegar
-- con las funciones heladera, agregarHielos, ... les debo un mejor nombre
type TransformadorDeBebida = Bebida->Bebida

heladera::Int->TransformadorDeBebida
heladera nuevaTemperatura (UnaBebida temp ings) = UnaBebida nuevaTemperatura ings

--alternativa loca, recordando que los constructores son funciones, también podemos usar aplicación parcial y composición en la construcción de una bebida
heladera' nuevaTemperatura = UnaBebida nuevaTemperatura.ingredientes

agregarHielos::Int->TransformadorDeBebida
agregarHielos cantHielos (UnaBebida temp ings) = UnaBebida (temp-3*cantHielos) ings

agregar::Ingrediente->TransformadorDeBebida
agregar ingrediente (UnaBebida temp ings) = UnaBebida temp (ingrediente:ings)

rebajar::Int->TransformadorDeBebida
rebajar porcentaje bebida = agregar (UnIngrediente "agua" (div (porcentaje * cantidadTotal bebida) 100) 0) bebida

mezclar::Bebida->TransformadorDeBebida
mezclar (UnaBebida temp1 ings1) (UnaBebida temp2 ings2) = UnaBebida ((temp1+temp2) `div` 2) (ings1++ings2)

coctelear::[Bebida]->Bebida
coctelear bebidas = foldl1 mezclar bebidas
coctelear' = foldl1 mezclar

coctelearSelectivo::(Bebida->Bool)->[Bebida]->Bebida
coctelearSelectivo criterio = coctelear.filter criterio

septimioRegimientoMachine::[Bebida]->Bebida
septimioRegimientoMachine = agregarHielos 3 . coctelearSelectivo esAlcoholica

moe'sMachine::[Bebida]->Bebida
moe'sMachine = heladera 4 . rebajar 15 . coctelear

-- y la prueba como la que hicimos en la consola más allá de lo que se pedía
-- para demostrar que se puede armar y usar una lista de transformadores de bebida!
-- map (\ f -> f (UnaBebida 10 [UnIngrediente "agua" 5 0])) [rebajar 5, heladera 3, agregarHielos 7, mezclar (UnaBebida 4 [UnIngrediente "vodka" 5 30, UnIngrediente "fanta" 5 0])]
