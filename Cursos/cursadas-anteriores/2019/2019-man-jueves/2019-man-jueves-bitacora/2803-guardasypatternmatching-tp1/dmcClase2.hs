--GitHub :) 

--PATTERN MATCHING

esManoDeNero "Pasta breaker" = True
esManoDeNero "Buster arm" = True
esManoDeNero "Tomboy" = True
esManoDeNero "banana" = False
esManoDeNero "mamaDeGuille" = False
esManoDeNero _ = False

precio "Diablito" = 600
precio "Diablito volador" = 800
precio "Diablito re groso" = 2500



--GUARDAS
rangoDeCombo :: Int -> String
rangoDeCombo cantGolpes | cantGolpes <= 10 = "D"
                        | cantGolpes >=11 && cantGolpes <= 30 = "A"
                        | otherwise = "SSS"


modulo x | x>= 0 = x
         | otherwise = 0-x










