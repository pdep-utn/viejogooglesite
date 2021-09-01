
object azucena {
	method leGusta(unDisfraz) 
		= unDisfraz.ternura() > 8
		
	method cuantosCaramelosPuedeDar(_) = 5
}

object sandra {
	method leGusta(unDisfraz)
		= unDisfraz.ternura() > unDisfraz.terror()
		
	method cuantosCaramelosPuedeDar(unaCasa){
		if(unaCasa.caos() >= 3) 
			return 1 
		else 
			return 7
	}
	
	// lo mismo con un poco más de azúcar sintáctico
	// method cuantosCaramelosPuedeDar(unaCasa) =
	//	 if(unaCasa.caos() >= 3) 1 else 7
	
}

object jorge {
	method leGusta(unDisfraz)
		= unDisfraz.terror() >= 8
		
	method cuantosCaramelosPuedeDar(unaCasa){
		if(unaCasa.cantidadDeCaramelos() >= 50){
			return 10
		} else {
			return 4
		}
	}
}

object casa {
	var caos = 0
	var cantidadDeCaramelos = 100
	
	method caos() = caos
	
	method caos(valor){
		caos = valor
	}
	
	method cantidadDeCaramelos() = cantidadDeCaramelos
	
	method cantidadDeCaramelos(valor){
		cantidadDeCaramelos = valor
	}
	
	method habitantes(){
		return [azucena, sandra, jorge]
	}
	
	method aQuienesLesGusta(unDisfraz) =
		self.habitantes().filter({unHabitante => unHabitante.leGusta(unDisfraz)})
	
	
	method maximoQuePuedeDar() = self.cuantoDan(self.habitantes())
	
	
	method cuantoDanLosQueLesGusta(unDisfraz) =
		self.cuantoDan(self.aQuienesLesGusta(unDisfraz))
	
	
	method cuantoDan(unosHabitantes) =
	 unosHabitantes.sum({unHabitante => unHabitante.cuantosCaramelosPuedeDar(self)})
	
}

object disfrazDeOso {
	method ternura() = 10
	method terror() = 3
}

object disfrazDeZombie {
	method ternura() = 0
	method terror() = 8
}

object juanita {
	var disfraz = disfrazDeZombie
	method disfraz() = disfraz
	
	method cuantosCaramelosPuedeConseguirEn(unaCasa) = unaCasa.maximoQuePuedeDar()
}

object rolo {
	method cuantosCaramelosPuedeConseguirEn(unaCasa) = 1
}

object tito {
	var disfraz = disfrazDeZombie
	
	method disfraz() = disfraz
	
	method disfraz(unDisfraz){
		disfraz = unDisfraz
	}
	
	method hermana() = juanita
	
	method cuantosCaramelosPuedeConseguirEn(unaCasa){
		if(self.hermana().disfraz() == self.disfraz()){
			return self.hermana().cuantosCaramelosPuedeConseguirEn(unaCasa)
		} else {
			return unaCasa.cuantoDanLosQueLesGusta(self.disfraz())
		}
	}
}