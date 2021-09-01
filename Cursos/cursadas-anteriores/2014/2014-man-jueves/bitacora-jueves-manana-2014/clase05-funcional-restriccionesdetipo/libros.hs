libros = [("Fundacion" , "Isaac Asimov" ),("La comunidad del anillo" , "J. R. R. Tolkien" ),("Yo, Robot" , "Isaac Asimov" ),
			("The Killing Joke" , "Alan Moore"),("Las cronicas del Angel Gris" ,"Alejandro Dolina"),
			("Odisea del espacio" ,"Arthur C. Clarke" ),("Buenos Presagios" ,"Terry Pratchett & Neil Gaiman" ),
			("Sandman" , "Neil Gaiman")]
			
librosDelAutor autor lista=[ titulo | (titulo, unAutor) <- lista, autor == unAutor]


--Acuerdense de mejorarlo para que me aparezcan los autores de libros compartidos

tituloYAutor lista = [ titulo ++ " - " ++ autor | (titulo,autor)<-lista]

tituloYAutorConLambda lista = map (\(titulo,autor)-> titulo ++ " - " ++ autor) lista



sumaDeCadaTupla lista = map (\(a,b) -> a + b) lista

flanderizar palabras = map (\palabra -> init palabra ++ "irijillo" ) palabras

