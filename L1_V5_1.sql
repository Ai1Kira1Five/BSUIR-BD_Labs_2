CREATE DATABASE Artsem_Stsepin;
GO

USE Artsem_Stsepin;
GO

CREATE SCHEMA sales;
GO

CREATE SCHEMA persons;
GO

CREATE TABLE sales.Orders (OrderNum INT NULL);
GO

BACKUP DATABASE Artsem_Stsepin
TO DISK = 'D:\DB\Lab1\Artsem_Stsepin.bak';
GO

USE master
DROP DATABASE Artsem_Stsepin
GO

RESTORE DATABASE Artsem_Stsepin 
FROM DISK = 'D:\DB\Lab1\Artsem_Stsepin.bak';
GO