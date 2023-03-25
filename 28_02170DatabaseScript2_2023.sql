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

# 6) SQL DATA QUERIES: Sort drinks by price
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


Drop function Total_Price;

# 7) SQL PROGRAMMING - Function: Customer bill
DELIMITER //
CREATE FUNCTION Total_Price(TabID INT, stTime TIMESTAMP) RETURNS INT
BEGIN
	DECLARE PriceSumDish INT;
    DECLARE PriceSumDrink INT;
    
    SELECT SUM(Price* Quantity_Dish) INTO PriceSumDish
    FROM Customer NATURAL JOIN Order_Dish NATURAL JOIN Dish 
    WHERE Table_ID = TabID and Start_Time = stTime and Order_Time = stTime;
    
    SELECT SUM(Price*Quantity_Drink) INTO PriceSumDrink
	FROM Customer NATURAL JOIN Order_Drink NATURAL JOIN Drink
	WHERE Table_ID = TabID and Start_Time = stTime and Order_Time = stTime;

    RETURN PriceSumDish + PriceSumDrink;
END //
DELIMITER ;

SELECT Total_Price(1, '2023-03-25 16:14:46');


# 7) SQL PROGRAMMING - Procedure: Given a dish, output its ingredients
DELIMITER //
CREATE PROCEDURE Ingredients_From_Dish(IN DID INT)
BEGIN
	SELECT Dish_Name, Ingr_Name 
	FROM Recipe NATURAL JOIN Ingredient NATURAL JOIN Dish 
	WHERE Dish_ID = DID AND Recipe.Ingr_ID = Ingredient.Ingr_ID 
	ORDER BY Dish_ID;
END //
DELIMITER ;
CALL Ingredients_From_Dish(10);


# 7) SQL PROGRAMMING - Trigger



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

# 8) SQL TABLE MODIFICATIONS: Remove pricy Dishes from menu
DELETE FROM Dish WHERE Price > 75;


SELECT coalesce(ODR.Table_ID, ODI.Table_ID), coalesce(ODR.Order_Time, ODI.Order_Time) , coalesce(ODR.Drink_ID, ODI.Dish_ID) as Item_ID
FROM Order_Drink ODR
JOIN Order_Dish ODI
WHERE ODR.Table_ID = 1;


SELECT *
FROM Order_Drink ODR
JOIN Order_Dish ODI
WHERE ODR.Table_ID = 1;

SELECT Table_ID, Order_Time, OD.Drink_ID as Item_ID, Quantity_Drink as Quantity, D.Drink_Name as Name, D.Price, D.Price*Quantity_Drink 
FROM Order_Drink OD
JOIN Drink D on OD.Drink_ID = D.Drink_ID
WHERE Table_ID = 1 AND Order_Time = '2023-03-25 16:14:46'
UNION 
SELECT Table_ID, Order_Time, OD.Dish_ID as Item_ID, Quantity_Dish as Quantity, D.Dish_Name as Name, D.Price, D.Price*Quantity_Dish
FROM Order_Dish as OD
JOIN Dish D on OD.Dish_ID = D.Dish_ID
WHERE Table_ID = 1 AND Order_Time = '2023-03-25 16:14:46';

SELECT Total_Price(1, '2023-03-25 16:14:46');
