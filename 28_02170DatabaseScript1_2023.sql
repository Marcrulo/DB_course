
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
	(Drink_ID		SMALLINT NOT NULL AUTO_INCREMENT,
	 Drink_Name		VARCHAR(20),
	 Price			SMALLINT,
     Drink_Type		ENUM('Soda','Alcoholic','Coffee','Water'),	
	 PRIMARY KEY(Drink_ID)
	);

CREATE TABLE Dish
	(Dish_ID		SMALLINT NOT NULL AUTO_INCREMENT,
	 Dish_Name		VARCHAR(20),
	 Price			SMALLINT,
     Dish_Type		ENUM('Pizza','Burger','Sides'),
	 PRIMARY KEY(Dish_ID)
	);

CREATE TABLE Ingredient
	(Ingr_ID		SMALLINT NOT NULL AUTO_INCREMENT,
	 Ingr_Name		VARCHAR(20),
	 Cost			INT,
	 PRIMARY KEY(Ingr_ID)
	);
    
CREATE TABLE Recipe
	(Ingr_ID		SMALLINT NOT NULL,
     Dish_ID		SMALLINT NOT NULL,
	 PRIMARY KEY(Ingr_ID, Dish_ID),
     FOREIGN KEY(Ingr_ID) REFERENCES Ingredient(Ingr_ID) ON DELETE CASCADE,
	 FOREIGN KEY(Dish_ID)   REFERENCES Dish(Dish_ID) ON DELETE CASCADE
	);
    
CREATE TABLE Customer
	(Table_ID		INT NOT NULL AUTO_INCREMENT,
	 Start_Time     TIMESTAMP,
	 PRIMARY KEY(Table_ID, Start_Time)
	);
    
CREATE TABLE Waiter
	(Waiter_ID		INT NOT NULL AUTO_INCREMENT,
     Waiter_Name	VARCHAR(50),
     Salary			INT,
	 PRIMARY KEY(Waiter_ID)
	);
    
CREATE TABLE Order_Dish
	(Table_ID		INT NOT NULL,
	 Order_Time     TIMESTAMP,
	 Dish_ID		SMALLINT NOT NULL,
     Quantity		TINYINT NOT NULL DEFAULT 0,
     
     PRIMARY KEY(Table_ID, Order_Time, Dish_ID, Quantity),
     FOREIGN KEY(Table_ID) REFERENCES Customer(Table_ID) ON DELETE CASCADE,
     FOREIGN KEY(Dish_ID) REFERENCES Dish(Dish_ID) ON DELETE CASCADE
	);

CREATE TABLE Order_Drink
	(Table_ID		INT NOT NULL,
	 Order_Time     TIMESTAMP,
	 Drink_ID		SMALLINT NOT NULL,
     Quantity		TINYINT NOT NULL DEFAULT 0,
     
     PRIMARY KEY(Table_ID, Order_Time, Drink_ID, Quantity),
     FOREIGN KEY(Table_ID) REFERENCES Customer(Table_ID) ON DELETE CASCADE,
     FOREIGN KEY(Drink_ID) REFERENCES Drink(Drink_ID) ON DELETE CASCADE
	);
    
CREATE TABLE Serves
	(Table_ID		INT NOT NULL,
     Start_Time		VARCHAR(20),#TIMESTAMP,
     Waiter_ID		INT NOT NULL,
	 PRIMARY KEY(Table_ID, Start_Time, Waiter_ID),
     FOREIGN KEY(Table_ID) REFERENCES Customer(Table_ID),# ON DELETE CASCADE,
     #FOREIGN KEY(Start_Time) REFERENCES Customer(Start_Time),# ON DELETE CASCADE,
     FOREIGN KEY(Waiter_ID) REFERENCES Waiter(Waiter_ID) #ON DELETE CASCADE
    );


INSERT Drink VALUES
(NULL,'San Pellegrino','20','Water');

INSERT Dish VALUES
(NULL,'Hawaii','69','Pizza');

INSERT Ingredient VALUES
(NULL, 'Pineapple','5');

INSERT Recipe VALUES
('1','1');

INSERT Customer VALUES
('1',CURRENT_TIMESTAMP);

INSERT Waiter VALUES
(NULL,'Joe',1000);
    
INSERT Order_Dish VALUES
('1',CURRENT_TIMESTAMP,'1','1');

INSERT Order_Drink VALUES
('1',CURRENT_TIMESTAMP,'1','1');

INSERT Serves VALUES
('1',CURRENT_TIMESTAMP,'1');
    
    
    
    

