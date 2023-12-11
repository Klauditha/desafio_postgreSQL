/*CREACION DE BASE DE DATOS*/
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

/*TABLA USUARIOS*/
CREATE TABLE Usuarios(
    id serial,
    email varchar(50),
    nombre varchar(50),
    apellido varchar(50),
    rol varchar
);

/*INSERT TABLA USUARIOS*/
INSERT INTO Usuarios(email, nombre, apellido, rol) VALUES
('atorres@example.com', 'Antonio', 'Perez', 'administrador'),
('bsoto@example.com', 'Bastian', 'Soto', 'usuario'),
('mvergara@example.com', 'Maria', 'Soto', 'usuario'),
('cmartinez@example.com', 'Camila', 'Martinez', 'usuario'),
('sjimenez@example.com', 'Susana', 'Jimenez', 'usuario');   


/*TABLA POSTS*/
CREATE TABLE Posts(
    id serial,
    titulo varchar,
    contenido text,
    fecha_creacion timestamp,
    fecha_actualizacion timestamp,
    destacado boolean,
    usuario_id bigint
);

/*INSERT TABLA POSTS*/
INSERT INTO Posts(titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id) VALUES
('Post 1', 'Nuestro primer post', '2022-01-01 12:25:00', '2022-01-02 18:00:05', true, 1),
('Post 2', 'Me parece una buena idea', '2022-02-01 23:05:00', '2022-02-04 15:40:20', true, 1),
('Post 3', 'Fue una gran experiencia', '2022-04-01 21:50:00', '2022-05-01 18:02:00', true, 2),
('Post 4', 'No me gusto', '2022-01-15 02:40:00', '2022-01-20 04:50:00', false, 5),
('Post 5', 'Me parece bien', '2022-08-11 12:45:10', '2022-09-01 00:25:00', true, 10);


/*TABLA COMENTARIOS*/
CREATE TABLE Comentarios(
    id serial,
    contenido text,
    fecha_creacion timestamp,
    usuario_id bigint,
    post_id bigint
);

/*INSERT TABLA COMENTARIOS*/
INSERT INTO Comentarios(contenido, fecha_creacion, usuario_id, post_id) VALUES
('Comentario 1', '2022-01-01 12:25:00', 1, 1),
('Comentario 2', '2022-02-01 23:05:00', 2, 1),
('Comentario 3', '2022-04-01 21:50:00', 3, 1),
('Comentario 4', '2022-01-15 02:40:00', 1, 2),
('Comentario 5', '2022-08-11 12:45:10', 2, 2); 