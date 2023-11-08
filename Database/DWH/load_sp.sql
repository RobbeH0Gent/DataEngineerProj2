USE DW;

-- EMPTY AND REFILL dim_date
TRUNCATE TABLE dim_date;
EXEC fill_dim_date;

-- EMPTY AND REFILL dim_customer;
TRUNCATE TABLE dim_customer;
EXEC fill_dim_customer;

-- EMPTY AND REFILL dim_contact;
TRUNCATE TABLE dim_contact;
EXEC fill_dim_contact;

-- EMPTY AND REFILL dim_email;
EXEC fill_dim_email;

-- ADD TO fact_account
EXEC fill_fact_account;

-- ADD TO fact_customer
EXEC fill_fact_customer;