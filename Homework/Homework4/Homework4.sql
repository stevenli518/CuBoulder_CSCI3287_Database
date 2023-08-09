-- Q1.1 
use information_schema;
Select table_name, table_rows
	from tables
where table_schema like 'aw%';

-- Q1.2
use aw; 
SELECT COUNT(*)
	FROM DimAccount;
SELECT COUNT(*)
	FROM DimCurrency;
SELECT COUNT(*)
	FROM DimCustomer;
SELECT COUNT(*)
	FROM DimDepartmentGroup;
SELECT COUNT(*)
	FROM DimEmployee;
SELECT COUNT(*)
	FROM DimGeography;
SELECT COUNT(*)
	FROM DimOrganization;
SELECT COUNT(*)
	FROM DimProduct;
SELECT COUNT(*)
	FROM DimProductCategory;
SELECT COUNT(*)
	FROM DimProductSubcategory;
SELECT COUNT(*)
	FROM DimPromotion;
SELECT COUNT(*)
	FROM DimReseller;
SELECT COUNT(*)
	FROM DimSalesReason;
SELECT COUNT(*)
	FROM DimSalesTerritory;
SELECT COUNT(*)
	FROM DimScenario;
SELECT COUNT(*)
	FROM DimTime;
SELECT COUNT(*)
	FROM FactCurrencyRate;
SELECT COUNT(*)
	FROM FactFinance;
SELECT COUNT(*)
	FROM FactInternetSales;
    
-- Q2
use information_schema;
SELECT table_name, column_name
	FROM COLUMNS
where table_schema like 'aw%'
	AND column_key like 'PRI';
    
-- Q5

use aw; 
SELECT  *
	FROM DimProductCategory;

SELECT ProductSubcategoryKey, EnglishProductSubcategoryName
	FROM DimProductSubcategory;
    
SELECT DISTINCT EnglishProductSubcategoryName 
	FROM DimProductSubcategory
INNER JOIN DimProductCategory
	ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
WHERE DimProductCategory.EnglishProductCategoryName = 'Bikes';

-- Q6
SELECT *
FROM  DimProductSubcategory;

SELECT DISTINCT EnglishProductSubcategoryName,  SUM(FactInternetSales.SalesAmount) AS 'TotalSales'
	FROM DimProductSubcategory
INNER JOIN DimProduct
	ON DimProductSubcategory. ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
INNER JOIN FactInternetSales
	ON DimProduct.ProductKey = FactInternetSales.ProductKey
INNER JOIN DimTime
	ON FactInternetSales.OrderDateKey = DimTime.TimeKey
WHERE DimProductSubcategory.ProductCategoryKey = '1'
	AND
		DimTime.CalendarYear = '2004'
GROUP BY EnglishProductSubcategoryName;

-- Q7
SELECT * FROM DimProductSubcategory;

SELECT EnglishProductSubcategoryName 
	FROM DimProductSubcategory
WHERE ProductCategoryKey != 1
LIMIT 6;

-- Q8
SELECT * FROM FactInternetSales;

 SELECT DISTINCT DimProduct.Color, COUNT(FactInternetSales.OrderQuantity) AS 'TotalBikeSales', DimTime.CalendarYear
	FROM DimProductSubcategory
INNER JOIN DimProduct
	ON DimProductSubcategory. ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
INNER JOIN FactInternetSales
	ON DimProduct.ProductKey = FactInternetSales.ProductKey
INNER JOIN DimTime
	ON FactInternetSales.OrderDateKey = DimTime.TimeKey
WHERE DimProductSubcategory.ProductCategoryKey = '1'
	AND DimTime.CalendarYear BETWEEN 2001 AND 2004

GROUP BY DimProduct.Color,DimTime.CalendarYear
ORDER BY DimTime.CalendarYear,
		COUNT(FactInternetSales.OrderQuantity) DESC;

SELECT Color, MAX(TotalBikeSales) AS 'BikeSales', CalendarYear 
FROM (
SELECT DISTINCT DimProduct.Color, COUNT(*) AS 'TotalBikeSales', DimTime.CalendarYear
	FROM DimProductSubcategory
INNER JOIN DimProduct
	ON DimProductSubcategory. ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
INNER JOIN FactInternetSales
	ON DimProduct.ProductKey = FactInternetSales.ProductKey
INNER JOIN DimTime
	ON FactInternetSales.OrderDateKey = DimTime.TimeKey
WHERE DimProductSubcategory.ProductCategoryKey = '1'
	AND DimTime.CalendarYear BETWEEN 2001 AND 2004

GROUP BY DimProduct.Color,DimTime.CalendarYear
ORDER BY DimTime.CalendarYear,
		COUNT(FactInternetSales.OrderQuantity) DESC
) AS SUB
GROUP BY CalendarYear, Color;

-- Q9
SELECT * FROM DimGeography;

SELECT DISTINCT  COUNT(*) AS 'TotalBikeSales', DimTime.CalendarYear, DimTime.EnglishMonthName, DimCustomer.Gender
	FROM DimProductSubcategory
INNER JOIN DimProduct
	ON DimProductSubcategory. ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
INNER JOIN FactInternetSales
	ON DimProduct.ProductKey = FactInternetSales.ProductKey
INNER JOIN DimCustomer
	ON DimCustomer.CustomerKey = FactInternetSales.CustomerKey
INNER JOIN DimTime
	ON FactInternetSales.OrderDateKey = DimTime.TimeKey
WHERE DimCustomer.Gender = 'F'
	AND DimProductSubcategory.ProductCategoryKey = '1'
GROUP BY DimCustomer.Gender, DimTime.CalendarYear, DimTime.EnglishMonthName
ORDER BY COUNT(*) DESC;

-- Q10
SELECT * FROM DimCustomer;
SELECT * FROM FactInternetSales;

SELECT DISTINCT  SUM((FactInternetSales.UnitPrice - FactInternetSales.ProductStandardCost) ) AS 'highest margin', DimTime.CalendarYear,  DimGeography.StateProvinceName AS Province
	FROM DimProductSubcategory
INNER JOIN DimProduct
	ON DimProductSubcategory. ProductSubcategoryKey = DimProduct.ProductSubcategoryKey
INNER JOIN FactInternetSales
	ON DimProduct.ProductKey = FactInternetSales.ProductKey
INNER JOIN DimCustomer
	ON DimCustomer.CustomerKey = FactInternetSales.CustomerKey
INNER JOIN DimTime
	ON FactInternetSales.OrderDateKey = DimTime.TimeKey 
INNER JOIN DimGeography
	On DimGeography.GeographyKey = DimCustomer.GeographyKey
WHERE DimTime.CalendarYear = '2004'
	AND DimProductSubcategory.ProductCategoryKey = '1'
GROUP BY DimGeography.StateProvinceName
ORDER BY 'highest margin'  DESC
LIMIT 10;

