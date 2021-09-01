// ------------------------------------------------------------------------------------------------------------------
// MODOS
// ------------------------------------------------------------------------------------------------------------------
object standard {

	method consumoDe(equipo) = equipo.consumoBase()

	method computoDe(equipo) = equipo.computoBase()

	method realizoComputo(equipo) {
	}

}

class Overclock {

	var usosRestantes

	override method initialize() {
		if (usosRestantes < 0) throw new DomainException(message="Los usos restantes deben ser >= 0")
	}

	method consumoDe(equipo) = equipo.consumoBase() * 2

	method computoDe(equipo) = equipo.computoBase() + equipo.computoExtraPorOverclock()

	method realizoComputo(equipo) {
		if (usosRestantes == 0) {
			equipo.estaQuemado(true)
			throw new DomainException(message="Equipo quemado!")
		}
		usosRestantes -= 1
	}

}

class AhorroDeEnergia {

	var computosRealizados = 0

	method consumoDe(equipo) = 200

	method computoDe(equipo) = equipo.consumo() / equipo.consumoBase() * equipo.computoBase()

	method periodicidadDeError() = 17

	method realizoComputo(equipo) {
		computosRealizados += 1
		if (computosRealizados % self.periodicidadDeError() == 0) throw new DomainException(message = "Corriendo monitor")
	}

}

class APruebaDeFallos inherits AhorroDeEnergia {

	override method computoDe(equipo) = super(equipo) / 2

	override method periodicidadDeError() = 100

}

// ------------------------------------------------------------------------------------------------------------------
// EQUIPOS
// ------------------------------------------------------------------------------------------------------------------
class Equipo {

	var property modo = standard
	var property estaQuemado = false

	method estaActivo() = !estaQuemado && self.computo() > 0

	method consumo() = modo.consumoDe(self)

	method computo() = modo.computoDe(self)

	method computar(problema) {
		if (problema.complejidad() > self.computo()) throw new DomainException(message="Capacidad excedida")
		modo.realizoComputo(self)
	}

	method consumoBase()

	method computoBase()

	method computoExtraPorOverclock()

}

class A105 inherits Equipo {

	override method consumoBase() = 300

	override method computoBase() = 600

	override method computoExtraPorOverclock() = self.computoBase() * 0.3

	override method computar(problema) {
		if (problema.complejidad() < 5) throw new DomainException(message="Error de fábrica")
		super(problema)
	}

}

class B2 inherits Equipo {

	const microsInstalados

	override method consumoBase() = 10 + 50 * microsInstalados

	override method computoBase() = 800.min(100 * microsInstalados)

	override method computoExtraPorOverclock() = microsInstalados * 20

}

class SuperComputadora {

	const equipos = []
	var totalDeComplejidadComputada = 0

	method equiposActivos() = equipos.filter{ equipo => equipo.estaActivo() }

	method estaActivo() = true

	method computo() = self.equiposActivos().sum{ equipo => equipo.computo() }

	method consumo() = self.equiposActivos().sum{ equipo => equipo.consumo() }

	method equipoActivoQueMas(criterio) = self.equiposActivos().max(criterio)

	method malConfigurada() = self.equipoActivoQueMas{ equipo => equipo.consumo() } != self.equipoActivoQueMas{ equipo => equipo.computo() }

	method computar(problema) {
		const subProblema = new Problema(complejidad = problema.complejidad() / self.equiposActivos().size())
		self.equiposActivos().forEach{ equipo => equipo.computar(subProblema)}
		totalDeComplejidadComputada += problema.complejidad()
	}

}

class Problema {

	const property complejidad

}

