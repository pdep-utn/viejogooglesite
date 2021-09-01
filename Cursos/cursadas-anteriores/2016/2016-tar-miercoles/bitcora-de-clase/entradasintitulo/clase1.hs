doble numero = numero * 2
cuadruple numero = doble numero * 2
cuadruple' numero = doble (doble numero)

-- no es necesaria la notación de tipos, Haskell es capaz de inferirlo. En este caso vemos que afecta a la funcionalidad, ya que acota el dominio a los valores de tipo Int exclusivamente. Ya volveremos a hablar de ese tema más adelante.
esPar :: Int -> Bool
esPar numero = mod numero 2 == 0

aprueba nota1 nota2 = notaAprobada nota1 && notaAprobada nota2
notaAprobada nota = nota >= 4