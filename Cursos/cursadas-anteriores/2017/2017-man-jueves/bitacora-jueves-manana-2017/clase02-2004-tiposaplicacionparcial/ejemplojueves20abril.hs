--siguiente = (1 +)  
--doble = (2 *)

elSiguienteDelDobleEsPar = even.(1+).(2*)

--mayorA1:: Int-> Int
mayorA1 = max 1

--maximo:: Int->Int->Int->Int
maximo a b c = max a (max b c)

laPalabraContieneLaLetray::String->Bool
laPalabraContieneLaLetray = elem 'y'

-----
--1° Paso 
dobleDelSiguiente = doble.siguiente
siguiente x =1+x 
doble x = 2*x


--2° Paso
dobleDelSiguiente' = doble'.siguiente'
siguiente' = (1+)
doble' x = x * 2


--3° Paso
dobleDelSiguiente'' = doble''.(1+)
doble'' = (2*)


--4° Paso
dobleDelSiguiente''' = (2*).(1+)

---

esP = ('p'==)

-- consultas:
-- > ( esP. head) "palabras"
-- True

-- > ( ( 'p'==). head) "palabras"
-- True
