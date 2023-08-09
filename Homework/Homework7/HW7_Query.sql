-- Create a Customer Summary showing all plans for each customer, including any cancellations
SELECT  customer_name, plan.plan_type, plan_name
FROM customer
INNER JOIN customer_plan
ON customer.customer_ID = customer_plan.customer_ID
INNER JOIN plan
ON customer_plan.plan_ID = plan.plan_ID;
-- WHERE customer.customer_ID = 1;

-- Create a Customer Call Log 
SELECT customer_name, call_date, call_duration, call_cost, call_type
FROM customer
INNER JOIN call_traffic
ON customer.customer_ID = call_traffic.customer_ID;


-- Create a Plan Revenue report showing revenue for each plan 

SELECT plan_type, SUM(transaction.transaction_amount) AS revenue
FROM plan
INNER JOIN transaction
ON plan.plan_ID = transaction.plan_ID
GROUP BY plan_type
ORDER BY SUM(transaction.transaction_amount)
DESC;
