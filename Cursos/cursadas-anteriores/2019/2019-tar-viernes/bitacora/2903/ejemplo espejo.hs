espejoAgrandador algo otraCosa = 2 * algo + algo/2 - otraCosa

edadMinimaParaTrabajar = 18

esMayor edad = edad > edadMinimaParaTrabajar

tieneEdadLaboralActiva edad = edad > 18 && edad < 80

seJubila nombre edad = not (tieneEdadLaboralActiva edad) && nombre == "juan"

factorial 0 = 1
factorial nro = nro * factorial (nro - 1)

longitud [] = 0
longitud (primerElemento:unaListaConTodosLosDemas) = 1 + longitud unaListaConTodosLosDemas

moverArriba (0,'a') = (0, "agua")
moverArriba (0,columna) = (0, columna:"hundido")
moverArriba (x,y) = (x, "averiado")

