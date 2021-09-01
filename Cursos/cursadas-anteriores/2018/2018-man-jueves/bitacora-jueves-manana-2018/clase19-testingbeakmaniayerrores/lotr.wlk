
object aragorn {
	var property seguidores = #{}
	
	method agregarSeguidor(seguidor){
		seguidores.add(seguidor)
	}
	
	method viajar(kms){
		if(!self.estanListos())
			error.throwWithMessage("no estan listos para viajar")
				
		seguidores.forEach({ unSeguidor => 
			unSeguidor.viajar(kms)
		})
	}
	
	method estanListos(){
		return seguidores.all({ unSeguidor =>
			unSeguidor.estaListo()
		})
	}
	/*
	 * Capitán de los montaraces del norte, segundo de ese nombre, hijo de Arathorn II y de Gilraen
	 */
}

object frodo {
	/*
	 * Portador del anillo único
	 */
}

object sam {
	/*
	 * Fiel compañero de Frodo
	 */
}

object pippin {
	var nivelDeHambre = 50
	var cantDesayunos = 0
	
	method nivelDeHambre(){
		return nivelDeHambre
	}
	
	method desayunar(){
		cantDesayunos += 1
	}
	
	method viajar(kms){
		nivelDeHambre += kms * 2
	}
	
	method estaListo(){
		return cantDesayunos >= 2
	}
	
	/*
	 *Gran amigo de Frodo y Sam
	 */
}

object merry {
	/*
	 * Merry
	 */
}

object anilloUnico {
	/*
	 * El precioso. 
	 * Un Anillo para gobernarlos a todos. 
	 * Un Anillo para encontrarlos, un Anillo para atraerlos a todos y atarlos en las tinieblas.
	 */
}

object sauron {
	/*
	 * El señor oscuro de Mordor
	 */
}