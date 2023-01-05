/*
# PROBLEM: SQL Data: Company Data - totals per day
https://www.codewars.com/kata/58164d628906323d4300026e/sql

Your task is simple, given the data you must calculate on each day how many hours have been clocked up for each department.

Resultant table:
day (date) [order by]
department_name (name of department) [order by]
total_hours (total hours for the day)

*/

--# SOLUTION

SELECT t.login::date AS day, d.name department_name,
       SUM(DATE_PART('hour',t.logout) - DATE_PART('hour',t.login)) AS total_hours
FROM department d
JOIN timesheet t
ON d.id = t.department_id
GROUP BY t.login::date, d.name
ORDER BY t.login::date, d.name; 
