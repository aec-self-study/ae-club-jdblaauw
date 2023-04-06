with customers as (

    select 
    customer_id, 
    name, 
    email, 
    created_at first_order_at, 
    (select COUNT(id) from `analytics-engineers-club.coffee_shop.orders` O1 where O1.customer_id = O2.customer_id) as Number_of_orders
    from `analytics-engineers-club.coffee_shop.orders` O2
    left join `analytics-engineers-club.coffee_shop.customers` on `analytics-engineers-club.coffee_shop.customers`.id = O2.customer_id

    group by 1,2,3,4

    order by first_order_at

    limit 5
                    )