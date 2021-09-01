titular (evento, tematica, participacion, "Europa") = "Se realizo el gran "  ++ evento ++ " con una participacion de " ++  show (participacion*2)
titular (evento, tematica, participacion, "Bolivia") = "Se realizo el "  ++ evento ++ " con apenas " ++  show (div participacion 10) ++ " participantes"
titular (evento, tematica, participacion, lugar) 
  | importante tematica = noticiaRelleno
  | multitudinaria participacion =  show participacion ++ " personas participaron del " ++ evento ++ tematica
  | evento == "banderazo" = "Dale campeon"
  | otherwise = noticia1

noticiaRelleno = "Gran torneo de lol en La Rural"
noticia1 = "Comer tierra, nuevo metodo para adelgazar"
noticia2 = "La decencia de los que buscan en la basura"
noticia3 = "Un nuevo desafío en el mundo laboral, prepararse para trabajar hasta los 80"

multitudinaria participacion  = participacion > 10000

importante "despidos" = True
importante "Dia de la Memoria" = True
importante otros = False

incrementar porcentaje cantidad = cantidad * (1 + porcentaje/ 100)

difundir (evento, tematica, participacion, lugar) = (evento, tematica, incrementar 50 participacion, lugar) 

consecuencia "campeonato" = "banderazo"
consecuencia "despidos" = "piquete"
consecuencia "Dia de la Memoria" = "marcha"
consecuencia "Dia de Malvinas" = "desfile"
consecuencia otraCosa = "nada"

pasaronCosas quePaso = (consecuencia quePaso, quePaso, estimacionPolicial quePaso, "Argentina")

estimacionPolicial acto = fromIntegral (length acto) * 1000

cotizacionesDolar = [15.1, 22.5, 42.1, 37.2, 43.70,44.9, 44.5] 

eventoDolar cotizaciones 
  | last cotizaciones > 45.0 = ("cacerolazo", "dolar", maximum cotizaciones * 1000, "microcentro")
 | otherwise = nada   

nada = ("me quedo en mi casa", "esta todo bien", 1, "argentina")

noticiaDePobreza sectores = "El " ++ show (100/fromIntegral (length sectores)) ++ "% mas rico gana " ++ show (indiceDistribucion sectores) ++ " veces mas que el mas pobre"

indiceDistribucion sectores = head sectores / last sectores
