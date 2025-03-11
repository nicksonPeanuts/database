show databases;
use classicmodels;

/*select è come una tabella!*/

SELECT * from customers;

SELECT customerName from customers;

SELECT * from products WHERE MSRP < 75;

SELECT * from employees WHERE lastName LIKE '%son';

/*seleziona tutto da employees dove lastName non ha il pattern son */

SELECT * from employees WHERE lastName NOT LIKE '%son';

/*esercizi di database*/
SELECT * from employees WHERE firstName LIKE  '_arry';

SELECT * from products WHERE productScale LIKE '1:_0';

SELECT * from products;

SELECT * FROM employees
    WHERE firstName BETWEEN 'B' AND 'F';

SELECT officeCode, city, phone FROM offices WHERE country IN ('USA', 'FRANCE');