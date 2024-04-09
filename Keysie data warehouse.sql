/* Designed a data warehouse for my client shop.*/

/*1:the first table is a store table*/
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Store_dim_tbl' AND TABLE_SCHEMA = 'dbo')
DROP TABLE Store_dim_tbl;
go

create table Store_dim_tbl
(
stored_id int primary key identity(1,1) nonclustered not null,
stored_id_altkey int not null,
store_name varchar(90) null,
store_number int not null,
stored_manager_id int,
store_rating int null,
store_location varchar(90)
)


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'manager_dim_tbl' AND TABLE_SCHEMA = 'dbo')
DROP TABLE manager_dim_tbl;
go
create table manager_dim_tbl
(
manager_id int not null priamry key identity(1,1) nonclustered  ,
manager_altkey int not null,
store_manager_First_name nvarchar(90),
store_manager_First_name nvarchar(90),
hired_date datetime,
manger_phone_numner int,
manager_position varchar(90),
managers_supervisor_id int
)


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Supervisor_dim_tbl' AND TABLE_SCHEMA = 'dbo')
DROP TABLE Supervisor_dim_tbl;
go
create table Supervisor_dim_tbl
(
supervsior_id int not null primary key identity(1,1) nonclustered,
supervisor_id_altkey int not null,
supervisor_First_name varchar(90),
supervisor_Last_name varchar(90),
supervisor_phone_number int,
supervisor_Location varchar(90),
)


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'promotion_dim_tbl' AND TABLE_SCHEMA = 'dbo')
DROP TABLE promotion_dim_tbl;
go
create table promotion_dim_tbl
(
promotion_id int not null primary key identity(1,1) nonclustered,
promation_altkey int not null,
promation_type varchar(90),
store_id int
)

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'product_dim_tbl' AND TABLE_SCHEMA = 'dbo')
DROP TABLE product_dim_tbl;
go
create table product_dim_tbl(
product_id int not null primary key identity(1,1) nonclustered,
product_id_altkey int not null,
product_name varchar(90),
product_category varchar(90),
product_manufactured_date datetime,
product_expiration_date datetime,
product_manufactured_county varchar(90),
order_id int,
store_id int
)


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'order_dim_tbl' AND TABLE_SCHEMA = 'dbo')
DROP TABLE order_dim_tbl;
go

create table order_dim_tbl
(
order_id int not null primary key identity key(1,1) nonclustered,
order_id_altkey int not null,
orderno varchar(90),
order_category varchar(90),
order_shipped_date datetime,
order_recieved_by datetime,
Date_id int,
product_id int,
customer_id int,
quantity int,
amount money
)


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Date_dim_tbl' AND TABLE_SCHEMA = 'dbo')
DROP TABLE Date_dim_tbl;
go

CREATE TABLE Date_dim_tbl (
    Date_id INT PRIMARY KEY,
    CalendarDate DATE,
    Year INT,
    Quarter INT,
    Month INT,
    Day INT,
    DayOfWeek INT,
    DayOfYear INT,
    Weekday BIT,
    WeekOfYear INT,
    IsHoliday BIT -- You can add additional attributes like holidays if needed
);

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'customer_dim_tbl' AND TABLE_SCHEMA = 'dbo')
DROP TABLE customer_dim_tbl;
go

create table customer_dim_tbl
(
customer_id int not null primary key identity(1,1) nonclustered,
customer_id_altkey int not null,
customer_first_name varchar(90),
customer_last_name varchar(90),
customer_adress varchar(90),
customer_city varchar(90),
customer_state varchar(90),
customer_gender varchar(30),
customer_order_id varchar(90),
)



create table sales_fact_tbl
(
sales_id int not null priamry key identity(1,1) nonclustered,
sales_id_alt_key int not null,
manager_id int not null references manager_dim_tbl(manager_id),
supervsior_id int not null references Supervisor_dim_tbl(supervsior_id),
promotion_id int not null references promotion_dim_tbl(promotion_id),
product_id int not null references product_dim_tbl(product_id),
order_id int not null references order_dim_tbl(order_id),
Date_id int not null references Date_dim_tbl(Date_id),
customer_id int not null references customer_dim_tbl(customer_id),
orderno varchar(90) null,
quantity int null,
amount money null,
constraint sales_fact_tbl primary key nonclustered (sales_id,manager_id,supervsior_id,promotion_id,product_id,order_id,Date_id_Key,customer_id)
)