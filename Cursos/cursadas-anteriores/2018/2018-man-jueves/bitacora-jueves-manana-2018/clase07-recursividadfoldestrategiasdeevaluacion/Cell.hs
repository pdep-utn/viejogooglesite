


data Androide = UnAndroide {
    poder :: Int,
    estado :: String
} deriving Show

data Absorbible = UnAbsorbible {
    fuerza :: Int,
    estadoAlSerAbsorbido :: String
} deriving Show

cell = UnAndroide{poder = 10, estado = "Debil"}

hernan = UnAbsorbible {fuerza = 1, estadoAlSerAbsorbido = "Imperfecto"}

a17 = UnAbsorbible {fuerza = 50, estadoAlSerAbsorbido = "Semi perfecto"}

a18 = UnAbsorbible {fuerza = 350, estadoAlSerAbsorbido = "Perfecto"}

pila = UnAbsorbible {fuerza = 2150, estadoAlSerAbsorbido = "DuraCell"}

absorber androide absorbible  | poder androide > fuerza absorbible = androide {poder= poder androide*6,estado =estadoAlSerAbsorbido absorbible}
							  | otherwise = androide {estado ="Bien pinche muerto"}
							   
absorbibles = [hernan,a17,a18,pila]



repetir x = x : repetir x

-- enumFrom
enumerarDesde n = n : enumerarDesde (n+1)




