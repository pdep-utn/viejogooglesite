f x y z = x z y 

cuantosVerificanLaCondicion condicion lista = length (filter condicion lista)


data PC = UnaPc{ram::Int, marca::String,disco::Int} deriving Show

--comprarMemoria n mipc = mipc{ram = ram mipc + n, disco = disco mipc + 1}
--gastarMemoria tiempo mipc = mipc{ram = ram mipc - 2*tiempo, disco = disco mipc + 1}
--incendio mipc = mipc{ram = 0, disco = disco mipc + 1}
--superActualizacion mipc = mipc{ram = ram mipc ^2, disco = disco mipc + 1}

pc1 = UnaPc{ram = 8, marca = "PH", disco = 100}


comprarMemoria n mipc = actualizarRam (+n) mipc
superActualizacion mipc = actualizarRam (^2) mipc
gastarMemoria tiempo mipc = actualizarRam (+(2*tiempo*(-1))) mipc
incendio mipc = actualizarRam (\x -> 0) mipc

actualizarRam queHacerConLaRam mipc = mipc{ram = queHacerConLaRam (ram mipc), disco = disco mipc + 1}
	


