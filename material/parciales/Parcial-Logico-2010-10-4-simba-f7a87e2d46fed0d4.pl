/******** LEER ********************
NOTA IMPORTANTE
La siguiente es UNA de las soluciones válidas al parcial.
Se presenta como ayuda para quien YA HA INTENTADO RESOLVER el parcial.
Se recomienda SIEMPRE CONSULTAR A UN DOCENTE sobre las soluciones aquí
propuestas, ya que las mismas son EJEMPLOS de solución, y no son ni las
mejores ni las más adecuadas.
Forma parte del criterio de un ingeniero poder decidir cuándo una solución
es buena, y
LA JUSTIFICACIÓN DE LA SOLUCIÓN ES MÁS IMPORTANTE QUE LA SOLUCIÓN MISMA
Y cada ejercicio ó parcial en particular merece una justificación propia.
**********************************/

%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).

comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).

comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).

comio(shenzi,hormiga(conCaraDeSimba)).

pesoHormiga(2).

%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).
peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).
peso(mufasa, 600).

peso(vaquitaSanAntonio(_,Peso),Peso).
peso(cucaracha(_,_,Peso),Peso).
peso(hormiga(_),Peso):- pesoHormiga(Peso).

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).
persigue(scar, mufasa).


%EJERCICIO 1

% a) Qué cucaracha es jugosita: ó sea, hay otra con su mismo tamaño pero ella es más gordita.

jugosita(cucaracha(Nombre,Tamanio,Peso)):-
        bicho(cucaracha(Nombre,Tamanio,Peso)),
        bicho(cucaracha(_,Tamanio,OtroPeso)),
        Peso > OtroPeso.

%Con éste predicado dejamos explícito cuando Alguien es un bicho válido:
bicho(Alguien):- comio(_,Alguien).

% b) Si un personaje es hormigofílico... (Comio al menos dos hormigas distintas)

hormigofilico(Alguien):-
        comio(Alguien, hormiga(UnaHormiga)),
        comio(Alguien,hormiga(OtraHormiga)),
        UnaHormiga\=OtraHormiga.
/*
Otra manera de resolver éste ejercicio hubiera sido usando un findall para
obtener una lista, y contar la cantidad de hormigas.
Sin embargo, la solución actual es la correcta y la otra no, por dos razones:
1- La solución actual es más declarativa: dice lo mismo que el enunciado.
Además, la solución con el findall es procedural: en ningún momento el enunciado
habla de tamaños de listas.
2- La solución actual usa la herramientas básica del paradigma: la consulta
para saber si algo existe, mientras que la solución con findall es innecesariamente
más compleja*/

% c) Si un personaje es cucarachofóbico (no comió cucarachas)
cucarachofobico(Alguien):-
        personaje(Alguien),   %Generación
        not(comio(Alguien,cucaracha(_,_,_))).
/*Aquí aparecen dos conceptos importantes: la generación, y el not.
La generación es necesaria porque al momento de preguntar si
"X persona no comió una cucaracha" necesitamos que ese Alguien esté siempre unificado,
porque si no está unificado, la pregunta sería "¿nadie comió una cucaracha?"*/

%Con éste predicado dejamos explícito cuándo Alguien es un personaje válido:
personaje(Alguien):-
        peso(Alguien,_),
        not(bicho(Alguien)).

% d) Conocer a los picarones.
% Un personaje es picarón si va a comer una cucaracha jugosita ó si se
% come a remeditos la vaquita.
% Además, pumba es picarón de por sí

picarones(Picarones):-
        findall(Alguien, picaron(Alguien), Picarones).

picaron(Alguien):-
        comio(Alguien,Bicho), jugosita(Bicho).
picaron(Alguien):-
        comio(Alguien,vaquitaSanAntonio(remeditos,_)).
picaron(pumba).

/*Lo importante de éste ejercicio son 2 cosas:
1- Abstraer el concepto de cuándo Alguien es picarón. Gracias a ésto el predicado
picarones es más declarativo.
2- Entender que si hay varias maneras de hacer que el predicado picaron sea
cierto, entonces cada una de esas maneras debe ir en una cláusula separada.*/

%EJERCICIO 2

% a) Se quiere saber cuánto engorda un personaje (sabiendo que engorda una cantidad igual a la suma de los pesos de todos los bichos en su menú).
% Los bichos no engordan

cuantoEngorda(Alguien,PesoTotal) :-
        personaje(Alguien),
        findall(Peso, engordeBocadillo(Alguien,Peso),Pesos),
        sumlist(Pesos,PesoTotal).
/*Aquí se vuelve a delegar un concepto para que el predicado quede más
declarativo. Además, se genera porque si Alguien no estuviera unificado,
el findall encontraría todos los pesos de todos los bocadillos, y no sólo
los de ese Alguien.*/

engordeBocadillo(Alguien, Peso):-
        comio(Alguien, Victima),
        peso(Victima,Peso).

% Se agrega al inicio de la base, junto con los hechos:
% peso(vaquitaSanAntonio(_,Peso),Peso).
% peso(cucaracha(_,_,Peso),Peso).
% peso(hormiga(_),P):- pesoHormiga(P).

/*Ésto último es lo más importante del predicado: al haber abstraido el concepto
de peso, me permite tratar polimórficamente a todos los bichos, y así puedo
conocer el peso de cada uno de ellos sin necesidad de hacer 3 veces el predicado
engordeBocadillo.*/


% b) Pero como indica la ley de la selva, cuando un personaje persigue a otro, se lo termina comiendo, y por lo tanto también engorda.
% Realizar una nueva versión del predicado

%Se reemplaza la regla anterior por esta:
%engordeBocadillo(Alguien, Peso):-
%       seCome(Alguien, Victima),
%       peso(Victima,Peso).

% Y se agrega el siguiente predicado:
seCome(Alguien,Victima):-
        comio(Alguien,Victima).
seCome(Alguien,Victima):-
        persigue(Alguien,Victima).
/*Éste es el principal concepto importante de la solución: aquí se elige
tratar a bichos y a personajes polimórficamente como víctimas, y ésto me permite
hacer pocas modificaciones a lo anterior, manteniendo la idea de cuantoEngorda,
ya que éste predicado no debería cambiar
En otras palabras, si la manera de engordar no cambió, el predicado cuantoEngorda
tampoco debe cambiar.*/

% Aca se repiten las mismas reglas anteriores pero con otros nombres ,para poder probar en forma independiente lo pedido en cada item.
cuantoEngordaB(Alguien,PesoTotal) :-
        personaje(Alguien),
        findall(Peso, engordeBocadilloB(Alguien,Peso),Pesos),
        sumlist(Pesos,PesoTotal).

engordeBocadilloB(Alguien, Peso):-
        seCome(Alguien, Victima),
        peso(Victima,Peso).

% Una variantes sería agregar:
% comio(Alguien, Victima):-
%       persigue(Alguien,Victima).
% Y habría que definir diferente el predicado bicho/2

% c)Ahora se complica el asunto, porque en realidad cada animal antes de comerse a sus víctimas espera a que estas se alimenten.
% De esta manera, lo que engorda un animal no es sólo el peso original de sus víctimas, sino también hay que tener en cuenta lo que éstas comieron y por lo tanto engordaron.
% Hacer una última version del predicado.

% Se reemplaza la regla anterior por esta:
% engordeBocadillo(Alguien, Peso):-
%       seCome(Alguien, Victima),
%       peso(Victima,PesoVictima),
%       cuantoEngorda(Victima,Engorde),   /*Aquí hay una llamada recursiva*/
%       Peso is PesoVictima + Engorde.

% y se agrega:
%
% cuantoEngorda(Alguien, 0):-
%       bicho(Alguien).
/*Ésta solución utiliza recursividad como manera de resolver el ejercicio porque
permite recorrer el árbol alimenticio de manera declarativa.
El caso base es necesario ya que, como estamos tratando polimórficamente a las
víctimas, es importante que se pueda saber cuánto engorda un bicho, que es 0, y sirve de caso base.*/

% Aca se repiten las mismas reglas anteriores pero con otros nombres ,para poder probar en forma independiente lo pedido en cada item.


cuantoEngordaC(Alguien,PesoTotal) :-
        personaje(Alguien),
        findall(Peso, engordeBocadilloC(Alguien,Peso),Pesos),
        sumlist(Pesos,PesoTotal).

cuantoEngordaC(Alguien, 0):-
        bicho(Alguien).

engordeBocadilloC(Alguien, Peso):-
        seCome(Alguien, Victima),
        peso(Victima,PesoVictima),
        cuantoEngordaC(Victima,Engorde),
        Peso is PesoVictima + Engorde.

% EJERCICIO 3

% Sabiendo que todo animal adora a todo lo que no se lo come o no lo persigue, encontrar al rey.
% El rey es el animal a quien sólo hay un animal que lo persigue y todos adoran.


rey(Rey):-
        soloLoPersigueUno(Rey),
        todosLoAdoran(Rey).

soloLoPersigueUno(Alguien):-
        personaje(Alguien),
        not(hayMasDeUnPerseguidor(Alguien)).
/*Nuevamente se hace uso de las herramientas más básicas del paradigma.
De una manera elegante se afirma que si no hay más de un perseguidor, es porque
sólo lo persigue uno, ó no lo persigue ninguno.
*/

hayMasDeUnPerseguidor(Alguien):-
        persigue(UnPerseguidor,Alguien),
        persigue(OtroPerseguidor,Alguien),
        UnPerseguidor \= OtroPerseguidor.

todosLoAdoran(Alguien):-
        personaje(Alguien),
        forall(animal(Animal),adora(Animal,Alguien)).

animal(Alguien):- bicho(Alguien).
animal(Alguien):- personaje(Alguien).

adora(Alguien,Adorado):-
        not(seCome(Adorado,Alguien)).

















