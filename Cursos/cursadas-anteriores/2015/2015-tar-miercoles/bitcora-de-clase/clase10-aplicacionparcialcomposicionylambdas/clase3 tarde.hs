sumarUnoATodos numeros = map sumarUno numeros
sumarUnoATodos' numeros = map (\numero -> numero + 1) numeros
sumarUnoATodos'' numeros = map (+1) numeros

sumarUno numero = numero + 1

pares numeros = filter even numeros
pares'  = filter even 

entre minimo maximo numero = minimo <= numero && maximo >= numero

-- queremos hacer una función que me retorne una lista de booleanos (?)
-- que indiquen si el número que me pasan está entre 3 y cada uno de
-- los máximos de la lista

-- nos hacemos esta función auxiliar de momento
entre3y maximo num = entre 3 maximo num

-- alternativa tranqui con expresión lambda
floca num maximos = map (\max -> entre3y max num) maximos

-- alternativa fumeta con flip y aplicación parcial
floca' num maximos = map (flip entre3y num) maximos

-- alternativa más mejor sin la función fea entre3y
floca'' num maximos = map (flip (entre 3) num) maximos

---------


--Vemos composición, acá quedó un ejemplo de una composición más o menos compleja
-- (cuya funcionalidad no es particularmente importante, es sólo para jugar un rato)

-- la lista de numeros se aplica a toda la función compuesta
-- esos paréntesis que delimitan la composición son necesarios para que el filter no se aplique totalmente y deje de ser función (ya no se podría componer)
-- si prueban quitarle esos paréntesis van a ver que Haskell les tira error de tipos al tratar de cargar el programa

otraFLoca numeros = ((*2).length.map (+2).filter even) numeros 

-- podemos definir la misma función sin explicitar el parámetro numeros, sino estableciendo una equivalencia con la otra función (Notación point-free)
-- el tipo de otraFLoca' es igual al de la expresión a la derecha del =, es una función que espera una lista de números y retorna un número

otraFLoca' = (*2).length.map (+2).filter even
