/*
    Title: db_init_outland_adventures
    Author(s) in Alplabetical Order: Christopher Kaiser, Estiven Hernandez, Juan Taylor, Julia Gonzalez, Michelle Choe
    Date: 9 July 2023
    Description: outland adventures initialization script.
*/

-- drop database user if exists 
DROP USER IF EXISTS 'outland_adventures_user'@'localhost';


-- create movies_user and grant them all privileges to the movies database 
CREATE USER 'outland_adventures_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

-- grant all privileges to the movies database to user movies_user on localhost 
GRANT ALL PRIVILEGES ON outland_adventures.* TO 'outland_adventures_user'@'localhost';

-- drop tables if they are present
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS guides;
DROP TABLE IF EXISTS users_attending_trips;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS orders;

-- create users table
CREATE TABLE users (
    user_id 	   INT 	   	   AUTO_INCREMENT  NOT NULL,
    username 	   VARCHAR(50),
    password 	   VARCHAR(50),
    fname 	   VARCHAR(50),
    lname 	   VARCHAR(50),
    past_trips 	   VARCHAR(255),

    PRIMARY KEY (user_id)
);

-- create equipment table
CREATE TABLE equipment (
    equipment_id   INT             NOT NULL	   AUTO_INCREMENT,
    user_id 	   INT	   	   NOT NULL,
    name 	   VARCHAR(50) 	   NOT NULL,
    cost 	   DOUBLE 	   NOT NULL,
    equip_status   ENUM('Bought','Rented') 	   NOT NULL,
    equip_type 	   ENUM('Hiking', 'Camping') 	   NOT NULL,
    equip_expired  BOOLEAN,
  
    PRIMARY KEY (equipment_id),

    CONSTRAINT fk_users    
    FOREIGN KEY (user_id) 
        REFERENCES users(user_id)
);

-- create orders table
CREATE TABLE orders (
    order_id 	     INT 	   PRIMARY KEY 	   AUTO_INCREMENT 	   NOT NULL,
    user_id 	     INT,
    equipment_id     INT,
    purchase_date    DATETIME,
    
    PRIMARY KEY (order_id),

    CONSTRAINT fk_users	
    FOREIGN KEY (user_id) 
        REFERENCES users(user_id),

    CONSTRAINT fk_equipment
    FOREIGN KEY (equipment_id) 
        REFERENCES equipment(equipment_id)
);

-- create guide table
CREATE TABLE guides (
    guide_id       INT             NOT NULL        AUTO_INCREMENT,
    first_name     VARCHAR(15)     NOT NULL,
    last_name      VARCHAR(15)     NOT NULL,

    PRIMARY KEY(country_id)
);

-- create country table
CREATE TABLE country (
    country_id     INT             NOT NULL        AUTO_INCREMENT,
    country_name   VARCHAR(15)     NOT NULL,

    PRIMARY KEY(country_id)
);

-- create trip table
CREATE TABLE trips (
    trip_id        INT             NOT NULL        AUTO_INCREMENT,
    trip_name      VARCHAR(15)     NOT NULL,
    trip_date      DATETIME,

    PRIMARY KEY(trip_id),

    CONSTRAINT fk_guide
    FOREIGN KEY(guide_id)
        REFERENCES guide(guide_id),

    CONSTRAINT fk_country
    FOREIGN KEY(country_id)
        REFERENCES country(country_id),
); 

-- create users_attending trips table
CREATE TABLE users_attending_trip (
    user_id   	   INT             NOT NULL,
    trip_id   	   INT             NOT NULL,

    PRIMARY KEY(user_id, trip_id),

    CONSTRAINT fk_users
    FOREIGN KEY(user_id)
        REFERENCES user(user_id),

    CONSTRAINT fk_trip
    FOREIGN KEY(trip_id)
        REFERENCES trip(trip_id)
);
 
