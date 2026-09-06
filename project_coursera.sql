-- Query 1: Analyze total units sold for each product
SELECT 
    p.productCode,
    p.productName,
    p.quantityInStock,
    SUM(od.quantityOrdered) AS totalSold
FROM products p
JOIN orderdetails od
    ON p.productCode = od.productCode
GROUP BY 
    p.productCode,
    p.productName,
    p.quantityInStock
ORDER BY totalSold DESC;

-- Query 2: Identify the 10 slowest-selling products
SELECT p.productCode,p.productName,p.quantityInStock,SUM(od.quantityOrdered) AS totalSold
FROM products p
LEFT JOIN orderdetails od
    ON p.productCode = od.productCode
GROUP BY 
    p.productCode,p.productName,p.quantityInStock
ORDER BY totalSold ASC;

-- Query 3: Identify products with no recorded sales

SELECT p.productCode,p.productName,p.quantityInStock
FROM products p
LEFT JOIN orderdetails od
    ON p.productCode = od.productCode
WHERE od.productCode IS NULL;

-- Query 4: Compare current inventory levels with total units sold

SELECT p.productCode,p.productName,p.quantityInStock,sum(od.quantityOrdered) AS totalSold,
p.quantityInStock / sum(od.quantityOrdered) AS stockToSalesRatio
FROM products p
JOIN orderdetails od
    ON p.productCode = od.productCode
GROUP BY 
    p.productCode,
    p.productName,
    p.quantityInStock
ORDER BY stockToSalesRatio DESC;

-- Query 5: Identify products with a high stock-to-sales ratio

SELECT p.productCode,p.productName,p.quantityInStock,sum(od.quantityOrdered) AS totalSold,
p.quantityInStock / sum(od.quantityOrdered) AS stockToSalesRatio
FROM products p
JOIN orderdetails od
    ON p.productCode = od.productCode
GROUP BY 
    p.productCode,
    p.productName,
    p.quantityInStock
    Having stocktosalesratio>8
ORDER BY stockToSalesRatio DESC;

-- Warehouse Capacity Utilization
select warehouseName, warehousePctCap from warehouses
order by 2 desc;

-- Number of Products Stored by Warehouse
select w.warehouseName, count(p.productCode) as total_products from products p 
join warehouses w on p.warehousecode=w.warehouseCode
group by w.warehouseName
order by total_products desc;

-- Total Inventory Units by Warehouse
select w.warehouseName, sum(p.quantityinstock) as total_stock from products p 
join warehouses w on p.warehousecode=w.warehouseCode
group by w.warehouseName
order by total_stock desc;

-- wrong
SELECT w.warehouseName,SUM(p.quantityInStock) AS totalStock,SUM(od.quantityOrdered) AS totalSold,
SUM(od.quantityOrdered) / SUM(p.quantityInStock) AS salesToStockRatio FROM products p
JOIN warehouses w 
    ON p.warehouseCode = w.warehouseCode
JOIN orderdetails od 
    ON p.productCode = od.productCode
GROUP BY w.warehouseName
ORDER BY salesToStockRatio DESC; #wrong coz tables got multiplied

-- Total Sales Value by Warehouse
SELECT w.warehouseName,SUM(od.quantityOrdered * od.priceEach) AS totalSales FROM products p
JOIN warehouses w
    ON p.warehouseCode = w.warehouseCode
JOIN orderdetails od
    ON p.productCode = od.productCode
GROUP BY w.warehouseName
ORDER BY totalSales DESC;


-- Total Units Sold by Warehouse
select w.warehousename,sum(od.quantityordered) as total_sold from products p join
warehouses w on p.warehouseCode=w.warehouseCode
join orderdetails od on p.productCode=od.productCode
group by w.warehouseName
order by total_sold desc;

-- Warehouse Stock-to-Sales Ratio
SELECT w.warehouseName,stock.totalStock,sales.totalSold,stock.totalStock / sales.totalSold AS stockToSalesRatio
FROM warehouses w
JOIN (
    SELECT warehouseCode,SUM(quantityInStock) AS totalStock FROM products
    GROUP BY warehouseCode
) stock
    ON w.warehouseCode = stock.warehouseCode
JOIN (
    SELECT p.warehouseCode,SUM(od.quantityOrdered) AS totalSold FROM products p
    JOIN orderdetails od
	ON p.productCode = od.productCode
    GROUP BY p.warehouseCode
) sales
ON w.warehouseCode = sales.warehouseCode
ORDER BY stockToSalesRatio DESC;

-- Product-to-Warehouse Mapping
select p.productname,w.warehousename,p.quantityinstock from products p
join warehouses w on p.warehouseCode=w.warehouseCode;


-- Inventory Value by Product
select productname,(quantityInStock*buyprice) as inventory_cost from products
order by inventory_cost desc;


-- High-Value Inventory with Low Sales
select p.productname,p.quantityinstock,(quantityInStock*buyprice) as inventory_cost,sum(od.quantityOrdered) as total_sold
from products p join orderdetails od
on p.productCode=od.productCode
group by p.productName,p.quantityInStock,p.buyPrice
having inventory_cost>500000
order by total_sold asc;

-- Total Units Sold by Product Line
select p.productLine,sum(od.quantityOrdered) as quantity_sold
from products p join orderdetails od
on p.productCode=od.productCode
group by p.productLine
order by quantity_sold desc;

-- Total Inventory by Product Line
select productline,sum(quantityinstock) as total_stock from products
group by productLine
order by total_stock;

-- Product-Line Stock-to-Sales Ratio
SELECT stock.productLine,stock.totalStock,sales.totalSold,stock.totalStock / sales.totalSold AS stockToSalesRatio
FROM
(SELECT productLine,SUM(quantityInStock) AS totalStock FROM products
    GROUP BY productLine) stock
JOIN
(SELECT p.productLine,SUM(od.quantityOrdered) AS totalSold FROM products p
    JOIN orderdetails od
        ON p.productCode = od.productCode
    GROUP BY p.productLine) sales
    ON stock.productLine = sales.productLine
ORDER BY stockToSalesRatio DESC;

-- South-to-West Inventory Transfer Scenario

SELECT
    west.currentStock,
    south.currentStock AS southStock,
    west.currentStock / 0.50 AS estimatedWestCapacity,
    west.currentStock + south.currentStock AS stockAfterTransfer,
    (west.currentStock + south.currentStock)
        / (west.currentStock / 0.50) * 100
        AS estimatedCapacityAfterTransfer
FROM
(
    SELECT SUM(p.quantityInStock) AS currentStock
    FROM products p
    JOIN warehouses w
        ON p.warehouseCode = w.warehouseCode
    WHERE w.warehouseName = 'West'
) west
CROSS JOIN
(
    SELECT SUM(p.quantityInStock) AS currentStock
    FROM products p
    JOIN warehouses w
        ON p.warehouseCode = w.warehouseCode
    WHERE w.warehouseName = 'South'
) south;

-- Identify the top 10 best-selling products and their current inventory
select p.productname,p.productcode,p.quantityInStock,sum(od.quantityordered) as total_sold,
(p.quantityinstock/sum(od.quantityordered)) as ratio
from products p
join orderdetails od
on p.productCode=od.productCode
group by p.productName,p.productCode,p.quantityInStock
order by total_sold desc limit 10;

-- Calculate the total inventory value held by each warehouse

SELECT w.warehouseName,SUM(p.quantityInStock * p.buyPrice) AS inventoryValue FROM products p
JOIN warehouses w
ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseName
ORDER BY inventoryValue DESC;

-- Identify high-selling products with relatively low inventory

SELECT p.productCode,p.productName,p.quantityInStock,SUM(od.quantityOrdered) AS totalSold,
p.quantityInStock / SUM(od.quantityOrdered) AS stockToSalesRatio FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
GROUP BY p.productCode,p.productName,p.quantityInStock
HAVING stockToSalesRatio < 3
ORDER BY totalSold DESC;