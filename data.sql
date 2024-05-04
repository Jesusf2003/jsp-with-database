-- Crear una base de datos
CREATE DATABASE  dbInstitute;

-- Listar base de datos de MySQL
SHOW DATABASES;

-- Poner la base de datos en uso
USE dbInstitute;

-- Crear una tabla Career
CREATE TABLE career
(
    codigo char(4) primary key,
    nombre varchar(100) not null,
    descripcion varchar(120) not null,
    estado char(1) default 'A'
);

-- Crear una tabla
CREATE TABLE student
(
    identificador int not null auto_increment primary key,
    nombres varchar(60) not null,
    apellidos varchar(70) not null,
    dni char(8) not null,
    celular char(9) not null,
    email varchar(50) not null,
    carrera_codigo char(4),
    CONSTRAINT fk_student_career FOREIGN KEY (carrera_codigo) REFERENCES career(codigo)
);


-- Insertar registros
INSERT INTO career
(codigo, nombre, descripcion)
VALUES
    ('C001', 'Computación e Informática', 'Desarrolla soluciones de software'),
    ('C002', 'Administración y Sistemas', 'Realiza Análisis-Funcional de los procesos de negocios, en busca de la mejora continua'),
    ('C003', 'Administración de redes', 'Especialista en redes y comunicación'),
    ('C004', 'Industrial y Sistemas', 'Diseña, supervisa y optimiza procesos industriales');


INSERT INTO student
(nombres, apellidos, dni, celular, email, carrera_codigo)
VALUES
    ('Alberto', 'Barrios Palomino', '78451211', '952741236', 'eugenio@yahoo.com', 'C001'),
    ('Carolina', 'Tarazona Meza', '78451212', '966332587', 'carolina.tarazona@yahoo.com', 'C002'),
    ('Roberto', 'Martínez Campos', '74125898', '988774125', 'roberto.martinez@gmail.com', 'C003'),
    ('Claudia', 'Rodríguez Guerra', '15253698', '955112478', 'claudia.rodriguez@outlook.com', 'C004'),
    ('Eduardo', 'Gómez Pérez', '85632145', '977854123', 'eduardo.gomez@yahoo.com', 'C001'),
    ('Ana', 'López Montoya', '98745236', '954785236', 'ana.lopez@gmail.com', 'C002'),
    ('María', 'García Torres', '65214785', '933774125', 'maria.garcia@yahoo.com', 'C003'),
    ('Juan', 'Hernández Ruiz', '36521478', '955632145', 'juan.hernandez@gmail.com', 'C004'),
    ('Luis', 'Díaz Castro', '78523641', '944785236', 'luis.diaz@yahoo.com', 'C001'),
    ('Mónica', 'Sánchez Delgado', '98741236', '966325874', 'monica.sanchez@yahoo.com', 'C002'),
    ('Pedro', 'Ramírez Gutiérrez', '32587412', '977452136', 'pedro.ramirez@gmail.com', 'C003'),
    ('Sofía', 'Fernández López', '74125863', '955632147', 'sofia.fernandez@yahoo.com', 'C004'),
    ('Pablo', 'González Flores', '98521475', '944785632', 'pablo.gonzalez@gmail.com', 'C001'),
    ('Laura', 'Martínez Sánchez', '63258741', '977452369', 'laura.martinez@yahoo.com', 'C002'),
    ('Diego', 'López Rodríguez', '74512365', '955632147', 'diego.lopez@gmail.com', 'C003');


-- Listamos registros
SELECT * FROM student;