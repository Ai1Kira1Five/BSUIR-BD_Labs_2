--1.
SELECT DISTINCT 
	HumanResources.EmployeeDepartmentHistory.BusinessEntityID,
	JobTitle, 
	Name,
	StartTime,
	EndTime 
FROM HumanResources.EmployeeDepartmentHistory
INNER JOIN HumanResources.Employee 
ON HumanResources.EmployeeDepartmentHistory.BusinessEntityID =
HumanResources.Employee.BusinessEntityID
INNER JOIN HumanResources.Shift 
ON HumanResources.EmployeeDepartmentHistory.ShiftID =
HumanResources.Shift.ShiftID;
GO

--2.
SELECT 
	GroupName, 
	COUNT(BusinessEntityID) as 'EmpCount'
FROM HumanResources.Department
INNER JOIN HumanResources.EmployeeDepartmentHistory 
ON HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
GROUP BY HumanResources.Department.GroupName;
GO

--Show Employees of 'Quality Assurance' to check EmpCount.
SELECT 
	GroupName, 
	BusinessEntityID
FROM HumanResources.Department
INNER JOIN HumanResources.EmployeeDepartmentHistory 
ON HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
WHERE GroupName = 'Quality Assurance';
GO

--3.
SELECT 
	Name, 
	HumanResources.EmployeeDepartmentHistory.BusinessEntityID, 
	Rate, 
	MAX(Rate) over (PARTITION BY Name) as 'MaxInDepartment',
	DENSE_RANK() over (PARTITION BY Name ORDER BY Rate ASC) as 'RateGroup'	
FROM HumanResources.Department
INNER JOIN HumanResources.EmployeeDepartmentHistory 
ON HumanResources.Department.DepartmentID =
HumanResources.EmployeeDepartmentHistory.DepartmentID
INNER JOIN HumanResources.EmployeePayHistory 
ON HumanResources.EmployeeDepartmentHistory.BusinessEntityID =
HumanResources.EmployeePayHistory.BusinessEntityID
GROUP BY 
	Name, 
	Rate, 
	HumanResources.EmployeeDepartmentHistory.BusinessEntityID
ORDER BY Name;
GO