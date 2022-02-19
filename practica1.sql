
/* Consultas a resolver 
-- insertar 5 tuplas adicionales en curso_has_estudiante
-- 1: Listar los alumnos con estatus de regular (considere que un alumno regular puede tener no aprobada como máximo una materia)
-- 2: Listar el porcentaje de no aprobados por materia en los semestres 20212 y 20221 
-- 3: Listar los profesores que aprobaron a todos sus alumnos en todas sus materias
-- 4: Listar los profesores con el mayor porcentaje de no aprobados en los semestres 20212 y 20221
-- 5: Determinar si en la materia T302 existe un porcentaje de no aprobados entre el 30% y 50% en cada uno de sus grupos.
-- 6: Listar los alumnos que han aprobado todas las asignaturas que imparte el profesor  10275287
*/











/*
-- 4: Listar los profesores con el mayor porcentaje de no aprobados en los semestres 20212 y 20221
*/


SELECT Cursado.idProfesor, COUNT()*100/(SELECT COUNT() 
					FROM Curso Cursado INNER JOIN Curso_Has_Estudiante CursoHas
					ON Cursado.idMateria=CursadoHas.idMateria AND Cursado.grupo = CursadoHas.grupo AND Cursado.Semetre LIKE "2021_") AS "INDICE_REPROBADOS_EN_20211-20212"
                    FROM CURSO Cursado INNER JOIN Curso_Has_Estudiante CursadoHas
					ON Cursado.idMateria = CursadoHas.idMateria AND Cuesado.grupo = CursadoHas.grupo AND Cursado.SEMESTRE LIKE "2021_" AND CALIFICACION <6
					GROUP BY Cursasdo.idProfesor
                    ORDER BY 2 DESC;

