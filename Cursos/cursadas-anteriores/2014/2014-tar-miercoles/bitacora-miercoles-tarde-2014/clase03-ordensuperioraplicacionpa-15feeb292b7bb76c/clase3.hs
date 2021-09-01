data TAlumno = Alumno String [Int] deriving (Show, Eq)
promedio (Alumno legajo notas) = sum notas `div` length notas
aprobo (Alumno legajo notas) = todasAprobadas notas
promociono alumno = promedio alumno >= 7 && aprobo alumno
notas (Alumno _ notas ) = notas

todasAprobadas notas = all (>= 4) notas

todosAprobaron alumnos = all aprobo alumnos

algunoPromociono alumnos = any promociono alumnos

-- Debería retornar algo como esto [("23456", 7), ("345432", 4)]
promediosDeAlumnos alumnos = map legajoPromedio alumnos

legajoPromedio alumno = (legajo alumno, promedio alumno)
legajo (Alumno legajo _) = legajo

-- Usando una lambda en vez de definir legajoPromedio
promediosDeAlumnos' alumnos = map (\alumno -> (legajo alumno, promedio alumno)) alumnos

-- Ejemplitos de aplicación vs composición
impar x = not (even x)
impar' x = (not.even) x
impar'' = not.even