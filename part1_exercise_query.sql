-- Ortex's Data Engineering Exercise, Part 1
-- Database: ortex

DROP DATABASE IF EXISTS ortex;

CREATE DATABASE ortex
    WITH 
    OWNER = alexalonso
    ENCODING = 'UTF8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE ortex
    IS 'Ortex Data Engineering Exercise';

GRANT ALL ON DATABASE ortex TO alexalonso;

GRANT ALL ON DATABASE ortex TO PUBLIC;


-- USE ortex;
-- Table creation to load csv.
CREATE TABLE transactions2017
(
	transactionID SERIAL PRIMARY KEY,
	gvkey NUMERIC ( 10 ) ,
	companyName VARCHAR ( 250 ),
	companyISIN VARCHAR ( 2000 ),
	companySEDOL VARCHAR ( 200 ),
	insiderID numeric ( 10 ),
	insiderName VARCHAR ( 255 ),
	insiderRelation VARCHAR ( 255 ),
	insiderLevel VARCHAR ( 50 ),
	connectionType VARCHAR ( 50 ),
	connectedInsiderName VARCHAR ( 255 ),
	connectedInsiderPosition VARCHAR ( 255 ),
	transactionType VARCHAR ( 20 ),
	transactionLabel VARCHAR ( 20 ),
	iid VARCHAR ( 20 ),
	securityISIN VARCHAR ( 255 ),
	securitySEDOL VARCHAR ( 255 ),
	securityDisplay VARCHAR ( 255 ),
	assetClass VARCHAR ( 255 ),
	shares NUMERIC ( 20 ),
	inputdate DATE,
	tradedate DATE,
	maxTradedate NUMERIC ( 20 ),
	price NUMERIC ( 10,2 ),
	maxPrice NUMERIC ( 10,2 ),
	value NUMERIC ( 20,2 ),
	currency VARCHAR ( 20 ),
	valueEUR NUMERIC ( 20,2 ),
	unit VARCHAR ( 20 ),
	correctedTransactionID NUMERIC ( 20 ),
	source VARCHAR ( 20 ),
	tradeSignificance NUMERIC ( 10 ),
	holdings NUMERIC ( 20 ),
	filingURL VARCHAR ( 255 ),
	exchange VARCHAR ( 200 )
);
-- .csv file loading into previously made table
\copy transactions2017 FROM '2017.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8' QUOTE '"' ESCAPE '''';

-- Query to answer the 1st task.
select exchange
from transactions2017 
GROUP BY exchange
order by count(exchange) desc
limit 3;
-- Query to answer the 2nd task.
with valueEUR as (
	select companyname, value
	from transactions2017
	where currency = 'EUR' and 
	extract(year from tradedate) = 2017 and
	extract(month from tradedate) = 8	
)
select companyname
from valueEUR
GROUP BY companyname
ORDER BY sum(value) desc
limit 2;
-- Query to answer the 3rd task.
with filtered as (
	select 
	extract(MONTH from tradedate) as transaction_month,
	count(tradedate) FILTER (where tradesignificance = 3) as total_per_month_ts3,
	count(tradedate) as total_per_month
	from transactions2017
	where extract(year from tradedate) = 2017
	GROUP BY transaction_month
)
select 
TO_CHAR(TO_DATE (transaction_month::text, 'MM'), 'Month') AS "Month Name",
trunc((total_per_month_ts3::NUMERIC/total_per_month::NUMERIC)*100,2) as percentage_ts3_monthly
from filtered