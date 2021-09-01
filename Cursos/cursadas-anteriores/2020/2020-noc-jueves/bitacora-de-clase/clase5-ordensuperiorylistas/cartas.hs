data Carta = Carta {
  nombre :: String,
  tags :: [String],
  velocidad :: Int,
  altura :: Int,
  peso :: Int,
  fuerza :: Int,
  peleas :: Int
} deriving (Eq, Show)

ponerTag :: String -> Carta -> Carta
ponerTag tag carta = carta{tags = tag : tags carta}

quitarTag :: String -> Carta -> Carta
quitarTag tag carta = carta{tags = filter (/= tag) (tags carta)}

batinombres :: [Carta] -> [String]
batinombres cartas = (filter ((=="bat").take 3) . map nombre) cartas

hayCartasConTodosLosTagsMuyLargos :: [Carta] -> Bool
hayCartasConTodosLosTagsMuyLargos cartas = (any (all ((>10) . length) . tags)) cartas

aliensCorregidos :: [Carta] -> [Carta]
aliensCorregidos cartas = 
  (map (ponerTag "alien" . quitarTag "alguien") . filter (elem "alguien" . tags)) cartas