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
('cmartinez@example.com', 'Camila', 'Martinez', 'administrador'),
('sjimenez@example.com', 'Susana', 'Jimenez', 'usuario');   
