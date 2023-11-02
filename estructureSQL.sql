CREATE DATABASE IF NOT EXISTS university;

USE university;

CREATE TABLE professors (
  dni VARCHAR(20) NOT NULL,
  firstName VARCHAR(50) NOT NULL,
  lastName VARCHAR(50) NOT NULL,
  professorTitle VARCHAR(20) NOT NULL,
  principalPhoneNumber VARCHAR(15) NOT NULL,
  principalEmail VARCHAR(50) NOT NULL,
  birthdate DATE NOT NULL,
  connectionTime TIME NOT NULL,
  disconnectionTime TIME
);

CREATE TABLE emailsProfessor (
  email VARCHAR(50) NOT NULL,
  professor_id VARCHAR(20) NOT NULL
);

CREATE TABLE phonesProfessor (
  phoneNumber VARCHAR(15) NOT NULL,
  professor_id VARCHAR(20) NOT NULL
);

CREATE TABLE faculties (
  id INT NOT NULL,
  nameFaculty VARCHAR(50) NOT NULL
);

CREATE TABLE departments (
  id INT NOT NULL,
  nameDepartment VARCHAR(50) NOT NULL,
  address VARCHAR(50) NOT NULL,
  faculty_id INT NOT NULL
);

CREATE TABLE statesCourse (
  id INT NOT NULL,
  nameState VARCHAR(20) NOT NULL
);

CREATE TABLE courses (
  id INT NOT NULL,
  nameCourse VARCHAR(50) NOT NULL,
  description VARCHAR(255) NOT NULL,
  duration VARCHAR(50) NOT NULL,
  department_id INT NOT NULL,
  professor_id VARCHAR(20) NOT NULL,
  stateCourse_id INT NOT NULL
);

CREATE TABLE students (
  dni VARCHAR(20) NOT NULL,
  firstName VARCHAR(50) NOT NULL,
  lastName VARCHAR(50) NOT NULL,
  principalPhoneNumber VARCHAR(15) NOT NULL,
  principalEmail VARCHAR(50) NOT NULL,
  birthdate DATE NOT NULL
);

CREATE TABLE emailsStudent (
  email VARCHAR(50) NOT NULL,
  student_id VARCHAR(20) NOT NULL
);

CREATE TABLE phonesStudent (
  phoneNumber VARCHAR(15) NOT NULL,
  student_id VARCHAR(20) NOT NULL
);

CREATE TABLE academicSessions (
  id INT NOT NULL,
  startDate DATE NOT NULL,
  endDate DATE NOT NULL
);

CREATE TABLE courses_academicSessions (
  course_id INT NOT NULL,
  academicSession_id INT NOT NULL
);

CREATE TABLE statesInscription (
  id INT NOT NULL,
  nameState VARCHAR(20) NOT NULL
);

CREATE TABLE inscriptions (
  id INT NOT NULL,
  course_id INT NOT NULL,
  student_id VARCHAR(20) NOT NULL,
  stateInscription_id INT NOT NULL
);

CREATE TABLE exams (
  id INT NOT NULL,
  grade DECIMAL(4,1) NOT NULL,
  examDate DATE NOT NULL,
  student_id VARCHAR(20) NOT NULL,
  course_id INT NOT NULL
);

CREATE TABLE attendances (
  course_id INT NOT NULL,
  student_id VARCHAR(20) NOT NULL,
  attendanceDate DATE NOT NULL,
  attend BOOLEAN NOT NULL
);


-- PRIMARY KEYS
ALTER TABLE professors ADD CONSTRAINT PK_Professors_Dni PRIMARY KEY (dni);

ALTER TABLE faculties ADD CONSTRAINT PK_Faculties_Id PRIMARY KEY (id);
ALTER TABLE faculties MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE departments ADD CONSTRAINT PK_Departments_Id PRIMARY KEY (id);
ALTER TABLE departments MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE statesCourse ADD CONSTRAINT PK_StatesCourse_Id PRIMARY KEY (id);
ALTER TABLE statesCourse MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE courses ADD CONSTRAINT PK_Courses_Id PRIMARY KEY (id);
ALTER TABLE courses MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE students ADD CONSTRAINT PK_Students_Dni PRIMARY KEY (dni);

ALTER TABLE academicSessions ADD CONSTRAINT PK_AcademicSessions_Id PRIMARY KEY (id);
ALTER TABLE academicSessions MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE statesInscription ADD CONSTRAINT PK_StatesInscription_Id PRIMARY KEY (id);
ALTER TABLE statesInscription MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE inscriptions ADD CONSTRAINT PK_Inscriptions_Id PRIMARY KEY (id);
ALTER TABLE inscriptions MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE exams ADD CONSTRAINT PK_Exams_Id PRIMARY KEY (id);
ALTER TABLE exams MODIFY id INT NOT NULL AUTO_INCREMENT;


-- UIDS
ALTER TABLE professors ADD CONSTRAINT UC_Professors_Phone UNIQUE (principalPhoneNumber);
ALTER TABLE professors ADD CONSTRAINT UC_Professors_Email UNIQUE (principalEmail);

ALTER TABLE emailsProfessor ADD CONSTRAINT UC_EmailsProfessor_Email UNIQUE (email);

ALTER TABLE phonesProfessor ADD CONSTRAINT UC_PhonesProfessor_PhoneNumber UNIQUE (phoneNumber);

ALTER TABLE faculties ADD CONSTRAINT UC_Faculties_nameFaculty UNIQUE (nameFaculty);

ALTER TABLE statesCourse ADD CONSTRAINT UC_StatesCourse_nameState UNIQUE (nameState);

ALTER TABLE courses ADD CONSTRAINT UC_Courses_professor_id UNIQUE (professor_id);

ALTER TABLE students ADD CONSTRAINT UC_Students_Phone UNIQUE (principalPhoneNumber);
ALTER TABLE students ADD CONSTRAINT UC_Students_Email UNIQUE (principalEmail);

ALTER TABLE emailsStudent ADD CONSTRAINT UC_EmailsStudent_Email UNIQUE (email);

ALTER TABLE phonesStudent ADD CONSTRAINT UC_PhonesStudent_PhoneNumber UNIQUE (phoneNumber);

ALTER TABLE statesInscription ADD CONSTRAINT UC_StatesInscription_NameState UNIQUE (nameState);