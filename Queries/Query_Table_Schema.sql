-- pipeline target server/ db
USE [widgets-database]
GO
SELECT * FROM sys.columns c
JOIN sys.tables t
ON t.object_id = c.object_id
WHERE t.name = 'table2';