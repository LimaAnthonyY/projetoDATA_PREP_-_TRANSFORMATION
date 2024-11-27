CREATE TABLE wide_table (
    order_id UUID PRIMARY KEY, -- Chave primária para o pedido
    customer_id UUID NOT NULL, -- ID do cliente
    customer_name VARCHAR(255) NOT NULL, -- Nome do cliente
    customer_email VARCHAR(255) NOT NULL UNIQUE, -- E-mail único do cliente
    customer_state CHAR(2) NOT NULL, -- Estado do cliente (2 caracteres)
    customer_city VARCHAR(255) NOT NULL, -- Cidade do cliente
    product_id UUID NOT NULL, -- ID do produto
    product_name VARCHAR(255) NOT NULL, -- Nome do produto
    product_category_name VARCHAR(255) NOT NULL, -- Categoria do produto
    price NUMERIC(10, 2) NOT NULL, -- Preço do produto
    freight_value NUMERIC(10, 2) NOT NULL, -- Valor do frete
    seller_id UUID NOT NULL, -- ID do vendedor
    seller_name VARCHAR(255) NOT NULL, -- Nome do vendedor
    geolocation_id INT, -- ID da geolocalização (referência à tabela dim_geolocation)
    payment_value NUMERIC(10, 2) NOT NULL, -- Valor do pagamento
    order_status VARCHAR(50) NOT NULL DEFAULT 'pending', -- Status do pedido (com valor padrão)
    order_purchase_timestamp TIMESTAMP NOT NULL, -- Data de compra do pedido
    review_score SMALLINT CHECK (review_score >= 1 AND review_score <= 5), -- Nota de avaliação (restrição de 1 a 5)
    review_comment_message TEXT, -- Comentário de avaliação
    order_delivered_customer_date TIMESTAMP, -- Data de entrega do pedido ao cliente

    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES dim_products(product_id) ON DELETE CASCADE,
    CONSTRAINT fk_seller FOREIGN KEY (seller_id) REFERENCES dim_sellers(seller_id) ON DELETE CASCADE,
    CONSTRAINT fk_geolocation FOREIGN KEY (geolocation_id) REFERENCES dim_geolocation(geolocation_id) ON DELETE SET NULL
);

CREATE INDEX idx_wide_table_customer_id ON wide_table (customer_id);
CREATE INDEX idx_wide_table_product_id ON wide_table (product_id);
CREATE INDEX idx_wide_table_seller_id ON wide_table (seller_id);
CREATE INDEX idx_wide_table_geolocation_id ON wide_table (geolocation_id);
CREATE INDEX idx_wide_table_order_status ON wide_table (order_status);
CREATE INDEX idx_wide_table_order_purchase_timestamp ON wide_table (order_purchase_timestamp);
