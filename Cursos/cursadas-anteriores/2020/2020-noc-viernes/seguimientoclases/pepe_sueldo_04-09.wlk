/** First Wollok example */
object pepe {
	//method decimeTuSueldo // mal, porque siempre les estoy diciendo decime algo
	//method calcularSueldo //mal, porque siempre estoy calculando algo
	//method getSueldo // mal.
	
	// es un método de consulta, que no modifica.
	// ergo el nombre es un sustantivo
	// además, uso la sintaxis del =
	var categoria = gerente
	var tipoDeBono = nulo
	method sueldo() = self.neto() + tipoDeBono.valorDeBono(self)
	method categoria() = categoria
	method categoria(nuevaCategoria){
		categoria = nuevaCategoria
	}
	method neto() = categoria.neto()
	//
}

object gerente{
	var neto = 15000
	method neto()= neto
}

object cadete{
	var neto = 20000
	method neto()= neto
}

object nulo{
	method valorDeBono(empleado) = 0
}

object montoFijo{
	const monto = 800	
	method valorDeBono(empleado) = monto
}

object porcentaje{
	method valorDeBono(empleado) = empleado.neto() * 0.1
}



