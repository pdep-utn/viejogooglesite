venderAlfajores:: Int->Int->Int
venderAlfajores cantidad precio=cantidad*precio
venderAlfajoresDescuento:: Int-> Int-> Int
venderAlfajoresDescuento cantidad precio= venderAlfajores cantidad (precio-2)

venderAlfajoresPorMayor:: Int-> Int-> Int
venderAlfajoresPorMayor cantidad precio= venderAlfajores cantidad precio -15


--Era vender por la longitud del discurso, y el 8 es el precio si recuerdo bien. No vimos fromIntegral, pero como que tengo que cambiar el int que devuelve la magia esta
venderAlfajoresPorDiscurso :: String -> Int
venderAlfajoresPorDiscurso saludo = venderAlfajores (length saludo) precioEstandar
precioEstandar = 8

--Esto era vender por discurso, y ahora vende paquete
venderAlfajoresPorDiscursoEmpaquetado :: String -> Int
venderAlfajoresPorDiscursoEmpaquetado = cantidadDeAlfajoresPorPaquete.venderAlfajoresPorDiscurso 
cantidadDeAlfajoresPorPaquete paquetes = paquetes*6

--Ahora el discurso tenia cierto exito.
cantidadVenta:: String->Float
cantidadVenta "aburrido" = 0.5
cantidadVenta "divertido" = 1

exitoDiscurso:: Int ->String
exitoDiscurso 128 = "divertido"
exitoDiscurso largo = "aburrido"

cantidadQueVende discurso cantidadDePersonas=  cantidadVenta  ((exitoDiscurso.length) discurso) * cantidadDePersonas

venderPorExitoDeDiscurso discurso cantidadDePersonas precio = venderAlfajores (round (cantidadQueVende discurso cantidadDePersonas)) precio

