ejemplo = [("moto",2,"rojo"),("auto",6,"verde"),("avion",368,"blanco")]
ejemplo2 = [("moto",2,"rojo"),("auto",6,"verde"),("avion",368,"verde")]

preciosActuales = [("blanco",500),("verde",10),("rojo",100)]
pasajeros (_,p,_) = p
nombre (n,_,_) = n
color (_,_,c) = c


--1)
totalPasajeros vehiculos = sum (map pasajeros vehiculos)

totalPasajeros2 = sum.map pasajeros 


--2)


nombresVehiculosQuePuedenLlevar cantidad vehiculos = map nombre (vehiculosQuePuedenLlevar cantidad vehiculos) 

vehiculosQuePuedenLlevar cantidad vehiculos = filter (capacidadMayorQue cantidad)  vehiculos

capacidadMayorQue cantidad unVehiculo = pasajeros unVehiculo >= cantidad

--3)
cuantosVehiculosDeColor unColor = length.filter ((unColor==).color) 

--esDeColor unColor vehiculo = color vehiculo == unColor
esDeColor unColor = (== unColor).color

--4)
menorDesperdicio cantidad vehiculos = minimum (desperdicios cantidad vehiculos)

desperdicios cantidad vehiculos = map (desperdicio cantidad) (vehiculosQuePuedenLlevar cantidad vehiculos)

desperdicio cantidad vehiculo = pasajeros vehiculo - cantidad

--5)
cuantoCuestaLlevar cantidad vehiculos precios =  map (nombreYPrecio cantidad precios) (vehiculosQuePuedenLlevar cantidad vehiculos) 

nombreYPrecio cantidad precios vehiculo = (nombre vehiculo , (precioUnitario (color vehiculo) precios) * cantidad)

precioUnitario nombre precios = (precio.head.filter ((nombre==).descripcion)) precios

--descripcion (d, _) = d
descripcion = fst
precio = snd

--6)
ondaVerde vehiculos = map pintarDeVerde vehiculos

pintarDeVerde (nombre,capacidad,_) = (nombre,capacidad, "verde")

--7)
seguridadCero vehiculos = map aumentaCapacidad vehiculos

aumentaCapacidad ("moto",_,color) = ("moto", 5, color)
aumentaCapacidad ("avion",capacidad,color) = ("avion", capacidad + 100, color)
aumentaCapacidad ("auto",capacidad,color) = ("auto", capacidad *2, color)

