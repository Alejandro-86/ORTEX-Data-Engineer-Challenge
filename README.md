# ORTEX-Data-Engineer-Challenge
 Solution to Ortex Data Engineer Challenge exercises, the first is a .sql query for the first part of the challenge and the second is a Python script for the second part of the challenge. The .csv file is also included.

 The Challenge tasks are detailed up next: 

DATA ENGINEER PROGRAMMING EXERCISES 
Introduction 
Thank you for doing our programming exercises. There are two separate tasks, one in SQL, one in Python
Data 
Attached is a CSV file with insider transactions in multiple stocks and exchanges; each line corresponds to one 
transaction. The file is provided with headers, the headers are self-descriptive, but if you do not know what they mean 
that does not matter for the exercise. 


# PART 1 
Create a PostgreSQL SQL solution to import the data needed to perform the following tasks to a new database table
and calculate some values. The solution should use Postgres 13 or above, and we would like to see the SQL to create 
the table(s), import the data and produce the required output.
Tasks 
The application should be able to calculate and write out the answers to the below questions. 
1. Which are the top 3 exchange with the most transactions in the file? 
2. In August 2017, which 2 companyNames had the highest combined valueEUR?
3. For 2017, only considering transactions with tradeSignificance 3, what is the percentage of transactions per 
month?


# PART 2 
Create a Python (3.7+) solution to use import the data and perform the following tasks. You may use any recently 
maintained libraries on pypi (e.g., Pandas) to perform these tasks.
Tasks 
The application should be able to calculate and write out the answers to the below questions. 
1. Which are the top 3 source with the highest ratio of Buy to Sell transactions weighted by the number of 
shares per transaction
2. Which are the top 3 currency by the total numerical value of trades in that currency
3. What is the total number of transactions where inputdate was more than 2 weeks after tradedate


Notes: 
Please deliver code as .py files, do not submit anything else, e.g. Jupyter Notebooks.
All code should confirm to PEP-8 and we will be reviewing for simplicity, efficiency, clarity and compliance with 
coding standards