%% TESTS %%

:-begin_tests(punto2).

test(provincias_picantes, set(Provincia = [buenosAires, chaco])):-esPicante(Provincia).

test(provincia_no_picante_por_pocos_habitantes):-not(esPicante(sanLuis)).

test(provincia_no_picante_por_un_partido_solo):-not(esPicante(santaFe)).

:-end_tests(punto2).

:-begin_tests(punto3).

test(le_gana_entre_dos_partidos_elige_el_ganador, nondet):-leGanaA(frank, garrett, tierraDelFuego).

test(le_gana_si_hay_un_solo_partido, nondet):-leGanaA(frank, jackie, santaFe).

test(no_puede_ganar_si_el_partido_no_se_presenta_en_la_provincia, nondet):-not(leGanaA(claire, jackie, misiones)).

test(le_gana_si_ambos_son_del_mismo_partido_y_el_partido_se_presenta_en_la_provincia, nondet):-leGanaA(frank, claire, tierraDelFuego).

test(no_puede_ganar_si_dos_partidos_empatan_en_votos, nondet):-not(leGanaA(heather, linda, buenosAires)).

:-end_tests(punto3).

:-begin_tests(punto4).

test(grandes_candidatos, set(Candidato = [frank])):-elGranCandidato(Candidato).

test(candidatos_que_no_son_grandes, set(Candidato = [claire, catherine, linda, garrett, seth, heather, jackie])):-
    esCandidato(Candidato, _), not(elGranCandidato(Candidato)).

:-end_tests(punto4).


:-begin_tests(punto5).

test(ajuste_partido_ganador_resta_porcentaje, nondet) :- ajusteConsultora(rojo, buenosAires, 20).

test(ajuste_partido_perdedor_suma_porcentaje, nondet) :- ajusteConsultora(amarillo, tierraDelFuego, 15).

:-end_tests(punto5).


:-begin_tests(punto7).

test(candidatos_serios, set(Candidato = [claire])):-serio(Candidato).

test(candidatos_no_serios_no_pueden_cumplir_suficientes_promesas, set(Candidato = [garrett, seth, frank, heather, jackie, linda, catherine])):-
    esCandidato(Candidato, _), not(serio(Candidato)).

:-end_tests(punto7).

:-begin_tests(punto8).

test(esta_arreglado, set(Candidato = [frank])):-estaArreglado(Candidato).

test(no_esta_arreglado, set(Candidato = [garrett, claire, seth, heather, jackie, linda, catherine])):-
    esCandidato(Candidato, _), not(estaArreglado(Candidato)).

:-end_tests(punto8).

:-begin_tests(punto9).

test(el_favorito, set(Candidato = [garrett])) :- elFavorito(Candidato).

test(promesa_negativa, set(Candidato = [claire, frank])) :- tienePromesaNegativa(Candidato).

test(puntaje_total, nondet) :- puntajeTotal(garrett, 11).

:-end_tests(punto9).