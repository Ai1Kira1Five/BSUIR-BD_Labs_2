--a.
ALTER TABLE dbo.Employee
ADD EmpNum int;
GO

--test
SELECT * FROM dbo.Employee;
GO

--b.
DECLARE @MyTableVar TABLE(
	BusinessEntityID int not null,
	NationalIDNumber nvarchar(15) not null,
	LoginID nvarchar(256) not null,
	JobTitle nvarchar(50) not null,
	BirthDate date not null,
	MaritalStatus nchar(1) not null,
	Gender nchar(1) not null,
	HireDate date not null,
	VacationHours smallint not null,
	SickLeaveHours smallint not null,
	ModifiedDate datetime,
	EmpNum int
);

INSERT @MyTableVar SELECT 
	BusinessEntityID,
	NationalIDNumber,
	LoginID,
	JobTitle,
	BirthDate,
	MaritalStatus,
	Gender,
	HireDate,
	(SELECT VacationHours 
	FROM HumanResources.Employee
	WHERE HumanResources.Employee.BusinessEntityID = dbo.Employee.BusinessEntityID),
	SickLeaveHours,
	ModifiedDate,
	ROW_NUMBER() OVER(ORDER BY BusinessEntityID)
FROM dbo.Employee;

--test
SELECT * FROM @MyTableVar;

--c.
UPDATE emp
SET emp.EmpNum = tableVar.EmpNum
FROM dbo.Employee emp
INNER JOIN @MyTableVar tableVar
ON emp.BusinessEntityID = tableVar.BusinessEntityID

UPDATE emp
SET emp.VacationHours = tableVar.VacationHours
FROM dbo.Employee emp
INNER JOIN @MyTableVar tableVar
ON emp.BusinessEntityID = tableVar.BusinessEntityID
WHERE tableVar.VacationHours != 0;

--test
SELECT * FROM dbo.Employee;
GO

--d.
DELETE dbo.Employee
FROM dbo.Employee
INNER JOIN Person.Person 
ON dbo.Employee.BusinessEntityID = Person.BusinessEntityID
WHERE Person.EmailPromotion = 0 ;
GO

--test
SELECT * FROM dbo.Employee;
GO

--e.

--constraints search
SELECT CONSTRAINT_NAME
FROM AdventureWorks2012.INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Employee';
GO

--default vals search
SELECT SD.name
FROM sys.tables ST 
INNER JOIN sys.syscolumns SC 
ON ST.object_id = SC.id
INNER JOIN sys.default_constraints SD 
ON ST.object_id = SD.parent_object_id 
AND SC.colid = SD.parent_column_id
WHERE ST.object_id = object_id('dbo.Employee');
GO

ALTER TABLE dbo.Employee 
DROP COLUMN EmpNum;

ALTER TABLE dbo.Employee 
DROP CONSTRAINT AK_NationalIDNumber;

ALTER TABLE dbo.Employee 
DROP CONSTRAINT CHK_VacationHours;

ALTER TABLE dbo.Employee 
DROP CONSTRAINT DF_VacationHours;
GO

--f.
DROP TABLE dbo.Employee;
GO