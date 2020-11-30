--1.
SELECT Name, GroupName 
FROM AdventureWorks2012.HumanResources.Department
WHERE GroupName = 'Research and Development'
ORDER BY name ASC;
GO

--2.
SELECT MIN(SickLeaveHours) AS 'MinSickLeaveHours' 
FROM AdventureWorks2012.HumanResources.Employee;
GO

--3.
SELECT DISTINCT TOP 10 JobTitle, 
SUBSTRING(JobTitle,1,(CHARINDEX(' ',JobTitle + ' ')-1)) AS 'FirstWord'
FROM AdventureWorks2012.HumanResources.Employee
ORDER BY JobTitle ASC;
GO