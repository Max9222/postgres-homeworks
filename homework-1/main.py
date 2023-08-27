import psycopg2
import csv

all_data = {"customers": "customers_data.csv", "employees": "employees_data.csv", "orders": "orders_data.csv"}

enter = input('Привет, при нажатии "Enter" три таблицы данными из north_data заполнятся')

for table, name_file in all_data.items():
    print(table)
    print(name_file)

    """Скрипт для заполнения данными таблиц в БД Postgres."""
    # connect to bd
    conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='123')
    try:
        with conn:
            with conn.cursor() as cur:
                # Добавляем
                with open(f"north_data/{name_file}", 'r') as csv_file:
                    items = csv.reader(csv_file)
                    for i in items:
                        if len(i) == 3:
                            cur.execute(f"INSERT INTO {table} VALUES (%s, %s, %s)", (i[0], i[1], i[2]))
                        elif len(i) == 5:
                            cur.execute(f"INSERT INTO {table} VALUES (%s, %s, %s, %s, %s)", (i[0], i[1], i[2], i[3], i[4]))
                        else:
                            cur.execute(f"INSERT INTO {table} VALUES (%s, %s, %s, %s, %s, %s)", (i[0], i[1], i[2], i[3], i[4], i[5]))

                # Получаем
                cur.execute(f"SELECT * FROM {table}")
                rows = cur.fetchall()
                print("Все готово")

    finally:
        conn.close()
