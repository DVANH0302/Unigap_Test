Create table employees(
	id integer,
	name text, 
	department text,
	salary integer,
	join_date date
);


-- Exercise 5

Create table Orders (
	Order_ID int not null Primary key, 
	Date_Order date,
	Good_Type text,
	Good_Amount Float,
	Client_ID INT
);

Create table Order_Delivery(
	Order_ID INT,
	Date_Delivery date,
	Delivery_Employee_Code int,
	Foreign key (Order_ID) References Orders(Order_ID)
);

-- Inserting values into Orders table
INSERT INTO Orders (Order_ID, Date_Order, Good_Type, Good_Amount, Client_ID)
VALUES
    (1, '2024-07-08', 'Electronics', 1200.50, 101),
    (2, '2024-07-09', 'Clothing', 350.75, 102),
    (3, '2024-07-10', 'Books', 45.00, 103);

-- Inserting values into Order_Delivery table
INSERT INTO Order_Delivery (Order_ID, Date_Delivery, Delivery_Employee_Code)
VALUES
    (1, '2024-07-09', 1001),
    (2, '2024-07-10', 1002),
    (3, '2024-07-11', 1003);
--1 Count number of unique client order and number of orders by order month.
select count(distinct Client_ID) from Orders;
select count(*) from orders group by MONTH(Date_Order);

-- 2 Get list of client who have more than 10 orders in this year.
Select Client_ID, count(Order_ID) as number_of_orders from Orders
Where YEAR(Date_Order) = 2024
Group by Client_ID
having count(Order_ID) > 0; -- pretend to be > 10 

-- 3 From the above list of client: get information of first and second last order of client (Order date, good type, and amount)
with cte as (
Select Client_ID, count(Order_ID) as number_of_orders from Orders
Where YEAR(Date_Order) = 2024
Group by Client_ID
having count(Order_ID) > 0 -- pretend to be > 10 
),
 cte_2 as ( 
select b.Client_ID, b.Date_Order, b.Good_Type, b.Good_Amount, 
	   ROW_NUMBER() Over (Partition by b.CLient_ID Order by b.Date_Order Desc ) as ranking  
from cte a join Orders b on a.Client_ID = b.CLient_ID)

select * from cte_2 where ranking <3
;

--4. Calculate total good amount and Count number of Order which were delivered in Sep.2019
select sum(Good_Amount) as total_good_amount,  count(Order_ID) as total_orders from Orders
where Year(Date_Order) = 2024 and Month(Date_Order) = 7 ; -- Pretend to be in Sep 2019

--5. Assuming your 2 tables contain a huge amount of data and each join will take about 30 hours,
-- while you need to do daily report, what is your solution?

-- Solution: Create index on the columns used in join 

