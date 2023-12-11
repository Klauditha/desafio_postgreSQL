/*
2. Cruza los datos de la tabla usuarios y posts, mostrando las siguientes columnas:
nombre y email del usuario junto al título y contenido del post.
*/

SELECT U.nombre, U.email, P.titulo, P.contenido
FROM Usuarios U
    JOIN Posts P ON U.id = P.usuario_id

/*
3. Muestra el id, título y contenido de los posts de los administradores.
a. El administrador puede ser cualquier id.
*/

SELECT P.id, P.titulo, P.contenido
FROM Usuarios U
    JOIN Posts P ON U.id = P.usuario_id
WHERE U.rol
ilike 'administrador'

/*
4. Cuenta la cantidad de posts de cada usuario.
a. La tabla resultante debe mostrar el id e email del usuario junto con la
cantidad de posts de cada usuario.
*/

SELECT U.id, U.email, COUNT(P.id) AS Cantidad_Posts
FROM Usuarios U
    LEFT JOIN Posts P ON U.id = P.usuario_id
GROUP BY U.id, U.email


/*
5. Muestra el email del usuario que ha creado más posts.
    a. Aquí la tabla resultante tiene un único registro y muestra solo el email.
*/

SELECT *
FROM
    (SELECT U.email, COUNT(P.id) AS Cantidad_Posts
    FROM Usuarios U
        JOIN Posts P ON U.id = P.usuario_id
    GROUP BY U.email) AS QUERY
WHERE cantidad_posts = (SELECT COUNT(id) AS CONTADOR
FROM Posts
GROUP BY usuario_id
ORDER BY CONTADOR DESC LIMIT 1 ) 


/*
6. Muestra la fecha del último post de cada usuario.
*/
SELECT U.id
AS IdUsuario, MAX
(P.fecha_creacion) Fecha_Ultimo_Post
	FROM Usuarios U 
	JOIN Posts P ON U.id = P.usuario_id
	GROUP BY U.id
	ORDER BY U.id

/*
7. Muestra el título y contenido del post (artículo) con más comentarios.
*/

SELECT titulo, contenido AS articulo
FROM
    (SELECT P.titulo, P.contenido, COUNT(C.id) AS Cantidad_Comentario
    FROM Posts P
        JOIN Comentarios C ON P.id = C.post_id
    GROUP BY P.titulo, P.contenido
    ORDER BY Cantidad_Comentario DESC
LIMIT 1) AS QUERY

/*
8. Muestra en una tabla el título de cada post, el contenido de cada post y el contenido
de cada comentario asociado a los posts mostrados, junto con el email del usuario
que lo escribió.
*/

SELECT P.titulo, P.contenido as contenido_post, C.contenido as contenido_comentario, U.email FROM Posts P
JOIN Comentarios C ON C.post_id = P.id
JOIN Usuarios U  ON C.usuario_id = U.id


/*
9. Muestra el contenido del último comentario de cada usuario.
*/
SELECT C.contenido, C.usuario_id as usuario FROM Comentarios C
JOIN (	SELECT MAX(C.fecha_creacion) AS fecha_creacion , U.id FROM Comentarios C 
		JOIN Usuarios U  ON C.usuario_id = U.id
		GROUP BY U.id) AS QUERY
ON C.fecha_creacion = query.fecha_creacion

/*
10. Muestra los emails de los usuarios que no han escrito ningún comentario.
*/
SELECT U.email FROM Usuarios U
LEFT JOIN Comentarios C ON U.id = C.usuario_id
WHERE C.id IS NULL
