SELECT table_schema, table_name, table_rows  
 FROM information_schema.tables 
 WHERE TABLE_SCHEMA LIKE 'classic%'; 
 
 -- Q1 
 SELECT DISTINCT offices.country 
	FROM offices
ORDER BY offices.country ASC;
    
-- Q2
SELECT  employees.employeeNumber, employees.lastName, employees.firstName
	FROM employees
WHERE employees.officeCode IN 
	(SELECT	officeCode
			FROM offices
	WHERE country = 'USA');

-- Q3
SELECT productCode, productName, productScale, productVendor, buyPrice
	FROM products
WHERE productLine = 'Classic Cars'
	AND quantityInStock >= 1000 
	AND quantityInStock <= 2000;

-- Q4
SELECT productCode, productName, productVendor, buyPrice, MSRP 
	FROM products
WHERE productVendor = 'Gearbox Collectibles'
	AND MSRP > (SELECT AVG(MSRP)
					FROM products);

-- Q5
 SELECT productName, productScale, buyPrice, quantityInStock, buyPrice*quantityInStock AS TotalValue
	FROM products
	WHERE productScale = '1:12'
LIMIT 5;

-- Q6
SELECT state, COUNT(customerNumber) AS Customers
	FROM customers
WHERE state IS NOT NULL
GROUP BY state
	HAVING Customers > 2
ORDER BY state ASC;

-- Q7
SELECT orderdetails.productCode , products.productName, COUNT(orderdetails.orderNumber) AS OrderCount
	FROM orderdetails, products
WHERE orderdetails.productCode = products.productCode
GROUP BY orderdetails.productCode
	HAVING OrderCount > 50;
    
-- Q8
SELECT  customers.customerNumber, customers.customerName, SUM(payments.amount) AS TotalPayments, customers.creditLimit
	FROM customers, payments
WHERE customers.customerNumber = payments.customerNumber
GROUP BY customerNumber
	HAVING SUM(payments.amount) > creditLimit
ORDER BY customerNumber;

-- Q9
SELECT  employeeNumber, CONCAT(firstName,' ',lastname) AS Name
	FROM employees
WHERE reportsTo in (SELECT employeeNumber
							FROM employees
					WHERE CONCAT(firstName,' ',lastname) = 'William Patterson'
						OR CONCAT(firstName,' ',lastname) = 'Mary Patterson'); 
                            
-- Q10
SELECT productName, MSRP, buyPrice, MSRP-buyPrice AS Profit
	FROM Products
WHERE productName LIKE '%Ferrari%';
    
-- Q11
SELECT orderNumber, requiredDate, shippedDate, requiredDate-shippedDate AS DateDifference, MONTH(shippedDate) AS ShippedMonth
	FROM orders
WHERE requiredDate-shippedDate < 10 
	AND MONTH(shippedDate) = 10
	AND YEAR(shippedDate) = 2003;

-- Q12
SELECT firstName, lastName
	FROM employees
WHERE jobTitle IN ('VP Sales','VP Marketing')
	AND employeeNumber NOT IN (SELECT salesRepEmployeeNumber
										FROM customers
								WHERE salesRepEmployeeNumber IS NOT NULL);
-- Q13
SELECT customers.customerName, customers.customerNumber
	FROM customers
WHERE customers.customerNumber 
							NOT IN (SELECT customerNumber
										FROM orders
								WHERE YEAR(orderDate) > 2004)
AND customers.country = 'Germany';

-- Q14
SELECT products.productName, orderdetails.productCode, orderdetails.quantityOrdered, orders.status 
	FROM orderdetails
INNER JOIN products
	ON products.productCode = orderdetails.productCode
INNER JOIN orders
	ON orders.orderNumber = orderdetails.orderNumber
WHERE orderdetails.orderNumber IN (SELECT orderNumber
										FROM orders
									WHERE orders.status = 'In Process')
AND orderdetails.quantityOrdered > 40;

-- Q15
USE `classicmodels`;
DROP TABLE IF EXISTS `TopCustomers`;
CREATE TABLE `TopCustomers`(
	`CustomerNumber` INT NOT NULL,
    `ContactDate` DATE NOT NULL,
    `OrderCount` INT NOT NULL,
    `OrderTotal` DECIMAL(9,2) NOT NULL,
    CONSTRAINT `TopCustomer_PK` PRIMARY KEY (CustomerNumber)
);

-- Q16
INSERT INTO `TopCustomers`(`CustomerNumber`, `ContactDate`, `OrderCount`,`OrderTotal`)
SELECT customers.customerNumber, DATE(NOW()), SUM(orderdetails.quantityOrdered), SUM(orderdetails.quantityOrdered*orderdetails.priceEach)
	FROM customers
INNER JOIN orders
	ON customers.customerNumber = orders.customerNumber
INNER JOIN orderdetails
	ON orders.orderNumber = orderdetails.orderNumber
GROUP BY customers.customerNumber
	HAVING SUM(orderdetails.quantityOrdered*orderdetails.priceEach) > 140000;
    
-- Verify
SELECT * FROM TopCustomers;

-- Q17
SELECT customerNumber, contactDate, OrderCount, orderTotal 
	FROM TopCustomers
ORDER BY orderTotal DESC
	LIMIT 5;

-- Q18
ALTER TABLE TopCustomers
	ADD COLUMN CustomerRatings INT DEFAULT 0; 

-- Verify
SELECT * FROM TopCustomers;

-- Q19
UPDATE TopCustomers
	SET CustomerRatings = FLOOR(RAND()*11);
-- Verify
SELECT * FROM TopCustomers;

-- Q20
SELECT* 
	FROM TopCustomers
ORDER BY CustomerRatings DESC;

-- Q21
DROP TABLE IF EXISTS `TopCustomers`;

    



    
    


    

