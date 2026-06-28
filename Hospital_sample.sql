CREATE DATABASE hospital_db;
USE hospital_db;
CREATE TABLE doctors(
doctor_id INT PRIMARY KEY,
doctor_name VARCHAR(50) NOT NULL,
department VARCHAR(50),
place VARCHAR(50)
);
CREATE TABLE patients(
patients_id INT PRIMARY KEY,
patients_name VARCHAR(50) NOT NULL,
age INT,
issues VARCHAR(50),
place VARCHAR(50),
doctor_id INT,
CONSTRAINT FK_doctorid FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id)
);
CREATE TABLE appoinments(
op_id INT PRIMARY KEY,
op_date DATE,
place VARCHAR(50),
doctor_name VARCHAR(50),
doctor_id INT,
patients_id INT,
CONSTRAINT FK_doctor_id FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id),
CONSTRAINT FK_patientsid FOREIGN KEY(patients_id) REFERENCES patients(patients_id)
);

INSERT INTO doctors VALUES
(1, 'Dr. Ravi', 'Cardiology', 'Chennai'),
(2, 'Dr. Meena', 'Neurology', 'Coimbatore'),
(3, 'Dr. Arjun', 'Orthopedics', 'Madurai'),
(4, 'Dr. Priya', 'Dermatology', 'Salem'),
(5, 'Dr. Kumar', 'General', 'Erode');

INSERT INTO patients VALUES
(101, 'Anu', 25, 'Skin Allergy', 'Salem', 4),
(102, 'Bala', 40, 'Heart Pain', 'Chennai', 1),
(103, 'Cathy', 30, 'Fracture', 'Madurai', 3),
(104, 'David', 50, 'Headache', 'Coimbatore', 2),
(105, 'Eva', 35, 'Fever', 'Erode', 5),
(106, 'Frank', 60, 'Heart Pain', 'Chennai', 1),
(107, 'Gokul', 28, 'Skin Allergy', 'Salem', 4);

INSERT INTO appoinments VALUES
(201, '2026-04-01', 'Chennai', 'Dr. Ravi', 1, 102),
(202, '2026-04-02', 'Salem', 'Dr. Priya', 4, 101),
(203, '2026-04-03', 'Madurai', 'Dr. Arjun', 3, 103),
(204, '2026-04-04', 'Coimbatore', 'Dr. Meena', 2, 104),
(205, '2026-04-05', 'Erode', 'Dr. Kumar', 5, 105),
(206, '2026-04-06', 'Chennai', 'Dr. Ravi', 1, 106),
(207, '2026-04-07', 'Salem', 'Dr. Priya', 4, 107);

SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM appoinments;

-- Retrieve all doctors from the doctors table.
SELECT * FROM doctors;
-- Get all patients who are above 30 years old.
SELECT * FROM patients
WHERE age > 30;
-- Display patient names and their issues.
SELECT patients_name,issues FROM patients;
-- Find all doctors working in Chennai.
SELECT * FROM doctors
WHERE place IN ("Chennai");
-- Count total number of patients.
SELECT COUNT(*) FROM patients;
-- Show all patients along with their doctor names.
SELECT p.patients_id,p.patients_name,p.age,p.issues,p.place,d.doctor_name
FROM patients p
JOIN doctors d
ON p.doctor_id=d.doctor_id;
-- List all appointments with patient name and doctor name.
SELECT a.op_id,a.op_date,a.place,p.patients_name,d.doctor_name
FROM appoinments a 
JOIN Patients p
ON a.patients_id=p.patients_id
JOIN doctors d 
ON a.doctor_id=d.doctor_id;
-- Find patients who have Heart Pain.
SELECT * FROM patients
WHERE issues = "Heart Pain";
-- Get all patients treated by Dr. Ravi.
SELECT p.patients_id,p.patients_name,p.age,p.issues,p.place,d.doctor_name
FROM patients p
JOIN doctors d
ON p.doctor_id=d.doctor_id
WHERE doctor_name = "Dr. Ravi";
-- Display doctors who have patients from the same city.
SELECT d.doctor_id,d.doctor_name,d.place,p.patients_name
FROM doctors d
JOIN patients p
ON p.doctor_id=d.doctor_id
WHERE p.place=d.place;
-- Get patient name, doctor name, and department.
SELECT p.patients_name,d.doctor_name,d.department
FROM patients p
INNER JOIN doctors d 
ON p.doctor_id=d.doctor_id;
-- Show all doctors and their patients (including doctors with no patients).
SELECT d.doctor_name,d.doctor_id,d.place,p.patients_name
FROM patients p
LEFT JOIN doctors d
ON p.doctor_id=d.doctor_id;
-- Show all patients and their doctors.
SELECT p.patients_id,p.patients_name,p.age,p.issues,p.place,d.doctor_name
FROM patients p
RIGHT JOIN doctors d
ON p.doctor_id=d.doctor_id;
-- Find patients who don’t have any appointments.
SELECT a.op_id,a.op_date,a.place,p.patients_name
FROM patients p
JOIN appoinments a 
ON p.patients_id=a.patients_id
WHERE a.patients_id IS NULL;
-- List doctors who never had any appointments.
SELECT d.doctor_name,d.doctor_id
FROM doctors d 
JOIN appoinments a 
ON a.doctor_id=d.doctor_id
WHERE a.doctor_id IS NULL;
-- Count number of patients per doctor.
SELECT d.doctor_name,d.doctor_id,COUNT(p.patients_name) AS total_patients
FROM patients p
LEFT JOIN doctors d
ON p.doctor_id=d.doctor_id
GROUP BY doctor_id,doctor_name;
-- Find the doctor who has treated the maximum patients.
SELECT d.doctor_name,d.doctor_id,COUNT(p.patients_name) AS total_patients
FROM patients p
LEFT JOIN doctors d
ON p.doctor_id=d.doctor_id
GROUP BY doctor_id,doctor_name
ORDER BY COUNT(p.patients_name) DESC
LIMIT 1;
-- Count patients city-wise.
SELECT place,COUNT(patients_name) AS total_patients FROM patients
GROUP BY place;
-- Find average age of patients per doctor.
SELECT d.doctor_name,ROUND(AVG(p.age)) AS Average_age
FROM patients p
JOIN doctors d
ON p.doctor_id=d.doctor_id
GROUP BY doctor_name;
-- Count number of appointments per city.
SELECT place,COUNT(op_id) AS total_appoinments FROM appoinments
GROUP BY place;
-- Find patients whose age is greater than the average age.
SELECT patients_id,patients_name,age FROM patients
WHERE age>(SELECT ROUND(AVG(age)) FROM patients);
-- Get doctors who have more patients than average.
SELECT d.doctor_id, d.doctor_name, COUNT(p.patients_id) AS total_patients
FROM doctors d
JOIN patients p 
ON d.doctor_id = p.doctor_id
GROUP BY d.doctor_id, d.doctor_name
HAVING COUNT(p.patients_id) > (
    SELECT AVG(patient_count)
    FROM (
        SELECT COUNT(*) AS patient_count
        FROM patients
        GROUP BY doctor_id
    ) AS avg_table
);
