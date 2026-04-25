-- Database: vin_datathon
-- DROP DATABASE IF EXISTS vin_datathon;
-- \c vin_datathon

-- ==========================================
-- CLASS MASTER
-- ==========================================

CREATE TABLE geography (
    zip INT PRIMARY KEY,
    city VARCHAR(255) NOT NULL,
    region VARCHAR(100) NOT NULL,
    district VARCHAR(255) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    segment VARCHAR(100) NOT NULL,
    size VARCHAR(50) NOT NULL,
    color VARCHAR(50) NOT NULL,
    price FLOAT NOT NULL,
    cogs FLOAT NOT NULL,
    CONSTRAINT chk_cogs_price CHECK (cogs < price)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    zip INT NOT NULL REFERENCES geography(zip),
    city VARCHAR(255) NOT NULL,
    signup_date DATE NOT NULL,
    gender VARCHAR(20) NULL,
    age_group VARCHAR(50) NULL,
    acquisition_channel VARCHAR(100) NULL
);

CREATE TABLE promotions (
    promo_id VARCHAR(50) PRIMARY KEY,
    promo_name VARCHAR(255) NOT NULL,
    promo_type VARCHAR(50) NOT NULL,
    discount_value FLOAT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    applicable_category VARCHAR(100) NULL, 
    promo_channel VARCHAR(100) NULL,
    stackable_flag INT NOT NULL DEFAULT 0,
    min_order_value FLOAT NULL
);

-- ==========================================
-- CLASS TRANSACTION
-- ==========================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    zip INT NOT NULL REFERENCES geography(zip),
    order_status VARCHAR(50) NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    device_type VARCHAR(50) NOT NULL,
    order_source VARCHAR(100) NOT NULL
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity INT NOT NULL,
    unit_price FLOAT NOT NULL,
    discount_amount FLOAT NOT NULL,
    promo_id VARCHAR(50) NULL REFERENCES promotions(promo_id),
    promo_id_2 VARCHAR(50) NULL REFERENCES promotions(promo_id)
);

CREATE TABLE payments (
    order_id INT PRIMARY KEY REFERENCES orders(order_id),
    payment_method VARCHAR(100) NOT NULL,
    payment_value FLOAT NOT NULL,
    installments INT NOT NULL DEFAULT 1
);

CREATE TABLE shipments (
    order_id INT PRIMARY KEY REFERENCES orders(order_id),
    ship_date DATE NOT NULL,
    delivery_date DATE NULL,
    shipping_fee FLOAT NOT NULL DEFAULT 0
);

CREATE TABLE returns (
    return_id VARCHAR(50) PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    return_date DATE NOT NULL,
    return_reason TEXT NOT NULL,
    return_quantity INT NOT NULL,
    refund_amount FLOAT NOT NULL
);

CREATE TABLE reviews (
    review_id VARCHAR(50) PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    review_date DATE NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_title TEXT NULL
);

-- ==========================================
-- CLASS ANALYTICAL & OPERATIONAL
-- ==========================================

CREATE TABLE sales (
    Date DATE PRIMARY KEY,
    Revenue FLOAT NOT NULL,
    COGS FLOAT NOT NULL
);

CREATE TABLE inventory (
    snapshot_date DATE NOT NULL,
    product_id INT NOT NULL REFERENCES products(product_id),
    stock_on_hand INT NOT NULL,
    units_received INT NOT NULL,
    units_sold INT NOT NULL,
    stockout_days INT NOT NULL,
    days_of_supply FLOAT NOT NULL,
    fill_rate FLOAT NOT NULL,
    stockout_flag INT NOT NULL,
    overstock_flag INT NOT NULL,
    reorder_flag INT NOT NULL,
    sell_through_rate FLOAT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    segment VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    PRIMARY KEY (snapshot_date, product_id)
);

CREATE TABLE web_traffic (
    date DATE PRIMARY KEY,
    sessions INT NOT NULL,
    unique_visitors INT NOT NULL,
    page_views INT NOT NULL,
    bounce_rate FLOAT NOT NULL,
    avg_session_duration_sec FLOAT NOT NULL,
    traffic_source VARCHAR(100) NOT NULL
);
