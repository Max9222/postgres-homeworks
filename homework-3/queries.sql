-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT customers.company_name as customer, Concat(employees.first_name, ' ', employees.last_name) as employee
FROM orders
INNER JOIN customers USING(customer_id)
INNER JOIN employees USING(employee_id)
INNER JOIN shippers on orders.ship_via = shippers.shipper_id
WHERE customers.city = 'London' and employees.city = 'London'
and shippers.company_name = 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinuedSELECT) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT products.product_name, products.units_in_stock, suppliers.contact_name, suppliers.phone
FROM products
INNER JOIN suppliers USING(supplier_id)
INNER JOIN categories USING(category_id)

WHERE products.discontinued NOT IN (1)
AND products.units_in_stock < 25
AND categories.category_name='Condiments'
AND categories.category_name='Dairy Products'   # При выполнении этого условия выдает пустую таблицу
ORDER BY products.units_in_stock;   # А так все работает корректно

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT customers.company_name
FROM customers
FULL OUTER JOIN orders ON customers.customer_id = orders.customer_id   # ИЛИ FULL OUTER JOIN orders USING(customer_id)
WHERE customers.customer_id IS NULL
OR orders.customer_id IS NULL
ORDER BY customers.company_name   # теперь как на скриншоте

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT products.product_name
FROM order_details
JOIN products USING(product_id)
WHERE order_details.quantity=(SELECT COUNT(*)+1 FROM employees)