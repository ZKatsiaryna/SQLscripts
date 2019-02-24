--Простая фильтрация данных.
--1.1 1	Выбрать в таблице Orders заказы, которые были доставлены после 6 мая 1998 года (колонка ShippedDate) включительно и которые доставлены с ShipVia >= 2. Запрос должен возвращать только колонки OrderID, ShippedDate и ShipVia. 
 --select OrderID, ShippedDate, ShipVia from dbo.Orders where OrderDate >= '1998-05-06' and ShipVia >= 2

 --1.1.2.	Написать запрос, который выводит только недоставленные заказы из таблицы Orders. В результатах запроса возвращать для колонки ShippedDate вместо значений NULL строку ‘Not Shipped’ (использовать системную функцию CASЕ). Запрос должен возвращать только колонки OrderID и ShippedDate.
--select OrderID,
--case 
--when ShippedDate is NULL then 'Not Shipped' end 'ShippedDate'
--from  dbo.Orders where ShippedDate is null

--1.1.3 Выбрать в таблице Orders заказы, которые были доставлены после 6 мая 1998 года (ShippedDate) не включая эту дату или которые еще не доставлены. В запросе должны возвращаться только колонки OrderID (переименовать в Order Number) и ShippedDate (переименовать в Shipped Date). В результатах запроса возвращать для колонки ShippedDate вместо значений NULL строку ‘Not Shipped’, для остальных значений возвращать дату в формате по умолчанию.
--select OrderID as 'Order Number', case 
--when ShippedDate is NULL then 'Not Shipped' 
--else convert(varchar(25), ShippedDate)  end 'Shipped Date'  
--from  dbo.Orders where ShippedDate >'1998-05-05' or ShippedDate is null

 --1.2. Использование операторов IN, DISTINCT, ORDER BY, NOT
--1.2.1 Выбрать из таблицы Customers всех заказчиков, проживающих в USA и Canada. Запрос сделать с только помощью оператора IN. Возвращать колонки с именем пользователя и названием страны в результатах запроса. Упорядочить результаты запроса по имени заказчиков и по месту проживания.
--select ContactName, Country 
--from Customers where Country in ('USA', 'CANADA')
--order by ContactName, Country;

--1.2.2 Выбрать из таблицы Customers всех заказчиков, не проживающих в USA и Canada. Запрос сделать с помощью оператора IN. Возвращать колонки с именем пользователя и названием страны в результатах запроса. Упорядочить результаты запроса по имени заказчиков.
--select ContactName, Country 
--from Customers where Country not in ('USA', 'CANADA')
--order by ContactName

--1.2.3 Выбрать из таблицы Customers все страны, в которых проживают заказчики. Страна должна быть упомянута только один раз и список отсортирован по убыванию. Не использовать предложение GROUP BY. Возвращать только одну колонку в результатах запроса. 
--select distinct Country 
--from Customers 
--order by Country desc

--1.3. Использование оператора BETWEEN, DISTINCT
--1.3.1 Выбрать все заказы (OrderID) из таблицы Order Details (заказы не должны повторяться), где встречаются продукты с количеством от 3 до 10 включительно – это колонка Quantity в таблице Order Details. Использовать оператор BETWEEN. Запрос должен возвращать только колонку OrderID.
--select distinct OrderID
--from [Order Details] where Quantity between 3 and 10

--1.3.2 Выбрать всех заказчиков из таблицы Customers, у которых название страны начинается на буквы из диапазона b и g. Использовать оператор BETWEEN. Проверить, что в результаты запроса попадает Germany. Запрос должен возвращать только колонки CustomerID и Country и отсортирован по Country.
--select CustomerID, Country
--from Customers where Country between 'b' and 'h'
--order by Country

--1.3.3 Выбрать всех заказчиков из таблицы Customers, у которых название страны начинается на буквы из диапазона b и g, не используя оператор BETWEEN. 
--select ContactName
--from Customers where Country like '[b-g]%'

--1.4. Использование оператора LIKE
--1.4.1 В таблице Products найти все продукты (колонка ProductName), где встречается подстрока 'chocolade'. Известно, что в подстроке 'chocolade' может быть изменена одна буква 'c' в середине - найти все продукты, которые удовлетворяют этому условию. 
--select ProductName
--from Products where ProductName like 'Cho_olade'

--2.1 Задание 2.1. Использование агрегатных функций (SUM, COUNT)
--2.1.1 Найти общую сумму всех заказов из таблицы Order Details с учетом количества закупленных товаров и скидок по ним. Результатом запроса должна быть одна запись с одной колонкой с названием колонки 'Totals'.
--select sum(
--Case 
--when Discount=0 then Quantity * UnitPrice
--else Quantity * UnitPrice* Discount end
--)  as 'Totals'
--from [Order Details] 

--2.1.2	По таблице Orders найти количество заказов, которые еще не были доставлены (т.е. в колонке ShippedDate нет значения даты доставки). Использовать при этом запросе только оператор COUNT. Не использовать предложения WHERE и GROUP.
--select Count(*) - COUNT(ShippedDate) 
--from Orders 

--2.1.3 3.	По таблице Orders найти количество различных покупателей (CustomerID), сделавших заказы. Использовать функцию COUNT и не использовать предложения WHERE и GROUP.
--select  Count(distinct CustomerID)
--from Orders 

--2.2.1 По таблице Orders найти количество заказов с группировкой по годам. В результатах запроса надо возвращать две колонки c названиями Year и Total. Написать проверочный запрос, который вычисляет количество всех заказов.
--select YEAR(RequiredDate) AS 'Year', Count(CustomerID) AS 'Total'
--from Orders
--Group by YEAR(RequiredDate)

--select Count(CustomerID)
--from Orders

--2.2.2 По таблице Orders найти количество заказов, cделанных каждым продавцом. Заказ для указанного продавца – это любая запись в таблице Orders, где в колонке EmployeeID задано значение для данного продавца. В результатах запроса надо возвращать колонку с именем продавца (Должно высвечиваться имя полученное конкатенацией LastName & FirstName. Эта строка LastName & FirstName должна быть получена отдельным запросом в колонке основного запроса. Также основной запрос должен использовать группировку по EmployeeID.) с названием колонки ‘Seller’ и колонку c количеством заказов возвращать с названием 'Amount'. Результаты запроса должны быть упорядочены по убыванию количества заказов. 
--select (Employees.LastName + ', ' + Employees.FirstName) as 'Seller', Count(Orders.EmployeeID) as 'Amount' 
--from Orders 
--join Employees on Orders.EmployeeID=Employees.EmployeeID
--Group by (Employees.LastName + ', ' + Employees.FirstName)
--Order by 'Amount' desc

--2.2.3 По таблице Orders найти количество заказов, сделанных каждым продавцом и для каждого покупателя. Необходимо определить это только для заказов, сделанных в 1998 году. 
--select CustomerID, [EmployeeID], COUNT(*) AS 'Total'
--from [Northwind].[dbo].[Orders] 
--group by CustomerID, [EmployeeID], YEAR(OrderDate)
--having Year(OrderDate)=1998
--order by CustomerID

----2.2.4 Найти покупателей и продавцов, которые живут в одном городе. Если в городе живут только один или несколько продавцов, или только один или несколько покупателей, то информация о таких покупателя и продавцах не должна попадать в результирующий набор. Не использовать конструкцию JOIN. 
--select Customers.CompanyName, Customers.City, (Employees.LastName + ', ' + Employees.FirstName) as 'Employees' 
--from Customers, Employees
--where Customers.City= Employees.City

--2.2.5 Найти всех покупателей, которые живут в одном городе. 
--select CustomerID, City
--from Customers T1
--where exists(select * from Customers as T2 where T1.City = T2.City and T1.CustomerID <> T2.CustomerID)

----2.2.6 По таблице Employees найти для каждого продавца его руководителя.
--select LastName as Employee, (select LastName From  Employees E2 where E2.EmployeeID = E1.ReportsTo) as "ReportTo"
--from Employees E1

--2.3.1	Определить продавцов, которые обслуживают регион 'Western' (таблица Region). 
--select Employees.LastName, Territories.TerritoryDescription
--from Employees
--join EmployeeTerritories on Employees.EmployeeID = EmployeeTerritories.EmployeeID
--join Territories on Territories.TerritoryID = EmployeeTerritories.TerritoryID
--join Region on Territories.RegionID = Region.RegionID where Region.RegionDescription = 'Western' 

--2.3.2 Выдать в результатах запроса имена всех заказчиков из таблицы Customers и суммарное количество их заказов из таблицы Orders. Принять во внимание, что у некоторых заказчиков нет заказов, но они также должны быть выведены в результатах запроса. Упорядочить результаты запроса по возрастанию количества заказо
--select Customers.CompanyName, Count(Orders.OrderID ) as "quality"
--from Customers 
--left join Orders on Customers.CustomerID = orders.CustomerID
--left join [Order Details] on Orders.OrderID = [Order Details].OrderID
--group by Customers.CompanyName
--order by "quality" ASC

--2.4.1 1.	Выдать всех поставщиков (колонка CompanyName в таблице Suppliers), у которых нет хотя бы одного продукта на складе (UnitsInStock в таблице Products равно 0). Использовать вложенный SELECT для этого запроса с использованием оператора IN. 
--select CompanyName
--from Suppliers
--where SupplierID in (select SupplierID from products where UnitsInStock=0)

--2.4.2 Выдать всех продавцов, которые имеют более 150 заказов. Использовать вложенный SELECT.
--select Employees.LastName 
--from Employees
--where (select count(*) from orders where Employees.EmployeeID = orders.EmployeeID)  >150

--2.4.3 Выдать всех заказчиков (таблица Customers), которые не имеют ни одного заказа (подзапрос по таблице Orders). Использовать оператор EXISTS.
--select Customers.CompanyName
--from Customers
--where not EXISTS (select Orders.OrderID from Orders where Customers.CustomerID = Orders.CustomerID)
