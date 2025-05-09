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

/* DECODIFICARE RELAZIONI */

/* prodotto cartesiano fra le tabelle */

SELECT * from customers, employees;

SELECT * FROM customers;

SELECT customerName, salesRepEmployeeNumber,
lastName, employeeNumber
FROM customers, employees
WHERE salesRepEmployeeNumber = employeeNumber



#QUERY HARD con subquery,
SELECT od.orderNumber, p.productCode, p.productName, od.quantityOrdered, od.priceEach, (od.quantityOrdered * od.priceEach) as tot
FROM orderdetails od
INNER JOIN products p USING (productCode)
WHERE (priceEach*quantityOrdered) =
      (SELECT MAX(priceEach*quantityOrdered) FROM orderdetails od2 where od.orderNumber = od2.orderNumber)
order by productCode



SET @nic = (SELECT MAX(MSRP) FROM products);

select @nic

SELECT * from products
where msrp = @nic

set profiling = 1;

SHOW PROFILES;

#DAL BLOCCO NOTE PREPARE STATEMENT
#statement preparato con query che seleziona
PREPARE STMT1 FROM 'SELECT productCode, productName FROM products WHERE MSRP > ?';
SET @pi = 100;
EXECUTE STMT1 USING @pi;

#VISTE

CREATE VIEW viewListinoClienti AS
SELECT productCode, productName, MSRP
FROM products;

SELECT * from viewListinoClienti;

CREATE VIEW viewtotaleordini AS
    SELECT orderNumber, sum(quantityOrdered * priceEach) as totale FROM orderdetails GROUP BY orderNumber;
drop view viewtotaleordini;

SELECT * from viewtotaleordini

SELECT totale FROM viewtotaleordini WHERE orderNumber = 10101



CREATE PROCEDURE sp_contaOrdini(
IN orderStatus VARCHAR(25),
OUT total INT)
BEGIN
SELECT count(orderNumber)
INTO total FROM orders
WHERE status = orderStatus;
END


CALL sp_contaOrdini('Shipped', @total);
SELECT @total; --- 303


CREATE PROCEDURE sp_getOrderByCust(
    IN clientCode INT(24),
    OUT shipped varchar(25),
    OUT cancelled varchar(25),
    OUT resolved varchar(25),
    OUT disputed varchar(25)
)
BEGIN
    SELECT count(*) INTO shipped FROM orders
        WHERE customerNumber = clientCode AND status = "Shipped";

    SELECT count(*) INTO cancelled FROM orders
        WHERE customerNumber = clientCode AND status = "Cancelled";

    SELECT count(*) INTO resolved FROM orders
        WHERE customerNumber = clientCode AND status = "Resolved";

    SELECT count(*) INTO disputed FROM orders
        WHERE customerNumber = clientCode AND status = "Disputed";

end;

CALL sp_getOrderByCust(141,@shipped,@canceled,
@resolved,@disputed);
SELECT @shipped,@canceled,@resolved,@disputed;

CREATE PROCEDURE sp_getCustomerLevel(
    IN customerCode INT(25),
    OUT livello VARCHAR(25)
)
BEGIN
    DECLARE creditLim double
    SELECT creditLimit INTO creditLim
    FROM customers
    WHERE customerNumber = customerCode;
        IF creditLimit > 50000 THEN
            SET livello = "PLATINUM";
        ELSEIF creditLimit >= 10000 THEN
            SET livello = "GOLD";
        ELSE
            SET livello = "SILVER";
        end if;
end;

CALL sp_getCustomerLevel(103, @livello);
SELECT @livello;


CREATE PROCEDURE sp_fibonacci(IN n int, OUT out_fib int)
BEGIN
DECLARE m INT default 0;
DECLARE k INT default 1;
DECLARE i INT default 1;
DECLARE tmp INT;
WHILE (i<=n) DO
set tmp = m+k;
set m = k;
set k = tmp;
set i = i+1;
END WHILE;
SET out_fib = m;
END;GESTIR

CALL sp_fibonacci(10, @fib)
SELECT @fib


CREATE PROCEDURE sp_counting(
    IN customerNo INT
)
BEGIN
    DECLARE conteggio INT;
    SELECT count(*) INTO conteggio FROM customers WHERE customerNumber = customerNo;
    IF conteggio = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT ="Errore, non ci sono ordini";
    END IF;
    SELECT count(*) FROM orders WHERE customerNumber = customerNo;
end;

SELECT customers.customerNumber FROM customers INNER JOIN orders ON(customers.customerNumber = orders.customerNumber)

CALL sp_counting(231312)





