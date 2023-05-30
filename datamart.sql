CREATE DATABASE datamart_proyecto03;

/*Tablas Datamart*/
CREATE TABLE products(
    "product_id" INT NOT NULL,
    "name_product" VARCHAR(46),
    "product_subcategory" VARCHAR(50),
    "product_category" VARCHAR(50),
    "list_price" VARCHAR(10),

    PRIMARY KEY("product_id")
);

CREATE TABLE channels(
    "channel_id" INT NOT NULL,
    "class" VARCHAR(20),
    "name_channel" VARCHAR(20),

    PRIMARY KEY("channel_id")
);

CREATE TABLE promotions(
    "promotion_id" INT NOT NULL,
    "name_promotion" VARCHAR(30),
    "promo_subcategory"  VARCHAR(30),
    "promo_category" VARCHAR(30),

    PRIMARY KEY("promotion_id")
);

CREATE TABLE times(
    "order_date" VARCHAR2(20) NOT NULL,
    "year_actual" NUMERIC,
    "quarter_name" VARCHAR2(40),
    "month_name" VARCHAR2(40),
    "week_of_year" NUMERIC,
    "day_of_week" VARCHAR2(40),

    PRIMARY KEY("order_date")
);

CREATE TABLE geography(
    "city_id" INT NOT NULL,
    "name_city" VARCHAR(30),
    "state_province" VARCHAR(50),
    "country_name" VARCHAR(40),
    "subregion_name" VARCHAR(30),
    "region_name" VARCHAR(30),

    PRIMARY KEY("city_id")
);

CREATE TABLE sales(
    "order_id" INT NOT NULL,
    "product_id" INT NOT NULL,
    "channel_id" INT NOT NULL,
    "promotion_id" INT NOT NULL,
    "city_id" INT NOT NULL,
    "order_date" VARCHAR2(20) NOT NULL,
    "quantity" NUMERIC(10,2) NOT NULL,
    "amount" NUMERIC(10,2) NOT NULL,
    "cost" INT NOT NULL,

    CONSTRAINT fk_products FOREIGN KEY ("product_id")
        REFERENCES PRODUCTS("product_id"),
    CONSTRAINT fk_channels FOREIGN KEY ("channel_id")
        REFERENCES CHANNELS("channel_id"),
    CONSTRAINT fk_promotions FOREIGN KEY ("promotion_id")
        REFERENCES PROMOTIONS("promotion_id"),
    CONSTRAINT fk_geography FOREIGN KEY ("city_id")
        REFERENCES GEOGRAPHY("city_id"),
    CONSTRAINT fk_times FOREIGN KEY ("order_date")
        REFERENCES TIMES("order_date")
);

/*Consultas a Base de Datos Transaccional*/
/*Table channels*/
SELECT id as channel_id,class,name as name_channel FROM channels

/*Table promotions*/
SELECT p.id AS promotion_id, p.name AS name_promotion, ps.name AS promo_subcategory, pc.name AS promo_category
FROM promotions p
LEFT JOIN promo_subcategories ps ON p.subcategory_id = ps.id
LEFT JOIN promo_categories pc ON ps.category_id = pc.id;

/*Table products*/
SELECT p.identifier as product_id, 
       p.name as name_product, 
       s.name as product_subcategory,
	   c.name as product_category,
	   p.list_price as list_price
FROM products p
LEFT JOIN categories s ON p.subcategory_reference = s.id 
LEFT JOIN categories c ON s.category_id = c.id

/*Table geography*/
SELECT c.id AS city_id, c.name AS city_name, c.state_province, cn.name AS country_name, r.name AS subregion_name, rg.name AS region_name
FROM cities c
LEFT JOIN countries cn ON c.country_iso_code = cn.iso_code
LEFT JOIN regions r ON cn.region_id = r.id
LEFT JOIN regions rg ON r.id = rg.id;

/*Table Times*/
SELECT DISTINCT oi.order_date::TEXT,
EXTRACT(year FROM oi.order_date) AS year_actual,
CASE
           WHEN EXTRACT(quarter FROM oi.order_date) = 1 THEN 'First'
           WHEN EXTRACT(quarter FROM oi.order_date) = 2 THEN 'Second'
           WHEN EXTRACT(quarter FROM oi.order_date) = 3 THEN 'Third'
           WHEN EXTRACT(quarter FROM oi.order_date) = 4 THEN 'Fourth'
           END AS quarter_name,
TO_CHAR(oi.order_date, 'TMMonth') AS month_name,
EXTRACT(week FROM oi.order_date) AS week_of_year,
TO_CHAR(oi.order_date, 'D') AS day_of_week
FROM order_items oi
INNER JOIN orders o ON o.id = oi.order_id;

/*Facts Table Sales*/
SELECT o.id AS order_id, oi.product_id, c.id AS channel_id, o.promotion_id, a.city_id, oi.order_date::TEXT, oi.quantity, oi.amount, oi.cost
FROM orders o
INNER JOIN order_items oi ON o.id = oi.order_id
LEFT JOIN channels c ON c.name = o.channel
LEFT JOIN addresses a ON a.customer_id = o.customer_id;

