IF not exists (SELECT * FROM SYS.TABLES SysTables WHERE SysTables.[Name] = 'CreditCardsData')
begin 
	CREATE TABLE [dbo].[CreditCardData]
	(
		[Id] INT NOT NULL PRIMARY KEY, 
		[CardNumber] INT NOT NULL, 
		[ExpirationDate] DATETIME NOT NULL, 
		[CardHolder] NCHAR(10) NULL, 
		[EmployeeID] INT NULL, 
		CONSTRAINT [FK_CreditCardData_Employees] FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
	)
END
