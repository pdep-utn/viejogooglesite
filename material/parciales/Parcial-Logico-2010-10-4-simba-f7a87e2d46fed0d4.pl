/******** LEER ********************
NOTA IMPORTANTE
La siguiente es UNA de las soluciones v�lidas al parcial.
Se presenta como ayuda para quien YA HA INTENTADO RESOLVER el parcial.
Se recomienda SIEMPRE CONSULTAR A UN DOCENTE sobre las soluciones aqu�
propuestas, ya que las mismas son EJEMPLOS de soluci�n, y no son ni las
mejores ni las m�s adecuadas.
Forma parte del criterio de un ingeniero poder decidir cu�ndo una soluci�n
es buena, y
LA JUSTIFICACI�N DE LA SOLUCI�N ES M�S IMPORTANTE QUE LA SOLUCI�N MISMA
Y cada ejercicio � parcial en particular merece una justificaci�n propia.
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

% a) Qu� cucaracha es jugosita: � sea, hay otra con su mismo tama�o pero ella es m�s gordita.

jugosita(cucaracha(Nombre,Tamanio,Peso)):-
        bicho(cucaracha(Nombre,Tamanio,Peso)),
        bicho(cucaracha(_,Tamanio,OtroPeso)),
        Peso > OtroPeso.

%Con �ste predicado dejamos expl�cito cuando Alguien es un bicho v�lido:
bicho(Alguien):- comio(_,Alguien).

% b) Si un personaje es hormigof�lico... (Comio al menos dos hormigas distintas)

hormigofilico(Alguien):-
        comio(Alguien, hormiga(UnaHormiga)),
        comio(Alguien,hormiga(OtraHormiga)),
        UnaHormiga\=OtraHormiga.
/*
Otra manera de resolver �ste ejercicio hubiera sido usando un findall para
obtener una lista, y contar la cantidad de hormigas.
Sin embargo, la soluci�n actual es la correcta y la otra no, por dos razones:
1- La soluci�n actual es m�s declarativa: dice lo mismo que el enunciado.
Adem�s, la soluci�n con el findall es procedural: en ning�n momento el enunciado
habla de tama�os de listas.
2- La soluci�n actual usa la herramientas b�sica del paradigma: la consulta
para saber si algo existe, mientras que la soluci�n con findall es innecesariamente
m�s compleja*/

% c) Si un personaje es cucarachof�bico (no comi� cucarachas)
cucarachofobico(Alguien):-
        personaje(Alguien),   %Generaci�n
        not(comio(Alguien,cucaracha(_,_,_))).
/*Aqu� aparecen dos conceptos importantes: la generaci�n, y el not.
La generaci�n es necesaria porque al momento de preguntar si
"X persona no comi� una cucaracha" necesitamos que ese Alguien est� siempre unificado,
porque si no est� unificado, la pregunta ser�a "�nadie comi� una cucaracha?"*/

%Con �ste predicado dejamos expl�cito cu�ndo Alguien es un personaje v�lido:
personaje(Alguien):-
        peso(Alguien,_),
        not(bicho(Alguien)).

% d) Conocer a los picarones.
% Un personaje es picar�n si va a comer una cucaracha jugosita � si se
% come a remeditos la vaquita.
% Adem�s, pumba es picar�n de por s�

picarones(Picarones):-
        findall(Alguien, picaron(Alguien), Picarones).

picaron(Alguien):-
        comio(Alguien,Bicho), jugosita(Bicho).
picaron(Alguien):-
        comio(Alguien,vaquitaSanAntonio(remeditos,_)).
picaron(pumba).

/*Lo importante de �ste ejercicio son 2 cosas:
1- Abstraer el concepto de cu�ndo Alguien es picar�n. Gracias a �sto el predicado
picarones es m�s declarativo.
2- Entender que si hay varias maneras de hacer que el predicado picaron sea
cierto, entonces cada una de esas maneras debe ir en una cl�usula separada.*/

%EJERCICIO 2

% a) Se quiere saber cu�nto engorda un personaje (sabiendo que engorda una cantidad igual a la suma de los pesos de todos los bichos en su men�).
% Los bichos no engordan

cuantoEngorda(Alguien,PesoTotal) :-
        personaje(Alguien),
        findall(Peso, engordeBocadillo(Alguien,Peso),Pesos),
        sumlist(Pesos,PesoTotal).
/*Aqu� se vuelve a delegar un concepto para que el predicado quede m�s
declarativo. Adem�s, se genera porque si Alguien no estuviera unificado,
el findall encontrar�a todos los pesos de todos los bocadillos, y no s�lo
los de ese Alguien.*/

engordeBocadillo(Alguien, Peso):-
        comio(Alguien, Victima),
        peso(Victima,Peso).

% Se agrega al inicio de la base, junto con los hechos:
% peso(vaquitaSanAntonio(_,Peso),Peso).
% peso(cucaracha(_,_,Peso),Peso).
% peso(hormiga(_),P):- pesoHormiga(P).

/*�sto �ltimo es lo m�s importante del predicado: al haber abstraido el concepto
de peso, me permite tratar polim�rficamente a todos los bichos, y as� puedo
conocer el peso de cada uno de ellos sin necesidad de hacer 3 veces el predicado
engordeBocadillo.*/


% b) Pero como indica la ley de la selva, cuando un personaje persigue a otro, se lo termina comiendo, y por lo tanto tambi�n engorda.
% Realizar una nueva versi�n del predicado

%Se reemplaza la regla anterior por esta:
%engordeBocadillo(Alguien, Peso):-
%       seCome(Alguien, Victima),
%       peso(Victima,Peso).

% Y se agrega el siguiente predicado:
seCome(Alguien,Victima):-
        comio(Alguien,Victima).
seCome(Alguien,Victima):-
        persigue(Alguien,Victima).
/*�ste es el principal concepto importante de la soluci�n: aqu� se elige
tratar a bichos y a personajes polim�rficamente como v�ctimas, y �sto me permite
hacer pocas modificaciones a lo anterior, manteniendo la idea de cuantoEngorda,
ya que �ste predicado no deber�a cambiar
En otras palabras, si la manera de engordar no cambi�, el predicado cuantoEngorda
tampoco debe cambiar.*/

% Aca se repiten las mismas reglas anteriores pero con otros nombres ,para poder probar en forma independiente lo pedido en cada item.
cuantoEngordaB(Alguien,PesoTotal) :-
        personaje(Alguien),
        findall(Peso, engordeBocadilloB(Alguien,Peso),Pesos),
        sumlist(Pesos,PesoTotal).

engordeBocadilloB(Alguien, Peso):-
        seCome(Alguien, Victima),
        peso(Victima,Peso).

% Una variantes ser�a agregar:
% comio(Alguien, Victima):-
%       persigue(Alguien,Victima).
% Y habr�a que definir diferente el predicado bicho/2

% c)Ahora se complica el asunto, porque en realidad cada animal antes de comerse a sus v�ctimas espera a que estas se alimenten.
% De esta manera, lo que engorda un animal no es s�lo el peso original de sus v�ctimas, sino tambi�n hay que tener en cuenta lo que �stas comieron y por lo tanto engordaron.
% Hacer una �ltima version del predicado.

% Se reemplaza la regla anterior por esta:
% engordeBocadillo(Alguien, Peso):-
%       seCome(Alguien, Victima),
%       peso(Victima,PesoVictima),
%       cuantoEngorda(Victima,Engorde),   /*Aqu� hay una llamada recursiva*/
%       Peso is PesoVictima + Engorde.

% y se agrega:
%
% cuantoEngorda(Alguien, 0):-
%       bicho(Alguien).
/*�sta soluci�n utiliza recursividad como manera de resolver el ejercicio porque
permite recorrer el �rbol alimenticio de manera declarativa.
El caso base es necesario ya que, como estamos tratando polim�rficamente a las
v�ctimas, es importante que se pueda saber cu�nto engorda un bicho, que es 0, y sirve de caso base.*/

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
% El rey es el animal a quien s�lo hay un animal que lo persigue y todos adoran.


rey(Rey):-
        soloLoPersigueUno(Rey),
        todosLoAdoran(Rey).

soloLoPersigueUno(Alguien):-
        personaje(Alguien),
        not(hayMasDeUnPerseguidor(Alguien)).
/*Nuevamente se hace uso de las herramientas m�s b�sicas del paradigma.
De una manera elegante se afirma que si no hay m�s de un perseguidor, es porque
s�lo lo persigue uno, � no lo persigue ninguno.
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

















