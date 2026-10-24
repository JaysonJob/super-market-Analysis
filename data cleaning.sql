--seting the search path to the schema name so every queries to be relating to the schema
set search_path to capstone_project;

-- Checking that the table is valid
select* from sales;
------=====data cleaning and preparation=======
--step 1:checking for duplicates
-- check if there are any exact duplicate rows in the table
select customer_id,transaction_date,product_name,quantity,total_amount,count(*)
from sales
group by customer_id,transaction_date,product_name,quantity,total_amount
having count(*) > 1;
--we have no duplicates

--step 2 Check for nulls in our dataset
-- count how many nulls are in each column
select count(*) - count(customer_id) as missing_customer,
    count(*) - count(transaction_date) as missing_date,
    count(*) - count(product_name) as missing_product,
    count(*) - count(product_category) as missing_category,
    count(*) - count(store_id) as missing_store,
    count(*) - count(quantity) as missing_quantity,
    count(*) - count(unit_price) as missing_price,
    count(*) - count(total_amount) as missing_total,
    count(*) - count(payment_method) as missing_payment,
    count(*) - count(promotion_active) as missing_promo,
    count(*) - count(is_holiday) as missing_holiday,
    count(*) - count(inflation_index) as missing_inflation
from sales;
--our data has no nulls

-- STEP 3: CLEAN CUSTOMER_ID
-- check if any customer ids are null.and update them to 'Unknown'
update sales
set customer_id = 'Unknown'
where customer_id is null;

--STEP 4: CLEAN PRODUCT_NAME & CATEGORY
-- check for empty product names and set them to Unknown Product and trimming
update sales
set product_name = 'Unknown Product'
where product_name is null or trim(product_name) = '';

select product_name from sales;

-- checking for nulls categories and set them to Uncategorized and triming
update sales
set product_category = 'Uncategorized'
where product_category is null or trim(product_category) = '';


-- STEP 5: CLEAN STORE_ID
-- check for empty store ids and set them to Unknown Store
update sales
set store_id = 'Unknown Store'
where store_id is null;

-- STEP 7: CLEAN QUANTITY
-- check if any quantity is zero or negative and setting it to 1 for easy visualization
update sales
set quantity = 1
where quantity <= 0 or quantity is null;
--confirming the updated column
select quantity,count(*)
from sales
group by quantity;

-- STEP 7: CLEAN UNIT_PRICE
-- checking if any prices are negative and setting them to 0
update sales
set unit_price = 0
where unit_price < 0 or unit_price is null;

-- STEP 8: CLEAN TOTAL_AMOUNT
-- checking if the total amount matches quantity times unit price.
update sales
set total_amount = (quantity * unit_price)
where total_amount != (quantity * unit_price) or total_amount is null;

-- STEP 9: CLEAN PAYMENT_METHOD
-- check for empty payment methods and set them to Unknown and trim
update sales
set payment_method = 'Unknown'
where payment_method is null or trim(payment_method) = '';
-- change 'Mobile Wallet' to 'M-Pesa'
update sales
set payment_method = 'M-Pesa'
where payment_method = 'Mobile Wallet';
--confirming if the table is well updated
select payment_method from sales 
group by payment_method;

-- STEP 11: CLEAN INFLATION_INDEX
-- check if inflation is negative or null and set it to the average if so
update sales
set inflation_index = (select avg(inflation_index) from sales)
where inflation_index < 0 or inflation_index is null;

--cheking the whole table
select * from sales limit 1000;

