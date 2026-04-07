BULK INSERT Basketball.load.players
FROM 'C:\Data\dobos\data\basketball\2008-2009.regular_season\proc\playbyplay.txt'
WITH
(
	DATAFILETYPE = 'char',
	ROWTERMINATOR = '0x0A',
	FIELDTERMINATOR  = ',',
	TABLOCK
)

GO

TRUNCATE TABLE Basketball.load.player
GO

BULK INSERT Basketball.load.player
FROM 'C:\Data\dobos\data\basketball\2008-2009.players.csv'
WITH
(
	DATAFILETYPE = 'char',
	--ROWTERMINATOR = '0x0A',
	FIELDTERMINATOR  = ',',
	FIRSTROW = 2,
	TABLOCK
)

GO

BULK INSERT Basketball.load.number
FROM 'C:\Data\dobos\data\basketball\2008-2009.regular_season\proc\numbers.txt'
WITH
(
	DATAFILETYPE = 'char',
	--ROWTERMINATOR = '0x0A',
	FIELDTERMINATOR  = ',',
	TABLOCK
)