/*CREACION BDD*/

/*CREACION TABLAS*/
CREATE TABLE INSCRITOS(cantidad INT, fecha DATE, fuente VARCHAR);


/*INSERCION DE DATOS*/
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );


/*CASO 1 : ¿Cuántos registros hay?*/
SELECT COUNT(*) AS REGISTROS_TOTALES FROM INSCRITOS

/*CASO 2 : ¿Cuántos inscritos hay en total?*/
SELECT SUM(cantidad) AS INSCRITOS_TOTALES FROM INSCRITOS

/*CASO 3 : ¿Cuál o cuáles son los registros de mayor antigüedad? ocupar subconsultas*/
SELECT * FROM INSCRITOS 
WHERE fecha IN (SELECT MIN(fecha) FROM INSCRITOS)

/*CASO 4 : ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de
ahora en adelante). */
SELECT fecha, SUM(cantidad) AS INSCRITOS FROM INSCRITOS 
GROUP BY fecha
ORDER BY fecha

/*CASO 5 : ¿Cuántos inscritos hay por fuente?*/
SELECT fuente, SUM(cantidad) AS INSCRITOS FROM INSCRITOS 
GROUP BY fuente


/*CASO 6: ¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se
inscribieron en ese día?*/
SELECT fecha, SUM(cantidad) AS INSCRITOS FROM INSCRITOS 
GROUP BY fecha
ORDER BY sum(cantidad) DESC 
FETCH FIRST 1 ROW ONLY

/*CASO 7: ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas
personas fueron? - si hay más de un registro, tomar el primero*/
SELECT fuente, fecha, SUM(cantidad) AS INSCRITOS FROM INSCRITOS 
WHERE fuente = 'Blog'
GROUP BY fuente, fecha
ORDER BY SUM(cantidad) 
DESC LIMIT 1

/*CASO 8: ¿Cuál es el promedio de personas inscritas por día? */
SELECT ROUND(avg(query.promedio)) as PROMEDIO_TOTAL FROM
	(SELECT fecha, ROUND(AVG(cantidad),0) AS PROMEDIO FROM INSCRITOS
	GROUP BY fecha) as query



/*CASO 9: ¿Qué días se inscribieron más de 50 personas?*/
SELECT fecha FROM INSCRITOS
GROUP BY fecha
HAVING sum(cantidad)>50
ORDER BY fecha
/*CASO 10: ¿Cuál es el promedio diario de personas inscritas a partir del tercer día en adelante,
considerando únicamente las fechas posteriores o iguales a la indicada?*/
SELECT * FROM
	(SELECT fecha, ROUND(AVG(cantidad),0) AS PROMEDIO FROM INSCRITOS
	GROUP BY fecha
	ORDER BY fecha) AS query
WHERE query.fecha >= '2021-03-01'