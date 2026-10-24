--creating a schema well be working on
create schema capstone_project;
--seting the search path to the schema name so every queries to be relating to the schema
set search_path to capstone_project;

--creating the table so i can import the data manually
-- customer_id and store_id are set to varchar because they contain letters (e.g., C001, S001).
create table sales (
    customer_id varchar(50),
    transaction_date date,
    product_name varchar(255),
    product_category varchar(100),
    store_id varchar(50),
    quantity int,
    unit_price numeric(10, 2),
    total_amount numeric(10, 2),
    payment_method varchar(50),
    promotion_active varchar(10),
    is_holiday varchar(10),
    inflation_index numeric(10, 2)
);

-- Checking that the table was created successfully.
select* from sales;
