-- Nível Básico (SELECT, WHERE, ORDER BY)
-- 1- Quais são os nomes dos clientes (CustomerName) e os contatos (ContactName) localizados no país 'Germany'?

select 
	CustomerName,
	ContactName 
from 
	Customers 
WHERE 
	Country = 'Germany'
;

-- 2- Liste o nome do produto (ProductName) e o preço (Price) de todos os produtos que pertencem à categoria 'Beverages' (CategoryID 1). Ordene a lista pelo preço, do mais caro para o mais barato.
select 
	ProductName, 
	Price 
from 
	products 
where 
	CategoryID = 1 
order by 
	Price desc 
;

-- 3- Qual é o sobrenome (LastName), primeiro nome (FirstName) e data de nascimento (BirthDate) do funcionário com o EmployeeID 4? Inclua também as notas (Notes) sobre a formação dele.
select 
	LastName, 
	FirstName, 
	BirthDate, 
	Notes 
from 
	employees 
where 
	EmployeeID = 4;


-- Nível Intermediário (Agregação, GROUP BY, JOINs Simples)
-- 4- Liste todos os países (Country) e o número total de clientes em cada país. Apresente a contagem em ordem decrescente.
select 
	country,
	count(CustomerID) 
as 
	TotalCustomers
from 
	customers
group by 
	Country
order by 
	TotalCustomers desc
;

-- 5- Quais são os nomes dos fornecedores (SupplierName) que fornecem produtos classificados como 'Seafood' (CategoryID 8)?
select 
	SupplierName 
from 
	suppliers as s
inner join 
	products as p 
on 
	s.SupplierID = p.SupplierID
where 
	p.CategoryID = 8
;

-- 6- Qual é o nome do produto (ProductName) e o preço (Price) do produto mais caro e do produto mais barato no banco de dados?
select 
	ProductName, 
	Price  
from 
	products 
where 
	Price = (select max(Price) from products)
or 
	Price = (select min(Price) from products)
order by 
	Price desc
;

-- 7- Calcule o número total de pedidos (OrderID) processados por cada transportadora (ShipperName).
select 
	s.ShipperName,
	count(ord.OrderID) as TotalOrders
from 
	orders as ord
inner join 
	shippers as s on ord.ShipperID = s.ShipperID
group by 
	s.ShipperName
order by 
	TotalOrders desc
;

-- 8- Calcule a quantidade média (Quantity) de produtos vendidos por pedido (OrderID).
select
	o.OrderID,
    avg(od.Quantity) as MediaQuantidadeVendida
from
	orders as o
inner join
	orderdetails od 
on 
	o.OrderID = od.OrderID
group by
	o.OrderID;
    
-- 9- Liste o nome completo do funcionário (FirstName, LastName) e o número total de pedidos que cada um processou.
select
	e.FirstName,
	e.LastName,
    count(o.OrderID) as TotalPedidosProcessados
from
	employees e
inner join
	Orders o
on
	e.EmployeeID = o.EmployeeID
group by
	e.EmployeeID,
    e.FirstName,
    e.LastName
order by
	TotalPedidosProcessados desc;

-- 10- Quantos pedidos foram realizados no mês de julho de 1996? (Dica: Use a coluna OrderDate).
