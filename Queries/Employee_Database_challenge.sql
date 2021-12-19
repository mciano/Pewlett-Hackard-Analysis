--Deliverable 1
select e.emp_no, 
	e.first_name, 
	e.last_name, 
	t.title, 
	t.from_date, 
	t.to_date
into retirement_titles
from employees as e
inner join titles as t on (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;
SELECT * FROM unique_titles;
-- number of employees retiring by title
select count(title) as total, 
	title
into retiring_titles
from unique_titles
group by title
order by total desc; 
SELECT * FROM retiring_titles;
--------------------------------------------------
--deliverable 2--
select distinct on (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,de.from_date, de.to_date,t.title
into mentor_elig
from employees as e
inner join dept_emp as de on (e.emp_no = de.emp_no)
inner join titles as t on (e.emp_no = t.emp_no)
where de.to_date = ('9999-01-01')
and (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
order by e.emp_no;

SELECT * FROM mentor_elig;