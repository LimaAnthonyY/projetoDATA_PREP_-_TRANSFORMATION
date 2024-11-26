import pandas as pd
from sqlalchemy import create_engine, text
import os
import logging
from dotenv import load_dotenv
import datetime

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

load_dotenv()

olist_engine = create_engine('postgresql://user:password@localhost:5432/olist_db')
received_engine = create_engine('postgresql://user:password@localhost:5433/received_db')

files_and_tables = {
    'olist_customers_dataset.csv': 'customers',
    'olist_geolocation_dataset.csv': 'geolocation',
    'olist_order_items_dataset.csv': 'order_items',
    'olist_order_payments_dataset.csv': 'order_payments',
    'olist_order_reviews_dataset.csv': 'order_reviews',
    'olist_orders_dataset.csv': 'orders',
    'olist_products_dataset.csv': 'products',
    'olist_sellers_dataset.csv': 'sellers',
    'product_category_name_translation.csv': 'product_category_translation'
}

def obter_data_hora_atual():
    return datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

def load_csv_to_olist():
    base_path = os.path.join(os.getcwd(), "Dados")
    
    for file_name, table_name in files_and_tables.items():
        file_path = os.path.join(base_path, file_name)
        
        if os.path.exists(file_path):
            try:
                df = pd.read_csv(file_path)
                
                if df.empty:
                    continue

                df['data_insercao'] = obter_data_hora_atual()
                df.to_sql(table_name, olist_engine, if_exists='append', index=False, method='multi', chunksize=1000)
            except Exception as e:
                logging.error(f"Erro ao carregar {file_name}: {e}")
        else:
            logging.error(f"O arquivo {file_name} não foi encontrado em {file_path}.")

def execute_starschema():
    script_path = os.path.join(os.getcwd(), "starschema.sql")
    
    try:
        with open(script_path, 'r', encoding='utf-8') as file:
            starschema_sql = file.read()
        
        with received_engine.begin() as connection:
            connection.execute(text(starschema_sql))
    except FileNotFoundError:
        logging.error(f"O arquivo {script_path} não foi encontrado.")
    except Exception as e:
        logging.error(f"Erro ao executar o script starschema.sql: {e}")

def execute_wideschema():
    script_path = os.path.join(os.getcwd(), "wideschema.sql")
    
    try:
        with open(script_path, 'r', encoding='utf-8') as file:
            wideschema_sql = file.read()
        
        with received_engine.begin() as connection:
            connection.execute(text(wideschema_sql))
    except FileNotFoundError:
        logging.error(f"O arquivo {script_path} não foi encontrado.")
    except Exception as e:
        logging.error(f"Erro ao executar o script wideschema.sql: {e}")

def transfer_data_to_received():
    try:
        with olist_engine.connect() as olist_conn, received_engine.begin() as received_conn:
            tables_to_transfer = ['orders', 'customers', 'products', 'sellers', 'geolocation']

            for table in tables_to_transfer:
                df = pd.read_sql(f"SELECT * FROM {table}", olist_conn)
                df.to_sql(f'dim_{table}', received_conn, if_exists='append', index=False, method='multi', chunksize=1000)

            logging.info("Transferência de dados concluída com sucesso!")
    except Exception as e:
        logging.error(f"Erro ao transferir dados para o banco received_db: {e}")

def etl_pipeline():
    try:
        load_csv_to_olist()
        execute_starschema()
        execute_wideschema()
        transfer_data_to_received()
        logging.info("Execução do pipeline ETL concluída com sucesso! Star Schema e Wide Schema foram executados com sucesso.")
    except Exception as e:
        logging.error(f"Erro durante a execução do pipeline ETL: {e}")
    finally:
        olist_engine.dispose()
        received_engine.dispose()

if __name__ == "__main__":
    etl_pipeline()
