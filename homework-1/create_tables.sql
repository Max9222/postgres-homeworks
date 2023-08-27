CREATE TABLE employees
(
	employee_id int PRIMARY KEY,
	first_name varchar(100) NOT NULL,
	last_name varchar(100) NOT NULL,
	title varchar(100) NOT NULL,
	birth_date date,
	notes text
);



CREATE TABLE customers
(
	customer_id char(5),
	company_name varchar(100) NOT NULL,
	contact_name text
);


CREATE TABLE orders
(
	order_id int PRIMARY KEY,
	customer_id char(5),
	employee_id int, --REFERENCES employees(employee_id) NOT NULL
	order_date date,
	ship_city varchar(50)
);

INSERT INTO employees VALUES (1, 'Nancy', 'Davolio', 'Sales Representative', '1948-12-08', 'Education includes a BA in psychology from Colorado State University in 1970.  She also completed The Art of the Cold Call.  Nancy is a member of Toastmasters International.');
INSERT INTO customers VALUES ('ALFKI', 'Alfreds Futterkiste', 'Maria Anders');
INSERT INTO orders VALUES (10248, 'VINET', 5, '1996-07-04', 'Reims');

SELECT * FROM employees
SELECT * FROM customers
SELECT * FROM orders