// ------------------------------------------------------------------------------------------------------------------
// PERSONAJES
// ------------------------------------------------------------------------------------------------------------------

class Personaje {
	const property fuerza = 100
	const property inteligencia = 100
	var property rol
	
	method potencialOfensivo() = 10 * fuerza + rol.potencialOfensivoExtra()

	method esGroso() = self.esInteligente() || rol.esGroso(self)
	
	method esInteligente()
}

class Humano inherits Personaje {
	override method esInteligente() = inteligencia > 50
}

class Orco inherits Personaje {
	override method potencialOfensivo() = super() * 1.1
	override method esInteligente() = false
}


// ------------------------------------------------------------------------------------------------------------------
// ROLES
// ------------------------------------------------------------------------------------------------------------------


object guerrero {
	method potencialOfensivoExtra() = 10
	
	method esGroso(personaje) = personaje.fuerza() > 50
}


object brujo {
	method potencialOfensivoExtra() = 0
	
	method esGroso(personaje) = true
}


class Cazador {
	var mascota
	
	method potencialOfensivoExtra() = mascota.potencialOfensivo()
	
	method esGroso(personaje) = mascota.esLongeva()
}


class Mascota {
	const fuerza
	const edad
	const tieneGarras
	
	method potencialOfensivo() = if (tieneGarras) fuerza * 2 else fuerza
	
	method esLongeva() = edad > 10
}

// ------------------------------------------------------------------------------------------------------------------
// ZONAS
// ------------------------------------------------------------------------------------------------------------------

class Ejercito {
	
	const property miembros = []
	
	method potencialOfensivo() = miembros.sum{ personaje => personaje.potencialOfensivo() }
	
	method invadir(zona) {
		if(zona.potencialDefensivo() < self.potencialOfensivo()) {
			zona.seOcupadaPor(self)
		}
	}
}


class Zona {
	var habitantes
	
	method potencialDefensivo() = habitantes.potencialOfensivo()
	method seOcupadaPor(ejercito) { habitantes = ejercito }
}

class Ciudad inherits Zona {
	override method potencialDefensivo() = super() + 300
}

class Aldea inherits Zona {
	const maxHabitantes = 50
	
	override method seOcupadaPor(ejercito) {
		if(ejercito.miembros().size() > maxHabitantes) {
			const nuevosHabitantes = ejercito.miembros().sortedBy{uno, otro =>
				uno.potencialOfensivo() > otro.potencialOfensivo()
			}.take(10)
			
			super(new Ejercito(miembros = nuevosHabitantes))
			
			ejercito.miembros().removeAll(nuevosHabitantes)
		} else super(ejercito)
	}
}




