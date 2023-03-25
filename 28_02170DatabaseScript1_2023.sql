
### CREATE DATABASE
DROP DATABASE IF EXISTS pizzaria;
CREATE DATABASE pizzaria;
USE pizzaria;

### DROP TABLES IF EXIST
DROP TABLE IF EXISTS Dish;
DROP TABLE IF EXISTS Drink;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS Recipe;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Waiter;
DROP TABLE IF EXISTS Order_Dish;
DROP TABLE IF EXISTS Order_Drink;
DROP TABLE IF EXISTS Serves;

### CREATE TABLES
CREATE TABLE Drink
	(Drink_ID		INT AUTO_INCREMENT,
	 Drink_Name		VARCHAR(20),
	 Price			INT,
     Drink_Type		ENUM('Soda','Alcoholic','Coffee','Water'),	
	 PRIMARY KEY(Drink_ID)
	);

CREATE TABLE Dish
	(Dish_ID		INT AUTO_INCREMENT, 
	 Dish_Name		VARCHAR(20),
	 Price			INT,
     Dish_Type		ENUM('Pizza','Burger','Sides'),
	 PRIMARY KEY(Dish_ID)
	);

CREATE TABLE Ingredient
	(Ingr_ID		INT AUTO_INCREMENT,
	 Ingr_Name		VARCHAR(20),
	 Cost			FLOAT,
	 PRIMARY KEY(Ingr_ID)
	);
    
CREATE TABLE Recipe
	(Ingr_ID		INT,
     Dish_ID		INT,
	 PRIMARY KEY(Ingr_ID, Dish_ID),
     FOREIGN KEY(Ingr_ID) REFERENCES Ingredient(Ingr_ID) ON DELETE CASCADE,
	 FOREIGN KEY(Dish_ID) REFERENCES Dish(Dish_ID) ON DELETE CASCADE
	);
    
CREATE TABLE Customer
	(Table_ID		INT AUTO_INCREMENT,
	 Start_Time     TIMESTAMP,
	 PRIMARY KEY(Table_ID, Start_Time)
	);
    
CREATE TABLE Waiter
	(Waiter_ID		INT AUTO_INCREMENT,
     Waiter_Name	VARCHAR(50),
     Salary			INT,
	 PRIMARY KEY(Waiter_ID)
	);
    
CREATE TABLE Order_Dish
	(Table_ID		INT ,
	 Order_Time     TIMESTAMP,
	 Dish_ID		INT,
     Quantity_Dish  INT NOT NULL DEFAULT 1,
     
     PRIMARY KEY(Table_ID, Order_Time, Dish_ID, Quantity),
     FOREIGN KEY(Table_ID) REFERENCES Customer(Table_ID) ON DELETE CASCADE,
     FOREIGN KEY(Dish_ID) REFERENCES Dish(Dish_ID) ON DELETE CASCADE
	);

CREATE TABLE Order_Drink
	(Table_ID		INT,
	 Order_Time     TIMESTAMP,
	 Drink_ID		INT,
     Quantity_Drink	INT NOT NULL DEFAULT 1,
     
     PRIMARY KEY(Table_ID, Order_Time, Drink_ID, Quantity),
     FOREIGN KEY(Table_ID) REFERENCES Customer(Table_ID) ON DELETE CASCADE,
     FOREIGN KEY(Drink_ID) REFERENCES Drink(Drink_ID) ON DELETE CASCADE
	);
    
CREATE TABLE Serves
	(Table_ID		INT,
     Start_Time		TIMESTAMP,
     Waiter_ID		INT,
	 PRIMARY KEY(Table_ID, Start_Time, Waiter_ID),
     FOREIGN KEY(Table_ID, Start_Time) REFERENCES Customer(Table_ID,Start_Time) ON DELETE CASCADE,
     FOREIGN KEY(Waiter_ID) REFERENCES Waiter(Waiter_ID) ON DELETE CASCADE
    );


CREATE VIEW Non_Admin_Waiter AS 
SELECT Waiter_ID, Waiter_Name 
FROM Waiter;




INSERT Drink VALUES
('1','San Pellegrino','20','Water'),
('2','Coca Cola','22','Soda'),
('3','Sprite','21','Soda'),
('4','Latté','25','Coffee'),
('5','Cappuccino','30','Coffee'),
('6','Red Wine','50','Alcoholic'),
('7','Beer','22','Alcoholic'),
(NULL, 'Fanta', '21', 'Soda');

INSERT Dish VALUES
('0','Margherita','69','Pizza'),
('4','Lyngby','85','Pizza'),
('10','Hawaii','75','Pizza'),
('11','Italiano','79','Pizza'),
('100','Classic','60','Burger'),
('102','Bacon','65','Burger'),
('151','Fries','45','Sides'),
('60','Chicken Nuggets','60','Sides');

INSERT Ingredient VALUES
('1', 'Dough','3'),
('2', 'Tomato','3'),
('3', 'Cheese','12'),
('4', 'Ham','7'),
('5', 'Pineapple','8'),
('6', 'Mushroom','9'),
('7', 'Shrimp','15'),
('8', 'Beef','9'),
('9', 'Onion','1'),
('10', 'Frozen Fries', '3'),
('11', 'Frozen Nuggets','1'),
('12', 'Burger Bun','1'),
('13', 'Lettuce','1'),
('14', 'Bacon','1'),
('15', 'Mayo','1');

INSERT Recipe VALUES
('1','0'),('2','0'),('3','0'),
('1','4'),('2','4'),('3','4'),('4','4'),('6','4'),('7','4'),
('1','10'),('2','10'),('3','10'),('4','10'),('5','10'),('1','11'),('2','11'),('3','11'),('8','11'),('9','11'),
('10','151'),
('11','60'),
('12','100'),('8','100'),('13','100'),('15','100'),('2','100'),
('12','102'),('8','102'),('13','102'),('15','102'),('2','102'),('14','102');

INSERT Customer VALUES
('1','2023-03-25 16:14:46'),
('1', '2022-03-23 11:10:21'),
('5','2023-03-25 16:14:46'),
('42','2023-03-25 16:14:46');

INSERT Waiter VALUES
(NULL,'Joe',33000),
(NULL,'Candice',20000),
(NULL,'Steve',25000);
    
INSERT Order_Dish VALUES
('1','2023-03-25 16:14:46','0',DEFAULT),
('1','2023-03-25 16:14:46','4','2'),
('1','2022-03-23 11:10:21', '4','2'),
('1','2023-03-25 16:14:46','151','3'),
('5','2023-03-25 16:14:46','10','1'),
('5','2023-03-25 16:14:46','11','2'),
('5','2023-03-25 16:14:46','4','1'),
('42','2023-03-25 16:14:46','102','5');

INSERT Order_Drink VALUES
('1','2023-03-25 16:14:46','1','2'),
('1','2023-03-25 16:14:46','2','3'),
('5','2023-03-25 16:14:46','3','1'),
('5','2023-03-25 16:14:46','5','2'),
('42','2023-03-25 16:14:46','7','3'),
('42','2023-03-25 16:14:46','6','2'),
('42',CURRENT_TIMESTAMP,'4','1');

INSERT Serves VALUES
('1','2023-03-25 16:14:46','1'),
('5','2023-03-25 16:14:46','2'),
('42','2023-03-25 16:14:46','3');

    
    
    
    

