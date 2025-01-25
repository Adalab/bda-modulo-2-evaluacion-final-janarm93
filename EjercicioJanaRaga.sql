USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT *
FROM film;

SELECT DISTINCT title AS 'Nombre película'
FROM film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT DISTINCT title AS 'Películas de clasificación PG-13'
FROM film
WHERE rating = 'PG-13';

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title,
description
FROM film
WHERE description LIKE '%amazing%';

-- 4 Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title
FROM film
WHERE length > 120;

-- 5. Encuentra los nombres de todos los actores, muestralos en una sola columna que se llame nombre_actor y contenga nombre y apellido.

SELECT CONCAT(first_name, ' ', last_name) AS Nombre_actor
FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT CONCAT(first_name, ' ', last_name) AS Nombre_actor
FROM actor
WHERE last_name LIKE '%Gibson%';

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT first_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla film que no tengan clasificacion "R" ni "PG-13".

SELECT title AS 'Título',
rating AS 'Clasificación'
FROM film
WHERE rating NOT IN ('R', 'PG-13');

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

SELECT rating AS 'Clasificación',
COUNT(film_id) AS 'Número películas'
FROM film
GROUP BY rating;

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente,
-- su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT *
FROM rental;

SELECT *
FROM customer;

SELECT c.customer_id AS 'ID cliente/a',
c.first_name AS 'Nombre',
c.last_name AS 'Apellido',
COUNT(r.rental_id) AS 'Número películas'
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT *
FROM category;

SELECT *
FROM film_category;

SELECT *
FROM inventory;

SELECT *
FROM rental;

SELECT c.name AS 'Categoria',
COUNT(r.rental_id) AS 'Total alquileres'
FROM rental r
INNER JOIN inventory i
ON i.inventory_id = r.inventory_id
INNER JOIN film_category fc
ON i.film_id = fc.film_id
INNER JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.category_id;

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación
-- junto con el promedio de duración.

SELECT rating AS 'Clasificación',
AVG(length) AS 'Promedio'
FROM film
GROUP BY rating
ORDER BY AVG(length) ASC;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

SELECT *
FROM actor;

SELECT *
FROM film_actor;

SELECT *
FROM film;

SELECT CONCAT(a.first_name,' ', a.last_name) AS Nombre_apellido,
f.title AS Titulo
FROM actor a
INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
INNER JOIN film f
ON fa.film_id = f.film_id
WHERE f.title LIKE '%Indian Love%';

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT*
FROM film;

SELECT title AS 'Título películas',
description AS 'Descripción'
FROM film
WHERE description LIKE '%dog%'
OR description LIKE '%cat%';

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.

SELECT *
FROM film_actor;

SELECT *
FROM actor;


SELECT CONCAT(a.first_name,' ', a.last_name) AS Nombre_apellido
FROM actor a
LEFT JOIN film_actor fa
ON a.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL;

-- ponemos WHERE con fa.actor_id y no con a.actor_id porque la tabla actor es la primera y hemos hecho un LEFT JOIN, por lo que nunca será nula.

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT title AS Titulo,
release_year AS Lanzamiento
FROM film
WHERE release_year BETWEEN 2005 AND 2010
ORDER BY Lanzamiento ASC;

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".

-- Aclaración: categoria = name en tabla category

SELECT f.title AS Titulo,
c.name AS Categoria
FROM film f
INNER JOIN category c
WHERE c.name = 'Family';

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

SELECT a.first_name,
a.last_name,
COUNT(DISTINCT fa.film_id) AS Numero_peliculas
FROM actor a
INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.first_name, a.last_name
HAVING Numero_peliculas > 10
ORDER BY Numero_peliculas DESC;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

SELECT title, length, rating
FROM film
WHERE rating = 'R' AND length > 120 -- se indica 120 porque la columna length está en minutos y no en horas (2h = 120min).
ORDER BY length DESC;

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas
-- en las que han actuado.

SELECT CONCAT(a.first_name,' ', a.last_name) AS Nombre_apellido,
COUNT(DISTINCT fa.film_id) AS Peliculas
FROM actor a
INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING Peliculas > 5
ORDER BY Peliculas DESC;

-- 22. Encuentra el título de todas las películas que fueron alquiladas durante más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes. Pista: Usamos DATEDIFF para calcular la diferencia entre una fecha y otra, ej: DATEDIFF(fecha_inicial, fecha_final)
-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
-- BONUS
-- 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film con subconsultas.
-- 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos. Pista: Podemos hacer un JOIN de una tabla consigo misma, poniendole un alias diferente.
