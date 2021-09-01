
object carlosDuty {
	var cantLogros = 0
	method esViolento(){
		return true
	}
	method tiempoRestante(){
		return 30 - cantLogros * 0.5
	}
	method jugar(cantHoras){
		if (cantHoras > 2){
			cantLogros += 1
		}
	}
}

object timbaElLeon {
	var meQuedan = 50
	method esViolento(){
		return false
	}
	
	method tiempoRestante(){
		return meQuedan
	}
	
	method jugar(cantHoras){
		meQuedan -= cantHoras
	}
}

object devilMayLaughVI{
	var nivelDeSangre = 3
	
	method esViolento(){
		return nivelDeSangre > 5
	}
	
	method tiempoRestante(){
		return 100
	}
	
	method jugar(cantHoras){
		nivelDeSangre += 1
	}
}

object eish{
	var horasJugadas = 0
	var modo = modoConTrucos
	
	method esViolento(){
		return modo.sosViolento(horasJugadas)
	}
	
	method tiempoRestante(){
		return modo.tiempoRestante(horasJugadas)
	}
	
	method jugar(cantHoras){
		horasJugadas += cantHoras
	}
}

object modoConTrucos {
	method sosViolento(horasJugadas){
		return true
	}
	
	method tiempoRestante(hsJugadas){
		return hsJugadas * 2
	}
}

object modoSinTrucos {
	method sosViolento(horasJugadas){
		return horasJugadas > 3
	}
	
	method tiempoRestante(hsJugadas){
		return 90 - hsJugadas	
	}
}