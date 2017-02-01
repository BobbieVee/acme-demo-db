drop table if exists Users;
drop table if exists Departments;
drop table if exists Roles;

create table Users (id integer primary key autoincrement, name text);

create table Departments (
  id integer primary key autoincrement,
  name text,
  managerId integer references Users(id));

create table Roles (
  id integer primary key autoincrement,
  userId integer references Users(id),
  departmentId integer references Departments(id)
);

insert into Users (name) values ('Moe');
insert into Users (name) values ('Larry');
insert into Users (name) values ('Curly');

insert into Departments (name, managerId) values ('engineering', 2);
insert into Departments (name, managerId) values ('hr', 2);

-- add curly to hr and engineering
insert into Roles (userId, departmentId) values (3, 2);
insert into Roles (userId, departmentId) values (3, 1);
insert into Roles (userId, departmentId) values (1, 1);

select Departments.name as departmentName, Users.name as manager
from Departments
join Users on Users.id = Departments.managerId;

select count(*) as count, Users.name as manager
from Users
join Departments
on Departments.managerId = Users.id
group by Users.name;

--list each employees roles
select Roles.id, Users.name as user, Departments.name as department
from Roles
join Users 
on Users.id = Roles.userId
join Departments
on Departments.id = Roles.departmentId;

select Users.name, count(*) as numberOfDepartments
from Users
join Roles
on Roles.userId = Users.id
group by Users.name;
