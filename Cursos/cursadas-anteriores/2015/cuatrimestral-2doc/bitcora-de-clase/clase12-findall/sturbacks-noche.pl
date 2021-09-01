pedido(vero,frappuccinoFrutilla).
pedido(vero,frappuccinoFrutilla).
pedido(vero, light).
pedido(gus,irishCream).
pedido(gus,explosiva).
pedido(gus,extrema).
pedido(alf,conTodo).
pedido(franco,light).
pedido(franco,frappuccinoFrutilla).
pedido(franco,irishCream).
pedido(franco,explosiva).
pedido(franco,extrema).
pedido(franco,conTodo).
pedido(nico, frappuccinoFrutilla).
pedido(nico, dulceDeLecheLatte).
pedido(nico, light).

persona(vero).
persona(gus).
persona(alf).
persona(franco).
persona(nico).

bebida(dulceDeLecheLatte,[base(cafe,100),leche(10,50)]).
bebida(frappuccinoFrutilla,[base(helado,80),jarabe(frutilla),jarabe(dulceDeLeche),leche(2,60)]).
bebida(irishCream,[jarabe(baileys),leche(3,50)]).
bebida(explosiva,[base(ron,90),base(vodka,100),jarabe(baileys)]).
bebida(extrema,[base(cafe,100),base(helado,80),base(ron,90),leche(10,10),jarabe(chocolate)]).
bebida(light,[base(cafe,5),jarabe(frutilla)]).
bebida(cafecito,[base(cafe,10)]).
bebida(conTodo,[base(cafe,5),jarabe(frutilla),base(helado,80),base(mouse,90),leche(10,10),jarabe(chocolate),base(helado,80),base(mouse,90),leche(10,10),jarabe(chocolate),base(helado,80),base(mouse,90),leche(10,10),jarabe(chocolate)]).
bebida(milkshake, [base(helado, 80), leche(5, 10)]).

tieneAlcohol(baileys).
tieneAlcohol(tiaMaria).
tieneAlcohol(vodka).
tieneAlcohol(ron).


%%% ?- cantidadDeCalorias(Bebida, Calorias).
cantidadDeCalorias(Bebida, Calorias):-
	bebida(Bebida, Ingredientes),
	findall(CaloriasIngrediente, 
		(member(Ingrediente, Ingredientes),
		calorias(Ingrediente, CaloriasIngrediente)),
		ListaDeCalorias),
	sumlist(ListaDeCalorias, Calorias).
	
%% ?- calorias(base(helado, 80), Calorias)
%% ?- calorias(Ingrediente, Calorias). <--- no se puede

calorias(base(Algo, Cantidad), Calorias):-
	Algo \= cafe,
	Calorias is Cantidad * 10.
calorias(base(cafe, Cantidad), Calorias):-
	Calorias is Cantidad * 5.
calorias(leche(Grasa, Cantidad), Calorias):-
	Calorias is Grasa * Cantidad.
calorias(jarabe(_), 15).

%% ?- cuantasBebidasPidio(Persona, Cantidad).
cuantasBebidasPidio(Persona, Cantidad):-
	persona(Persona),
	findall(Bebida, pedido(Persona, Bebida), Bebidas),
	length(Bebidas, Cantidad).
	
%% ?- totalCaloriasConsumidas(Persona, Total).
totalCaloriasConsumidas(Persona, Total):-
	persona(Persona),
	findall(CantCalorias, 
		(pedido(Persona, Bebida),
		cantidadDeCalorias(Bebida, CantCalorias)),
		Calorias),
	sumlist(Calorias, Total).

%% ?- tomoDosBebidasDistintas(Persona).
tomoDosBebidasDistintas(Persona):-
	pedido(Persona, Bebida1),
	pedido(Persona, Bebida2),
	Bebida1 \= Bebida2.

%% ?- siemprePideLoMismo(Persona).
siemprePideLoMismo(Persona):-
	pedido(Persona, Bebida),
	not((pedido(Persona, Otra), Otra \= Bebida)).


%% ?- esDeAA(Bebida). -> Bebida = explosiva
esDeAA(Bebida):- bebida(Bebida, Ingredientes),
	forall((member(Ingrediente, Ingredientes), 
	nombre(Ingrediente, Nombre)), tieneAlcohol(Nombre)).
	
nombre(base(Nombre,_), Nombre).
nombre(jarabe(Nombre), Nombre).
nombre(leche(_,_), leche).
	

%% ?- bebidaMasPedida(Bebida).
bebidaMasPedida(Bebida1):-
	cuantasVecesSePidio(Bebida1, Cant1),
	forall((cuantasVecesSePidio(Bebida2, Cant2),Bebida1 \= Bebida2), Cant1 > Cant2
	).
	
bebidaMasPedidaGarron(Bebida):-
	findall(B, bebida(B, _), Bebidas),
	maximoPedidos(Bebidas, Bebida).
	
maximoPedidos([Bebida], Bebida).
maximoPedidos([Bebida1, Bebida2|Bebidas], BebidaMasPedida):-
	cuantasVecesSePidio(Bebida1, Cant1),
	cuantasVecesSePidio(Bebida2, Cant2),
	Cant1 > Cant2,
	maximoPedidos([Bebida1|Bebidas], BebidaMasPedida).
maximoPedidos([Bebida1, Bebida2|Bebidas], BebidaMasPedida):-
	cuantasVecesSePidio(Bebida1, Cant1),
	cuantasVecesSePidio(Bebida2, Cant2),
	Cant1 =< Cant2,
	maximoPedidos([Bebida2|Bebidas], BebidaMasPedida).

cuantasVecesSePidio(Bebida, Cantidad):-
	bebida(Bebida, _),
	findall(Persona, pedido(Persona, Bebida), Personas),
	length(Personas, Cantidad).
	
	
	
	