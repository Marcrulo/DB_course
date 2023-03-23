# 6) SQL DATA QUERIES: Basic select statements
SELECT * FROM Customer;
SELECT * FROM Dish;
SELECT * FROM Drink;
SELECT * FROM Ingredient;
SELECT * FROM Order_Dish;
SELECT * FROM Order_Drink;
SELECT * FROM Recipe;
SELECT * FROM Serves;
SELECT * FROM Waiter;

# 6) SQL DATA QUERIES: Order drinks by price
SELECT Drink_Name, Price FROM Drink ORDER BY Price;

# 6) SQL DATA QUERIES: Popularity of dishes
SELECT Dish_ID, Dish_Name, 
	(SELECT SUM(Quantity) 
	 FROM Order_Dish 
	 WHERE Order_Dish.Dish_ID = Dish.Dish_ID) as Quantity_Sold
FROM Dish
ORDER BY Quantity_Sold DESC;
 
# 6) SQL DATA QUERIES: Drink type popularity
SELECT Drink_Type,SUM(Quantity) as Quantity_Sold
FROM Order_Drink  NATURAL JOIN Drink
GROUP BY Drink_Type
ORDER BY Quantity_Sold DESC;

# 6) SQL DATA QUERIES: Get dish ingredients
SELECT Dish_Name, Ingr_Name 
FROM Recipe NATURAL JOIN Ingredient NATURAL JOIN Dish 
WHERE Recipe.Ingr_ID = Ingredient.Ingr_ID 
ORDER BY Dish_ID;


SELECT * FROM Customer
WHERE Table_ID = 1 and Start_Time = '2023-03-23 11:10:21';


# 7) SQL PROGRAMMING: 
# Function: Customer bill
DELIMITER //
CREATE FUNCTION Total_Price(TabID INT, stTime TIMESTAMP) RETURNS INT
BEGIN
	DECLARE PriceSum INT;
    SELECT Dish_ID INTO PriceSum 
    FROM Order_Dish;
    
    RETURN PriceSum;
END //
DELIMITER ;

# procedures

# triggers

# (event)



# 8) SQL TABLE MODIFICATIONS: Pay raise for waiters
UPDATE Waiter SET Salary = 
CASE
WHEN Salary <= 25000
THEN Salary*1.05
WHEN Salary <= 30000
THEN Salary*1.02
ELSE Salary*0.98
END;

# 8) SQL TABLE MODIFICATIONS: Inflation
UPDATE Ingredient SET Cost = 
CASE
WHEN Cost <= 10
THEN Cost*1.1
ELSE Cost*1.08
END;