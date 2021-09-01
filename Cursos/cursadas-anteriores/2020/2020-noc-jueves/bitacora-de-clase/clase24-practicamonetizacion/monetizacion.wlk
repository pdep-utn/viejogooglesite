// ------------------------------------------------------------------------------------------------------------------
// CONTENIDOS
// ------------------------------------------------------------------------------------------------------------------
class Contenido {

	const property titulo
	var property vistas = 0
	var property ofensivo = false
	var property monetizacion

	method monetizacion(nuevaMonetizacion) {
		if (!nuevaMonetizacion.puedeAplicarseA(self)) throw new DomainException(message="Este contenido no soporta la forma de monetización")
		monetizacion = nuevaMonetizacion
	}

	override method initialize() {
		if (!monetizacion.puedeAplicarseA(self)) throw new DomainException(message="Este contenido no soporta la forma de monetización")
	}

	method recaudacion() = monetizacion.recaudacionDe(self)

	method puedeVenderse() = self.esPopular()

	method esPopular()

	method recaudacionMaximaParaPublicidad()

	method puedeAlquilarse()

}

class Video inherits Contenido {

	override method esPopular() = vistas > 10000

	override method recaudacionMaximaParaPublicidad() = 10000

	override method puedeAlquilarse() = true

}

const tagsDeModa = [ "objetos", "pdep", "serPeladoHoy" ]

class Imagen inherits Contenido {

	const property tags = []

	override method esPopular() = tagsDeModa.all{ tag => tags.contains(tag) }

	override method recaudacionMaximaParaPublicidad() = 4000

	override method puedeAlquilarse() = false

}

// ------------------------------------------------------------------------------------------------------------------
// MONETIZACIONES
// ------------------------------------------------------------------------------------------------------------------
object publicidad {

	method recaudacionDe(contenido) = (
0.05 * contenido.vistas() + if(contenido.esPopular()) 2000 else 0
).min(contenido.recaudacionMaximaParaPublicidad())

	method puedeAplicarseA(contenido) = !contenido.ofensivo()

}

class Donacion {

	var property donaciones = 0

	method recaudacionDe(contenido) = donaciones

	method puedeAplicarseA(contenido) = true

}

class Descarga {

	const property precio

	method recaudacionDe(contenido) = contenido.vistas() * precio

	method puedeAplicarseA(contenido) = contenido.puedeVenderse()

}

class Alquiler inherits Descarga {

	override method precio() = 1.max(super())

	override method puedeAplicarseA(contenido) = super(contenido) && contenido.puedeAlquilarse()

}

// ------------------------------------------------------------------------------------------------------------------
// USUARIOS
// ------------------------------------------------------------------------------------------------------------------
object usuarios {

	const todosLosUsuarios = []

	method emailsDeUsuariosRicos() = todosLosUsuarios.filter{ usuario => usuario.verificado() }.sortedBy{ uno , otro => uno.saldoTotal() > otro.saldoTotal() }.take(100).map{ usuario => usuario.email() }

	method cantidadDeSuperUsuarios() = todosLosUsuarios.count{ usuario => usuario.esSuperUsuario() }

}

class Usuario {

	const property nombre
	const property email
	var property verificado = false
	const contenidos = []

	method saldoTotal() = contenidos.sum{ contenido => contenido.recaudacion() }

	method esSuperUsuario() = contenidos.count{ contenido => contenido.esPopular() } >= 10

	method publicar(contenido) {
		contenidos.add(contenido)
	}

}

