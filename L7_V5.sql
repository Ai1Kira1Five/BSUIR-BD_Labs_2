USE AdventureWorks2012;
GO

CREATE PROCEDURE dbo.Cards_PROC (@card XML)
AS
BEGIN
	SELECT 
		xmlNode.value('@ID', 'int') AS ID, 
		xmlNode.value('@Type', 'nvarchar(50)') AS [Type],
		xmlNode.value('@Number', 'nvarchar(25)') AS Number
	FROM @card.nodes('/CreditCards/Card') AS xml(xmlNode)
END
GO

DROP PROCEDURE dbo.Cards_PROC;
GO

DECLARE @card XML = (
	SELECT CreditCardID AS "@ID", 
		CardType AS "@Type", 
		CardNumber AS "@Number" 
	FROM Sales.CreditCard
	FOR XML PATH('Card'), ROOT('CreditCards')
)

EXECUTE dbo.Cards_PROC @card;

SELECT @card;
GO


-- with temp table
CREATE TABLE #Cards(
	CreditCardID int,
	CardType nvarchar(50), 
	CardNumber nvarchar(25)
)

INSERT INTO #Cards(CreditCardID, CardType, CardNumber)
SELECT 
	xmlNode.value('@ID', 'int'), 
	xmlNode.value('@Type', 'nvarchar(50)'),
	xmlNode.value('@Number', 'nvarchar(25)') 
FROM @card.nodes('/CreditCards/Card') AS xml(xmlNode)

SELECT TOP(5) * FROM #Cards
GO