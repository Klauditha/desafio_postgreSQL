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

