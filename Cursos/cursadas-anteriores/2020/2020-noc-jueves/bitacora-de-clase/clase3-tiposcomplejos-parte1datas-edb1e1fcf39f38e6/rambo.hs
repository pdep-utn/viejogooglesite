{-
  Práctica: clase 3
  Rambo tiene dos armas: una principal y una secundaria, 
  cada una con un cargador de cierta capacidad con alguna cantidad de balas.

  1- Averiguar cuántas balas le quedan a Rambo en total
  2- Dada un arma, disparar si tiene balas
  3- Hacer que Rambo dispare todo a la vez
-}

data Arma = Arma {
  balas :: Int,
  tamañoCargador :: Int
} deriving (Eq, Show)

data Rambo = Rambo {
  armaPrincipal :: Arma,
  armaSecundaria :: Arma
} deriving (Eq, Show)


balasTotales :: Rambo -> Int
balasTotales rambo = balas (armaPrincipal rambo) + balas (armaSecundaria rambo)


{-
Más detalles sobre disparar un arma:
- Si el cargador esta lleno, Rambo se confía y dispara 2 tiros
- Si el cargador no está lleno pero tiene al menos una bala la dispara
- Si el cargador está vacío, Rambo gatilla pero no pasa nada
-}

disparar :: Arma -> Arma
disparar arma | balas arma == tamañoCargador arma = arma{balas = balas arma - 2}
              | balas arma > 0                    = arma{balas = balas arma - 1}
              | otherwise                         = arma

dispararTodo :: Rambo -> Rambo
dispararTodo rambo = rambo{
                       armaPrincipal = disparar (armaPrincipal rambo),
                       armaSecundaria = disparar (armaSecundaria rambo)
                     }
