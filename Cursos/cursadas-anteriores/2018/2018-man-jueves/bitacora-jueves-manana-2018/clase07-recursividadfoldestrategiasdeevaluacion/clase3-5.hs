unos::[Int]
unos = 1:unos

repetir x = x:repetir x

naturales n = n:naturales (n+1) 

pares = deDosEnDos 100
impares = deDosEnDos 99

deDosEnDos 0 = [0] 
deDosEnDos 1 = [1] 
deDosEnDos n = n:deDosEnDos (n-2)

factorial 0 = 1
factorial n = n*factorial (n-1)

misum [] = 0
misum (x:xs) = x + misum xs

milength [] = 0
milength lista = 1 + milength (tail lista)

mimaximum [x] = x
mimaximum (x:xs)  = max x (mimaximum xs) 

reina = "isabel"

casan "isabel" "felipe" = "carlos"
casan "carlos" "diana" = "guillermo"
casan "guillermo" "catalina" = "jorge"

--dinastia reina ["felipe","diana","catalina"]

--dinastia persona [] = persona
--dinastia persona (conyuge:conyuges) = dinastia (casan persona conyuge) conyuges   

dinastia persona conyuges = foldl casan persona conyuges

dinastia' :: String -> [String]-> String
dinastia' = foldl casan

miotrosum:: [Int] -> Int
miotrosum = foldl (+) 0 