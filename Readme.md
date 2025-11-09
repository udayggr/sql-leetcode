SELECT DATE_FORMAT(NOW(), '%Y-%m-%d'); 


SQL Server Syntax: DATEDIFF(datepart, startdate, enddate)
-- Get the number of days between two dates in SQL Server
SELECT DATEDIFF(DAY, '2024-01-01', '2024-11-09') AS DaysDifference;
313 days.


MySQL Syntax: DATEDIFF(enddate, startdate) (returns the difference in days)
-- Get the number of days between two dates in MySQL
SELECT DATEDIFF('2024-11-09', '2024-01-01') AS DaysDifference;


DATEADD() / DATE_SUB() (SQL Server, MySQL) 

-- Get the date 30 days ago in SQL Server
SELECT DATEADD(DAY, -30, GETDATE()) AS Date30DaysAgo;


MySQL Example:
-- Get the date 30 days ago in MySQL
SELECT DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AS Date30DaysAgo;

1. SQL Server:
SELECT DATEADD(day, -10, GETDATE()) AS DateMinus10Days; -- Subtract 10 days from current date
SELECT DATEADD(month, -2, '2025-10-26') AS DateMinus2Months; -- Subtract 2 months from a specific date

2. MySQL:
SELECT DATE_SUB(CURDATE(), INTERVAL 10 DAY) AS DateMinus10Days; -- Subtract 10 days from current date
SELECT DATE_SUB('2025-10-26', INTERVAL 2 MONTH) AS DateMinus2Months; -- Subtract 2 months from a specific date

3. Oracle:
SELECT SYSDATE - 10 AS DateMinus10Days FROM DUAL; -- Subtract 10 days from current date
SELECT ADD_MONTHS(SYSDATE, -2) AS DateMinus2Months FROM DUAL; -- Subtract 2 months from current date

4. PostgreSQL:
SELECT CURRENT_DATE - INTERVAL '10 days' AS DateMinus10Days; -- Subtract 10 days from current date
SELECT '2025-10-26'::date - INTERVAL '2 months' AS DateMinus2Months; -- Subtract 2 months from a specific date