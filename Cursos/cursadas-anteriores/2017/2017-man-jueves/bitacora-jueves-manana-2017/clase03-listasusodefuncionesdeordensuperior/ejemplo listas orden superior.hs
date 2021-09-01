--Ejemplo Listas Orden Superior

data Persona = UnaPersona String Int String deriving Show

paisesNoInvitados = ["Estados Unidos","Iraq","Burkina Faso"]
gabriel = UnaPersona "gabi" 19 "Argentina"
jess = UnaPersona "jess" 23 "Argentina"
santiago = UnaPersona "santiago" 20 "Iraq"


sonTodosMayores familia = all ((>18).edad) familia
edad (UnaPersona _ edad _) = edad

quienesEntra familia paises =filter (condicionDeEntrada paises) familia
condicionDeEntrada paises (UnaPersona nombre edad pais) = edad>18 && nombre /= "gabi" && not (elem pais paises)
--condicionDeEntrada2 paises persona = esMayor persona && estaInvitado paises persona && noSeLlamaGabi persona
mudanzaFamiliar pais familia= map (mudanza pais) familia 
mudanza paisACambiar (UnaPersona nombre edad pais) = UnaPersona nombre edad paisACambiar
--mudanza2 (UnaPersona nombre edad pais) paisACambiar = paisACambiar

cantidadDeLetrasDeUnParrafo :: [String] -> Int
cantidadDeLetrasDeUnParrafo  = sum.map length
hayUnaPalabraLarga :: [String] -> Bool
hayUnaPalabraLarga parrafo = any ((>5).length) parrafo
hayUnaPalabraLarga2 :: [String] -> Bool
hayUnaPalabraLarga2  = any (>5) .(map length)
