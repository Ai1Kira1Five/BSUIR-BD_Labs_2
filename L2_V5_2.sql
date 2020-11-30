IF OBJECT_ID('dbo.Employee', 'U') IS NOT NULL
DROP TABLE dbo.Employee;
GO

--a.
SELECT 
	BusinessEntityID, 
	NationalIDNumber, 
	LoginID,
	JobTitle,
	BirthDate,
	MaritalStatus,
	Gender,
	HireDate,
	VacationHours,
	SickLeaveHours,
	ModifiedDate 
INTO dbo.Employee  
FROM  HumanResources.Employee 
WHERE 1 = 0;
GO

--b.
ALTER TABLE dbo.Employee
ADD CONSTRAINT AK_NationalIDNumber 
UNIQUE(NationalIDNumber);
GO

--c.
ALTER TABLE dbo.Employee
ADD CONSTRAINT CHK_VacationHours 
CHECK(VacationHours>0);
GO

--d.
ALTER TABLE dbo.Employee
ADD CONSTRAINT DF_VacationHours 
DEFAULT 144 FOR VacationHours;
GO

--e.
INSERT INTO dbo.Employee (
	BusinessEntityID, 
	NationalIDNumber, 
	LoginID,
	JobTitle,
	BirthDate,
	MaritalStatus,
	Gender,
	HireDate,
	SickLeaveHours,
	ModifiedDate 
) SELECT 
	BusinessEntityID, 
	NationalIDNumber, 
	LoginID,
	JobTitle,
	BirthDate,
	MaritalStatus,
	Gender,
	HireDate,
	SickLeaveHours,
	ModifiedDate  
FROM HumanResources.Employee
WHERE JobTitle = 'Buyer';
GO

--test
SELECT * FROM dbo.Employee;
GO

--f.
ALTER TABLE dbo.Employee
ALTER COLUMN ModifiedDate DATE;
GO