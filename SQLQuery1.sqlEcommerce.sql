CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);



CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


INSERT INTO Customers VALUES
(1,'Rahul','Delhi'),
(2,'Aman','Mumbai'),
(3,'Priya','Noida');


INSERT INTO Products VALUES
(101,'Laptop',50000),
(102,'Mouse',500),
(103,'Keyboard',1500);

INSERT INTO Orders VALUES
(1001,1,'2026-11-01'),
(1002,2,'2026-11-02'),
(1003,1,'2026-11-03');

INSERT INTO OrderDetails VALUES
(1,1001,101,1),
(2,1001,102,2),
(3,1002,103,1),
(4,1003,102,3);


SELECT SUM(P.Price * OD.Quantity) AS TotalSales
FROM OrderDetails OD
JOIN Products P
ON OD.ProductID = P.ProductID;


SELECT
    P.ProductName,
    SUM(OD.Quantity) AS QuantitySold,
    SUM(P.Price * OD.Quantity) AS Revenue
FROM OrderDetails OD
JOIN Products P
ON OD.ProductID = P.ProductID
GROUP BY P.ProductName;


SELECT
    C.CustomerName,
    SUM(P.Price * OD.Quantity) AS TotalSpent
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD
ON O.OrderID = OD.OrderID
JOIN Products P
ON OD.ProductID = P.ProductID
GROUP BY C.CustomerName;


SELECT TOP 1
    P.ProductName,
    SUM(OD.Quantity) AS QtySold
FROM OrderDetails OD
JOIN Products P
ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY QtySold DESC;


SELECT
    O.OrderDate,
    SUM(P.Price * OD.Quantity) AS DailyRevenue
FROM Orders O
JOIN OrderDetails OD
ON O.OrderID = OD.OrderID
JOIN Products P
ON OD.ProductID = P.ProductID
GROUP BY O.OrderDate
ORDER BY O.OrderDate;


SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

SELECT COUNT(*) AS TotalOrders
FROM Orders;

SELECT COUNT(*) AS TotalCustomers
FROM Customers;

SELECT SUM(P.Price * OD.Quantity) AS Revenue
FROM OrderDetails OD
JOIN Products P
ON OD.ProductID = P.ProductID;


SELECT TOP 1
    C.CustomerName,
    SUM(P.Price * OD.Quantity) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY C.CustomerName
ORDER BY TotalSpent DESC;

SELECT TOP 1
    P.ProductName,
    SUM(P.Price * OD.Quantity) AS Revenue
FROM Products P
JOIN OrderDetails OD
ON P.ProductID = OD.ProductID
GROUP BY P.ProductName
ORDER BY Revenue DESC;


CREATE VIEW vw_SalesReport
AS
SELECT
    O.OrderID,
    O.OrderDate,
    C.CustomerName,
    P.ProductName,
    OD.Quantity,
    P.Price,
    (OD.Quantity * P.Price) AS Amount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID;



SELECT * FROM vw_SalesReport;


SELECT
    SUM(Amount) AS TotalRevenue
FROM vw_SalesReport;




SELECT
    ProductName,
    SUM(Quantity) AS QtySold
FROM vw_SalesReport
GROUP BY ProductName
ORDER BY QtySold DESC;


SELECT
    OrderDate,
    SUM(Amount) AS Revenue
FROM vw_SalesReport
GROUP BY OrderDate
ORDER BY OrderDate;