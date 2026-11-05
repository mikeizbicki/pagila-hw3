/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

SELECT customer_id, first_name, last_name
FROM (
    SELECT c.customer_id,
           c.first_name,
           c.last_name,
           count(DISTINCT t.film_id) FILTER (WHERE cat.name = 'Action') AS action_count
    FROM customer c
    JOIN LATERAL (
        SELECT r.rental_date, i.film_id
        FROM rental r
        JOIN inventory i USING (inventory_id)
        WHERE r.customer_id = c.customer_id
        ORDER BY r.rental_date DESC, r.rental_id DESC
        LIMIT 5
    ) t ON true
    LEFT JOIN film_category fc ON t.film_id = fc.film_id
    LEFT JOIN category cat ON fc.category_id = cat.category_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) x
WHERE action_count >= 4
ORDER BY customer_id;
