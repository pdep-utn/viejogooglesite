type Objeto = String
type Mochila = [Objeto]
type Lugar = (String,Bool)
type LugaresVisitados = [Lugar]

data Hobbit = UnHobbit {
    nombre :: String,
    mochila :: Mochila,
    nivelHambre :: Int,
    lugaresVisitados :: LugaresVisitados
}deriving (Show)

--MOCHILA
mochilaFrodo :: Mochila
mochilaFrodo = ["anilloUnico", "cadena", "manzana", "panDeLembas", "dardo", "frascoDeLuz"]

mochilaSam :: Mochila
mochilaSam = ["sarten", "especias", "manzana", "panDeLembas", "cuerdaElfica"]

mochilaPippin :: Mochila
mochilaPippin = ["manzana", "manzana"]

algunObjetoEmpiezaConA :: Mochila -> Bool
algunObjetoEmpiezaConA mochila =
    any empiezaConA mochila 

empiezaConA :: Objeto -> Bool
empiezaConA = (=='a').head

aligerarMochila :: Mochila -> Mochila
aligerarMochila mochilaPesada = 
    filter esLiviano mochilaPesada

esLiviano :: Objeto -> Bool
esLiviano = (<8).length 

pesoMochilaDe :: Hobbit -> Int
pesoMochilaDe hobbit = 
    sum (map length (mochila hobbit))

darObjetoACompania :: [Hobbit] -> Objeto -> [Hobbit]
darObjetoACompania hobbits objeto =
    map (darObjetoAHobbit objeto) hobbits

darObjetoAHobbit :: Objeto -> Hobbit -> Hobbit
darObjetoAHobbit objeto hobbit =
    hobbit { mochila = objeto : (mochila hobbit)}



--HOBBITS
frodo = UnHobbit {nombre= "Frodo Bolson", mochila=mochilaFrodo}

sam = UnHobbit {nombre= "Sam Gamyi", mochila=mochilaSam}

pippin = UnHobbit{nombre="Peregrin Tuk", mochila=mochilaPippin}


