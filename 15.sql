-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT category, name, revenue
FROM (
    SELECT pt.category,
    pt.name,
    SUM(od.quantity * p.price) AS revenue,
    RANK() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS rank_no
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
) ranked_pizzas
WHERE rank_no <= 3;