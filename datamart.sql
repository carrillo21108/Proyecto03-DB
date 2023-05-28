CREATE DATABASE datamart_proyecto03;

CREATE TABLE sales(
    product_id INT, //FK
    channel_id INT, //FK
);

CREATE TABLE products(
    product_id INT, //PK
    name VARCHAR(46),
    product_subcategory VARCHAR(50),
    product_category VARCHAR(50),
    list_price VARCHAR(10),
    min_price VARCHAR(9),

    PRIMARY KEY(product_id)
);

CREATE TABLE channels(
    channel_id INT, PK
    class VARCHAR(20),
    name VARCHAR(20),

    PRIMARY KEY(channel_id)
);

CREATE TABLE promotions(

);

CREATE TABLE times(

);

CREATE TABLE geography(

);