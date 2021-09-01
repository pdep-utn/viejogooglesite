doble y = 2 * y

doble' y = y + y

cuadruple y = doble (doble y)

modulo x
	| x >= 0 = x
	| otherwise = -x

-- no es obligatorio, pero podemos explicitar el tipo de las funciones, en este caso sirve para
-- acotar el dominio a los enteros, ya que su definición es válida para cualquier tipo numérico
factorial :: Int -> Int
-- cuando es 0 sabemos que hay que retornar 1, podemos definirlo por pattern matching
factorial 0 = 1
-- cuando no es 0, sólo tenemos un resultado válido para los números positivos
-- al no dar una definición para los números menores a 0 estamos acotando el dominio de la función
factorial n
	| n > 0 = factorial (n-1) * n
	
-- Si hacemos la consulta
-- > factorial (-1)
-- Nos va a tirar un error que dice "Non-exhaustive patterns in function factorial", esto se debe a que no encontró una definición que pudiera usar para el valor recibido. Este es un error deseable, no es un bug de mi programa que tire un error si le paso un valor que no puede manejar.
	
----- definiendo tipos
-- un mazo no es más que una lista de cartas, lo definimos como un alias
type Mazo = [UnaCarta]
-- una carta es un tipo definido por nosotros y podemos construir una carta
-- usando el constructor Carta
data UnaCarta = Carta Int String deriving (Show, Eq)

-- podemos abrir el patrón de la carta por pattern matching usando el constructor
palo (Carta numero palo ) = palo

-- si preguntamos con :t de qué tipo es la función esBasto nos dice
-- esBasto :: UnaCarta -> Bool
-- puede inferir que recibe una carta porque palo recibe algo de ese tipo, no puede ser otra cosa
esBasto carta = "basto" == palo carta

-- Si sólo queremos que sea válido usar primerCarta con un mazo y no con cualquier lista, por ejemplo [1,2,3], podemos restringir el dominio de la función declarando el tipo explícitamente.
primerCarta :: Mazo -> UnaCarta
primerCarta (carta : _) = carta