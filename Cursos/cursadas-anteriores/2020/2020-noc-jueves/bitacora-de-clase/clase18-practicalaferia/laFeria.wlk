object julieta {
  var property tickets = 15
  var cansancio = 0
 
  method puntería() = 20
 
  method fuerza() = 80 - cansancio
 
  method jugar(juego) {
    tickets = tickets + juego.ticketsGanados(self)
    cansancio = cansancio + juego.cansancioQueProduce()
  }

  method puedeCanjear(premio) = tickets > premio.costo()
}


object gerundio {
  method jugar(juego) { }

  method puedeCanjear(premio) = true
}



object ositoDePeluche {
  method costo() = 45
}

object taladroRotopercutor {
  var property costo
}


object tiroAlBlanco {
  method ticketsGanados(jugador) = (jugador.puntería() / 10).roundUp()
  method cansancioQueProduce() = 3
}

object pruebaDeFuerza {
  method ticketsGanados(jugador) = if(jugador.fuerza() > 75) 20 else 0
  method cansancioQueProduce() = 8
}

object ruedaDeLaFortuna {
  var property aceitada

  method ticketsGanados(jugador) = 0.randomUpTo(20).roundUp()
  method cansancioQueProduce() = if(aceitada) 0 else 1
}
