{-
  Práctica: clase 4
  Para un dominio dado con Clientes y Productos, definir:
	- nuevoClienteVIP :: String -> Cliente
	- comprar :: Producto -> Cliente -> Cliente
	- comprarEnPromoción :: Producto -> Producto -> Monto -> Cliente -> Cliente

-}

-- Punto de partida

data Cliente = Cliente {
  saldo :: Float,
  esVIP :: Bool,
  nombre :: String
} deriving (Eq, Show)

data Producto = Producto {
  tipo :: String,
  precio :: Float
} deriving (Eq, Show)


cambiarSaldo cliente delta = cliente{
  saldo = saldo cliente + delta
}

-- Resolución

nuevoClienteVIP :: String -> Cliente
nuevoClienteVIP = Cliente 0 True

comprar :: Producto -> Cliente -> Cliente
comprar producto cliente =
  (cambiarSaldo cliente . negate . precioNeto) producto
precioNeto :: Producto -> Float
precioNeto = (*1.21) . precio

comprarEnPromoción :: Producto -> Producto -> Float -> Cliente -> Cliente
comprarEnPromoción prod1 prod2 descuento cliente =
  ((`cambiarSaldo` descuento) . comprar prod2 . comprar prod1) cliente
