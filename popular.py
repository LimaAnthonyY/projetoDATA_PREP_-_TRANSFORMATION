import psycopg2

# Definição das URLs de conexão
url_5433 = "postgresql://user:password@localhost:5433/receive_db"
url_5432 = "postgresql://user:password@localhost:5432/olist_db"

# Função para conectar ao banco de dados
def connect_to_db(url):
    try:
        conn = psycopg2.connect(url)
        conn.autocommit = True  # Definindo autocommit para não precisar usar commit manualmente
        return conn
    except Exception as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

# Função para popular a tabela dim_customers
def populate_dim_customers(src_cursor, dest_cursor):
    try:
        # Consulta para pegar dados da tabela 'customers' (do banco olist_db)
        src_cursor.execute("""
            SELECT customer_id, customer_city, customer_state
            FROM customers
        """)
        
        data = src_cursor.fetchall()
        
        if data:
            # Inserir os dados na tabela 'dim_customers' (do banco receive_db)
            for row in data:
                # Preencher com NULL as colunas 'customer_name' e 'customer_email', que não existem no 'olist_db'
                dest_cursor.execute("""
                    INSERT INTO dim_customers (customer_id, customer_name, customer_email, customer_state, customer_city)
                    VALUES (%s, NULL, NULL, %s, %s)  -- Inserindo NULL para 'customer_name' e 'customer_email'
                    ON CONFLICT (customer_id) DO NOTHING;  -- Para evitar duplicatas, se já existir o 'customer_id'
                """, (row[0], row[2], row[1]))  # Mapeando customer_id, customer_state, e customer_city
            print(f"{len(data)} registros inseridos em dim_customers.")
        else:
            print("Nenhum dado encontrado para a tabela 'customers'.")
    except Exception as e:
        print(f"Erro ao popular a tabela dim_customers: {e}")

# Função principal para realizar a conexão e a inserção de dados
def main():
    # Conectar aos bancos de dados
    src_conn = connect_to_db(url_5432)  # Conexão com o banco 'olist_db'
    dest_conn = connect_to_db(url_5433)  # Conexão com o banco 'receive_db'

    if src_conn and dest_conn:
        src_cursor = src_conn.cursor()
        dest_cursor = dest_conn.cursor()

        try:
            # Populando a tabela dim_customers
            print("Populando dim_customers...")
            populate_dim_customers(src_cursor, dest_cursor)

        finally:
            # Fechar os cursores e conexões
            src_cursor.close()
            dest_cursor.close()
            src_conn.close()
            dest_conn.close()
            print("Conexões e cursores fechados.")

if __name__ == "__main__":
    main()
