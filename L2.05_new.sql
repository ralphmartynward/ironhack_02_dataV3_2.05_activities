USE bank;

SELECT * FROM bank.account;
SELECT * FROM bank.card;
SELECT * FROM bank.disp;

SELECT * FROM bank.order
WHERE amount > 10000;

SELECT * FROM bank.order
WHERE k_symbol = 'SIPO';

SELECT account_id, amount, k_symbol FROM bank.order
WHERE k_symbol = 'SIPO';

SELECT account_id AS 'Account', amount, k_symbol AS 'Type of Payment' FROM bank.order
WHERE (k_symbol = 'SIPO') AND (amount > 1000); 

SELECT account_id AS 'Account', amount, k_symbol AS 'Type of Payment' FROM bank.order
WHERE (k_symbol IN ('SIPO','LEASING','UVER')) AND (amount > 1000); 

SELECT account_id AS 'Account', amount, k_symbol AS 'Type of Payment' FROM bank.order
WHERE (k_symbol = 'SIPO') AND NOT (amount > 1000); 

-- numerics

SELECT * FROM bank.loan;

SELECT *, amount-payments AS balance
FROM bank.loan;

SELECT *, amount-payments AS balance, round((amount-payments)/1000,2) AS 'balance in thousands'
FROM bank.loan;

SELECT * FROM bank.account
LIMIT 10;

SELECT * FROM bank.account
ORDER BY account_id DESC
LIMIT 10;

SELECT DISTINCT frequency FROM bank.account;

SELECT * from bank.district;
 
-- 2.05 Activity 1
/*
Activity 1.1
Select districts and salaries (from the district table) where salary is greater than 10000. 
Return columns as district_name and average_salary.
*/
SELECT A2 as district_name, A11 as average_salary
FROM district
WHERE A11 > 10000; 

/* Activity 1.2
Select those loans whose contract finished and were not paid. 
Hint: You should be looking at the loan column and you will need the extended case study 
information to tell you which value of status is required.
*/
SELECT loan_id, account_id, amount, payments, 
status FROM loan
WHERE status = 'B'; -- 'B' stands for contract finished, loan not payed 

/* Activity 1.3
Select cards of type junior. Return just first 10 in your query.
*/
SELECT * FROM card
WHERE type = 'junior'
LIMIT 10;

/* Activity 1.4
Select those loans whose contract finished and not paid back. 
Return the debt value from the status you identified in the last activity, 
together with loan id and account id.
*/
SELECT loan_id, account_id, amount, payments,
CASE
WHEN status = 'B' then amount-payments -- 'B' stands for contract finished, loan not payed
END AS 'debt' -- 'debt' is the alias for the column
FROM loan;

/* Activity 1.5
Calculate the urban population for all districts. 
Hint: You are looking for the number of inhabitants and the % of urban inhabitants in each district. 
Return columns as district_name and urban_population.
*/
SELECT DISTINCT A2 as district_name, A10 as urban_inhabitants
FROM district;

/* Activity 1.6
On the previous query result - rerun it but filtering out districts where the rural population 
is greater than 50%.
*/
SELECT A2 as 'district_name', round(A4*A10/100,0) AS 'rural_population' FROM district
WHERE A10<50;


--

-- numeric aggregates
SELECT COUNT(*) FROM bank.order;
SELECT COUNT(account_id) FROM bank.order;

SELECT COUNT(DISTINCT account_id) FROM bank.order;

SELECT AVG(amount) FROM bank.order;
SELECT MAX(amount) FROM bank.order;
SELECT MIN(amount) FROM bank.order;

-- strings

SELECT * FROM bank.order;

SELECT *, concat(order_id,account_id) AS 'concat' FROM bank.order;

SELECT *, concat(order_id,account_id,' ',bank_to) AS 'concat' FROM bank.order;

SELECT k_symbol, left(k_symbol,3), right(k_symbol,2) , concat(left(k_symbol,2),right(k_symbol,2)) AS 'standardized_k_symbol' FROM bank.order;


-- case when

SELECT * FROM bank.loan;

SELECT loan_id, account_id,
CASE
WHEN status = 'B' then 'Defaulter - contract finished'
WHEN status = 'A' then 'Good - contract finished'
WHEN status = 'C' then 'Good - contract ongoing'
WHEN status = 'D' then 'In Debt - contract ongoing'
ELSE 'No status'
END AS 'Status Description',status AS 'previous status'
FROM bank.loan;


SELECT loan_id, account_id, amount, status AS 'previous status',
CASE
WHEN status = 'B' then 'Defaulter - contract finished'
WHEN (status = 'A') AND (amount > 100000) then 'Great - contract finished'
WHEN (status = 'A') AND (amount <= 100000) then 'Good - contract finished'
WHEN status = 'C' then 'Good - contract ongoing'
WHEN status = 'D' then 'In Debt - contract ongoing'
ELSE 'No status'
END AS 'Status Description'
FROM bank.loan;

-- 2.05 Activity 2
 

-- Activity 2.1
-- Get all junior cards issued last year. Hint: Use the numeric value (980000).
SELECT * 
FROM card
WHERE type = 'junior' AND issued > 980000 AND issued < 990000; 

-- Activity 2.2
-- Get the first 10 transactions for withdrawals that are not in cash. 
-- You will need the extended case study information to tell you which values are required here, and you will need to refer to conditions on two columns.
SELECT trans_id as transactions
FROM trans 
WHERE type = 'VYDAJ' AND NOT operation = 'VYBER' -- "VYDAJ": withdrawal / "VYBER" : cash
LIMIT 10;



-- Activity 2.3
-- Refine your query from last activity on loans whose contract finished and not paid back 
-- filtered to loans where they were left with a debt bigger than 1000. 
-- Return the debt value together with loan id and account id. 
-- Sort by the highest debt value to the lowest.
-- Show only loan_id, account_id and the debt.
SELECT loan_id, account_id, amount, payments,
CASE
WHEN status = 'B' then amount-payments -- 'B' stands for contract finished, loan not payed
END AS 'debt' -- 'debt' is the alias for the column
FROM loan
WHERE status = 'B' AND amount-payments > 1000
ORDER BY amount-payments DESC;



-- What are the biggest and the smallest transaction values in the trans database? 
SELECT max(amount), min(amount) FROM trans
WHERE amount > 0;





-- Activity 2.5
-- Get account information with an extra column year showing the opening year as 'YY'. 
SELECT *, substr(date,1,2) AS 'year' FROM account;
-- Eg., 1995 will show as 95. Hint: Look at the first two characters of the string date in the account table. You would have to use function substr. Google is your friend.
SELECT * , concat(left(date,2)) as 'opening_year' FROM account;

--

-- datetime

SELECT * FROM bank.account;

SELECT * , CONVERT(date,DATE) FROM bank.account;
SELECT * , CONVERT(date,datetime) FROM bank.account;

SELECT * FROM bank.card;

SELECT *,CONVERT(left(issued,6),date) AS 'issued_date' FROM bank.card;

SELECT *, date_format(CONVERT(left(issued,6),date), '%d-%m-%Y') AS 'issued_date' FROM bank.card;

SELECT *, date_format(CONVERT(left(issued,6),date), '%M') AS 'issued_date' FROM bank.card;



