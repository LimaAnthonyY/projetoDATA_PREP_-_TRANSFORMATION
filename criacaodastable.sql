-- Criação da tabela 'customers'
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    customer_unique_id VARCHAR(255) NOT NULL,
    customer_zip_code_prefix INT,
    customer_city VARCHAR(255),
    customer_state VARCHAR(2)
);

-- Criação da tabela 'geolocation'
CREATE TABLE IF NOT EXISTS geolocation (
    geolocation_id SERIAL PRIMARY KEY,
    lat DOUBLE PRECISION,
    lng DOUBLE PRECISION,
    geolocation_zip_code_prefix INT
);

-- Criação da tabela 'order_items'
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id VARCHAR(255) NOT NULL,
    seller_id VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    freight_value DECIMAL(10, 2) NOT NULL
);

-- Criação da tabela 'order_payments'
CREATE TABLE IF NOT EXISTS order_payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    payment_type VARCHAR(255),
    payment_installments INT,
    payment_value DECIMAL(10, 2) NOT NULL
);

-- Criação da tabela 'order_reviews'
CREATE TABLE IF NOT EXISTS order_reviews (
    review_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATE,
    review_answer_timestamp DATE
);

-- Criação da tabela 'orders'
CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- Criação da tabela 'products'
CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR(255) PRIMARY KEY,
    product_category_name VARCHAR(255),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

-- Criação da tabela 'sellers'
CREATE TABLE IF NOT EXISTS sellers (
    seller_id VARCHAR(255) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(255),
    seller_state VARCHAR(2)
);

-- Criação da tabela 'product_category_translation'
CREATE TABLE IF NOT EXISTS product_category_translation (
    product_category_name VARCHAR(255) PRIMARY KEY,
    product_category_name_english VARCHAR(255)
);
