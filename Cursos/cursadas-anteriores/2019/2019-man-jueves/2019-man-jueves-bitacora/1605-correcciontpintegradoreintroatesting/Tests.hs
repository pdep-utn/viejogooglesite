import Test.Hspec
import TP

main = hspec $ do
  describe "Primera Parte" $ do
    describe "Al realizar su truco favorito:" $ do
      it "la nafta de RochaMcQueen es correcta" $ do
        (nafta . hacerSuTruco) rochaMcQueen `shouldBe` 300
      it "la velocidad de biankerr es correcta" $ do
        (velocidad . hacerSuTruco) biankerr `shouldBe` 28
      it "la velocidad de gushtav es correcta" $ do
        (velocidad . hacerSuTruco) gushtav `shouldBe` 145
      it "Le enamorade de rodra es correcta" $ do
        (enamorade . hacerSuTruco) rodra `shouldBe` "gushtav"

    describe "Incrementos de velocidad" $ do
      it "RochaMcQueen incrementa su velocidad correctamente" $ do
        (velocidad . incrementarVelocidad) rochaMcQueen `shouldBe` 30
      it "Biankerr incrementa su velocidad correctamente" $ do
        (velocidad . incrementarVelocidad) biankerr `shouldBe` 50
      it "Gushtav incrementa su velocidad correctamente" $ do
        (velocidad . incrementarVelocidad) gushtav `shouldBe` 160
      it "Rodra incrementa su velocidad correctamente" $ do
        (velocidad . incrementarVelocidad) rodra `shouldBe` 80

    describe "Posibilidad de usar su truco" $ do
      it "RochaMcQueen debe poder usar su truco" $ do
        rochaMcQueen `shouldSatisfy` puedeRealizar (truco rochaMcQueen)
      it "Gushtav NO debe poder usar su truco" $ do
        gushtav `shouldNotSatisfy` puedeRealizar (truco gushtav)
      it "Rodra NO debe poder usar su truco" $ do
        rodra `shouldNotSatisfy` puedeRealizar (truco rodra)

    describe "Otros trucos" $ do
      it "comboLoco modifica nafta correctamente" $ do
        (nafta . comboLoco) rochaMcQueen `shouldBe` 303
      it "comboLoco modifica velocidad correctamente" $ do
        (velocidad . comboLoco) rochaMcQueen `shouldBe` 15
      it "queTrucazo modifica velocidad correctamente" $ do
        (velocidad . queTrucazo) rodra `shouldBe` 100
      it "turbo modifica velocidad correctamente en Gushtav" $ do
        (velocidad . turbo) gushtav `shouldBe` 2130
      it "turbo modifica nafta correctamente en Gushtav" $ do
        (nafta . turbo) gushtav `shouldBe` 1
      it "turbo modifica velocidad correctamente en Rodra" $ do
        (velocidad . turbo) rodra `shouldBe` 50
      it "turbo modifica nafta correctamente en Rodra" $ do
        (nafta . turbo) rodra `shouldBe` 1

  describe "Segunda Parte" $ do
    let aplicarTrampa = modificarParticipantes
    let tieneNombre nombreParticipante = (== nombreParticipante) . nombre
    let estaParticipando nombreParticipante = any (tieneNombre nombreParticipante)
    let noEstaParticipando nombreParticipante = not . estaParticipando nombreParticipante
    describe "Las trampas" $ do
      it "La cantidad de participantes de potreroFunes luego de sacarUno debe ser 3" $ do
        (length . participantes . aplicarTrampa sacarUno) potreroFunes `shouldBe`3
      it "rochaMcQueen ya no participa en potreroFunes tras sacarUno" $ do
        (participantes . aplicarTrampa sacarUno) potreroFunes `shouldSatisfy` noEstaParticipando "rochaMcQueen"
      it "La cantidad de participantes de potreroFunes luego de la pocaReserva debe ser 3" $ do
        (length . participantes . aplicarTrampa pocaReserva) potreroFunes `shouldBe` 3
      it "Rodra ya no debería estar entre los participantes de potreroFunes luego de la pocaReserva" $ do
        (participantes . aplicarTrampa pocaReserva) potreroFunes `shouldSatisfy` noEstaParticipando "rodra"
      it "Consultar la velocidad del último participante de potreroFunes (rodra) luego de la lluvia" $ do
        (velocidad . last . participantes . aplicarTrampa lluvia) potreroFunes `shouldBe` 40

    describe "Más trucos" $ do
      let unGranTruco = elGranTruco [nitro, deReversa, impresionar]
      it "Consultar el nivelDeNafta de rodra tras realizar llenarTanque" $ do
        (nafta . llenarTanque) rodra `shouldBe` 300
      it "Consultar la velocidad de rodra tras realizar elGranTruco con nitro, deReversa e impresionar" $ do
        (velocidad . unGranTruco) rodra `shouldBe` 70
      it "Consultar el nivelDeNafta de rodra tras realizar elGranTruco con nitro, deReversa e impresionar" $ do
        (nafta . unGranTruco) rodra `shouldBe` 13
      it "Consultar la velocidad de rodra tras realizar multiNitro con 5 tanques" $ do
        (velocidad . multiNitro 5) rodra `shouldBe` 125

    describe "¡A correr!" $ do
      it "Consultar el nivel de nafta del primer participante (biankerr porque rochaMcQueen quedó afuera) luego de dar una vuelta en potreroFunes." $ do
        (nafta . head . participantes . darVuelta) potreroFunes `shouldBe` 490
      it "Consultar la velocidad del primer participante (biankerr porque rochaMcQueen quedó afuera) luego de dar una vuelta en potreroFunes." $ do
        (velocidad . head . participantes . darVuelta) potreroFunes `shouldBe` 28
      it "Consultar la cantidad de participantes tras dar dos vueltas en potrero funes" $ do
        (length. participantes . darVuelta . darVuelta) potreroFunes `shouldBe` 2
      it "Luego de 2 vueltas en potreroFunes, el nivelDeNafta del primer participante (gushtav) debe ser 70" $ do
        (nafta . head . participantes . darVuelta . darVuelta) potreroFunes `shouldBe` 70
      it "Queda un participante luego de correr potreroFunes" $ do
        (length . participantes . correrCarrera) potreroFunes `shouldBe` 1
      it "Rodra participa en potreroFunes tras correr la carrera" $ do
        (participantes . correrCarrera) potreroFunes `shouldSatisfy` estaParticipando "rodra"
        
    describe "¿Quién gana?" $ do
      it "Rodra es el ganador de potreroFunes" $ do
        quienGana potreroFunes `shouldSatisfy` tieneNombre  "rodra"

    describe "La gran carrera" $ do
      let infinitosParticipantes = rodra : rochaMcQueen : gushtav : infinitosParticipantes
      let potreroInfinito = Carrera{
        vueltas = 3,
        longitudPista = 5,
        publico = ["Ronco", "Tinch", "Dodain"],
        trampa = neutralizarTrucos,
        participantes = infinitosParticipantes
      }

      it "Podemos conocer el primer participante luego de 2 vueltas" $ do
        (head . participantes . darVuelta . darVuelta) potreroInfinito `shouldSatisfy` tieneNombre  "rodra"