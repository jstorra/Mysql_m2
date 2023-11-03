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


-- FOREIGN KEYS
ALTER TABLE emailsProfessor ADD FOREIGN KEY (professor_id) REFERENCES professors (dni);

ALTER TABLE phonesProfessor ADD FOREIGN KEY (professor_id) REFERENCES professors (dni);

ALTER TABLE departments ADD FOREIGN KEY (faculty_id) REFERENCES faculties (id);

ALTER TABLE courses ADD FOREIGN KEY (department_id) REFERENCES departments (id);
ALTER TABLE courses ADD FOREIGN KEY (professor_id) REFERENCES professors (dni);
ALTER TABLE courses ADD FOREIGN KEY (stateCourse_id) REFERENCES statesCourse (id);

ALTER TABLE emailsStudent ADD FOREIGN KEY (student_id) REFERENCES students (dni);

ALTER TABLE phonesStudent ADD FOREIGN KEY (student_id) REFERENCES students (dni);

ALTER TABLE courses_academicSessions ADD FOREIGN KEY (course_id) REFERENCES courses (id);
ALTER TABLE courses_academicSessions ADD FOREIGN KEY (academicSession_id) REFERENCES academicSessions (id);

ALTER TABLE inscriptions ADD FOREIGN KEY (course_id) REFERENCES courses (id);
ALTER TABLE inscriptions ADD FOREIGN KEY (student_id) REFERENCES students (dni);
ALTER TABLE inscriptions ADD FOREIGN KEY (stateInscription_id) REFERENCES statesInscription (id);

ALTER TABLE exams ADD FOREIGN KEY (student_id) REFERENCES students (dni);
ALTER TABLE exams ADD FOREIGN KEY (course_id) REFERENCES courses (id);

ALTER TABLE attendances ADD FOREIGN KEY (course_id) REFERENCES courses (id);
ALTER TABLE attendances ADD FOREIGN KEY (student_id) REFERENCES students (dni);


-- INSERTS INTO
INSERT INTO professors VALUES
('123456789A', 'Juan', 'Pérez', 'Profesor', '123456789', 'juan.perez@email.com', '1990-05-15', '08:00:00', '16:00:00'),
('987654321B', 'María', 'García', 'Docente', '987654321', 'maria.garcia@email.com', '1985-10-20', '09:30:00', '17:30:00'),
('111222333C', 'Pedro', 'López', 'Maestro', '111222333', 'pedro.lopez@email.com', '1978-03-12', '07:45:00', '15:45:00'),
('444555666D', 'Laura', 'Rodríguez', 'Catedrática', '444555666', 'laura.rodriguez@email.com', '1995-12-28', '08:15:00', '16:15:00'),
('777888999E', 'Ana', 'Martínez', 'Profesora', '777888999', 'ana.martinez@email.com', '1980-09-03', '10:00:00', '18:00:00');

INSERT INTO emailsProfessor VALUES
('correo1@email.com', '123456789A'),
('email2@ejemplo.com', '987654321B'),
('profesor@dominio.com', '123456789A'),
('email4@example.com', '444555666D'),
('ejemplo@correo.com', '777888999E');

INSERT INTO phonesProfessor VALUES 
('123456789', '123456789A'),
('987654321', '987654321B'),
('111222333', '111222333C'),
('444555666', '444555666D'),
('777888999', '777888999E');

INSERT INTO faculties VALUES
(1, 'Facultad de Ingeniería'),
(2, 'Facultad de Ciencias'),
(3, 'Facultad de Humanidades'),
(4, 'Facultad de Medicina'),
(5, 'Facultad de Artes');

INSERT INTO departments VALUES
(1, 'Departamento de Informática', 'Calle Principal 123', 1),
(2, 'Departamento de Física', 'Avenida Central 456', 2),
(3, 'Departamento de Literatura', 'Carrera Central 789', 3),
(4, 'Departamento de Cirugía', 'Calle de los Médicos 321', 4),
(5, 'Departamento de Música', 'Plaza de la Música 567', 5);

INSERT INTO statesCourse VALUES
(1, 'Activo'),
(2, 'Inactivo'),
(3, 'Pendiente'),
(4, 'Completado'),
(5, 'Cancelado');

INSERT INTO courses VALUES
(1, 'Programación Avanzada', 'Curso avanzado de programación', '3 meses', 1, '123456789A', 1),
(2, 'Física Cuántica', 'Introducción a la física cuántica', '4 meses', 2, '987654321B', 4),
(3, 'Literatura del Siglo XX', 'Estudio de literatura contemporánea', '5 meses', 3, '111222333C', 2),
(4, 'Cirugía Avanzada', 'Técnicas quirúrgicas avanzadas', '6 meses', 4, '444555666D', 1),
(5, 'Teoría Musical', 'Curso introductorio de teoría musical', '2 meses', 5, '777888999E', 3);

INSERT INTO students VALUES
('666666666F', 'Antonio', 'Martín', '666666666', 'antonio.martin@email.com', '1999-05-15'),
('777777777G', 'Lucía', 'Sánchez', '777777777', 'lucia.sanchez@email.com', '2000-08-20'),
('888888888H', 'Manuel', 'Pérez', '888888888', 'manuel.perez@email.com', '2001-03-12'),
('999999999J', 'Elena', 'Gómez', '999999999', 'elena.gomez@email.com', '2002-12-28'),
('101010101K', 'Isabel', 'Rodríguez', '101010101', 'isabel.rodriguez@email.com', '2003-09-03');

INSERT INTO emailsStudent VALUES
('correo1@email.com', '666666666F'),
('email2@ejemplo.com', '777777777G'),
('estudiante@dominio.com', '888888888H'),
('email4@example.com', '999999999J'),
('ejemplo@correo.com', '101010101K');

INSERT INTO phonesStudent VALUES 
('111111111', '666666666F'),
('222222222', '777777777G'),
('333333333', '888888888H'),
('444444444', '999999999J'),
('555555555', '101010101K');

INSERT INTO academicSessions VALUES
(1, '2023-09-01', '2024-01-31'),
(2, '2024-02-01', '2024-06-30'),
(3, '2024-07-01', '2024-11-30'),
(4, '2025-01-01', '2025-05-31'),
(5, '2025-06-01', '2025-10-31');

INSERT INTO courses_academicSessions VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO statesInscription VALUES
(1, 'En espera'),
(2, 'Aprobada'),
(3, 'Rechazada'),
(4, 'En proceso'),
(5, 'Finalizada');

INSERT INTO inscriptions VALUES
(1, 1, '666666666F', 2),
(2, 2, '777777777G', 5),
(3, 3, '888888888H', 1),
(4, 4, '999999999J', 4),
(5, 5, '101010101K', 3);

INSERT INTO exams VALUES
(1, 8.5, '2023-10-15', '666666666F', 1),
(2, 9.2, '2023-11-20', '777777777G', 2),
(3, 7.8, '2023-12-05', '888888888H', 3),
(4, 6.5, '2024-01-10', '999999999J', 4),
(5, 8.0, '2024-02-15', '101010101K', 5);

INSERT INTO attendances VALUES
(1, '666666666F', '2023-10-01', 1),
(2, '777777777G', '2023-10-05', 1),
(3, '888888888H', '2023-10-10', 0),
(4, '999999999J', '2023-10-15', 1),
(5, '101010101K', '2023-10-20', 0);