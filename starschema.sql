CREATE TABLE dim_customers ( 
    customer_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255) UNIQUE NOT NULL,
    customer_state CHAR(2) NOT NULL,
    customer_city VARCHAR(255) NOT NULL
);

CREATE TABLE dim_geolocation (
    geolocation_id SERIAL PRIMARY KEY,
    geolocation_lat NUMERIC(9, 6) NOT NULL,
    geolocation_lng NUMERIC(9, 6) NOT NULL,
    geolocation_state CHAR(2) NOT NULL,
    geolocation_city VARCHAR(255) NOT NULL,
    geolocation_zip_code_prefix VARCHAR(8)
);

CREATE TABLE dim_products (
    product_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_name VARCHAR(255) NOT NULL,
    product_category_name VARCHAR(255) NOT NULL
);

CREATE TABLE dim_sellers (
    seller_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    seller_name VARCHAR(255) NOT NULL,
    seller_state CHAR(2) NOT NULL
);

CREATE TABLE dim_time (
    date_id SERIAL PRIMARY KEY,
    date_actual DATE NOT NULL,
    day INT NOT NULL CHECK (day >= 1 AND day <= 31),
    month INT NOT NULL CHECK (month >= 1 AND month <= 12),
    year INT NOT NULL,
    quarter INT NOT NULL CHECK (quarter >= 1 AND quarter <= 4),
    month_name VARCHAR(20) NOT NULL,
    quarter_name VARCHAR(20) NOT NULL
);

CREATE TABLE fact_orders (
    order_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL REFERENCES dim_customers(customer_id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES dim_products(product_id) ON DELETE CASCADE,
    order_timestamp TIMESTAMP NOT NULL,
    seller_id UUID NOT NULL REFERENCES dim_sellers(seller_id) ON DELETE CASCADE,
    geolocation_id INT REFERENCES dim_geolocation(geolocation_id) ON DELETE SET NULL,
    payment_value NUMERIC(10, 2) NOT NULL,
    freight_value NUMERIC(10, 2) NOT NULL,
    order_status VARCHAR(50) NOT NULL
);

CREATE INDEX idx_fact_orders_customer_id ON fact_orders (customer_id);
CREATE INDEX idx_fact_orders_produ
