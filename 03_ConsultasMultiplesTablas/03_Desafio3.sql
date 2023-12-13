/**************************************************************************/
/* CREATE DATABASE                                                        */
/**************************************************************************/
-- Database: desafio3_Claudia_Villarroel_123
-- DROP DATABASE IF EXISTS "desafio3_Claudia_Villarroel_123";
CREATE DATABASE "desafio3_Claudia_Villarroel_123"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Chile.1252'
    LC_CTYPE = 'Spanish_Chile.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


/**************************************************************************/
/* SETUP                                                                  */
/**************************************************************************/

/*  TABLA USUARIOS */
CREATE TABLE Usuarios(
    id serial,
    email varchar(50),
    nombre varchar(50),
    apellido varchar(50),
    rol varchar
);

/*  INSERT TABLA USUARIOS   */
INSERT INTO Usuarios(email, nombre, apellido, rol) VALUES
('atorres@example.com', 'Antonio', 'Perez', 'administrador'),
('bsoto@example.com', 'Bastian', 'Soto', 'usuario'),
('mvergara@example.com', 'Maria', 'Soto', 'usuario'),
('cmartinez@example.com', 'Camila', 'Martinez', 'usuario'),
('sjimenez@example.com', 'Susana', 'Jimenez', 'usuario');   


/*  TABLA POSTS */
CREATE TABLE Posts(
    id serial,
    titulo varchar,
    contenido text,
    fecha_creacion timestamp,
    fecha_actualizacion timestamp,
    destacado boolean,
    usuario_id bigint
);

/*  INSERT TABLA POSTS  */
INSERT INTO Posts(titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES
('Post 1', 'Nuestro primer post', '2022-01-01 12:25:00', '2022-01-02 18:00:05', true, 1),
('Post 2', 'Me parece una buena idea', '2022-02-01 23:05:00', '2022-02-04 15:40:20', true, 1),
('Post 3', 'Fue una gran experiencia', '2022-04-01 21:50:00', '2022-05-01 18:02:00', true, 2),
('Post 4', 'No me gusto', '2022-01-15 02:40:00', '2022-01-20 04:50:00', false, 5),
('Post 5', 'Me parece bien', '2022-08-11 12:45:10', '2022-09-01 00:25:00', true, 10);


/*  TABLA COMENTARIOS   */
CREATE TABLE Comentarios(
    id serial,
    contenido text,
    fecha_creacion timestamp,
    usuario_id bigint,
    post_id bigint
);

/*  INSERT TABLA COMENTARIOS    */
INSERT INTO Comentarios(contenido, fecha_creacion, usuario_id, post_id) VALUES
('Comentario 1', '2022-01-01 12:25:00', 1, 1),
('Comentario 2', '2022-02-01 23:05:00', 2, 1),
('Comentario 3', '2022-04-01 21:50:00', 3, 1),
('Comentario 4', '2022-01-15 02:40:00', 1, 2),
('Comentario 5', '2022-08-11 12:45:10', 2, 2); 

/**************************************************************************/
/* RESOLUCION DESAFIO                                                    */
/**************************************************************************/
/*
2. Cruza los datos de la tabla usuarios y posts, mostrando las siguientes columnas:
nombre y email del usuario junto al título y contenido del post.
*/

    SELECT 
        U.nombre, 
        U.email, 
        P.titulo, 
        P.contenido
    FROM Usuarios U
    JOIN Posts P ON U.id = P.usuario_id

/*
3. Muestra el id, título y contenido de los posts de los administradores.
a. El administrador puede ser cualquier id.
*/

    SELECT 
        P.id, 
        P.titulo, 
        P.contenido
    FROM Usuarios U
    JOIN Posts P ON U.id = P.usuario_id
    WHERE U.rol ilike 'administrador'

/*
4. Cuenta la cantidad de posts de cada usuario.
a. La tabla resultante debe mostrar el id e email del usuario junto con la
cantidad de posts de cada usuario.
*/

    SELECT 
        U.id, 
        U.email, 
        COUNT(P.id) AS Cantidad_Posts
    FROM Usuarios U
    LEFT JOIN Posts P ON U.id = P.usuario_id
    GROUP BY U.id, U.email

/*
5. Muestra el email del usuario que ha creado más posts.
    a. Aquí la tabla resultante tiene un único registro y muestra solo el email.
    (debe mostrar email del usuario y cantidad de posts creados)
*/

    SELECT * FROM
        (SELECT U.email, COUNT(P.id) AS Cantidad_Posts
        FROM Usuarios U
        JOIN Posts P ON U.id = P.usuario_id
        GROUP BY U.email) AS QUERY
    WHERE cantidad_posts = (SELECT COUNT(id) AS CONTADOR
                            FROM Posts
                            GROUP BY usuario_id
                            ORDER BY CONTADOR 
                            DESC LIMIT 1 ) 

/*
6. Muestra la fecha del último post de cada usuario.
 (debe mostrar email usuario, el titulo del post y fecha de creacion)
*/
    SELECT 
        U.email, 
        P.titulo, 
        MAX(P.fecha_creacion) AS fecha_creacion
    FROM Usuarios U 
    JOIN Posts P ON U.id = P.usuario_id
    WHERE P.fecha_creacion IN (SELECT MAX(fecha_creacion) FROM Posts
							  GROUP BY usuario_id)
    GROUP BY U.email, P.titulo

/*
7. Muestra el título y contenido del post (artículo) con más comentarios.
(debe mostrar titulo del post, contenido del post y cantidad de comentarios)
*/

    SELECT 
        P.titulo, 
        P.contenido, 
        COUNT(C.id) AS Cantidad_Comentarios
    FROM Posts P
    JOIN Comentarios C ON P.id = C.post_id
    GROUP BY P.titulo, P.contenido
    ORDER BY Cantidad_Comentarios DESC
    LIMIT 1

/*
8. Muestra en una tabla el título de cada post, el contenido de cada post y el contenido
de cada comentario asociado a los posts mostrados, junto con el email del usuario
que lo escribió.
(debe mostrar solo los posts que han sido comentados)
*/

    SELECT 
        P.titulo, 
        P.contenido AS contenido_post, 
        C.contenido AS contenido_comentario, 
        U.email 
    FROM Posts P
    JOIN Comentarios C ON C.post_id = P.id
    JOIN Usuarios U  ON C.usuario_id = U.id

/*
9. Muestra el contenido del último comentario de cada usuario.
(debe mostrar el email del usuario, el contenido del comentario y solo los usuarios que han hecho comentarios)
*/
    SELECT 
        C.contenido, 
        query.email  
    FROM Comentarios C
    JOIN (	SELECT MAX(C.fecha_creacion) AS fecha_creacion , U.email 
            FROM Comentarios C 
            JOIN Usuarios U  ON C.usuario_id = U.id
            GROUP BY U.email) AS query
    ON C.fecha_creacion = query.fecha_creacion

/*
10. Muestra los emails de los usuarios que no han escrito ningún comentario.
*/
    SELECT U.email FROM Usuarios U
    LEFT JOIN Comentarios C ON U.id = C.usuario_id
    WHERE C.id IS NULL
