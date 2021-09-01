% Teniendo la conocida base de conocimientos (algo extendida):

padre(abbbbbbbbbbbe, abbbe).
padre(abbbe, abe).
padre(abe,homero).
padre(abe,herbert).
padre(homero,bart).
padre(homero,lisa).
padre(homero,maggie).

% Un ejemplo de predicado recursivo:
% El predicado ancestro/2, que relaciona dos personas si una es descendiente de la otra

ancestro(Ancestro, Descendiente):-
    padre(Ancestro,Descendiente).
ancestro(Ancestro, Descendiente):-
    padre(Ancestro,Viejo),
    ancestro(Viejo,Descendiente).

% Vemos que hay un caso base y un caso recursivo.

% Luego, con los productos:

producto(coto, lacteo, leche, 35).
producto(coto, galletita, oreo, 60).
producto(dia, lacteo, leche, 22).
producto(dia, lacteo, yoghurt, 30).
producto(dia, infusion, cafe, 70).
producto(dia, infusion, te, 30).
producto(dia, galletita, oreo, 45).

% Para "Juntar" en una lista, existe el findall:

cuantosProductosLacteosTiene(Super,Cuantos):-
	producto(Super,_,_,_),
	findall(Nombre, producto(Super,lacteo,Nombre,_), Productos),
	length(Productos,Cuantos).

% Importante entender que la consulta del medio del findall:
% producto(Super,lacteo,Nombre,_) 
% Es cierta si Nombre es el nombre de un lácteo de ese Super.
% Entonces, todos los Nombre estarán en la lista Productos.

quiereComprar(pepe,leche).
quiereComprar(pepe,oreo).
quiereComprar(ana,cafe).

% Este predicado se puede armar delegando, ó se puede hacer un "y"

% Delegando:

gastoEnSuper(Super, Persona, Monto):-
	supermercado(Super),
	findall(Precio,precioDeLoQueQuiere(Super,Persona,Precio),Precios),
	sum_list(Precios,Monto).

supermercado(Super) :-
	producto(Super,_,_,_).

precioDeLoQueQuiere(Super,Persona,Precio):-
	producto(Super,_,Nombre,Precio),
	quiereComprar(Persona,Nombre).


% Con un "y"
gastoEnSuperV2(Super, Persona, Monto):-
        supermercado(Super),
        findall(Precio, (producto(Super,_,Nombre,Precio), quiereComprar(Persona,Nombre)),Precios),
        sum_list(Precios,Monto).

% Ponerles nombre a los generadores (en este caso "supermercado") mejora mucho la expresividad.