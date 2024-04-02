create database jspdb;
use jspdb;
create table employee (
	id	int not null AUTO_INCREMENT,
    first_name	varchar(20),
    last_name 	varchar(20),
    username	varchar(250),
    pswd		varchar(20),
    address		varchar(45),
    contact		varchar(45),
    primary key (id)
);

select * from employee;