Employee Management System (SQL)
Project Overview

The Employee Management System is a relational database project developed using SQL.
The system is designed to store, manage, and analyze employee information within an organization in a structured and efficient manner.

It maintains records related to employees, job departments, salary structure, qualifications, leave management, and payroll processing.
The project demonstrates database design, normalization, table relationships, and analytical SQL queries for HR decision-making.

Objectives

To design a structured relational database for employee management

To maintain employee personal and job-related details

To manage salary, bonus, and payroll processing

To track employee qualifications and leave records

To perform HR analytics using SQL queries

To ensure data integrity using foreign key constraints and cascading rules

Database Tables

The database consists of the following tables:

JobDepartment – Stores department and job role information

Employee – Stores employee personal details

SalaryBonus – Stores salary and bonus structure

Qualification – Stores employee educational qualifications

Leaves – Tracks employee leave records

Payroll – Stores final payroll and salary calculations

Database Relationships

One department can have multiple employees

One employee can have multiple qualifications

One employee can take multiple leaves

Payroll links employee, job role, salary, and leave data

Foreign keys maintain referential integrity

Cascading rules (ON DELETE CASCADE, ON DELETE SET NULL, ON UPDATE CASCADE) prevent orphan records

SQL Features Used

CREATE, INSERT, UPDATE, DELETE statements

JOIN operations (INNER JOIN)

Aggregate functions such as COUNT, SUM, AVG, MAX

GROUP BY and ORDER BY

Subqueries

Constraints: PRIMARY KEY, FOREIGN KEY, UNIQUE

Data integrity using cascading actions

Analytical Queries Performed

The project includes SQL queries to generate HR insights such as:

Total number of employees

Department-wise employee distribution

Average salary per department

Top 5 highest-paid employees

Company salary expenditure

Job role analysis

Qualification analysis

Leave tracking and absence patterns

Payroll and bonus analysis

Files Included

employee_management_system.sql → Database creation, sample data, and queries

dataset/ → CSV files for each table

ER_Diagram.png → Entity Relationship diagram

Employee_Management_System_Presentation.pptx → Project presentation

How to Run the Project

Install MySQL or MySQL Workbench

Open MySQL Workbench

Create a new query tab

Open employee_management_system.sql

Execute the script

Database and tables will be created automatically

Run analysis queries to view results

Learning Outcomes

Understanding relational database design

Implementing normalized database schema

Working with foreign key relationships

Writing analytical SQL queries

Performing HR data analysis using SQL

Future Enhancements

Add attendance management

Add performance evaluation module

Build web interface using Python/Flask or Django

Dashboard visualization using Power BI

Technologies Used

SQL (MySQL)

MySQL Workbench

Relational Database Design

Author

Nadipelly Rajeshwar Rao
