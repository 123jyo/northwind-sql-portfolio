-- 📊 Northwind SQL Query Portfolio --

Author: Prabhjot Kaur
Database: Northwind
Purpose: Demonstrating SQL skills with real-world datasets (joins, aggregations, subqueries, window functions, etc.)

---

## Summary
This portfolio covers:
- ✅ Basic queries and joins (INNER, LEFT, RIGHT, FULL)
- ✅ Aggregation and grouping
- ✅ Filtering with WHERE and HAVING
- ✅ String functions (`CONCAT`, `||`)
- ✅ Conditional logic (`CASE`, `IF`)
- ✅ Date-based functions
- ✅ Subqueries: scalar, correlated, inline/derived, tuple
- ✅ Window functions: `RANK()`

Great for showcasing skills in interviews or GitHub portfolios.

---

## Tools Used
- SQLite
- DB Browser for SQLite
- GitHub
- ChatGPT for code review

---

## How to Use
1. Clone or download this repo.
2. Open the `northwind_queries.sql` file in your SQL editor.
3. Run queries step-by-step to explore SQL concepts.

---

## What I Learned
- Writing clean, readable SQL using real data
- Using window functions for ranking
- Handling NULLs and conditional logic effectively
- Structuring subqueries for advanced filtering

---

## SQL Practice Queries

---

## 1. CASE Statement - Order Category
SELECT Orders.OrderID,
       SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) AS OrderValue,
       CASE
         WHEN SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) > 5000 THEN 'High Value'
         WHEN SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) BETWEEN 1000 AND 5000 THEN 'Medium Value'
         ELSE 'Low Value'
       END AS OrderCategory
FROM Orders
JOIN `Order Details` ON Orders.OrderID = `Order Details`.OrderID
GROUP BY Orders.OrderID;

---

## 2. IF Statement - Discount Level
SELECT `Order Details`.OrderID,
       `Order Details`.ProductID,
       `Order Details`.Discount,
       IF(Discount = 0, 'No Discount',
          IF(Discount > 0.1, 'Big Discount', 'Small Discount')) AS DiscountLevel
FROM `Order Details`;

---

## 3. RANK() - Customer Spend Ranking
SELECT Customers.CustomerID,
       Customers.ContactName,
       Customers.CompanyName,
       SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) AS TotalSpent,
       RANK() OVER (ORDER BY SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) DESC) AS PurchaseRank
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN `Order Details` ON Orders.OrderID = `Order Details`.OrderID
GROUP BY Customers.CustomerID, Customers.ContactName, Customers.CompanyName;

---

## 4. Product Sales Summary
SELECT Products.ProductID,
       Products.ProductName,
       COUNT(`Order Details`.Quantity) AS QuantitySold,
       SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) AS TotalRevenue,
       ROUND(SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) / COUNT(`Order Details`.Quantity), 2) AS AvgPriceSold
FROM Products
JOIN `Order Details` ON `Order Details`.ProductID = Products.ProductID
GROUP BY Products.ProductID, Products.ProductName;

---

## 5. Category Sales Ranking
SELECT Products.ProductID,
       Products.ProductName,
       Categories.CategoryID,
       Categories.CategoryName,
       SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) AS TotalRevenue,
       RANK() OVER (ORDER BY SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) DESC) AS CategoryRank
FROM Products
JOIN Categories ON Categories.CategoryID = Products.CategoryID
JOIN `Order Details` ON `Order Details`.ProductID = Products.ProductID
GROUP BY Products.ProductID, Products.ProductName, Categories.CategoryID, Categories.CategoryName;

---

## 6. First and Last Order Date Per Customer
SELECT Customers.ContactName,
       MIN(Orders.OrderDate) AS FirstOrderDate,
       MAX(Orders.OrderDate) AS LastOrderDate
FROM Customers
JOIN Orders ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.ContactName;

---

## 7. Employees with Total Sales
SELECT Employees.EmployeeID,
       Employees.FirstName || ' ' || Employees.LastName AS EmployeeName,
       COUNT(Orders.OrderID) AS TotalOrdersHandled,
       SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) AS TotalAmountSold
FROM Employees
JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
JOIN `Order Details` ON Orders.OrderID = `Order Details`.OrderID
GROUP BY Employees.EmployeeID, EmployeeName
ORDER BY EmployeeName;

---

## 8. Products Never Ordered
SELECT Products.ProductID,
       Products.ProductName
FROM Products
LEFT JOIN `Order Details` ON Products.ProductID = `Order Details`.ProductID
WHERE `Order Details`.ProductID IS NULL;

---

## 9. Correlated Subquery - Customers with Above Average Spend
SELECT CustomerID, ContactName
FROM Customers
WHERE EXISTS (
    SELECT 1 FROM Orders
    JOIN `Order Details` ON Orders.OrderID = `Order Details`.OrderID
    WHERE Orders.CustomerID = Customers.CustomerID
    GROUP BY Orders.CustomerID
    HAVING SUM(`Order Details`.UnitPrice * `Order Details`.Quantity) > 5000
);

---

## 10. Derived Table - Average Revenue per Product
SELECT ProductName, TotalRevenue
FROM (
  SELECT Products.ProductName,
         SUM(`Order Details`.UnitPrice * `Order Details`.Quantity) AS TotalRevenue
  FROM Products
  JOIN `Order Details` ON Products.ProductID = `Order Details`.ProductID
  GROUP BY Products.ProductID
) AS RevenueTable
WHERE TotalRevenue > 1000;

---

## 11. Customers with Multiple Orders
SELECT CustomerID, COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 5;

---

## 12. Monthly Revenue Trend
SELECT STRFTIME('%Y-%m', OrderDate) AS Month,
       SUM(`Order Details`.UnitPrice * `Order Details`.Quantity) AS Revenue
FROM Orders
JOIN `Order Details` ON Orders.OrderID = `Order Details`.OrderID
GROUP BY Month
ORDER BY Month;

---

## 13. Top 5 Selling Products
SELECT Products.ProductName,
       SUM(`Order Details`.Quantity) AS TotalSold
FROM Products
JOIN `Order Details` ON Products.ProductID = `Order Details`.ProductID
GROUP BY Products.ProductID
ORDER BY TotalSold DESC
LIMIT 5;

---

## 14. AVG Unit Price by Category
SELECT Categories.CategoryName,
       AVG(Products.UnitPrice) AS AvgPrice
FROM Categories
JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryID;

---

## 15. Products with Price Higher than Category Avg
SELECT Products.ProductName, Products.UnitPrice, Categories.CategoryName
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Products.UnitPrice > (
  SELECT AVG(P.UnitPrice)
  FROM Products P
  WHERE P.CategoryID = Products.CategoryID
);

---

## 16. Employee Name Format (Concatenation)
SELECT EmployeeID, FirstName || ' ' || LastName AS FullName
FROM Employees;

---

## 17. JOIN Types - LEFT JOIN Example
SELECT 
  Customers.CustomerID, 
  Customers.ContactName, 
  Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerID;

---

## 18. JOIN Types - RIGHT JOIN (Simulated in SQLite)
-- SQLite does not support RIGHT JOIN natively, but this is how you'd conceptually simulate it.
SELECT 
  Orders.OrderID,
  Customers.CustomerID,
  Customers.ContactName
FROM Orders
LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
