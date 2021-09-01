object tom {
	var energia = 50
	
	var posicion = 30
	
	// var velocidad = 10 // ???? esto está bien ????? -> NO.
	 // Porque la velocidad DEPENDE de la energía.
	 // entonces, mejor que SE CALCULE EN EL MOMENTO.
	
	method podesAtraparA(unRaton) =  self.velocidad() > unRaton.velocidad()
	// self es un objeto? -> sssssi, puede ser.
	// tom y self qué son? objetos? ¿Cómo conocemos a los objetos?
	// self y tom son el mismo objeto.
	// self es una REFERENCIA
	// Reutilización. -> Disminución de código repetido -> + mantenible
	// el código no escala si repito.
	// abstracción? sí. Delegar también peeeero
	// Enfocarse más en el QUE que en el COMO = DECLARATIVIDAD
	// No me importa cómo se calcula, lo que quiero es MI velociddad (self velocidad)
	
	// UnRaton puede ser cualquier objeto!! 
	// -> pero DEBE entender el mensaje velocidad()
	//
	
	method velocidad() = 5 + (energia/10)
	
	method energia(cantidad) {
		energia = cantidad
	}
	
	method energia() = energia
	
	method correrA(unRaton){
		energia -= self.cantidadTiempoEnAlcanzarlo(unRaton)
		posicion = unRaton.posicion()
	}
	
	method cantidadTiempoEnAlcanzarlo(unRaton) {
		return 0.5 * self.velocidad()* self.distanciaA(unRaton)
	}
	
	method distanciaA(unRaton) = (posicion - unRaton.posicion()).abs()
	
	method posicion() = posicion
	
}

object robot {
	var posicion = 34
	
	method velocidad() = 8
	
	method posicion() = posicion
}


object jerry {
	var peso = 4
	var posicion = 36
	
	method velocidad() = 10 - peso
	
	method posicion() = posicion
}

object avion {
	method velocidad() = true
}

object peugeot504 {
	method velocidad(algo) = algo + 10
}



object superraton {
	var altura = 0.5
	method velocidad() = 1 / altura
	method altura(alt) {
		altura = alt
	}
}

// jerry y robot y superraton COMPARTEN UNA INTERFAZ
// en otras palabras, ambos entienden el mensaje velocidad()
// No importa cómo esté hecho (no sé cuál es el método)

// El avión NO comparte una interfaz con jerry y el robot
// Porque no sólo importa el nombre del método, sino también el retorno
// El peugeot504 NO comparte una interfaz con jerry y el robot.

// ¿Por qué me importa que compartan interfaz?
// para la felicidad de tom, que los USA INDISTINTAMENTE

// HAY POLIMORFISMO cuando:
// Hay un objeto (tom) que trata indistintamente a otros (los ratones)
