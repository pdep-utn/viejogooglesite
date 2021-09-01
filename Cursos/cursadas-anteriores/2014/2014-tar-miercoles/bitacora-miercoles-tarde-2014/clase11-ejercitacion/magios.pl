persona(bart). 
persona(larry).  
persona(otto).  
persona(marge). 
 
%cambiamos la forma en la que estaba modelada la informacion en el parcial porque era realmente molesto innecesariamente
persona(Magio):- esMagio(Magio).
esMagio(alMando(burns,29)). 
esMagio(alMando(clark,20)).  
esMagio(novato(lenny)). 
esMagio(novato(carl)).  
esMagio(elElegido(homero)). 
 
hijo(homero,abbe).
hijo(bart,homero).
hijo(larry,burns).  

salvo(carl,lenny).  
salvo(homero,larry).  
salvo(otto,burns). 
 
gozaBeneficio(carl, confort(sillon)). 
gozaBeneficio(lenny, confort(sillon)).  
gozaBeneficio(lenny, confort(estacionamiento, techado)).
gozaBeneficio(carl, confort(estacionamiento, libre)).  
gozaBeneficio(clark, confort(viajeSinTrafico)).  
gozaBeneficio(clark, dispersion(fiestas)). 
gozaBeneficio(burns, dispersion(fiestas)). 
gozaBeneficio(lenny, economico(descuento, 500)). 

%1
descendiente(Desc,Ancestro):-
	hijo(Desc,Ancestro).
descendiente(Desc, Ancestro):-
	hijo(Desc, Padre),
	descendiente(Padre, Ancestro).
	
dejaEntrar(Aspirante, Magio):- descendiente(Aspirante, Magio).
dejaEntrar(Aspirante, Magio):- salvo(Aspirante,Magio).
aspiranteMagio(Persona):- 
	persona(Persona),
	nombreMagio(Magio),
	not(esMagio(Persona)),
	dejaEntrar(Persona,Magio).
	
nombreMagio(Nombre):- esMagio(alMando(Nombre,_)).
nombreMagio(Nombre):- esMagio(novato(Nombre)).
nombreMagio(Nombre):- esMagio(elElegido(Nombre)).

%2

puedeDarOrdenes(Superior, Inferior):-
	persona(Superior),
	esMagio(Inferior),
	puedeDarOrdenesAux(Superior,Inferior).
	
puedeDarOrdenesAux(elElegido(_), _).
puedeDarOrdenesAux(alMando(_,_), novato(_)).
puedeDarOrdenesAux(alMando(_,Antiguedad), alMando(_,AntMenor)):-
	AntMenor < Antiguedad.
	
%3
sienteEnvidia(Persona, Lista):- persona(Persona),
	findall(Otro, (persona(Otro), envidiaA(Persona, Otro)) , Lista).
	
comunacho(Persona):- not(esMagio(Persona)),
	not(aspiranteMagio(Persona)).
envidiaA(Persona, Magio):-
	aspiranteMagio(Persona),
	esMagio(Magio).
envidiaA(Persona, Magio):-
	comunacho(Persona),
	aspiranteMagio(Magio).
envidiaA(Persona, Magio):-
	comunacho(Persona),
	esMagio(Magio).
envidiaA(novato(_),alMando(_,_)).

%4 no se podia usar forall entonces usamos "no existe X tal que se cumple A(X) y no B(X)"
masEnvidioso(Persona):-
	cuantosEnvidia(Persona, Cuantos),
	not( (cuantosEnvidia(Otro, C), Otro \= Persona,
			C >= Cuantos)).
			
cuantosEnvidia(Persona, Cuantos):-
	sienteEnvidia(Persona, Lista),
	length(Lista, Cuantos).
	
%5
soloLoGoza(Persona, Beneficio):-
	gozaBeneficio(Persona,Beneficio),
	forall((gozaBeneficio(P,B), P\= Persona),
			B \= Beneficio).
	
%6
tipoDeBeneficioMasAprovechado(Tipo):-
	tipoDeBeneficio(Tipo),
	aprovechado(Tipo, Cant),
	forall((tipoDeBeneficio(Otro), Otro\=Tipo),
		(aprovechado(Otro, C), C < Cant)).
		
tipoDeBeneficio(Tipo):- esDe(Tipo, _).

aprovechado(Tipo, Cant):-
	tipoDeBeneficio(Tipo),
	findall(Tipo, (gozaBeneficio(_, Benef), esDe(Tipo, Benef)), Lista),
	length(Lista, Cant).
esDe(confort, confort(_)).
esDe(confort, confort(_,_)).
esDe(economico, economico(_,_)).
esDe(dispersion, dispersion(_)).