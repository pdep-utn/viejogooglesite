actua(diCaprio,titanic).
actua(diCaprio,atrapameSiPuedes).
actua(diCaprio,gilbertGrape).
actua(jeanReno,elProfesional).
actua(bruceWillis,duroDeMatar).

genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(duroDeMatar, accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).

estreno(titanic,fecha(10,12,1998)).
estreno(gilbertGrape,fecha(19,1,1980)).
estreno(ironMan,fecha(20,2,2005)).
estreno(elProfesional,fechaYanqui(10,12,1980)).
estreno(rapidoYFurioso,fechaYanqui(2,28,2002)).
estreno(duroDeMatar,fechaYanqui(12,28,1990)).
estreno(forrestGump,fechaHorrible(19902003)).

pelicula(Peli):- genero(Peli,_).
pelicula(forrestGump).

/*Se quiere modelar los gustos cinéfilos de maría, juan y josé.
Se sabe que a juan le copan las películas de acción y en las que actúa jean renó,
que a maría le gustan los dramas de dicaprio y forrest gump y no le gusta el profesional,
y a josé le gustan los dramas en los que no trabaja dicaprio*/

leCopa(juan,Peli):- genero(Peli,accion).
leCopa(juan,Peli):- actua(jeanReno,Peli).
leCopa(maria,Peli):- actua(diCaprio,Peli), genero(Peli,drama).
leCopa(maria,forrestGump).
leCopa(jose,Peli):- genero(Peli,drama), not(actua(diCaprio,Peli)).

ganoOscar(titanic).
ganoOscar(duroDeMatar).
ganoOscar(elProfesional).
ganoOscar(forrestGump).

ganador(Actor):- actua(Actor, Pelicula),
	ganoOscar(Pelicula).
actorCapo(Actor):- actua(Actor,_),
	forall(actua(Actor,Pelicula),ganoOscar(Pelicula)).
	
buenAnio(Anio):- anio(Anio),
	forall(anioDeEstreno(Pelicula,Anio), ganoOscar(Pelicula)).
	
anio(Anio):- anioDeEstreno(_,Anio).

anioDeEstreno(Pelicula,Anio):- estreno(Pelicula,Fecha),
	anioDeFecha(Fecha,Anio).

anioDeFecha(fechaHorrible(Nro),Anio):- Anio is Nro // 10000.
anioDeFecha(fecha(_,_,Anio),Anio).
anioDeFecha(fechaYanqui(_,_,Anio),Anio).
anioDeFecha(fechaAnsi(Anio,_,_),Anio).

esBuenaPelicula(Pelicula, Personas):-
	pelicula(Pelicula),
	forall( member(Persona, Personas), leCopa(Persona, Pelicula)).