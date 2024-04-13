-- Crear una base de datos
CREATE DATABASE  dbInstitute;

-- Listar base de datos de MySQL
SHOW DATABASES;

-- Poner la base de datos en uso
USE dbInstitute;

-- Crear una tabla
CREATE TABLE student
(
    identificador int not null auto_increment primary key,
    nombres varchar(60) not null,
    apellidos varchar(70) not null,
    dni char(8) not null,
    celular char(9) not null,
    email varchar(50) not null,
    contrasena varchar(20) not null
);


-- Insertamos registros
INSERT INTO student
(nombres, apellidos, dni, celular, email, contrasena)
VALUES
('Alberto', 'Barrios Palomino', '78451211', '952741236', 'eugenio@yahoo.com', 'Alberto2024$$'),
('Carolina', 'Tarazona Meza', '78451212', '966332587', 'carolina.tarazona@yahoo.com', 'Carolina2024$$'),
('Roberto', 'Martínez Campos', '74125898', '988774125', 'roberto.martinez@gmail.com', 'Roberto2024@@'),
('Claudia', 'Rodríguez Guerra', '15253698', '955112478', 'claudia.rodriguez@outlook.com', 'Claudia2024@@');

-- Listamos registros
SELECT * FROM student;