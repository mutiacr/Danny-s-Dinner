USE dannys_diner;

/*Answering 1st Questions:What is the total amount each customer spent at the restaurant?*/
SELECT Customer_id, sum(price) AS Total_Amount
FROM sales
left join menu
on sales.product_id =menu.product_id
group by customer_id
order by customer_id ASC;
/*Closed*/

/*Answering 2nd Questions:How many days has each customer visited the restaurant?*/
SELECT customer_id, COUNT(distinct order_date) AS Visited_Days
FROM sales
group by Customer_id;
/*Closed*/

/*Answering 3rd Questions:What was the first item from the menu purchased by each customer?*/
select distinct sales.customer_id, First_Order,product_name /*Use Distinct to remove
redundant value, for columns in the join case if the columns are the same
Between tables we have to define the domain initially based on one of the tables*/
from
	(SELECT Customer_id,min(order_date) as First_Order /*Aggregate Value to define First Order Date*/
	FROM sales
	group by Customer_id) As First /*Give Alias to The Subquery*/
join sales on sales.customer_id=First.customer_id /*to retrieve the product ID of the first order for each customer.*/
			and sales.order_date=First.First_Order
join menu on sales.product_id=menu.product_id; /*to get the corresponding product name*/
/*Closed*/

/*Answering 4th Questions:What is the most purchased item on the menu and how many times was it purchased by all customers?*/
SELECT product_name, count(sales.product_id) AS Order_Times
from sales
left join menu
on sales.product_id=menu.product_id
group by product_name
order by ORDER_TIMES DESC
LIMIT 1;
/*Closed*/

/*Answering 5th Questions:Which item was the most popular for each customer?*/
SELECT customer_id,product_name, count(sales.product_id) AS Order_Times
from sales
left join menu
on sales.product_id=menu.product_id
group by customer_id,product_name
order by ORDER_TIMES DESC;
/*Closed*/

/*Answering 6th Questions:Which item was purchased first by the customer after they became a member?*/
SELECT 
    s.customer_id,
    m.product_name,
    s.order_date,
    mb.join_date
FROM 
    sales AS s
JOIN 
    menu AS m ON s.product_id = m.product_id
JOIN 
    members AS mb ON s.customer_id = mb.customer_id
WHERE 
    s.order_date = (
        SELECT MIN(s1.order_date)
        FROM sales AS s1
        WHERE 
            s1.customer_id = s.customer_id
            AND s1.order_date >= mb.join_date
    )
    order by customer_id;
/*Closed*/

/*Answering 7th Questions:Which item was purchased just before the customer became a member?*/
SELECT 
    s.customer_id,
    m.product_name,
    s.order_date,
    mb.join_date
FROM 
    sales AS s
JOIN 
    menu AS m ON s.product_id = m.product_id
JOIN 
    members AS mb ON s.customer_id = mb.customer_id
WHERE 
    s.order_date = (
        SELECT MIN(s1.order_date)
        FROM sales AS s1
        WHERE 
            s1.customer_id = s.customer_id
            AND s1.order_date < mb.join_date
    )
    order by customer_id;
/*Closed*/


/*Answering 8th Questions:What is the total items and amount spent for each member before they became a member?*/
WITH cte AS (
    SELECT 
        s.customer_id,
        m.product_name,
        s.product_id,
        m.price,
        s.order_date,
        mb.join_date
    FROM 
        sales AS s
    JOIN 
        menu AS m ON s.product_id = m.product_id
    JOIN 
        members AS mb ON s.customer_id = mb.customer_id
    WHERE 
        s.order_date < mb.join_date
)
SELECT 
    customer_id, 
    COUNT(product_id) AS Total_Items, 
    SUM(price) AS Total_Amount
FROM 
    cte
GROUP BY 
    customer_id 
order by customer_id ASC;
/*Closed*/


/*Answering 9th Questions:If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?*/
select s.customer_id,
	sum(case when m.product_name="sushi" then 20*m.price
	else 10*m.price end) AS Total_Points
from sales as s
left join menu as m on s.product_id=m.product_id
group by s.customer_id;

/*Closed*/

/*Answering 10th Questions:In the first week after a customer joins the program (including their join date) 
they earn 2x points on all items, not just sushi - 
how many points do customer A and B have at the end of January?*/
SELECT customer_id, SUM(points) AS Total_Points 
from
(select s.customer_id,
        m.product_name,
        m.price,
        mb.join_date,
        s.order_date,
	CASE 
		WHEN s.order_date BETWEEN mb.join_date AND mb.join_date + 7 THEN price * 20
		ELSE price*10	
	end as points
from sales as s
JOIN 
	menu AS m ON s.product_id = m.product_id
JOIN 
	members AS mb ON s.customer_id = mb.customer_id
WHERE s.order_date BETWEEN '2021-01-01' AND '2021-01-31'
ORDER BY customer_id, order_date) as Program
group by customer_id
order by customer_id;

/*Answering Bonus Questions: Adding Membership Column */

SELECT* from
(SELECT s.customer_id,
	   order_date, 
	   product_name,
	   price,
	   CASE
	   WHEN order_date >= join_date THEN 'Y'
           ELSE 'N'
	   END AS member
FROM sales s
JOIN menu as m ON s.product_id = m.product_id
LEFT JOIN members as mb ON s.customer_id = mb.customer_id) AS members_details;


