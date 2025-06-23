-- 📊 Northwind SQL Query Portfolio --

Author: [Your Name Here]
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

## 1. CASE Statement - Order Category
```sql
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
```

---

## 2. IF Statement - Discount Level
```sql
SELECT `Order Details`.OrderID,
       `Order Details`.ProductID,
       `Order Details`.Discount,
       IF(Discount = 0, 'No Discount',
          IF(Discount > 0.1, 'Big Discount', 'Small Discount')) AS DiscountLevel
FROM `Order Details`;
```

---

## 3. RANK() - Customer Spend Ranking
```sql
SELECT Customers.CustomerID,
       Customers.ContactName,
       Customers.CompanyName,
       SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) AS TotalSpent,
       RANK() OVER (ORDER BY SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) DESC) AS PurchaseRank
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN `Order Details` ON Orders.OrderID = `Order Details`.OrderID
GROUP BY Customers.CustomerID, Customers.ContactName, Customers.CompanyName;
```

---

## 4. Product Sales Summary
```sql
SELECT Products.ProductID,
       Products.ProductName,
       COUNT(`Order Details`.Quantity) AS QuantitySold,
       SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) AS TotalRevenue,
       ROUND(SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) / COUNT(`Order Details`.Quantity), 2) AS AvgPriceSold
FROM Products
JOIN `Order Details` ON `Order Details`.ProductID = Products.ProductID
GROUP BY Products.ProductID, Products.ProductName;
```

---

## 5. Category Sales Ranking
```sql
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
```

---

## 6. First and Last Order Date Per Customer
```sql
SELECT Customers.ContactName,
       MIN(Orders.OrderDate) AS FirstOrderDate,
       MAX(Orders.OrderDate) AS LastOrderDate
FROM Customers
JOIN Orders ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.ContactName;
```

---

## 7. Employees with Total Sales
```sql
SELECT Employees.EmployeeID,
       Employees.FirstName || ' ' || Employees.LastName AS EmployeeName,
       COUNT(Orders.OrderID) AS TotalOrdersHandled,
       SUM(`Order Details`.Quantity * `Order Details`.UnitPrice) AS TotalAmountSold
FROM Employees
JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
JOIN `Order Details` ON Orders.OrderID = `Order Details`.OrderID
GROUP BY Employees.EmployeeID, EmployeeName
ORDER BY EmployeeName;
```

---

## 17. JOIN Types - LEFT JOIN Example
```sql
SELECT 
  Customers.CustomerID, 
  Customers.ContactName, 
  Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerID;
```

---

## 18. JOIN Types - RIGHT JOIN (Simulated in SQLite)
> SQLite does not support RIGHT JOIN natively, but this is how you'd conceptually simulate it.
```sql
SELECT 
  Orders.OrderID,
  Customers.CustomerID,
  Customers.ContactName
FROM Orders
LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
```

---

Feel free to expand with additional topics like recursive queries, advanced ranking, or performance tuning.
