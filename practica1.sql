
/*
GAMBOA DEL ANGEL ALAN EDUARDO
2019640190
3TM3

*/


-- 1: Listar los alumnos con estatus de regular (considere que un alumno regular puede tener no aprobada como máximo una materia)



CREATE VIEW 
Reprobados AS 
SELECT idEstudiante, count(*) as "Cantidad_Reprobadas"
FROM curso_has_estudiante
WHERE calificacion < 6
GROUP BY idEstudiante;

SELECT DISTINCT(idEstudiante) 
FROM 
curso_has_estudiante
WHERE idEstudiante NOT IN (SELECT idEstudiante
						FROM Reprobados
						WHERE Cantidad_Reprobadas >= 2) AND calificacion BETWEEN 6 AND 10;
                        


-- 2: Listar el porcentaje de no aprobados por materia en los semestres 20212 y 20221 
SELECT idMateria, count(*) /  (SELECT count(*) 
							  FROM curso_has_estudiante
							  WHERE Semestre LIKE "2021_2") AS "Porcentaje de Alumnos reprobados "
FROM curso_has_estudiante
WHERE calificacion <6 AND semestre LIKE "2022_1"
GROUP BY idMateria;


-- 3: Listar los profesores que aprobaron a todos sus alumnos en todas sus materias

SELECT DISTINCT(idProfesor) FROM Curso
WHERE idProfesor  NOT IN (SELECT DISTINCT(idProfesor)
						FROM curso Cursado INNER JOIN curso_has_estudiante cursasdohas
						ON Cursado.idMateria=cuhas.idMateria and Cursado.grupo=cursadohas.grupo
						WHERE calificacion <6);








-- 4: Listar los profesores con el mayor porcentaje de no aprobados en los semestres 20212 y 20221



SELECT Cursado.idProfesor, COUNT(*)*100/(SELECT COUNT(*) 
					FROM Curso Cursado INNER JOIN Curso_Has_Estudiante CursoHas
					ON Cursado.idMateria=CursadoHas.idMateria AND Cursado.grupo = CursadoHas.grupo AND Cursado.Semetre LIKE "2021_") AS "INDICE_REPROBADOS_EN_20211-20212"
                    FROM CURSO Cursado INNER JOIN Curso_Has_Estudiante CursadoHas
					ON Cursado.idMateria = CursadoHas.idMateria AND Cuesado.grupo = CursadoHas.grupo AND Cursado.SEMESTRE LIKE "2021_" AND CALIFICACION <6
					GROUP BY Cursasdo.idProfesor
                    ORDER BY 2 DESC;


-- 5: Determinar si en la materia T302 existe un porcentaje de no aprobados entre el 30% y 50% en cada uno de sus grupos.
SELECT  grupo, count(*)*100/(SELECT count(*) 
							FROM curso_has_estudiante
							WHERE idMateria="T302") AS "Porcentaje_Reprobados"
FROM curso_has_estudiante
WHERE idMateria="T302" AND calificacion < 6
GROUP BY grupo
HAVING "Porcentaje_de_Reprobados" BETWEEN 30 AND 50;

-- 6: Listar los alumnos que han aprobado todas las asignaturas que imparte el profesor  10275287
SELECT*
FROM curso cursado INNER JOIN curso_has_estudiante cuhas
ON cursado.idMateria=cuhas.idMateria AND cursado.grupo=cursadohas.grupo AND idProfesor=10275287
WHERE idEstudiante NOT IN (SELECT DISTINCT (idEstudiante) 
						  FROM curso cursado INNER JOIN curso_has_estudiante cursadohas
						  ON cursado.idMateria=cuhas.idMateria AND cursado.grupo=cursadohas.grupo AND idProfesor=10275287 AND calificacion < 6);

