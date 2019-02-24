--������� ���������� ������.
--1.1 1	������� � ������� Orders ������, ������� ���� ���������� ����� 6 ��� 1998 ���� (������� ShippedDate) ������������ � ������� ���������� � ShipVia >= 2. ������ ������ ���������� ������ ������� OrderID, ShippedDate � ShipVia. 
 --select OrderID, ShippedDate, ShipVia from dbo.Orders where OrderDate >= '1998-05-06' and ShipVia >= 2

 --1.1.2.	�������� ������, ������� ������� ������ �������������� ������ �� ������� Orders. � ����������� ������� ���������� ��� ������� ShippedDate ������ �������� NULL ������ �Not Shipped� (������������ ��������� ������� CAS�). ������ ������ ���������� ������ ������� OrderID � ShippedDate.
--select OrderID,
--case 
--when ShippedDate is NULL then 'Not Shipped' end 'ShippedDate'
--from  dbo.Orders where ShippedDate is null

--1.1.3 ������� � ������� Orders ������, ������� ���� ���������� ����� 6 ��� 1998 ���� (ShippedDate) �� ������� ��� ���� ��� ������� ��� �� ����������. � ������� ������ ������������ ������ ������� OrderID (������������� � Order Number) � ShippedDate (������������� � Shipped Date). � ����������� ������� ���������� ��� ������� ShippedDate ������ �������� NULL ������ �Not Shipped�, ��� ��������� �������� ���������� ���� � ������� �� ���������.
--select OrderID as 'Order Number', case 
--when ShippedDate is NULL then 'Not Shipped' 
--else convert(varchar(25), ShippedDate)  end 'Shipped Date'  
--from  dbo.Orders where ShippedDate >'1998-05-05' or ShippedDate is null

 --1.2. ������������� ���������� IN, DISTINCT, ORDER BY, NOT
--1.2.1 ������� �� ������� Customers ���� ����������, ����������� � USA � Canada. ������ ������� � ������ ������� ��������� IN. ���������� ������� � ������ ������������ � ��������� ������ � ����������� �������. ����������� ���������� ������� �� ����� ���������� � �� ����� ����������.
--select ContactName, Country 
--from Customers where Country in ('USA', 'CANADA')
--order by ContactName, Country;

--1.2.2 ������� �� ������� Customers ���� ����������, �� ����������� � USA � Canada. ������ ������� � ������� ��������� IN. ���������� ������� � ������ ������������ � ��������� ������ � ����������� �������. ����������� ���������� ������� �� ����� ����������.
--select ContactName, Country 
--from Customers where Country not in ('USA', 'CANADA')
--order by ContactName

--1.2.3 ������� �� ������� Customers ��� ������, � ������� ��������� ���������. ������ ������ ���� ��������� ������ ���� ��� � ������ ������������ �� ��������. �� ������������ ����������� GROUP BY. ���������� ������ ���� ������� � ����������� �������. 
--select distinct Country 
--from Customers 
--order by Country desc

--1.3. ������������� ��������� BETWEEN, DISTINCT
--1.3.1 ������� ��� ������ (OrderID) �� ������� Order Details (������ �� ������ �����������), ��� ����������� �������� � ����������� �� 3 �� 10 ������������ � ��� ������� Quantity � ������� Order Details. ������������ �������� BETWEEN. ������ ������ ���������� ������ ������� OrderID.
--select distinct OrderID
--from [Order Details] where Quantity between 3 and 10

--1.3.2 ������� ���� ���������� �� ������� Customers, � ������� �������� ������ ���������� �� ����� �� ��������� b � g. ������������ �������� BETWEEN. ���������, ��� � ���������� ������� �������� Germany. ������ ������ ���������� ������ ������� CustomerID � Country � ������������ �� Country.
--select CustomerID, Country
--from Customers where Country between 'b' and 'h'
--order by Country

--1.3.3 ������� ���� ���������� �� ������� Customers, � ������� �������� ������ ���������� �� ����� �� ��������� b � g, �� ��������� �������� BETWEEN. 
--select ContactName
--from Customers where Country like '[b-g]%'

--1.4. ������������� ��������� LIKE
--1.4.1 � ������� Products ����� ��� �������� (������� ProductName), ��� ����������� ��������� 'chocolade'. ��������, ��� � ��������� 'chocolade' ����� ���� �������� ���� ����� 'c' � �������� - ����� ��� ��������, ������� ������������� ����� �������. 
--select ProductName
--from Products where ProductName like 'Cho_olade'

--2.1 ������� 2.1. ������������� ���������� ������� (SUM, COUNT)
--2.1.1 ����� ����� ����� ���� ������� �� ������� Order Details � ������ ���������� ����������� ������� � ������ �� ���. ����������� ������� ������ ���� ���� ������ � ����� �������� � ��������� ������� 'Totals'.
--select sum(
--Case 
--when Discount=0 then Quantity * UnitPrice
--else Quantity * UnitPrice* Discount end
--)  as 'Totals'
--from [Order Details] 

--2.1.2	�� ������� Orders ����� ���������� �������, ������� ��� �� ���� ���������� (�.�. � ������� ShippedDate ��� �������� ���� ��������). ������������ ��� ���� ������� ������ �������� COUNT. �� ������������ ����������� WHERE � GROUP.
--select Count(*) - COUNT(ShippedDate) 
--from Orders 

--2.1.3 3.	�� ������� Orders ����� ���������� ��������� ����������� (CustomerID), ��������� ������. ������������ ������� COUNT � �� ������������ ����������� WHERE � GROUP.
--select  Count(distinct CustomerID)
--from Orders 

--2.2.1 �� ������� Orders ����� ���������� ������� � ������������ �� �����. � ����������� ������� ���� ���������� ��� ������� c ���������� Year � Total. �������� ����������� ������, ������� ��������� ���������� ���� �������.
--select YEAR(RequiredDate) AS 'Year', Count(CustomerID) AS 'Total'
--from Orders
--Group by YEAR(RequiredDate)

--select Count(CustomerID)
--from Orders

--2.2.2 �� ������� Orders ����� ���������� �������, c�������� ������ ���������. ����� ��� ���������� �������� � ��� ����� ������ � ������� Orders, ��� � ������� EmployeeID ������ �������� ��� ������� ��������. � ����������� ������� ���� ���������� ������� � ������ �������� (������ ������������� ��� ���������� ������������� LastName & FirstName. ��� ������ LastName & FirstName ������ ���� �������� ��������� �������� � ������� ��������� �������. ����� �������� ������ ������ ������������ ����������� �� EmployeeID.) � ��������� ������� �Seller� � ������� c ����������� ������� ���������� � ��������� 'Amount'. ���������� ������� ������ ���� ����������� �� �������� ���������� �������. 
--select (Employees.LastName + ', ' + Employees.FirstName) as 'Seller', Count(Orders.EmployeeID) as 'Amount' 
--from Orders 
--join Employees on Orders.EmployeeID=Employees.EmployeeID
--Group by (Employees.LastName + ', ' + Employees.FirstName)
--Order by 'Amount' desc

--2.2.3 �� ������� Orders ����� ���������� �������, ��������� ������ ��������� � ��� ������� ����������. ���������� ���������� ��� ������ ��� �������, ��������� � 1998 ����. 
--select CustomerID, [EmployeeID], COUNT(*) AS 'Total'
--from [Northwind].[dbo].[Orders] 
--group by CustomerID, [EmployeeID], YEAR(OrderDate)
--having Year(OrderDate)=1998
--order by CustomerID

----2.2.4 ����� ����������� � ���������, ������� ����� � ����� ������. ���� � ������ ����� ������ ���� ��� ��������� ���������, ��� ������ ���� ��� ��������� �����������, �� ���������� � ����� ���������� � ��������� �� ������ �������� � �������������� �����. �� ������������ ����������� JOIN. 
--select Customers.CompanyName, Customers.City, (Employees.LastName + ', ' + Employees.FirstName) as 'Employees' 
--from Customers, Employees
--where Customers.City= Employees.City

--2.2.5 ����� ���� �����������, ������� ����� � ����� ������. 
--select CustomerID, City
--from Customers T1
--where exists(select * from Customers as T2 where T1.City = T2.City and T1.CustomerID <> T2.CustomerID)

----2.2.6 �� ������� Employees ����� ��� ������� �������� ��� ������������.
--select LastName as Employee, (select LastName From  Employees E2 where E2.EmployeeID = E1.ReportsTo) as "ReportTo"
--from Employees E1

--2.3.1	���������� ���������, ������� ����������� ������ 'Western' (������� Region). 
--select Employees.LastName, Territories.TerritoryDescription
--from Employees
--join EmployeeTerritories on Employees.EmployeeID = EmployeeTerritories.EmployeeID
--join Territories on Territories.TerritoryID = EmployeeTerritories.TerritoryID
--join Region on Territories.RegionID = Region.RegionID where Region.RegionDescription = 'Western' 

--2.3.2 ������ � ����������� ������� ����� ���� ���������� �� ������� Customers � ��������� ���������� �� ������� �� ������� Orders. ������� �� ��������, ��� � ��������� ���������� ��� �������, �� ��� ����� ������ ���� �������� � ����������� �������. ����������� ���������� ������� �� ����������� ���������� ������
--select Customers.CompanyName, Count(Orders.OrderID ) as "quality"
--from Customers 
--left join Orders on Customers.CustomerID = orders.CustomerID
--left join [Order Details] on Orders.OrderID = [Order Details].OrderID
--group by Customers.CompanyName
--order by "quality" ASC

--2.4.1 1.	������ ���� ����������� (������� CompanyName � ������� Suppliers), � ������� ��� ���� �� ������ �������� �� ������ (UnitsInStock � ������� Products ����� 0). ������������ ��������� SELECT ��� ����� ������� � �������������� ��������� IN. 
--select CompanyName
--from Suppliers
--where SupplierID in (select SupplierID from products where UnitsInStock=0)

--2.4.2 ������ ���� ���������, ������� ����� ����� 150 �������. ������������ ��������� SELECT.
--select Employees.LastName 
--from Employees
--where (select count(*) from orders where Employees.EmployeeID = orders.EmployeeID)  >150

--2.4.3 ������ ���� ���������� (������� Customers), ������� �� ����� �� ������ ������ (��������� �� ������� Orders). ������������ �������� EXISTS.
--select Customers.CompanyName
--from Customers
--where not EXISTS (select Orders.OrderID from Orders where Customers.CustomerID = Orders.CustomerID)
