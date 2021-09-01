data Alumno = UnAlumno {nombre::String,legajo::Int, promedio::Float, estudioso::Bool} deriving Show

cansado::Alumno->Bool
cansado (UnAlumno nom leg prom est) = est && prom > 9

indice::Alumno->Float
indice (UnAlumno nom leg 10 est) = 1000
indice (UnAlumno nom leg prom True) = prom * 10
inidce alum = 1

puedeCursar::Alumno->Bool
puedeCursar alum = indice alum >= 60

--Por consola ingreso: 
--puedeCursar (UnAlumno "Pedro Perez" 117 8.5 True)
--La consola responde true, porque el indice es 85

--Ahora uso funciones que me define haskell automaticamente
-- existe la funcion legajo porque es uno de los componentes del alumno
esViejo alum = legajo alum < 100


--Como reflejo un cambio de estado en el alumno? Tengo que devolver un nuevo alumno con el nuevo estado

rendirFinal nota (UnAlumno nom leg prom est) = UnAlumno nom leg ((prom + nota)/2) est

temporadaDeFinales n1 n2 n3 alum = 
 rendirFinal n3 (rendirFinal n2 (rendirFinal n1 alum))
 
 --la ventaja de no desglosar el alumno en sus componentes es que si cambian sus componentes, no tengo que cambiar la funcion que usa al alumno. ejemplo: si el alumno tuviera otro parametro que es el pais de origen, no tengo que cambiar la funcion temporadaDeFinales. Si tendria que cambiar la funcion rendirFinal, porque tengo que agregar el nuevo componente al parametro que recibe rendirFinal.
