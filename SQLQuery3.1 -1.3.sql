IF EXISTS (SELECT * FROM SYS.TABLES SystemTables WHERE SystemTables.[Name] = 'Region')
BEGIN
    EXEC SP_RENAME '[dbo].[Region]', 'Regions';
END

IF NOT EXISTS (SELECT * FROM SYS.COLUMNS SystemColumns 
                            WHERE SystemColumns.[OBJECT_ID] = OBJECT_ID(N'[dbo].[Customers]') AND Name = 'BaseDate')
BEGIN
    ALTER TABLE [dbo].[Customers]
    ADD [BaseDate] DATETIME
END