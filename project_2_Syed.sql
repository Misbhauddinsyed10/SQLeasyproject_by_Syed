use salmanproject;
create table Employee (
employee_id int primary key,
employee_name varchar(100),
salary decimal(10,2),
department_id int );
insert into Employee (employee_id,
employee_name, salary,
department_id)
values ( 1, 'Harry', 75000.00, 12),
( 2, 'syed', 80000.00, 10),
(3, 'salman', 95000.00, 11),
(4, 'misbhauddin', 55000.00, 10),
(5, 'brooks', 105000.00, 12),
(6, 'adam', 43000.00, 11),
(7, 'larry', 30000.00, 12),
(8, 'chris', 88000.00, 11),
(9, 'shogun', 98000.00, 10);

use salmanproject;
create table department (
department_id int primary key,
department_name varchar(100),
foreign key (department_id) references Employee (department_id) );
insert into department ( department_id, department_name)
values ( 10, 'infromation technology'),
(11, 'sales'),
(12, 'operations');

use salmanproject;
create table project ( project_id int primary key,
project_name varchar(100),
employee_id int,
foreign key (employee_id) references Employee (employee_id) );
insert into project (project_id, project_name, employee_id)
values (4, 'itproject', 1),
(5, 'salesproject', 2),
(6, 'operationsproject', 3),
(22, 'itproject', 4),
(28, 'salesproject', 5),
(4, 'operationsproject', 6),
(5, 'salesproject', 7),
(4, 'itproject', 1),
(6, 'operationsproject', 2),
(22, 'itproject', 3),
(28, 'salesproject', 6),
(5, 'salesproject', 8),
(6, 'itproject', 9),
(5, 'salesproject', 9);

--Select all employees along with their department names, including those who don't have a department.
select employee_id, employee_name, department_name
from employee
right outer join department
on   employee.department_id = department.department_id;
--Find employees who earn more than their colleagues.
SELECT e1.employee_id, e1.employee_name, e1.salary
FROM employee e1
JOIN employee e2 ON e1.department_id = e2.department_id
WHERE e1.salary > e2.salary;
--Select employees who don't work in the Sales and IT departments
select employee_id, employee_name
from employee
join department
where department_name not in ('sales','informationtechnology');
--Find departments with an average salary greater than $60,000
select department_name, department_id
from department
having ( select avg(salary) > 60000.00 from employee where employee.department_id = department.department_id);
--Select employees, their departments, and the projects they are working on
SELECT e.employee_id, e.employee_name, d.department_name, p.project_name
FROM employee e
JOIN department d ON e.department_id = d.department_id
JOIN project p ON e.employee_id = p.employee_id;
--Write a query to find the total salary of employees working on more than one project, along with their project names and department names.
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.department_name,
    p.project_name,
    SUM(e.salary) AS total_salary
FROM 
    employees e
JOIN 
    employee_projects ep ON e.employee_id = ep.employee_id
JOIN 
    projects p ON ep.project_id = p.project_id
JOIN 
    departments d ON e.department_id = d.department_id
GROUP BY 
    e.employee_id, e.name, d.department_name, p.project_name
HAVING 
    COUNT(ep.project_id) > 1;
--Write a query to find all employees who are not assigned to any project.
SELECT e.employee_id, e.employee_name
FROM employee e
LEFT JOIN project p ON e.employee_id = p.employee_id
WHERE p.project_id IS NULL
LIMIT 0, 1000;
--Write a query to find employees who earn more than the average salary of their respective department.
SELECT e.employee_id, e.employee_name, e.salary, d.department_name
FROM employee e
INNER JOIN department d ON e.department_id = d.department_id
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employee e2
    WHERE e2.department_id = e.department_id
);


















