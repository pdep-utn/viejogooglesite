data Accesorio = UnAccesorio {
  tipoDeAccesorio:: String,
  puntosDeAccesorio :: Int,
  nombreDelAccesorio :: String} deriving Show

sumaDePuntajes [] = 0
sumaDePuntajes (accesorio:accesorios) = puntosDeAccesorio accesorio + sumaDePuntajes accesorios 

	
data Criatura = UnaCriatura {
  nombreDeCriatura :: String,
  accesorios :: [Accesorio]
} deriving Show

poder criatura = (sumaDePuntajes.accesorios) criatura

poder' (UnaCriatura _ accesorios) = sumaDePuntajes accesorios

agregarAccesorio :: Criatura -> Accesorio -> Criatura
agregarAccesorio criatura accesorio = UnaCriatura (nombreDeCriatura criatura) (accesorio : accesorios criatura)

-- datos de ejemplo para probar las funciones anteriores
muchosAccesorios = 
	[UnAccesorio "Amigable" 4 "Alas" ,
	UnAccesorio "Agresivo" 10 "garras"]
	
bicho = UnaCriatura "bicho" muchosAccesorios

