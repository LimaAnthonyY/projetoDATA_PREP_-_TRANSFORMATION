# projetoDATA_PREP_-_TRANSFORMATION

```python
PS C:\Users\Anthony\New folder\projetoDATA_PREP_-_TRANSFORMATION> python etl.py
>> 
Carregando olist_customers_dataset.csv na tabela customers...
Carregado com sucesso: customers
Carregando olist_geolocation_dataset.csv na tabela geolocation...
Carregado com sucesso: geolocation
Carregando olist_order_items_dataset.csv na tabela order_items...
Carregado com sucesso: order_items
Carregando olist_order_payments_dataset.csv na tabela order_payments...
Carregado com sucesso: order_payments
Carregando olist_order_reviews_dataset.csv na tabela order_reviews...
Carregado com sucesso: order_reviews
Carregando olist_orders_dataset.csv na tabela orders...
Carregado com sucesso: orders
Carregando olist_products_dataset.csv na tabela products...
Carregado com sucesso: products
Carregando olist_sellers_dataset.csv na tabela sellers...
Carregado com sucesso: sellers
Carregando product_category_name_translation.csv na tabela product_category_translation...
Carregado com sucesso: product_category_translation
PS C:\Users\Anthony\New folder\projetoDATA_PREP_-_TRANSFORMATION> 
```

```python
PS C:\Users\Anthony\New folder\projetoDATA_PREP_-_TRANSFORMATION> psql postgresql://postgres:password@localhost:5432/olist_db
>>
psql (17.2)
WARNING: Console code page (850) differs from Windows code page (1252)
         8-bit characters might not work correctly. See psql reference
         page "Notes for Windows users" for details.
Type "help" for help.

olist_db=# \d order_items
                       Table "public.order_items"
       Column        |       Type       | Collation | Nullable | Default
---------------------+------------------+-----------+----------+---------
 order_id            | text             |           |          |
 order_item_id       | bigint           |           |          |
 product_id          | text             |           |          |
 seller_id           | text             |           |          |
 shipping_limit_date | text             |           |          |
 price               | double precision |           |          |
 freight_value       | double precision |           |          |


olist_db=# SELECT COUNT(*) FROM customers;
 count
-------
 99441
(1 row)


olist_db=# SELECT COUNT(*) FROM geolocation;
 count
--------
 995475
(1 row)


olist_db=# SELECT COUNT(*) FROM order_items;
 count
--------
 112650
(1 row)


olist_db=# SELECT COUNT(*) FROM order_payments;
 count
--------
 103886
(1 row)


olist_db=# SELECT COUNT(*) FROM order_reviews;
 count
--------
 100000
(1 row)


olist_db=# SELECT COUNT(*) FROM orders;
 count
-------
 99441
(1 row)


olist_db=# SELECT COUNT(*) FROM products;
 count
-------
 32951
(1 row)


olist_db=# SELECT COUNT(*) FROM sellers;
 count
-------
  3095
(1 row)


olist_db=# SELECT COUNT(*) FROM product_category_translation;
 count
-------
    71
(1 row)


olist_db=# SELECT COUNT(*) FROM customers WHERE customer_id IS NULL;
 count
-------
     0
(1 row)


olist_db=# \q


```

```python
PS C:\Users\Anthony\New folder\projetoDATA_PREP_-_TRANSFORMATION> python analise___exxx.py                                
Primeiras 5 linhas da tabela customers:
                        customer_id                customer_unique_id  customer_zip_code_prefix          customer_city customer_state
0  06b8999e2fba1a1fbc88172c00ba8bc7  861eff4711a542e4b93843c6dd7febb0                     14409                 franca             SP   
1  18955e83d337fd6b2def6b18a428ac77  290c77bc529b7ac935b93aa66c333dc3                      9790  sao bernardo do campo             SP   
2  4e7b3e00288586ebd08712fdd0374a03  060e732b5b29e8181a18229c7b0b2b5e                      1151              sao paulo             SP   
3  b2b6027bc5c5109e529d4dc6358b12c3  259dac757896d24d7702b9acbbff3f3c                      8775        mogi das cruzes             SP   
4  4f2d8ab171c80ec8364f7c12e35b23ad  345ecd01c38d18a9036ed96c73b8d066                     13056               campinas             SP   

Primeiras 5 linhas da tabela geolocation:
   geolocation_zip_code_prefix  geolocation_lat  geolocation_lng geolocation_city geolocation_state
0                         1037       -23.545621       -46.639292        sao paulo                SP
1                         1046       -23.546081       -46.644820        sao paulo                SP
2                         1046       -23.546129       -46.642951        sao paulo                SP
3                         1041       -23.544392       -46.639499        sao paulo                SP
4                         1035       -23.541578       -46.641607        sao paulo                SP 

Primeiras 5 linhas da tabela order_items:
                           order_id  order_item_id                        product_id  ...  shipping_limit_date   price  freight_value
0  00010242fe8c5a6d1ba2dd792cb16214              1  4244733e06e7ecb4970a6e2683c13e61  ...  2017-09-19 09:45:35   58.90          13.29   
1  00018f77f2f0320c557190d7a144bdd3              1  e5f2d52b802189ee658865ca93d83a8f  ...  2017-05-03 11:05:13  239.90          19.93   
2  000229ec398224ef6ca0657da4fc703e              1  c777355d18b72b67abbeef9df44fd0fd  ...  2018-01-18 14:48:30  199.00          17.87   
3  00024acbcdf0a6daa1e931b038114c75              1  7634da152a4610f1595efa32f14722fc  ...  2018-08-15 10:10:18   12.99          12.79   
4  00042b26cf59d7ce69dfabb4e55b4fd9              1  ac6c3623068f30de03045865e4e10089  ...  2017-02-13 13:57:51  199.90          18.14   

[5 rows x 7 columns]

Primeiras 5 linhas da tabela order_payments:
                           order_id  payment_sequential payment_type  payment_installments  payment_value
0  b81ef226f3fe1789b1e8b2acac839d17                   1  credit_card                     8          99.33
1  a9810da82917af2d9aefd1278f1dcfa0                   1  credit_card                     1          24.39
2  25e8ea4e93396b6fa0d3dd708e76c1bd                   1  credit_card                     1          65.71
3  ba78997921bbcdc1373bb41e913ab953                   1  credit_card                     8         107.78
4  42fdf880ba16b47b59251dd489d4441a                   1  credit_card                     2         128.45

Primeiras 5 linhas da tabela order_reviews:
                          review_id                          order_id  ...  review_creation_date review_answer_timestamp
0  7bc2406110b926393aa56f80a40eba40  73fc7af87114b39712e6da79b0a377eb  ...   2018-01-18 00:00:00     2018-01-18 21:46:59
1  80e641a11e56f04c1ad469d5645fdfde  a548910a1c6147796b98fdf73dbeba33  ...   2018-03-10 00:00:00     2018-03-11 03:05:13
2  228ce5500dc1d8e020d8d1322874b6f0  f9e4b658b201a9f2ecdecbb34bed034b  ...   2018-02-17 00:00:00     2018-02-18 14:36:24
3  e64fb393e7b32834bb789ff8bb30750e  658677c97b385a9be170737859d3511b  ...   2017-04-21 00:00:00     2017-04-21 22:02:06
4  f7c4243c7fe1938f181bec41a392bdeb  8e6bfb81e283fa7e4f11123a3fb894f1  ...   2018-03-01 00:00:00     2018-03-02 10:26:53

[5 rows x 7 columns]

Primeiras 5 linhas da tabela orders:
                           order_id                       customer_id  ... order_delivered_customer_date order_estimated_delivery_date
0  e481f51cbdc54678b7cc49136f2d6af7  9ef432eb6251297304e76186b10a928d  ...           2017-10-10 21:25:13           2017-10-18 00:00:00  
1  53cdb2fc8bc7dce0b6741e2150273451  b0830fb4747a6c6d20dea0b8c802d7ef  ...           2018-08-07 15:27:45           2018-08-13 00:00:00  
2  47770eb9100c2d0c44946d9cf07ec65d  41ce2a54c0b03bf3443c3d931a367089  ...           2018-08-17 18:06:29           2018-09-04 00:00:00  
3  949d5b44dbf5de918fe9c16f97b45f8a  f88197465ea7920adcdbec7375364d82  ...           2017-12-02 00:28:42           2017-12-15 00:00:00  
4  ad21c59c0840e6cb83a9ceb5573f8159  8ab97904e6daea8866dbdbc4fb7aad2c  ...           2018-02-16 18:17:02           2018-02-26 00:00:00  

[5 rows x 8 columns]

Primeiras 5 linhas da tabela products:
                         product_id  product_category_name  product_name_lenght  ...  product_length_cm  product_height_cm  product_width_cm0  1e9e8ef04dbcff4541ed26657ea517e5             perfumaria                 40.0  ...               16.0               10.0              14.01  3aa071139cb16b67ca9e5dea641aaa2f                  artes                 44.0  ...               30.0               18.0              20.02  96bd76ec8810374ed1b65e291975717f          esporte_lazer                 46.0  ...               18.0                9.0              15.03  cef67bcfe19066a932b7673e239eb23d                  bebes                 27.0  ...               26.0                4.0              26.04  9dc1a7de274444849c219cff195d0b71  utilidades_domesticas                 37.0  ...               20.0               17.0              13.0
[5 rows x 9 columns] 

Primeiras 5 linhas da tabela sellers:
                          seller_id  seller_zip_code_prefix        seller_city seller_state
0  3442f8959a84dea7ee197c632cb2df15                   13023           campinas           SP
1  d1b65fc7debc3361ea86b5f14c68d2e2                   13844         mogi guacu           SP
2  ce3ad9de960102d0677a81f5d0bb7b2d                   20031     rio de janeiro           RJ
3  c0f3eea2e14555b6faeea3dd58c1b1c3                    4195          sao paulo           SP
4  51a04a8a6bdcb23deccc82b0b80742cf                   12914  braganca paulista           SP 

Primeiras 5 linhas da tabela product_category_translation:
    product_category_name product_category_name_english
0            beleza_saude                 health_beauty
1  informatica_acessorios         computers_accessories
2              automotivo                          auto
3         cama_mesa_banho                bed_bath_table
4        moveis_decoracao               furniture_decor

Tipos de dados da tabela customers:
                column_name data_type
0  customer_zip_code_prefix    bigint
1               customer_id      text
2        customer_unique_id      text
3             customer_city      text
4            customer_state      text

Tipos de dados da tabela geolocation:
                   column_name         data_type
0  geolocation_zip_code_prefix            bigint
1              geolocation_lat  double precision
2              geolocation_lng  double precision
3             geolocation_city              text
4            geolocation_state              text

Tipos de dados da tabela order_items:
           column_name         data_type
0        order_item_id            bigint
1                price  double precision
2        freight_value  double precision
3  shipping_limit_date              text
4            seller_id              text
5           product_id              text
6             order_id              text

Tipos de dados da tabela order_payments:
            column_name         data_type
0    payment_sequential            bigint
1  payment_installments            bigint
2         payment_value  double precision
3              order_id              text
4          payment_type              text

Tipos de dados da tabela order_reviews:
               column_name data_type
0             review_score    bigint
1                 order_id      text
2                review_id      text
3   review_comment_message      text
4     review_creation_date      text
5  review_answer_timestamp      text
6     review_comment_title      text

Tipos de dados da tabela orders:
                     column_name data_type
0                       order_id      text
1                    customer_id      text
2                   order_status      text
3       order_purchase_timestamp      text
4              order_approved_at      text
5   order_delivered_carrier_date      text
6  order_delivered_customer_date      text
7  order_estimated_delivery_date      text

Tipos de dados da tabela products:
                  column_name         data_type
0            product_width_cm  double precision
1           product_length_cm  double precision
2           product_height_cm  double precision
3         product_name_lenght  double precision
4  product_description_lenght  double precision
5          product_photos_qty  double precision
6            product_weight_g  double precision
7       product_category_name              text
8                  product_id              text

Tipos de dados da tabela sellers:
              column_name data_type
0  seller_zip_code_prefix    bigint
1               seller_id      text
2             seller_city      text
3            seller_state      text

Tipos de dados da tabela product_category_translation:
                     column_name data_type
0          product_category_name      text
1  product_category_name_english      text 

Valores nulos na tabela customers:
customer_id                 0
customer_unique_id          0
customer_zip_code_prefix    0
customer_city               0
customer_state              0
dtype: int64

Valores nulos na tabela geolocation:
geolocation_zip_code_prefix    0
geolocation_lat                0
geolocation_lng                0
geolocation_city               0
geolocation_state              0
dtype: int64 

Valores nulos na tabela order_items:
order_id               0
order_item_id          0
product_id             0
seller_id              0
shipping_limit_date    0
price                  0
freight_value          0
dtype: int64

Valores nulos na tabela order_payments:
order_id                0
payment_sequential      0
payment_type            0
payment_installments    0
payment_value           0
dtype: int64 

Valores nulos na tabela order_reviews:
review_id                  0
order_id                   0
review_score               0
review_comment_title       9
review_comment_message     7
review_creation_date       0
review_answer_timestamp    0
dtype: int64

Valores nulos na tabela orders:
order_id                         0
customer_id                      0
order_status                     0
order_purchase_timestamp         0
order_approved_at                0
order_delivered_carrier_date     1
order_delivered_customer_date    1
order_estimated_delivery_date    0
dtype: int64

Valores nulos na tabela products:
product_id                    0
product_category_name         0
product_name_lenght           0
product_description_lenght    0
product_photos_qty            0
product_weight_g              0
product_length_cm             0
product_height_cm             0
product_width_cm              0
dtype: int64

Valores nulos na tabela sellers:
seller_id                 0
seller_zip_code_prefix    0
seller_city               0
seller_state              0
dtype: int64

Valores nulos na tabela product_category_translation:
product_category_name            0
product_category_name_english    0
dtype: int64

Duplicatas na tabela customers:
0

Duplicatas na tabela geolocation:
0

Duplicatas na tabela order_items:
0

Duplicatas na tabela order_payments:
0

Duplicatas na tabela order_reviews:
0

Duplicatas na tabela orders:
0

Duplicatas na tabela products:
0

Duplicatas na tabela sellers:
0

Duplicatas na tabela product_category_translation:
0

                           order_id order_purchase_timestamp order_delivered_customer_date  order_duration_days
0  e481f51cbdc54678b7cc49136f2d6af7      2017-10-02 10:56:33           2017-10-10 21:25:13                  8.0
1  53cdb2fc8bc7dce0b6741e2150273451      2018-07-24 20:41:37           2018-08-07 15:27:45                 13.0
2  47770eb9100c2d0c44946d9cf07ec65d      2018-08-08 08:38:49           2018-08-17 18:06:29                  9.0
3  949d5b44dbf5de918fe9c16f97b45f8a      2017-11-18 19:28:06           2017-12-02 00:28:42                 13.0
4  ad21c59c0840e6cb83a9ceb5573f8159      2018-02-13 21:18:39           2018-02-16 18:17:02                  2.0
Total gasto por cliente:
                        customer_id  total_spent
0  00012a2ce6f8dcda20d059ce98491703        89.80
1  000161a058600d5901f007fab4c27140        54.90
2  0001fd6190edaaf884bcaf3d49edf079       179.99
3  0002414f95344307404f0ace7a26f1d5       149.90
4  000379cdec625522490c315e70c7a9fb        93.00
PS C:\Users\Anthony\New folder\projetoDATA_PREP_-_TRANSFORMATION> 
```

## Star Schema e Wide Table

### Star Schema

#### Criação da tabela fatos

```sql
CREATE TABLE IF NOT EXISTS fact_orders (
    order_id VARCHAR(32) PRIMARY KEY,
    customer_id VARCHAR(32),
    product_id VARCHAR(32),
    order_timestamp TIMESTAMP,
    seller_id VARCHAR(32),
    price NUMERIC,
    freight_value NUMERIC,
    order_status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_products(product_id),
    FOREIGN KEY (seller_id) REFERENCES dim_sellers(seller_id)
);

```

#### **Criação das Tabelas de Dimensão** :

##### **Dimensão de Clientes** :

```sql
CREATE TABLE IF NOT EXISTS dim_customers (
    customer_id VARCHAR(32) PRIMARY KEY,
    customer_name VARCHAR(255),
    customer_email VARCHAR(255),
    customer_state VARCHAR(50),
    customer_city VARCHAR(255)
);

```

##### **Dimensão de Produtos** :

```sql
CREATE TABLE IF NOT EXISTS dim_products (
    product_id VARCHAR(32) PRIMARY KEY,
    product_name VARCHAR(255),
    product_category_name VARCHAR(255)
);

```

##### **Dimensão de Tempo** :

```sql
CREATE TABLE IF NOT EXISTS dim_time (
    date_id SERIAL PRIMARY KEY,
    day INT,
    month INT,
    year INT,
    quarter INT
);

```

##### **Dimensão de Vendedores** :

```sql
CREATE TABLE IF NOT EXISTS dim_sellers (
    seller_id VARCHAR(32) PRIMARY KEY,
    seller_name VARCHAR(255),
    seller_state VARCHAR(50)
);

```

##### **Dimensão de Geolocalização** :

```sql
CREATE TABLE IF NOT EXISTS dim_geolocation (
    geolocation_id SERIAL PRIMARY KEY,
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_state VARCHAR(50),
    geolocation_city VARCHAR(255)
);

```

### Wide Table

#### **SQL para Criar a Wide Table** :

```sql
CREATE TABLE IF NOT EXISTS wide_table AS
SELECT 
    o.order_id,
    c.customer_id,
    c.customer_city,  -- Usando 'customer_city' já que 'customer_name' não existe
    c.customer_state,  -- Usando 'customer_state'
    p.product_id,
    oi.price,
    oi.freight_value,
    s.seller_id,
    g.geolocation_lat,
    g.geolocation_lng,
    op.payment_value,  -- Correção para 'payment_value' da tabela 'order_payments'
    o.order_status,
    r.review_score,
    r.review_comment_message,
    o.order_purchase_timestamp
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id  -- Junção com a tabela de produtos
JOIN sellers s ON oi.seller_id = s.seller_id
JOIN geolocation g ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
JOIN order_payments op ON o.order_id = op.order_id
JOIN order_reviews r ON o.order_id = r.order_id;

```



## O
