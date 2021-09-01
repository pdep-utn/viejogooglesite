data Androide = UnAndroide {
  fuerza :: Int,
  estado :: String
} deriving Show


data EntidadAbsorbible = UnaEntidadAbsorbible{
  poder :: Int,
  estadoAlSerAbsorbido :: String
} deriving Show


cell = UnAndroide{fuerza = 10, estado = "Debil"}

hernan = UnaEntidadAbsorbible {poder = 1, estadoAlSerAbsorbido = "Imperfecto"}

a17 = UnaEntidadAbsorbible {poder = 50, estadoAlSerAbsorbido = "Semi perfecto"}

a18 = UnaEntidadAbsorbible {poder = 350, estadoAlSerAbsorbido = "Perfecto"}

pila = UnaEntidadAbsorbible {poder = 2150, estadoAlSerAbsorbido = "DuraCell"}

absorbibles = [hernan,a17,a18,pila]

absorber:: Androide -> EntidadAbsorbible -> Androide
absorber androide absorbible 
  | fuerza androide > poder absorbible = androide { fuerza = fuerza androide*6,estado =estadoAlSerAbsorbido absorbible }
  | otherwise = androide {estado ="Bien pinche muerto"}

absorberATodos' :: Androide -> [EntidadAbsorbible] -> Androide
absorberATodos' androide [] = androide
absorberATodos' androide (x:xs) = 
  absorberATodos' (absorber androide x) xs

absorberATodos :: Androide -> [EntidadAbsorbible] -> Androide
absorberATodos androide entidades =
  foldl absorber androide entidades





todosLosPares = filter even [1..]