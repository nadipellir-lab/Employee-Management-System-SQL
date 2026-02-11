CREATE DATABASE JOBDEPARTMENTDB;
USE JOBDEPARTMENTDB;
-- Table 1: job department
CREATE TABLE JOBDEPARTMENT(
JOB_ID INT PRIMARY KEY,
JOBDEPT VARCHAR(50),
NAME VARCHAR(100),
DESCRIPTION TEXT,
SALARYRANGE VARCHAR(50)
);
SELECT * FROM JOBDEPARTMENT;

-- Table 2: salary bonus
CREATE TABLE SalaryBonus (
    salary_ID INT PRIMARY KEY,
    Job_ID INT,
    amount DECIMAL(10,2),
    annual DECIMAL(10,2),
    bonus DECIMAL(10,2),
    FOREIGN KEY (job_ID) REFERENCES JobDepartment(Job_ID)
        ON DELETE CASCAsalarybonusDE ON UPDATE CASCADE
);
SELECT * FROM SALARYBONUS;

-- Table 3: Employee
CREATE TABLE Employee (
    emp_ID INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    contact_add VARCHAR(100),
    emp_email VARCHAR(100) UNIQUE,
    emp_pass VARCHAR(50),
    Job_ID INT,
    CONSTRAINT fk_employee_job FOREIGN KEY (Job_ID)
        REFERENCES JobDepartment(Job_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
SELECT * FROM EMPLOYEE;

-- Table 4: Qualification
CREATE TABLE Qualification (
    QualID INT PRIMARY KEY,
    Emp_ID INT,
    Position VARCHAR(50),
    Requirements VARCHAR(255),
    Date_In DATE,
    CONSTRAINT fk_qualification_emp FOREIGN KEY (Emp_ID)
        REFERENCES Employee(emp_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
SELECT * FROM QUALIFICATION;

-- Table 5: Leaves
CREATE TABLE Leaves (
    leave_ID INT PRIMARY KEY,
    emp_ID INT,
    date DATE,
    reason TEXT,
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
SELECT * FROM LEAVES;

-- Table 6: Payroll
CREATE TABLE Payroll (
    payroll_ID INT PRIMARY KEY,
    emp_ID INT,
    job_ID INT,
    salary_ID INT,
    leave_ID INT,
    date DATE,
    report TEXT,
    total_amount DECIMAL(10,2),
    CONSTRAINT fk_payroll_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(job_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_salary FOREIGN KEY (salary_ID) REFERENCES SalaryBonus(salary_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_leave FOREIGN KEY (leave_ID) REFERENCES Leaves(leave_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);
SELECT * FROM PAYROLL;

-- problem statements
-- employee insights

USE JOBDEPARTMENTDB;
-- 1.How many unique employees are currently in the system?
SELECT COUNT(DISTINCT emp_ID) AS total_employees
FROM Employee;
-- 2.Which departments have the highest number of employees?
SELECT jd.jobdept,
       COUNT(e.emp_ID) AS employee_count
FROM Employee e
JOIN JobDepartment jd
ON e.Job_ID = jd.Job_ID
GROUP BY jd.jobdept
ORDER BY employee_count DESC;
-- 3.what is the average salary per department?
SELECT jd.jobdept,
       AVG(sb.amount) AS average_salary
FROM SalaryBonus sb
JOIN JobDepartment jd
ON sb.Job_ID = jd.Job_ID
GROUP BY jd.jobdept;
-- 4.Who are the top 5 highest-paid employees?
SELECT e.emp_ID,
       e.firstname,
       e.lastname,
       p.total_amount
FROM Payroll p
JOIN Employee e
ON p.emp_ID = e.emp_ID
ORDER BY p.total_amount DESC
LIMIT 5;
-- 5.What is the total salary expenditure across the company?
SELECT SUM(total_amount) AS total_salary_expenditure
FROM Payroll;

-- JOB ROLE & DEPARTMENT ANALYSIS
-- 1.How many different job roles exist in each department?
SELECT jobdept,
       COUNT(DISTINCT name) AS job_roles_count
FROM JobDepartment
GROUP BY jobdept;
-- 2.What is the average salary range per department?
SELECT jd.jobdept,
       AVG(sb.amount) AS avg_salary
FROM SalaryBonus sb
JOIN JobDepartment jd
ON sb.Job_ID = jd.Job_ID
GROUP BY jd.jobdept;
-- 3.Which job roles offer the highest salary?
SELECT jd.name AS job_role,
       sb.amount AS salary
FROM SalaryBonus sb
JOIN JobDepartment jd
ON sb.Job_ID = jd.Job_ID
ORDER BY sb.amount DESC;
-- 4.Which departments have the highest total salary allocation?
SELECT jd.jobdept,
       SUM(sb.amount) AS total_salary
FROM SalaryBonus sb
JOIN JobDepartment jd
ON sb.Job_ID = jd.Job_ID
GROUP BY jd.jobdept
ORDER BY total_salary DESC;

-- QUALIFICATION & SKILLS ANALYSIS
-- 1.How many employees have at least one qualification listed?
SELECT COUNT(DISTINCT Emp_ID) AS employees_with_qualification
FROM Qualification;
-- 2.Which positions require the most qualifications?
SELECT Position,
       COUNT(*) AS qualification_count
FROM Qualification
GROUP BY Position
ORDER BY qualification_count DESC;
-- 3.Which employees have the highest number of qualifications?
SELECT Emp_ID,
       COUNT(*) AS qualification_count
FROM Qualification
GROUP BY Emp_ID
ORDER BY qualification_count DESC;

-- LEAVE & ABSENCE PATTERNS
-- 1.Which year had the most employees taking leaves?
SELECT YEAR(date) AS year,
       COUNT(*) AS leave_count
FROM Leaves
GROUP BY YEAR(date)
ORDER BY leave_count DESC;
-- 2.Average number of leave days per department?
SELECT jd.jobdept,
       COUNT(l.leave_ID) / COUNT(DISTINCT e.emp_ID) AS avg_leave_days
FROM Leaves l
JOIN Employee e ON l.emp_ID = e.emp_ID
JOIN JobDepartment jd ON e.Job_ID = jd.Job_ID
GROUP BY jd.jobdept;
-- 3.Which employees have taken the most leaves?
SELECT emp_ID,
       COUNT(*) AS total_leaves
FROM Leaves
GROUP BY emp_ID
ORDER BY total_leaves DESC;
-- 4.Total number of leave days taken company-wide?
SELECT COUNT(*) AS total_leave_days
FROM Leaves;
-- 5.How do leave days correlate with payroll amounts?
SELECT p.emp_ID,
       COUNT(l.leave_ID) AS leaves_taken,
       AVG(p.total_amount) AS avg_payroll
FROM Payroll p
LEFT JOIN Leaves l
ON p.emp_ID = l.emp_ID
GROUP BY p.emp_ID;

-- PAYROLL & COMPENSATION ANALYSIS
-- 1.What is the total monthly payroll processed?
SELECT DATE_FORMAT(date, '%Y-%m') AS month,
       SUM(total_amount) AS monthly_payroll
FROM Payroll
GROUP BY month;
-- 2.What is the average bonus given per department?
SELECT jd.jobdept,
       AVG(sb.bonus) AS average_bonus
FROM SalaryBonus sb
JOIN JobDepartment jd
ON sb.Job_ID = jd.Job_ID
GROUP BY jd.jobdept;
-- 3.Which department receives the highest total bonuses?
SELECT jd.jobdept,
       SUM(sb.bonus) AS total_bonus
FROM SalaryBonus sb
JOIN JobDepartment jd
ON sb.Job_ID = jd.Job_ID
GROUP BY jd.jobdept
ORDER BY total_bonus DESC;
-- 4.Average value of total_amount after leave deductions?
SELECT AVG(total_amount) AS avg_net_salary
FROM Payroll;

-- CHALLENGES
-- 1.Prevent duplicate employees (email)
ALTER TABLE Employee
ADD CONSTRAINT unique_email UNIQUE (emp_email);
-- 2.Verify foreign keys & cascading rules
SHOW CREATE TABLE Payroll;
-- 3.Ensure date format
SELECT *
FROM Leaves
WHERE date IS NULL;
-- 4.Validate referential integrity
SELECT *
FROM Employee
WHERE Job_ID NOT IN (SELECT Job_ID FROM JobDepartment);
