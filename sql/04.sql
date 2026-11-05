/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. and have also appeared in at least one movie in the "Horror" category.
 */

SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film_category fc USING (film_id)
    JOIN category c USING (category_id)
    WHERE c.name = 'Children'
)
AND a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film_category fc USING (film_id)
    JOIN category c USING (category_id)
    WHERE c.name = 'Horror'
)
ORDER BY a.last_name, a.first_name;
