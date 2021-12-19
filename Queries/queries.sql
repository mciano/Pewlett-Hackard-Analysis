--get employees for retirement
select first_name, last_name
from employees
where birth_date between '1952-01-01' and '1952-12-31';

select first_name, last_name
from employees
where birth_date between '1953-01-01' and '1953-12-31';

select first_name, last_name
from employees
where birth_date between '1954-01-01' and '1954-12-31';

select first_name, last_name
from employees
where birth_date between '1955-01-01' and '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
and (hire_date between '1985-01-01' AND '1988--12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--export to a table
SELECT first_name, last_name
into retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
and (hire_date between '1985-01-01' AND '1988--12-31');

SELECT * FROM retirement_info;
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name, 
		dm.emp_no, 
		dm.from_date,
		dm.to_date
FROM departments as d
INNER JOIN dept_manager dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no, 
	ri.first_name, 
	ri.last_name, 
	de.to_date
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no;

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
--drop table current_emp;
select count(*) from current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Employee count by department number - make new table
SELECT COUNT(ce.emp_no), de.dept_no
into current_emp_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

---New Tables--- 7.3.5
select * from salaries
ORDER BY to_date DESC;

SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
into emp_info
from employees as e
inner join salaries as s on (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

select * from emp_info;

--List of managers per department
select dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
into manager_info
from dept_manager as dm
inner join departments as d on (dm.dept_no = d.dept_no)
inner join current_emp as ce on (dm.emp_no = ce.emp_no);

--get dept retirees
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
into dept_info
from current_emp as ce
inner join dept_emp as de on (ce.emp_no = de.emp_no)
inner join departments as d on (de.dept_no = d.dept_no);

--get all sales retiring employees
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
from current_emp as ce
inner join dept_emp as de on (ce.emp_no = de.emp_no)
inner join departments as d on (de.dept_no = d.dept_no)
where d.dept_name = 'Sales';

--get all sales & dev retiring employees
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
from current_emp as ce
inner join dept_emp as de on (ce.emp_no = de.emp_no)
inner join departments as d on (de.dept_no = d.dept_no)
where d.dept_name in ('Sales', 'Development');