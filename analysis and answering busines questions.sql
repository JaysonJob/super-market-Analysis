set search_path to capstone_project;
select* from sales;
--Analysis and answering the business questions
-- 1.Analysing the payment methods 
--business question:are m-pesa users spending more than cash or card users?
select payment_method,count(*) as total_transactions,
    sum(total_amount) as total_revenue
from sales
group by payment_method
order by total_revenue desc;
--ans= Credit card is most prefered and generates most revenue to run the busniess

-- 2.Analyzing the top selling product category
--question:which products helps the business the most?(top 10 products)
select product_category,sum(quantity) as total_items_sold,
    sum(total_amount) as total_revenue
from sales
group by product_category
order by total_revenue desc
limit 10;

-- 3.Analyzing promotions to check if it increases sales
--question:do we make more money when we give discounts?
select promotion_active,count(*) as number_of_sales,
    round(avg(total_amount),2) as avg_sale_value
from sales
group by promotion_active;

-- 4.Analyzing the holidays
--question:should we stock up and hire more staff on holidays?or does we make sales during the holidays?
select is_holiday,count(*) as total_transactions,
    round(avg(total_amount), 2) as avg_transaction_value
from sales
group by is_holiday;

-- 5.Analyzing the stores
--question:which store is the top performer and which one needs help?(top 10)
select store_id,sum(total_amount) as total_revenue,
    rank() over (order by sum(total_amount) desc) as store_rank
from sales
group by store_id
order by store_rank
limit 10;

-- 6. RFM customer analysis
-- business question:who are our best customers based on recency,frequency and money?
with rfm as (
    select customer_id,
        max(transaction_date) as last_purchase_date,
        count(*) as frequency,
        sum(total_amount) as monetary_value
    from sales
    group by customer_id)
select customer_id,
    last_purchase_date,frequency,
    round(monetary_value,2) as total_spent,
    rank() over (order by monetary_value desc) as spending_rank
from rfm
order by total_spent desc
limit 10;

-- 7.Analysing busines risk(attrition rate)
-- business question:which customers are we loosing(haven't bought in a while)
select customer_id,
    max(transaction_date) as last_purchase_date,
    (select max(transaction_date) from sales) - max(transaction_date) as total_days
from sales
group by customer_id
order by total_days desc
limit 20;

-- 8.Analyzing customers who bought the same product more than once
--question:who is our loyal customer?
select a.customer_id,a.product_name,
    a.transaction_date as first_purchase,b.transaction_date as second_purchase
from sales as a
join sales as b 
    on a.customer_id = b.customer_id 
    and a.product_name = b.product_name 
    and a.transaction_date < b.transaction_date
limit 10;