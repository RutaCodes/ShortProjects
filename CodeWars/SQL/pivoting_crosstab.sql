--# PROBLEM

--For this challenge you need to PIVOT data. You have two tables, products and details. Your task is to pivot the rows in products to produce a table of products 
--which have rows of their detail. Group and Order by the name of the Product.

--Tables and relationship below:

--products schema
--id
--name

--details schema
--id
--product_id
--detail

--You must use the CROSSTAB statement to create a table that has the schema as below:

--CROSSTAB table
--name
--good
--ok
--bad


--# SOLUTION

CREATE EXTENSION tablefunc;
SELECT *
FROM CROSSTAB('SELECT p.name, d.detail, COUNT(*)
               FROM products p
               JOIN details d
               ON p.id = d.product_id
               GROUP BY 1,2
               ORDER BY p.name')
     AS final_result(name TEXT, bad BIGINT, good BIGINT, ok BIGINT);
