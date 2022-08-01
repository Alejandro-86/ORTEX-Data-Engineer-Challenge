-- Ortex's Data Engineering Exercise, Part 1
-- Database: ortex

-- DROP DATABASE IF EXISTS ortex;

CREATE DATABASE ortex
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Argentina.1252'
    LC_CTYPE = 'Spanish_Argentina.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE ortex
    IS 'Ortex Data Engineering Exercise';

GRANT ALL ON DATABASE ortex TO postgres;

GRANT ALL ON DATABASE ortex TO PUBLIC;

USE ortex;
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
COPY transactions2017 FROM '/2017.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8' QUOTE '"' ESCAPE '''';

-- Query to answer the 1st task.
SELECT exchange,  COUNT(transactionid) AS total_transactions FROM transactions2017 GROUP BY exchange ORDER BY total_transactions DESC LIMIT 3;

-- Query to answer the 2nd task.
SELECT companyname, MAX(valueEUR) AS highest_value FROM transactions2017 WHERE EXTRACT(MONTH FROM tradedate) = 08 AND EXTRACT(YEAR FROM tradedate) = 2017 GROUP BY companyname ORDER BY highest_value DESC LIMIT 3; 

-- Query to answer the 3rd task.

SELECT (COUNT(transactionid)::float / SUM(COUNT(transactionid)) OVER() *100) AS transactions_percentage, EXTRACT(MONTH FROM tradedate) AS month FROM transactions2017  WHERE EXTRACT(YEAR FROM tradedate) = 2017 AND tradeSignificance = 3 GROUP BY month;
