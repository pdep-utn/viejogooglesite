-- Inferimos los tipos de estas funciones:
f :: Int -> Int -> Bool
f x y = x `mod` 2 == y

g :: Int -> ([Int], a) -> [Int]
g a b = take a [1..10] ++ fst b

h :: Char -> Bool -> String -> String
h i j k
	| i < 'w' = "Ok"
	| j = k
	
-- TP:
-- Cada post se identifica como una tupla con el mensaje y el puntaje que recibió de la comunidad con la forma (mensaje, puntaje).
type Post = (String, Int)

-- De los usuarios sabemos sus años de antigüedad en el foro y los posts que hizo.
data TUsuario = Usuario Int [Post] deriving (Show, Eq)

-- Algunos ejemplos de usuarios serían:
jorge = Usuario 2 [("Hola gente", 2), ("Windows FTW", 5)]
analia = Usuario 1 postsDeAnalia
roman = Usuario 5 []

postsDeAnalia :: [Post]
postsDeAnalia = [("Podríamos hacerlo nosotros", 9), ("Aguante Linux!", 13), ("Y ahora Windows va a sacar una versión libre", 7), ("Para mi no es así", 1), ("Software libre para todos", 10)]

-- 1
avanzarUnAnio (Usuario antiguedad posts) = Usuario (antiguedad+1) posts

-- 2
puntosBase usuario = antiguedad usuario * cantidadDePosts usuario
antiguedad (Usuario ant _) = ant
posts (Usuario _ posts) = posts
cantidadDePosts usuario = length (posts usuario)

-- 3
nivel usuario
	| cantidadDePosts usuario < 5 = "newbie"
	| puntosBase usuario < 50 = "intermedio"
	| otherwise = "avanzado"
	
-- 4
puntosTotales [] = 0
puntosTotales (post : posts) = puntos post + puntosTotales posts

puntos post = snd post

--------- continuamos en clase

-- Hacer la función pasarUnAnio :: [TUsuario] -> [TUsuario]
pasarUnAnio [] = []
pasarUnAnio (persona : resto) = (avanzarUnAnio persona : pasarUnAnio resto)

-- Saber los mensajesPosteados :: TUsuario -> [String] por un usuario.
mensajesPosteados (Usuario _ posts) = mensajes posts

mensajes [] = []
mensajes (post : resto) = (mensaje post : mensajes resto)

mensaje post = fst post

-- abstraemos la función transformar :: (a -> b) -> [a] -> [b]:
transformar _ [] = []
transformar f (elemento : cola) = (f  elemento : transformar f cola)

-- La función transformar es tan útil que ya existe en Haskell, y se llama map
-- podemos volver a definir pasarUnAnio y mensajesPosteados de la siguiente forma usando map:

pasarUnAnio' personas = map avanzarUnAnio personas
mensajesPosteados' (Usuario _ posts) = map mensaje posts

-- Saber los usuariosGrosos :: [TUsuario] -> [TUsuario] que son los que tienen más de 15 puntos bases
-- en vez de plantearlo de forma recursiva como hicimos antes, sabiendo que lo que queremos hacer es filtar
-- la guía de lenguajes nos dice que ya existe algo para eso, es la función filter :: (a -> Bool) -> [a] -> [a]

usuariosGrosos usuarios = filter esGroso usuarios
esGroso usuario = puntosBase usuario > 15

-- Saber si el foro estaDeModa :: [TUsuario] -> Bool que se cumple cuando posee algún usuario del mismo es newbie.
-- existe una función llamada any de tipo (a->Bool) -> [a] -> Bool que nos puede servir para esto

esNewbie usuario = "newbie" == nivel usuario
estaDeModa usuarios = any esNewbie usuarios

-- así como existe la función any, existe all que tiene el mismo tipo pero valida que todos cumplan en vez de alguno