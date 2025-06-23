--  Northwind SQL Query Portfolio --

Author: [Your Name Here]
Database: Northwind
Purpose: Demonstrating SQL skills with real-world datasets (joins, aggregations, subqueries, window functions, etc.)

---

## Summary
This portfolio covers:
-  Basic queries and joins (INNER, LEFT, RIGHT, FULL)
-  Aggregation and grouping
-  Filtering with WHERE and HAVING
-  String functions (`CONCAT`, `||`)
-  Conditional logic (`CASE`, `IF`)
-  Date-based functions
-  Subqueries: scalar, correlated, inline/derived, tuple
-  Window functions: `RANK()`

Great for showcasing skills in interviews or GitHub portfolios.

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
SQLite does not support RIGHT JOIN natively, but this is how you'd conceptually simulate it.

SELECT 
  Orders.OrderID,
  Customers.CustomerID,
  Customers.ContactName
FROM Orders
LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

---

Feel free to expand with additional topics like recursive queries, advanced ranking, or performance tuning.
