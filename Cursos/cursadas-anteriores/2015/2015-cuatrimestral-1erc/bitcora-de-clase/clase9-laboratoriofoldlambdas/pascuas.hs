type Persona = (String, [Huevo])
type Huevo = (Int, [String])

nombre = fst
huevos = snd
ingredientes = snd
peso = fst

glotones = [ ("Gaston", 
    [ (200, ["chocolate blanco", "nutella", "cereal", 
    "chocolate amargo", "almendras"]), 
    (100, ["chocolate amargo", "m&ms"]) ] ), 
    ("Veronica", [ (200, ["chocolate blanco", "nutella", "almendras"]),
    (100, ["chocolate amargo", "m&ms"]), (150, ["chocolate", "almendras"]),
    (100, ["chocolate amargo", "m&ms"]) ] ), 
    ("Nacho", [ (200, ["chocolate blanco", "nutella", "almendras"]), 
    (100, ["chocolate amargo", "m&ms", "almendras", "dulce de leche", 
    "moritas"]), (150, ["chocolate", "almendras"]), 
    (100, ["chocolate amargo", "m&ms"]), (150, ["chocolate", "nutella"])] ),
    ("Lucas", [ (200, ["chocolate blanco", "nutella", "almendras"]), 
    (100, ["chocolate amargo", "m&ms"]), (150, ["chocolate", "almendras", 
    "m&ms", "chocolate blanco", "moritas"]), (150, ["chocolate blanco", 
    "dulce de leche"])] ) ]
	
nico = ("Nico", [(50, ["chocolate", "dulce de leche"])])

noTodosGlotones = nico : glotones

-- 1) seTomaronLasPascuasMuyEnSerio retorna los nombres de los dos primeros que comieron más de 3 huevos
seTomaronLasPascuasMuyEnSerio = take 2.map nombre.filter (comioMasDeNHuevos 3)

-- Hacemos esta función porque parece una abstracción útil
comioMasDeNHuevos n = (>n).length.huevos

-- También es válido invertir el take y el map
seTomaronLasPascuasMuyEnSerio' = map nombre.take 2.filter (comioMasDeNHuevos 3)

-- 2) todosGlotones retorna true si todas las personas comieron algún huevo que tuviera nutella o pesara más de 150 grs
todosGlotones = all (any (\h -> tieneIngrediente "nutella" h || ((>150).peso) h).huevos)
	
-- Nuevamente, esto lo abstraemos porque es algo representativo del dominio a diferencia de la lambda, que no es lógica fácilmente reutilizable
tieneIngrediente ing = elem ing.ingredientes

-- Otra forma de hacer todosGlotones usando pattern matching en la lambda
todosGlotones' = all (any (\(p, ings) -> elem "nutella" ings || p >150).huevos)