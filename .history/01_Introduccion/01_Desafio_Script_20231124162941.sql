
DROP DATABASE desafio_Claudia_Villarroel_g42;
/*PUNTO 1*/
\c desafio_Claudia_Villarroel_g42;

/*PUNTO 2*/
USE desafio-Claudia_Villarroel-g42;

/*PUNTO 3*/
CREATE TABLE clientes (
	id SERIAL,
	email VARCHAR(50),
	nombre VARCHAR,
	telefono VARCHAR(16),
	empresa VARCHAR(50),
	tipo smallint
);

/*PUNTO 4*/
INSERT INTO clientes (email, nombre, telefono, empresa, tipo) 
VALUES
('bclyne0@cdbaby.com','Bryn Clyne','3097745042','Google',10),
('obartlomiejczyk1@51.la','Ode Bartlomiejczyk','12281572070','Oxxo',9),
('mblader2@examiner.com','Marylin Blader','8209657214','Microsoft',8),
('cbroxholme3@istockphoto.com','Claudia Broxholme','7473940538','Carozzi',7),
('cmarden4@google.fr','Consalve Marden','6243106369','Buk',1);

/*PUNTO 5*/
SELECT * FROM clientes ORDER BY tipo DESC LIMIT 3

/*PUNTO 6*/
INSERT INTO clientes (email, nombre, telefono, empresa, tipo) 
VALUES
('mmcrill5@ebay.co.uk','McRill','7905407699','Desafio',10),
('hingry9@bloglines.com','Harold Ingry','7222269505','Google',9);

SELECT * FROM clientes WHERE tipo=10;

SELECT * FROM clientes WHERE empresa='Google';

\q