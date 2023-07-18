SELECT * from sales 
select * from product
select * from goldusers_signup
SELECT * from users

1. what is the total amount each customer spent on zomato ???


select sales.userid, sum(product.price)  as c from sales join product on  product.product_id = sales.product_id 
group by sales.userid
order by c desc


2. how many  days each customer visited zomato ???

select userid, count(distinct created_date) as distinct_days from sales
group by  userid 


3. what was the first product purchased by each customer ??

select * from
(select *,rank() over(partition by userid order by created_date) as rk  from sales) 
 s where rk = 1


4. what is the most purchased item in the menu ?? how many times it has benn purchaed by customers??

select userid ,product_id, count(product_id) as no_of_times from sales 
group by  product_id,userid
order by no_of_times desc

5. which item is the most popular for each customer ???


 select userid ,product_id, count(product_id) as c from sales 
group by userid ,product_id


6. which item is first purchaed by the customer after they become a member ?

SELECT * from sales 
select * from product
select * from goldusers_signup
SELECT * from users


select * from(select c.*,rank() over (partition by userid order by created_date) rnk from (select sales.userid, sales.created_date,sales.product_id, goldusers_signup.gold_signup_date from sales join goldusers_signup 
on sales.userid=goldusers_signup.userid and created_date >= gold_signup_date) as c) b where rnk =1

7. which item had been purchased just before the customer became a member??


 select * from(select c.*,rank() over (partition by userid order by created_date desc) rnk from (select sales.userid, sales.created_date,sales.product_id, goldusers_signup.gold_signup_date from sales join goldusers_signup 
on sales.userid=goldusers_signup.userid and created_date <= gold_signup_date) as c) b where rnk =1

8. what is the total amount and order before they spent became a member??

select userid,count(created_date),sum(price) as total_amount_purchased from (select c.*,product.price from(select sales.userid, sales.created_date,sales.product_id, goldusers_signup.gold_signup_date from sales join goldusers_signup 
on sales.userid=goldusers_signup.userid and created_date <= gold_signup_date) c inner join product 
on c.product_id = product.product_id) e group by userid


9.if buying each product generates the points for eg 5 rs 2 zomato points and each product has different 
purchasing points for eg p1 =1 zomato point and p2  = 2 zomato point and p3 = 1 zomato point
calculate the points collected by each customer for which product most point had benn given??

select product.*,case when product_id=1 then 5 when product_id=2 then 2 when product_id=3 then 1 else 0 end as points from (select userid,product_id,sum(price) from
(select sales.*,product.price from sales inner join  product on sales.product_id=product.product_id) c group by userid,product_id)product


10.rank all the transaction of the customer???


SELECT *, rank() over(partition by userid order by created_date) rnk from sales ;


11. rank all the transaction of each member whenever they are zomato gold member for every non
non gold member transaction as na ???

SELECT * from sales 
select * from product
select * from goldusers_signup
SELECT * from users

select goldusers_signup.*,rank() over(partition by userid order by created_date) rnk from (select sales.userid,sales.created_date,goldusers_signup.gold_signup_date from sales inner join goldusers_signup
on sales.userid=goldusers_signup.userid and sales.created_date >= goldusers_signup.gold_signup_date) goldusers_signup