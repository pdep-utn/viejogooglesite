data Pais = UnPais {poblacion::Int,vaAlMundial::Bool,capital::String,provincias::[String]} deriving Show

arg = UnPais 45 True "CABA" ["San Juan","Santa Fe","Cordoba"]

chile = UnPais {poblacion=3,vaAlMundial=False,capital="Santiago",provincias=[]} 

nacimiento p = p {poblacion = poblacion p + 1}
nacimiento2 p = alterarPoblacion (+1) p


perderMundial p = p {poblacion = div (poblacion p) 2}
perderMundial2 p = alterarPoblacion (flip div 2) p 


inmigracion cant p = p {poblacion = poblacion p + cant}
inmigracion2 cant p = alterarPoblacion (+cant) p

explosionNuclear p = alterarPoblacion (\n->0) p


-- Logica en común:
alterarPoblacion funcion p = p {poblacion = funcion (poblacion p)}