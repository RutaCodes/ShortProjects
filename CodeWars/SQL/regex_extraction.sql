/*
# PROBLEM: SQL easy regex extraction

You'll have a table like the following:

name	          greeting
Austin Gaylord	  Hola que tal #4702665
Kacie Zulauf	  Bienvenido 45454545 tal #470815 BD. WA470815

Output
In this practice you'll need to extract from the greeting column the number preceeded by the # symbol and place it in a new column named user_id.

name	          greeting	                                user_id
Austin Gaylord	  Hola que tal #4702665	                        4702665
Kacie Zulauf	  Bienvenido 45454545 tal #470815 BD. WA470815	470815

NOTE: To keep it simple assume that the iser_id will be having varchar type

*/

--# SOLUTION

SELECT name, greeting, 
       REPLACE(SUBSTRING(greeting, '#[\d]+'), '#', '') AS user_id
       -- Or SUBSTRING(greeting FROM '#([0-9]+)') AS user_id
       -- Or SUBSTRING(greeting FROM '#(\d+)') AS user_id
FROM greetings;