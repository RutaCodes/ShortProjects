/*
# PROBLEM

Practise some SQL fundamentals by making a simple database on a topic you feel familiar with. Or use mine, populated with a wealth of Sailor Moon trivia.

sailorsenshi schema:
id
senshi_name
real_name_jpn
school_id
cat_id

cats schema:
id
name

schools schema:
id
school

Return a results table - sailor_senshi, real_name, cat and school - of all characters, containing each character's high school, their civilian name and the cat 
who introduced them to their magical crime-fighting destiny.

Keep in mind some senshi were not initiated by a cat guardian and one is not in high school. The field can be left blank if this is the case.

*/

--# SOLUTION

SELECT s.senshi_name AS sailor_senshi, s.real_name_jpn AS real_name,
       c.name AS cat, sh.school 
FROM sailorsenshi s
LEFT JOIN cats c
ON s.cat_id = c.id
LEFT JOIN schools sh
ON s.school_id = sh.id;
