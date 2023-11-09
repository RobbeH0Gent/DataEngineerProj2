USE DW;
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
-- EMPTY AND REFILL dim_date
-- TRUNCATE TABLE dim_date;
-- EXEC fill_dim_date;

-- EMPTY AND REFILL dim_customer;
DELETE FROM DimCustomer;
EXEC fill_dim_customer;

-- EMPTY AND REFILL dim_contact;
DELETE FROM DimContact;
EXEC fill_dim_contact;

-- EMPTY AND REFILL dim_email;
DELETE FROM DimEmail;
EXEC fill_dim_email;

-- ADD TO fact_account
EXEC fill_fact_account;

-- ADD TO fact_customer
EXEC fill_fact_contact;