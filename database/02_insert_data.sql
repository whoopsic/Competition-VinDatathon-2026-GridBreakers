COPY geography FROM 'data/raw/geography.csv' DELIMITER ',' CSV HEADER NULL '';
COPY products FROM 'data/raw/products.csv' DELIMITER ',' CSV HEADER NULL '';
COPY promotions FROM 'data/raw/promotions.csv' DELIMITER ',' CSV HEADER NULL '';
COPY sales FROM 'data/raw/sales.csv' DELIMITER ',' CSV HEADER NULL '';
COPY web_traffic FROM 'data/raw/web_traffic.csv' DELIMITER ',' CSV HEADER NULL '';
COPY customers FROM 'data/raw/customers.csv' DELIMITER ',' CSV HEADER NULL '';
COPY orders FROM 'data/raw/orders.csv' DELIMITER ',' CSV HEADER NULL '';

COPY order_items(order_id, product_id, quantity, unit_price, discount_amount, promo_id, promo_id_2) 
FROM 'data/raw/order_items.csv' DELIMITER ',' CSV HEADER NULL '';

COPY payments FROM 'data/raw/payments.csv' DELIMITER ',' CSV HEADER NULL '';
COPY shipments FROM 'data/raw/shipments.csv' DELIMITER ',' CSV HEADER NULL '';
COPY returns FROM 'data/raw/returns.csv' DELIMITER ',' CSV HEADER NULL '';
COPY reviews FROM 'data/raw/reviews.csv' DELIMITER ',' CSV HEADER NULL '';
COPY inventory FROM 'data/raw/inventory.csv' DELIMITER ',' CSV HEADER NULL '';