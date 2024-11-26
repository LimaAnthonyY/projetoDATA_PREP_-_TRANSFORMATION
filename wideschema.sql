CREATE TABLE wide_table (
    order_id UUID PRIMARY KEY,
    customer_id UUID NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255) NOT NULL UNIQUE,
    customer_state CHAR(2) NOT NULL,
    customer_city VARCHAR(255) NOT NULL,
    product_id UUID NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    product_category_name VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    freight_value NUMERIC(10, 2) NOT NULL,
    seller_id UUID NOT NULL,
    seller_name VARCHAR(255) NOT NULL,
    geolocation_zip_code_prefix VARCHAR(8),
    geolocation_lat NUMERIC(9, 6),
    geolocation_lng NUMERIC(9, 6),
    payment_value NUMERIC(10, 2) NOT NULL,
    order_status VARCHAR(50) NOT NULL,
    order_purchase_timestamp TIMESTAMP NOT NULL,
    review_score SMALLINT,
    review_comment_message TEXT,
    order_delivered_customer_date TIMESTAMP,
    
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES dim_products(product_id) ON DELETE CASCADE,
    CONSTRAINT fk_seller FOREIGN KEY (seller_id) REFERENCES dim_sellers(seller_id) ON DELETE CASCADE,
    CONSTRAINT fk_geolocation FOREIGN KEY (geolocation_zip_code_prefix) REFERENCES dim_geolocation(geolocation_zip_code_prefix) ON DELETE SET NULL
);

CREATE INDEX idx_wide_table_customer_id ON wide_table (customer_id);
CREATE INDEX idx_wide_table_product_id ON wide_table (product_id);
CREATE INDEX idx_wide_table_seller_id ON wide_table (seller_id);
CREATE INDEX idx_wide_table_geolocation_zip_code_prefix ON wide_table (geolocation_zip_code_prefix);
CREATE INDEX idx_wide_table_order_status ON wide_table (order_status);
CREATE INDEX idx_wide_table_order_purchase_timestamp ON wide_table (order_purchase_timestamp);
