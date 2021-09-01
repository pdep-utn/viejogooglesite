mails = ("guillermoperronelopez@gmail.com","hernanperalta3@gmail.com")


data Hobbit = UnHobbit{
	nombre :: String,
	estatura :: Int,
	salud :: Int,
	fuerza :: Int,
	deLaComarca :: Bool,
	anillo :: Anillo
} 
		
instance Show Hobbit where
	show hobbit = "hobbit " ++ nombre hobbit

instance Show (a->b) where
	show f = "funcionnnn"

type Anillo = (Int, String)
peso = fst
inscripcion = snd

lihue = UnHobbit {
	nombre = "Lihue",
	estatura = 150,
	salud = 200,
	fuerza = 420,
	deLaComarca = False,
	anillo = anilloDelChacal
}

anilloDelChacal = (420, "Un anillo para unir a los chacales. Un anillo para atraerlos a todos, un Anillo para hacerlos bailar y chacalearlos en las tinieblas")

guille = UnHobbit {
	nombre = "Guille",
	estatura = 155,
	salud = 320,
	fuerza = 250,
	deLaComarca = False,
	anillo = anilloDelPizzero
}

anilloDelPizzero = (500, "Aquel que porte este anillo hara las pizzas mas ricas del mundo, pero con la maldicion de siempre tener que cocinarlas en todas las juntadas")

esposta = UnHobbit {
	nombre = "Franco",
	estatura = 999,
	salud = 999,
	fuerza = 999,
	deLaComarca = True,
	anillo = anilloDelPoderSupremoTodoPoderosoYReCopado
}

anilloDelPoderSupremoTodoPoderosoYReCopado = (9999999, "Anillo del poderoso ser supremo Esposta, cuenta la leyenda que si alguien que no sea el se lo pone muere al instante")

herni = UnHobbit {
	nombre = "Hernan",
	estatura = 160,
	salud = 300,
	fuerza = 300,
	deLaComarca = True,
	anillo = anilloDeLaRelajacion
}


anilloDeLaRelajacion = (0, "Anillo con el poder de relajarte aun despues de rendir 2 recus, el tp de operativos y 1 final en el mismo dia")


	
	
ayudantes = [guille,herni,lihue,esposta]

--Map

fuerzaDeAyudantes = map fuerza 

--Filter

ayudantesDeLaComarca = filter deLaComarca

pares  = filter even
--Any

algunoEsDeLAComarca hobbits = any deLaComarca ayudantes

anilloPesado anillo  = (peso anillo > 600)

anillosDeLosAyudantes = map anillo

algunAyudanteTieneUnAnilloPesado anillos = any anilloPesado anillos

--All
ayudanteSano ayudante = (salud ayudante > 100)

ayudanteFuerte ayudante = (fuerza ayudante > 777)

todosSonSanos ayudantes = all ayudanteSano ayudantes

todosSonFuertes ayudantes = all ayudanteFuerte ayudantes

--find

cualEsElAyudanteFuerte ayudantes = find ayudanteFuerte ayudantes

find condicion lista = head (filter condicion lista)