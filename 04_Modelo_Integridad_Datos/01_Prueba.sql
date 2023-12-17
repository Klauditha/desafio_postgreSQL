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
