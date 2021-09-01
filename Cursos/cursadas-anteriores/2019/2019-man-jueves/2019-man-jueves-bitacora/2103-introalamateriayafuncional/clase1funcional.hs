dobleDe numero = 2 * numero

saludo = "Ohayou"

primero = head

primero' palabra = head palabra

areaDeUnCuadrado lado = lado * lado

siguenteDe numero = numero + 1


siguenteDeDobleDe numero = siguenteDe (dobleDe numero)

siguenteDeDobleDe' = siguenteDe . dobleDe

saludar unNombre = "Hola " ++ unNombre


nombreComplicado unNombre = esLargo (saludar unNombre)

esLargo :: String -> Bool
esLargo unSaludo = length unSaludo > 12


nombreComplicado' nombre = tamanioSaludo nombre > 12

tamanioSaludo = length . saludar


nombreComplicado'' :: String -> Bool
nombreComplicado'' = esLargo . saludar