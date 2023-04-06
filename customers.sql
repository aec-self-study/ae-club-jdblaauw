SELECT customer_id, name, email, created_at first_order_at, (SELECT COUNT(id) FROM  O1 WHERE O1.customer_id = O2.customer_id) as Number_of_orders
FROM  O2
LEFT JOIN  ON .id = O2.customer_id
GROUP BY 1,2,3,4
ORDER BY first_order_at
LIMIT 6

