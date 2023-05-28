CREATE DATABASE datamart_proyecto03;

CREATE TABLE sales(
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    channel_id INT NOT NULL,
    promotion_id INT NOT NULL,
    city_id INT NOT NULL,
    date_dim_id INT NOT NULL,
    quantity NUMERIC(10,2) NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    cost INT NOT NULL,

    PRIMARY KEY(order_id),
    CONSTRAINT fk_products FOREIGN KEY (product_id)
        REFERENCES products(product_id),
    CONSTRAINT fk_channels FOREIGN KEY (channel_id)
        REFERENCES channels(channel_id),
    CONSTRAINT fk_promotions FOREIGN KEY (promotion_id)
        REFERENCES promotions(promotion_id),
    CONSTRAINT fk_geography FOREIGN KEY (city_id)
        REFERENCES geography(city_id),
    CONSTRAINT fk_times FOREIGN KEY (date_dim_id)
        REFERENCES times(date_dim_id),
);

CREATE TABLE products(
    product_id INT NOT NULL,
    name VARCHAR(46),
    product_subcategory VARCHAR(50),
    product_category VARCHAR(50),
    list_price VARCHAR(10)

    PRIMARY KEY(product_id)
);

CREATE TABLE channels(
    channel_id INT NOT NULL,
    class VARCHAR(20),
    name VARCHAR(20),

    PRIMARY KEY(channel_id)
);

CREATE TABLE promotions(
    promotion_id INT NOT NULL,
    name VARCHAR(30),
    promo_subcategory  VARCHAR(30),
    promo_category VARCHAR(30),

    PRIMARY KEY(promotion_id)
);

CREATE TABLE times(
    date_dim_id INT NOT NULL,
    date_actual DATE NOT NULL,
    epoch BIGINT NOT NULL,
    day_suffix TEXT NOT NULL,
    day_name TEXT NOT NULL,
    day_of_week INT NOT NULL,
    day_of_month INT NOT NULL,
    day_of_quarter INT NOT NULL,
    day_of_year INT NOT NULL,
    week_of_month INT NOT NULL,
    week_of_year INT NOT NULL,
    week_of_year_iso CHAR(10) NOT NULL,
    month_actual INT NOT NULL,
    month_name TEXT NOT NULL,
    month_name_abbreviated CHAR(3) NOT NULL,
    quarter_actual INT NOT NULL,
    quarter_name TEXT NOT NULL,
    year_actual INT NOT NULL,
    first_day_of_week DATE NOT NULL,
    last_day_of_week DATE NOT NULL,
    first_day_of_month DATE NOT NULL,
    last_day_of_month DATE NOT NULL,
    first_day_of_quarter DATE NOT NULL,
    last_day_of_quarter DATE NOT NULL,
    first_day_of_year DATE NOT NULL,
    last_day_of_year DATE NOT NULL,
    mmyyyy TEXT NOT NULL,
    mmddyyyy TEXT NOT NULL,
    weekend_indr BOOLEAN NOT NULL,

    PRIMARY KEY(date_dim_id)
);

CREATE TABLE geography(
    city_id INT NOT NULL,
    city_name VARCHAR(30),
    state_province VARCHAR(50),
    country_name VARCHAR(40),
    subregion_name VARCHAR(30),
    region_name VARCHAR(30),

    PRIMARY KEY(city_id)
);