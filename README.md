# Hospital Management System — SQL Project

## Overview
Designed and implemented a Hospital Management relational database 
with 3 interconnected tables — Doctors, Patients, and Appointments. 
Performed 20+ advanced SQL queries to extract business insights 
on patient care, doctor performance, and appointment trends.

## Database Design
3 tables with Primary Keys and Foreign Key constraints:
- doctors — doctor_id, doctor_name, department, place
- patients — patients_id, name, age, issues, place, doctor_id (FK)
- appointments — op_id, op_date, place, doctor_id (FK), patients_id (FK)

## ER Diagram
![Hospital ER Diagram](Hospital_db_ER_diagram.PNG)

## Key Queries Performed
- Retrieved all doctors, patients and appointments using SELECT
- Filtered patients above 30 years old and by city using WHERE
- Used INNER JOIN to get patients with their doctor names
- Used LEFT JOIN and RIGHT JOIN for complete doctor-patient mapping
- Found patients with no appointments using NULL checks
- Counted total patients per doctor using COUNT and GROUP BY
- Found doctor with maximum patients using ORDER BY + LIMIT
- Calculated average patient age per doctor using AVG
- Found patients older than average age using Subquery
- Found doctors with more patients than average using nested Subquery + HAVING

## Tools & Technologies
- MySQL
- SQL — DDL (CREATE, INSERT), DML (SELECT)
- Joins — INNER, LEFT, RIGHT
- Aggregate Functions — COUNT, AVG, ROUND
- Clauses — GROUP BY, HAVING, ORDER BY, LIMIT
- Subqueries — Nested and correlated
- Constraints — PRIMARY KEY, FOREIGN KEY

## Project Files
- `Hospital_sample.sql` — Complete database schema and all queries
- `Hospital_db_ER_diagram.PNG` — Entity Relationship Diagram

## Skills Demonstrated
SQL · MySQL · Database Design · ER Diagrams · JOINs · 
Subqueries · Aggregations · Business Analysis · Reporting
