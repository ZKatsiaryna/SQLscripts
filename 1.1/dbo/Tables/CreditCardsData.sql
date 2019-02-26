CREATE TABLE [dbo].[CreditCardsData]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [CardNumber] INT NOT NULL, 
    [ExpirationDate] DATETIME2 NOT NULL, 
    [CardHolder] NCHAR(10) NULL, 
    [EmployeeID] INT NULL, 
    CONSTRAINT [FK_CreditCardsData_EmployeeID] FOREIGN KEY (EmployeeID) REFERENCES [Employees](EmployeeID)
)
