DROP SCHEMA Internal_schema CASCADE;
DROP SCHEMA Public_info CASCADE;
DROP ROLE Trader;
DROP ROLE Customer;

CREATE SCHEMA Internal_schema;
CREATE SCHEMA Public_info;

CREATE ROLE Trader;
CREATE ROLE Customer WITH LOGIN;

ALTER DEFAULT PRIVILEGES IN SCHEMA Internal_schema REVOKE ALL ON TABLES FROM PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA Public_info REVOKE ALL ON TABLES FROM PUBLIC;

--granting privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA Internal_schema GRANT SELECT ON TABLES TO Trader;
ALTER DEFAULT PRIVILEGES IN SCHEMA Internal_schema GRANT INSERT ON TABLES TO Trader;
ALTER DEFAULT PRIVILEGES IN SCHEMA Public_info GRANT SELECT ON TABLES TO Customer;
ALTER DEFAULT PRIVILEGES IN SCHEMA Public_info GRANT SELECT ON TABLES TO Trader;


CREATE TABLE Public_info.companies(
	internal_ID varchar ( 50 ) PRIMARY KEY,
	company_name varchar ( 50 ) UNIQUE NOT NULL,
	annual_revenue money NOT NULL);

CREATE TABLE Internal_schema.traders(
	staff_ID varchar ( 50 ) PRIMARY KEY,
	Trader_name varchar ( 50 ) NOT NULL,
	date_joined date NOT NULL);

CREATE TABLE Public_info.Portfolio(
	Portfolio_ID varchar ( 50 ) PRIMARY KEY,
	Portfolio_name varchar ( 50 ) NOT NULL);

CREATE TABLE Public_info.prices(
	company_ID varchar ( 50 ) references Public_info.companies(internal_ID),
	record_date date NOT NULL,
	record_value money NOT NULL) PARTITION BY RANGE (record_date);

CREATE TABLE Internal_schema.positions(
	company_ID varchar ( 50 ) references Public_info.companies(internal_ID),
	Portfolio_ID varchar ( 50 ) references Public_info.Portfolio(Portfolio_ID),
	current_stock numeric (20,3) NOT NULL);

CREATE index ix_annual_revenue_btree on Public_info.companies using btree (annual_revenue);
CREATE index ix_company_name_btree on Public_info.companies using btree (company_name);

CREATE index ix_staff_id_hash on Internal_schema.traders using hash (staff_ID);
CREATE index ix_date_joined_btree on Internal_schema.traders using btree (date_joined);

CREATE index ix_Portfolio_ID on Public_info.Portfolio using hash (Portfolio_ID);

CREATE index ix_record_value on Public_info.prices using btree (record_value);

CREATE index ix_current_stock on Internal_schema.positions using btree (current_stock); 



CREATE TABLE Public_info.prices1 PARTITION OF Public_info.prices
	FOR VALUES FROM ('2022-01-01') TO ('2022-04-01');

CREATE TABLE Public_info.prices2 PARTITION OF Public_info.prices
	FOR VALUES FROM ('2022-04-01') TO ('2022-07-01');

CREATE TABLE Public_info.prices3 PARTITION OF Public_info.prices
	FOR VALUES FROM ('2022-07-01') TO ('2022-10-01');

CREATE TABLE Public_info.prices4 PARTITION OF Public_info.prices
	FOR VALUES FROM ('2022-10-01') TO ('2023-01-01');

