CREATE DATABASE instituto_academico;

USE instituto_academico;


CREATE TABLE programa (
    programa_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_programa VARCHAR(100) NOT NULL,
    nivel VARCHAR(50),
    duracion_semestres INT
);


CREATE TABLE docentes (
    docente_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_docente VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    especialidad VARCHAR(100)
);


CREATE TABLE cursos (
    curso_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_curso VARCHAR(100) NOT NULL,
    creditos INT,
    programa_id INT,
    docente_id INT,

    FOREIGN KEY (programa_id) REFERENCES programa(programa_id),
    FOREIGN KEY (docente_id) REFERENCES docentes(docente_id)
);


CREATE TABLE estudiantes (
    estudiante_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_estudiante VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    fecha_nacimiento DATE,
    estado VARCHAR(30)
);


CREATE TABLE matriculas (
    matricula_id INT PRIMARY KEY AUTO_INCREMENT,
    estudiante_id INT NOT NULL,
    curso_id INT NOT NULL,
    fecha_matricula DATE,
    estado VARCHAR(30),
    nota_final DECIMAL(5,2),

    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(estudiante_id),
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id),
    UNIQUE (estudiante_id, curso_id)
);


INSERT INTO programa
(nombre_programa, nivel, duracion_semestres)
VALUES
('Desarrollo de Software', 'Tecnico', 6),
('Diseño Grafico Digital', 'Tecnico', 4),
('Gestion Administrativa', 'Tecnologico', 6);


INSERT INTO docentes
(nombre_docente, correo, especialidad)
VALUES
('Rodolfo Zapata', 'rodol.zapata@gmail.com', 'Programacion'),
('Juan David Nieto', 'juan.nieto@gmail.com', 'Bases de datos'),
('Andres Gomez', 'andres.gomez@gmail.com', 'Diseño digital'),
('Sandra Lopez', 'sandra.lopez@gmail.com', 'Administracion');


INSERT INTO cursos
(nombre_curso, creditos, programa_id, docente_id)
VALUES
('Fundamentos de Programacion', 4, 1, 1),
('Bases de Datos', 3, 1, 2),
('Diseno Digital', 3, 2, 3),
('Experiencia de Usuario UX', 3, 2, 3),
('Administracion General', 4, 3, 4),
('Emprendimiento', 2, 3, 4);

INSERT INTO estudiantes
(nombre_estudiante, correo, fecha_nacimiento, estado)
VALUES
('Victoria Garcia', 'victoria.garcia@gmail.com', '2003-06-24', 'Activo'),
('Santiago Jimenez', 'santi.jimenez@gmail.com', '2005-10-27', 'Activo'),
('Juan Perez', 'juan.perez@gmail.com', '2004-02-10', 'Activo'),
('Camila Rodriguez', 'camila.rodriguez@gmail.com', '2003-11-30', 'Activo'),
('Sofia Herrera', 'sofia.herrera@gmail.com', '2001-07-19', 'Activo'),
('Miguel Castro', 'miguel.castro@gmail.com', '2002-04-05', 'Inactivo'),
('Valentina Morales', 'valentina.morales@gmail.com', '2004-09-12', 'Activo'),
('Sebastian Diaz', 'sebastian.diaz@gmail.com', '2003-01-25', 'Inactivo');

INSERT INTO matriculas
(estudiante_id, curso_id, fecha_matricula, estado, nota_final)
VALUES
(1, 1, '2026-01-15', 'Finalizada', 4.5),
(1, 2, '2026-01-16', 'Activa', NULL),
(2, 1, '2026-01-15', 'Finalizada', 3.8),
(2, 3, '2026-01-17', 'Activa', NULL),
(3, 2, '2026-01-16', 'Retirada', 2.1),
(3, 4, '2026-01-18', 'Finalizada', 4.8),
(4, 3, '2026-01-17', 'Finalizada', 3.5),
(4, 5, '2026-01-19', 'Activa', NULL),
(5, 1, '2026-01-15', 'Finalizada', 2.9),
(6, 5, '2026-01-19', 'Retirada', 1.5),
(7, 6, '2026-01-20', 'Finalizada', 4.2),
(8, 2, '2026-01-16', 'Activa', NULL);

select * from matriculas;

/*punto 8 de la guía: Actualizar el estado de una matricula a "retirada"
 * y cambiar la especialidad de un docente. */

UPDATE matriculas SET estado = 'Retirada' WHERE matricula_id = 5;

UPDATE docentes SET especialidad = 'Desarrollo Web' WHERE docente_id = 1;


/*punto 9 de la guía: Asignar nota a una matricula que no tenga calificación.*/

UPDATE matriculas SET nota_final = 4.0 WHERE matricula_id = 2;


/*punto 10: Eliminar un registro de prueba sin relaciones.*/

INSERT INTO docentes (nombre_docente, correo, especialidad)
values ('Docente de Prueba', 'prueba@gmail.com', 'Prueba');

select * from docentes where correo = 'prueba@gmail.com'

DELETE FROM docentes WHERE correo = 'prueba@gmail.com';

/*punto 10: Intentar eliminar un programa que tenga cursos asociados 
 * y observa la protección de la FK.*/

DELETE FROM programa WHERE programa_id = 1;
/*SQL Error [1451] [23000]: Cannot delete or update a parent row: a foreign key constraint fails 
 * (`instituto_academico`.`cursos`, CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`programa_id`) REFERENCES `programa` (`programa_id`))
 */


/*punto 11: Mostrar todos los estudiantes ordenados alfabeticamente*/

select * from estudiantes order by nombre_estudiante asc;


/*punto 12: Lista estudiantes activos cuyo nombre comience por una letra elegida (M), usando LIKE.*/

select * from estudiantes where estado = 'Activo' and nombre_estudiante like '%M%';


/*punto 13: Muestra cursos con 3 o más créditos, de mayor a menor.*/


select * from cursos where creditos >= 3 order by creditos desc;


/*punto 14: Consulta matrículas dentro de un rango de fechas.*/

select * from matriculas where fecha_matricula between '2026-01-15' and '2026-01-18';


/*punto 15: Muestra el nombre de cada curso y su programa.*/

select
    c.nombre_curso,
    p.nombre_programa
from cursos c
inner join programa p
    on c.programa_id = p.programa_id;


/*punto 16: Lista cada curso con el nombre y correo del docente responsable.*/

select 
    c.nombre_curso,
    d.nombre_docente,
    d.correo
from cursos c
inner join docentes d
    on c.docente_id = d.docente_id;


/*punto 17: Muestra estudiante, curso, fecha y estado de cada matrícula.*/

select 
    e.nombre_estudiante,
    c.nombre_curso,
    m.fecha_matricula,
    m.estado
from matriculas m
inner join estudiantes e
    on m.estudiante_id = e.estudiante_id
inner join cursos c
    on m.curso_id = c.curso_id;


/*punto 18: Muestra estudiante, curso y nota final, solo para matrículas calificadas.*/

SELECT
    e.nombre_estudiante,
    c.nombre_curso,
    m.nota_final
FROM matriculas m
INNER JOIN estudiantes e
    ON m.estudiante_id = e.estudiante_id
INNER JOIN cursos c
    ON m.curso_id = c.curso_id
WHERE m.nota_final IS NOT NULL;


/*punto 19: Lista todos los estudiantes y sus matrículas si existen; incluye quienes no tienen matrículas (LEFT JOIN).*/

SELECT
    e.nombre_estudiante,
    m.matricula_id,
    c.nombre_curso,
    m.fecha_matricula,
    m.estado
FROM estudiantes e
LEFT JOIN matriculas m
    ON e.estudiante_id = m.estudiante_id
LEFT JOIN cursos c
    ON m.curso_id = c.curso_id;


/*punto 20: Identifica cursos sin estudiantes matriculados (LEFT JOIN e IS NULL).*/

SELECT
    c.curso_id,
    c.nombre_curso
FROM cursos c
LEFT JOIN matriculas m
    ON c.curso_id = m.curso_id
WHERE m.matricula_id IS NULL;


/*punto 21: Cuenta cuántos estudiantes hay registrados por estado.*/

SELECT
    estado,
    COUNT(*) AS cantidad_estudiantes
FROM estudiantes
GROUP BY estado;
