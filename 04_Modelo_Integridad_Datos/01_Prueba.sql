/*

1. Revisa el tipo de relación y crea el modelo correspondiente. Respeta las claves
primarias, foráneas y tipos de datos.

*/

/*Tabla Peliculas*/

-- Table: public.Peliculas

-- DROP TABLE IF EXISTS public."Peliculas";

CREATE TABLE IF NOT EXISTS public."Peliculas"
(
    id integer NOT NULL DEFAULT nextval('"Peliculas_id_seq"'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    anno integer,
    CONSTRAINT "Peliculas_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Peliculas"
    OWNER to postgres;

/*Tabla Tags*/    

-- Table: public.Tags

-- DROP TABLE IF EXISTS public."Tags";

CREATE TABLE IF NOT EXISTS public."Tags"
(
    id integer NOT NULL DEFAULT nextval('"Tags_id_seq"'::regclass),
    tag character varying(32) COLLATE pg_catalog."default",
    CONSTRAINT tags_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Tags"
    OWNER to postgres;


/* Tabla Peliculas_Tags */

-- Table: public.Peliculas_Tags

-- DROP TABLE IF EXISTS public."Peliculas_Tags";

CREATE TABLE IF NOT EXISTS public."Peliculas_Tags"
(
    pelicula_id integer NOT NULL,
    tags_id integer NOT NULL,
    CONSTRAINT peliculas_tags_pkey PRIMARY KEY (pelicula_id, tags_id),
    CONSTRAINT peliculas_id_fkey FOREIGN KEY (pelicula_id)
        REFERENCES public."Peliculas" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT tags_id_fkey FOREIGN KEY (tags_id)
        REFERENCES public."Tags" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Peliculas_Tags"
    OWNER to postgres;


/*
2. Inserta 5 películas y 5 tags; la primera película debe tener 3 tags asociados, la
segunda película debe tener 2 tags asociados.

*/

/* Insertar datos en Peliculas */
INSERT INTO public."Peliculas"(nombre, anno)
VALUES 
	('Fuera del mapa', 2020),
	('Nace una estrella', 2018),
	('Free Guy: Tomando el control', 2021),
	('La memoria infinita', 2023),
	('Barbie', 2023);

/* Insertar datos en Tags */
INSERT INTO public."Tags"(tag)
VALUES
    ('Comedia'),
    ('Accion'),
    ('Drama'),
    ('Suspense'),
    ('Animacion');


/* Insertar datos en Peliculas_Tags */
INSERT INTO public."Peliculas_Tags"(pelicula_id, tags_id)
VALUES
	(1,2),
	(1,3),
	(1,4),
	(2,3),
	(2,4);

/*

3. Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe
mostrar 0.

*/

SELECT P.nombre, COUNT(T.tag) AS CANTIDAD_TAGS
FROM public."Peliculas" P
LEFT JOIN  public."Peliculas_Tags" PT 
    ON P.id = PT.pelicula_id
LEFT JOIN  public."Tags" T 
    ON PT.tags_id = T.id
GROUP BY P.nombre


/*
4. Crea las tablas correspondientes respetando los nombres, tipos, claves primarias y
foráneas y tipos de datos.
*/

/* Tabla Preguntas */

-- Table: public.Preguntas

-- DROP TABLE IF EXISTS public."Preguntas";

CREATE TABLE IF NOT EXISTS public."Preguntas"
(
    id integer NOT NULL DEFAULT nextval('"Preguntas_id_seq"'::regclass),
    pregunta character varying(255) COLLATE pg_catalog."default",
    respuesta_correcta character varying COLLATE pg_catalog."default",
    CONSTRAINT preguntas_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Preguntas"
    OWNER to postgres;

/* Tabla Usuarios */

-- Table: public.Usuarios

-- DROP TABLE IF EXISTS public."Usuarios";

CREATE TABLE IF NOT EXISTS public."Usuarios"
(
    id integer NOT NULL DEFAULT nextval('"Usuarios_id_seq"'::regclass),
    nombre character varying(255) COLLATE pg_catalog."default",
    edad integer,
    CONSTRAINT usuarios_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Usuarios"
    OWNER to postgres;

/* Tabla Respuestas */

-- Table: public.Respuestas

-- DROP TABLE IF EXISTS public."Respuestas";

CREATE TABLE IF NOT EXISTS public."Respuestas"
(
    id integer NOT NULL DEFAULT nextval('"Respuestas_id_seq"'::regclass),
    respuesta character varying(255) COLLATE pg_catalog."default",
    usuario_id integer,
    pregunta_id integer,
    CONSTRAINT respuestas_pkey PRIMARY KEY (id),
    CONSTRAINT pregunta_fkey FOREIGN KEY (pregunta_id)
        REFERENCES public."Preguntas" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT usuario_fkey FOREIGN KEY (usuario_id)
        REFERENCES public."Usuarios" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Respuestas"
    OWNER to postgres;


/*
5. Agrega 5 usuarios y 5 preguntas.
La primera pregunta debe estar respondida correctamente dos veces, por dos
usuarios diferentes.
b. La segunda pregunta debe estar contestada correctamente solo por un
usuario.
c. Las otras tres preguntas deben tener respuestas incorrectas.
Contestada correctamente significa que la respuesta indicada en la tabla respuestas
es exactamente igual al texto indicado en la tabla de preguntas.
*/

/*Insertar datos en Usuarios*/
INSERT INTO public."Usuarios"(nombre, edad)
VALUES
    ('Pepito', 20),
    ('Juanito', 30),
    ('Pedrito', 40),
    ('Luisito', 50),
    ('Miguelito', 60);

/*Insertar datos en Preguntas*/
INSERT INTO public."Preguntas"(pregunta, respuesta_correcta)
VALUES
    ('¿Cual es la capital de Chile?', 'Santiago'),
    ('¿Cuantas regiones tiene Chile?', '16'),
    ('¿Cual es el nombre del Presidente de Chile?', 'Gabriel Boric'),
    ('¿Hace calor en verano?', 'Si'),
    ('¿Hace frio en invierno?', 'Si');   

/*Insertar datos en Respuestas*/
INSERT INTO public."Respuestas"(respuesta, usuario_id, pregunta_id)
VALUES
    ('Santiago', 1, 1),
    ('Santiago', 2, 1),
	('16', 3, 2),
	('Michelle Bachelet', 4, 3),
	('No', 5, 4),
	('No', 1, 5);


/*
6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la
pregunta).
*/

SELECT U.nombre, COUNT(P.pregunta) AS CANTIDAD_RESPUESTAS_CORRECTAS
FROM public."Usuarios" U
JOIN public."Respuestas" R  ON
	U.id = R.usuario_id 
LEFT JOIN public."Preguntas" P ON
P.id = R.pregunta_id 
	AND P.respuesta_correcta = R.respuesta
GROUP BY U.nombre

/*
7. Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios respondieron
correctamente.
*/

SELECT P.pregunta, COUNT(U.nombre) AS CANTIDAD_USUARIOS_RESPUESTAS_CORRECTAS
FROM public."Preguntas" P
JOIN public."Respuestas" R  ON
	P.id = R.pregunta_id 
LEFT JOIN public."Usuarios" U ON
	U.id = R.usuario_id 
	AND P.respuesta_correcta = R.respuesta
GROUP BY P.pregunta

/*
8.Implementa un borrado en cascada de las respuestas al borrar un usuario. Prueba la
implementación borrando el primer usuario.
*/

ALTER TABLE public."Respuestas" DROP CONSTRAINT usuario_fkey, ADD FOREIGN KEY
(usuario_id) REFERENCES public."Usuarios"(id) ON DELETE CASCADE;

DELETE FROM public."Usuarios"
WHERE id = 1