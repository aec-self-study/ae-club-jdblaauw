{{ config(
    materialized='table'
) }}

SELECT customer_id, 
name, 
email, 
created_at as first_order_at, 
(SELECT COUNT(id) FROM `analytics-engineers-club.coffee_shop.orders` O1 WHERE O1.customer_id = O2.customer_id) as Number_of_orders
FROM `analytics-engineers-club.coffee_shop.orders` O2
LEFT JOIN `analytics-engineers-club.coffee_shop.customers` ON `analytics-engineers-club.coffee_shop.customers`.id = O2.customer_id
GROUP BY 1,2,3,4
ORDER BY first_order_at
LIMIT 6