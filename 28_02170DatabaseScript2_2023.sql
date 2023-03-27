SET SQL_SAFE_UPDATES = 0;

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
	(SELECT SUM(Quantity_Dish)
	 FROM Order_Dish
	 WHERE Order_Dish.Dish_ID = Dish.Dish_ID) as Quantity_Sold
FROM Dish
ORDER BY Quantity_Sold DESC;

# 6) SQL DATA QUERIES: Drink type popularity
SELECT Drink_Type,SUM(Quantity_Drink) as Quantity_Sold
FROM Order_Drink  NATURAL JOIN Drink
GROUP BY Drink_Type
ORDER BY Quantity_Sold DESC;

# 6) SQL DATA QUERIES: Get dish ingredients
SELECT Dish_Name, Ingr_Name
FROM Recipe NATURAL JOIN Ingredient NATURAL JOIN Dish
WHERE Recipe.Ingr_ID = Ingredient.Ingr_ID
ORDER BY Dish_ID;

# 6) SQL DATA QUERIES: Get all orders from a specific customer
(SELECT Table_ID, Order_Time, OD.Drink_ID as Item_ID, Quantity_Drink as Quantity, D.Drink_Name as Name, D.Price, D.Price*Quantity_Drink as Total_cost
FROM Order_Drink OD
JOIN Drink D on OD.Drink_ID = D.Drink_ID
WHERE Table_ID = 1 AND Order_Time = '2023-03-25 16:14:46')
UNION
(SELECT Table_ID, Order_Time, OD.Dish_ID as Item_ID, Quantity_Dish as Quantity, D.Dish_Name as Name, D.Price, D.Price*Quantity_Dish as Total_cost
FROM Order_Dish as OD
JOIN Dish D on OD.Dish_ID = D.Dish_ID
WHERE Table_ID = 1 AND Order_Time = '2023-03-25 16:14:46');

### TEST ###
SELECT Dish_Name, Quantity_Dish as num, Quantity_Dish*Price as subtotal
FROM Order_Dish NATURAL JOIN Dish
WHERE Table_ID = 1 AND Order_Time = '2023-03-25 16:14:46';

SELECT Drink_Name, Quantity_Drink as num, Quantity_Drink*Price as subtotal
FROM Order_Drink NATURAL JOIN Drink
WHERE Table_ID = 1 AND Order_Time = '2023-03-25 16:14:46';


# 7) SQL PROGRAMMING - Function: Customer bill
DELIMITER //
CREATE FUNCTION Total_Price(TabID INT, ordTime TIMESTAMP) RETURNS INT
BEGIN
	DECLARE PriceSumDish INT;
    DECLARE PriceSumDrink INT;

    SELECT SUM(Price*Quantity_Dish) INTO PriceSumDish
    FROM Order_Dish NATURAL JOIN Dish
    WHERE Table_ID = TabID and Order_Time = ordTime;

    SELECT SUM(Price*Quantity_Drink) INTO PriceSumDrink
	FROM Order_Drink NATURAL JOIN Drink
	WHERE Table_ID = TabID and Order_Time = ordTime;

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
DELIMITER //
CREATE TRIGGER Update_Dish_Cost
AFTER INSERT ON Recipe
FOR EACH ROW
BEGIN
    UPDATE Dish
    SET Price = (
        SELECT 1.2 * SUM(Cost)
        FROM Ingredient
        WHERE Ingr_ID IN (SELECT Ingr_ID FROM Recipe WHERE Dish_ID = NEW.Dish_ID)
    )
    WHERE Dish_ID = NEW.Dish_ID;
END //
DELIMITER ;

# 8) SQL TABLE MODIFICATIONS: Pay raise for waiters
SELECT * FROM Waiter;
UPDATE Waiter SET Salary =
CASE
WHEN Salary <= 25000
THEN Salary*1.05
WHEN Salary <= 30000
THEN Salary*1.02
ELSE Salary*0.98
END;
SELECT * FROM Waiter;

# 8) SQL TABLE MODIFICATIONS: Inflation
SELECT * FROM Ingredient;
UPDATE Ingredient SET Cost =
CASE
WHEN Cost <= 10
THEN Cost*1.1
ELSE Cost*1.08
END;
SELECT * FROM Ingredient;

# 8) SQL TABLE MODIFICATIONS: Remove pricy Dishes from menu
DELETE FROM Dish WHERE Price > 75;
SELECT * FROM Dish;

SELECT Total_Price(1, '2023-03-25 16:14:46');
