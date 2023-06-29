CREATE DATABASE security_repair;
GO;
USE security_repair;


-- Table: servicios_tecnicos
CREATE TABLE servicios_tecnicos (
    id INT IDENTITY  NOT NULL,
    nombre VARCHAR(100)  NOT NULL,
    razon_social VARCHAR(80)  NOT NULL,
    fecha_fundacion DATE  NOT NULL,
    ruc BIGINT  NOT NULL,
    CONSTRAINT servicios_tecnicos_pk PRIMARY KEY  (id)
);

-- Table: tecnicos
CREATE TABLE tecnicos (
    id INT IDENTITY  NOT NULL,
    nombre VARCHAR(100)  NOT NULL,
    apellido_paterno VARCHAR(100)  NOT NULL,
    apellido_materno VARCHAR(100)  NOT NULL,
    telefono VARCHAR(20)  NOT NULL,
    correo VARCHAR(100)  NOT NULL,
    CONSTRAINT tecnicos_pk PRIMARY KEY  (id)
);


-- Table: clientes
CREATE TABLE clientes (
    id INT IDENTITY NOT NULL,
    nombre VARCHAR(100)  NOT NULL,
    apellido_paterno VARCHAR(100)  NOT NULL,
    apellido_materno VARCHAR(100)  NOT NULL,
    telefono VARCHAR(20)  NOT NULL,
    CONSTRAINT clientes_pk PRIMARY KEY  (id)
);


-- Table: dispositivos
CREATE TABLE dispositivos (
    id INT IDENTITY NOT NULL,
    descripcion varchar(50)  NOT NULL,
    CONSTRAINT dispositivos_pk PRIMARY KEY  (id)
);


-- Table: gamas
CREATE TABLE gamas (
    id INT IDENTITY  NOT NULL,
    descripcion VARCHAR(50)  NOT NULL,
    CONSTRAINT gamas_pk PRIMARY KEY  (id)
);


-- Table: reparaciones
CREATE TABLE reparaciones (
    id INT IDENTITY  NOT NULL,
    clientes_id INT  NOT NULL,
    servicios_tecnicos_id INT  NOT NULL,
    tecnicos_id INT  NOT NULL,
    tiempo_estimado INT  NOT NULL,
    precio MONEY  NOT NULL,
    urgencia INT  NOT NULL,
    prioridad VARCHAR(50)  NOT NULL,
    CONSTRAINT reparaciones_pk PRIMARY KEY  (id),
    CONSTRAINT reparaciones_clientes FOREIGN KEY (clientes_id)
        REFERENCES clientes(id),
    CONSTRAINT reparaciones_servicios_tecnicos FOREIGN KEY (servicios_tecnicos_id)
        REFERENCES servicios_tecnicos(id),
    CONSTRAINT reparaciones_tecnicos FOREIGN KEY (tecnicos_id)
        REFERENCES reparaciones(id)
);


-- Table: calificaciones
CREATE TABLE calificaciones (
    id INT IDENTITY NOT NULL,
    reparaciones_id INT  NOT NULL,
    clientes_id INT  NOT NULL,
    servicios_tecnicos_id INT  NOT NULL,
    descripcion VARCHAR(255)  NOT NULL,
    puntaje FLOAT(2)  NOT NULL,
    CONSTRAINT calificaciones_pk PRIMARY KEY  (id),
    CONSTRAINT calificaciones_reparaciones_fk FOREIGN KEY (reparaciones_id)
        REFERENCES reparaciones(id),
    CONSTRAINT calificaciones_clientes_fk FOREIGN KEY (clientes_id)
        REFERENCES clientes(id)
);


-- Table: citas
CREATE TABLE citas (
    id INT IDENTITY  NOT NULL,
    clientes_id INT  NOT NULL,
    servicios_tecnicos_id INT  NOT NULL,
    fecha DATE  NOT NULL,
    hora TIME(2)  NOT NULL,
    CONSTRAINT citas_pk PRIMARY KEY  (id),
    CONSTRAINT citas_clientes_fk FOREIGN KEY (clientes_id)
        REFERENCES clientes(id),
    CONSTRAINT citas_servicios_tecnicos_fk FOREIGN KEY (servicios_tecnicos_id)
        REFERENCES servicios_tecnicos(id)
);


-- Table: clientes_por_servicio_tecnico
CREATE TABLE clientes_por_servicio_tecnico (
    clientes_id INT  NOT NULL,
    servicios_tecnicos_id INT  NOT NULL,
    CONSTRAINT clientes_por_servicio_tecnico_pk PRIMARY KEY  (clientes_id,servicios_tecnicos_id),
    CONSTRAINT clientes_por_servicio_tecnico_clientes_id_fk FOREIGN KEY (clientes_id)
        REFERENCES clientes(id),
    CONSTRAINT clientes_por_servicio_tecnico_servicios_tecnicos_id_fk FOREIGN KEY (servicios_tecnicos_id)
        REFERENCES servicios_tecnicos(id)
);


-- Table: diagnosticos
CREATE TABLE diagnosticos (
    id INT  IDENTITY  NOT NULL,
    reparaciones_id INT  NOT NULL,
    descripcion VARCHAR(255)  NOT NULL,
    CONSTRAINT diagnosticos_pk PRIMARY KEY  (id),
    CONSTRAINT diagnosticos_reparaciones_fk FOREIGN KEY (reparaciones_id)
        REFERENCES reparaciones(id)
);

-- Table: empleados_por_servicio_tecnico
CREATE TABLE empleados_por_servicio_tecnico (
    servicios_tecnicos_id INT  NOT NULL,
    tecnicos_id INT  NOT NULL,
    fecha_inicio DATE  NOT NULL,
    fecha_fin DATE  NOT NULL,
    CONSTRAINT empleados_por_servicio_tecnico_pk PRIMARY KEY  (servicios_tecnicos_id,tecnicos_id,fecha_inicio),
    CONSTRAINT empleados_por_servicio_tecnico_servicios_tecnicos_fk FOREIGN KEY (servicios_tecnicos_id)
        REFERENCES servicios_tecnicos(id),
    CONSTRAINT empleados_por_servicio_tecnico_tecnicos_fk FOREIGN KEY (tecnicos_id)
        REFERENCES tecnicos(id)
);


-- Table: envios
CREATE TABLE envios (
    id INT IDENTITY  NOT NULL,
    clientes_id INT  NOT NULL,
    servicios_tecnicos_id INT  NOT NULL,
    fecha_de_envio DATE  NOT NULL,
    hora_de_envio TIME(2)  NOT NULL,
    empresa_de_envio VARCHAR(100)  NOT NULL,
    CONSTRAINT envios_pk PRIMARY KEY  (id),
    CONSTRAINT envios_clientes_fk FOREIGN KEY (clientes_id)
        REFERENCES clientes(id),
    CONSTRAINT envios_servicios_tecnicos_fk FOREIGN KEY (servicios_tecnicos_id)
        REFERENCES servicios_tecnicos(id)
);


-- Table: marcas
CREATE TABLE marcas (
    id INT IDENTITY  NOT NULL,
    descripcion VARCHAR(100)  NOT NULL,
    CONSTRAINT marcas_pk PRIMARY KEY  (id)
);


-- Table: modelos
CREATE TABLE modelos (
    id INT IDENTITY  NOT NULL,
    marcas_id INT  NOT NULL,
    descripcion VARCHAR(100)  NOT NULL,
    CONSTRAINT modelos_pk PRIMARY KEY  (id),
    CONSTRAINT modelos_marcas_fk FOREIGN KEY (marcas_id)
        REFERENCES marcas(id)
);


-- Table: equipos
CREATE TABLE equipos (
    dispositivos_id INT  NOT NULL,
    modelos_id INT  NOT NULL,
    clientes_id INT  NOT NULL,
    gamas_id INT  NOT NULL,
    esta_reportado BIT  NOT NULL,
    CONSTRAINT equipos_pk PRIMARY KEY  (dispositivos_id,modelos_id),
    CONSTRAINT equipos_dispositivos_fk FOREIGN KEY (dispositivos_id)
        REFERENCES dispositivos(id),
    CONSTRAINT equipos_modelos_fk FOREIGN KEY (modelos_id)
        REFERENCES modelos(id),
    CONSTRAINT equipos_clientes_fk FOREIGN KEY (clientes_id)
        REFERENCES clientes(id),
    CONSTRAINT equipos_gamas_fk FOREIGN KEY (gamas_id)
        REFERENCES gamas(id)
);


-- Table: estados_de_reparacion
CREATE TABLE estados_de_reparacion (
    id INT IDENTITY NOT NULL,
    reparaciones_id INT  NOT NULL,
    descripcion VARCHAR(100)  NOT NULL,
    fecha DATE  NOT NULL,
    CONSTRAINT estados_de_reparacion_pk PRIMARY KEY  (id),
    CONSTRAINT estados_de_reparacion_reparaciones_fk FOREIGN KEY (reparaciones_id)
        REFERENCES reparaciones(id)
);


-- Table: horarios
CREATE TABLE horarios (
    id INT IDENTITY  NOT NULL,
    servicios_tecnicos_id INT  NOT NULL,
    fecha DATE  NOT NULL,
    hora_apertura TIME(2)  NOT NULL,
    hora_cierre TIME(2)  NOT NULL,
    CONSTRAINT horarios_pk PRIMARY KEY  (id),
    CONSTRAINT horarios_servicios_tecnicos_fk FOREIGN KEY (servicios_tecnicos_id)
        REFERENCES servicios_tecnicos(id)
);


-- Table: reclamos
CREATE TABLE reclamos (
    id INT IDENTITY  NOT NULL,
    clientes_id INT  NOT NULL,
    servicios_tecnicos_id INT  NOT NULL,
    descripcion VARCHAR(255)  NOT NULL,
    CONSTRAINT reclamos_pk PRIMARY KEY  (id),
    CONSTRAINT reclamos_clientes_fk FOREIGN KEY (clientes_id)
        REFERENCES clientes(id),
    CONSTRAINT reclamos_servicios_tecnicos_fk FOREIGN KEY (servicios_tecnicos_id)
        REFERENCES servicios_tecnicos(id)
);

-- Table: reparaciones_por_equipos
CREATE TABLE reparaciones_por_equipos (
    fecha_de_reparacion DATE  NOT NULL,
    reparaciones_id INT  NOT NULL,
    equipos_dispositivos_id INT  NOT NULL,
    equipos_modelos_id INT  NOT NULL,
    CONSTRAINT reparaciones_por_equipos_pk PRIMARY KEY  (fecha_de_reparacion,reparaciones_id,equipos_dispositivos_id,equipos_modelos_id),
    CONSTRAINT reparaciones_por_equipos_reparaciones_fk FOREIGN KEY (reparaciones_id)
        REFERENCES reparaciones(id),
    CONSTRAINT reparaciones_por_equipos_equipos_dispositivos_fk FOREIGN KEY (equipos_dispositivos_id, equipos_modelos_id)
        REFERENCES equipos(dispositivos_id, modelos_id),
);


-- Table: sedes
CREATE TABLE sedes (
    id INT IDENTITY  NOT NULL,
    servicios_tecnicos_id INT  NOT NULL,
    calle VARCHAR(100)  NOT NULL,
    numero_calle INT  NOT NULL,
    codigo_postal INT  NOT NULL,
    ciudad VARCHAR(100)  NOT NULL,
    pais VARCHAR(100)  NOT NULL,
    CONSTRAINT sedes_pk PRIMARY KEY  (id),
    CONSTRAINT sedes_servicios_tecnicos_fk FOREIGN KEY (servicios_tecnicos_id)
        REFERENCES servicios_tecnicos(id)
);



INSERT INTO servicios_tecnicos (nombre, razon_social, fecha_fundacion, ruc)
VALUES
('MegaTech', 'MegaTech S.A.C', '2002-06-10', 654987321),
('TechSupport', 'SoporteTec S.A.C', '2004-09-18', 741852963),
('SmartFix', 'SmartFix S.A.C', '2012-01-20', 369852741),
('GlobalTech', 'GlobalTech S.A.C', '2009-07-17', 258963147),
('iRepair', 'iRepair S.A.C', '2005-04-03', 159263874),
('TechMaster', 'TechMaster S.A.C', '2003-03-08', 935718246),
('ElectroLab', 'ElectroLab S.A.C', '2007-06-23', 246813579),
('TechGenius', 'TechGenius S.A.C', '2001-12-01', 795246813),
('iFix', 'iFix S.A.C', '2006-05-12', 987654321),
('GadgetFix', 'GadgetFix S.A.C', '2009-01-06', 753198246);
GO;

INSERT INTO tecnicos(nombre, apellido_paterno, apellido_materno, telefono, correo)
VALUES
('Gabriel', 'Cabrera', 'Valencia', '987654321', 'gabriel.cabrera@gmail.com'),
('Daniela', 'Ríos', 'Navarro', '923456789', 'daniela.rios@gmail.com'),
('Adrián', 'Delgado', 'Soria', '987123456', 'adrian.delgado@gmail.com'),
('Camila', 'Soto', 'Lara', '956789123', 'camila.soto@gmail.com'),
('Renato', 'Moreno', 'Araya', '921654987', 'renato.moreno@gmail.com'),
('Valeria', 'Fuentes', 'Pacheco', '989123456', 'valeria.fuentes@gmail.com'),
('Lucas', 'Vera', 'Molina', '954987321', 'lucas.vera@gmail.com'),
('Antonella', 'Sepúlveda', 'Avendaño', '921789654', 'antonella.sepulveda@gmail.com'),
('Emilio', 'Arriagada', 'Oliva', '987321654', 'emilio.arriagada@gmail.com'),
('Abril', 'Palacios', 'Ortega', '956123789', 'abril.palacios@gmail.com'),
('Matías', 'Vidal', 'Arévalo', '954321987', 'matias.vidal@gmail.com'),
('Catalina', 'Muñoz', 'Bravo', '989654123', 'catalina.munoz@gmail.com'),
('Maximiliano', 'Carrasco', 'Zamorano', '923789456', 'maximiliano.carrasco@gmail.com'),
('Constanza', 'Araya', 'Pizarro', '921987654', 'constanza.araya@gmail.com'),
('Benjamín', 'Silva', 'Vargas', '954123789', 'benjamin.silva@gmail.com'),
('Valentina', 'González', 'Lira', '989456321', 'valentina.gonzalez@gmail.com'),
('Gaspar', 'Cortés', 'Muñoz', '923987654', 'gaspar.cortes@gmail.com'),
('Emilia', 'Ortiz', 'Aguirre', '987654321', 'emilia.ortiz@gmail.com'),
('Joaquín', 'Bravo', 'Soto', '923456789', 'joaquin.bravo@gmail.com'),
('Isidora', 'Cáceres', 'Gallardo', '987123456', 'isidora.caceres@gmail.com'),

('Luis', 'González', 'Ruíz', '987654321', 'luis.gonzalez@gmail.com'),
('María', 'Hernández', 'López', '923456789', 'maria.hernandez@gmail.com'),
('Carlos', 'Martínez', 'Sánchez', '987123456', 'carlos.martinez@gmail.com'),
('Laura', 'Rodríguez', 'Gómez', '956789123', 'laura.rodriguez@gmail.com'),
('Andrés', 'Gómez', 'Pérez', '921654987', 'andres.gomez@gmail.com'),
('Ana', 'García', 'Torres', '989123456', 'ana.garcia@gmail.com'),
('Javier', 'López', 'Flores', '954987321', 'javier.lopez@gmail.com'),
('Sofía', 'Pérez', 'Mendoza', '921789654', 'sofia.perez@gmail.com'),
('Diego', 'Sánchez', 'Ramos', '987321654', 'diego.sanchez@gmail.com'),
('Mónica', 'Ramírez', 'Vargas', '956123789', 'monica.ramirez@gmail.com'),
('Fernando', 'Torres', 'Cruz', '954321987', 'fernando.torres@gmail.com'),
('Elena', 'Flores', 'Silva', '989654123', 'elena.flores@gmail.com'),
('Hugo', 'Mendoza', 'Gómez', '923789456', 'hugo.mendoza@gmail.com'),
('Paola', 'Vargas', 'Hernández', '921987654', 'paola.vargas@gmail.com'),
('Alejandro', 'Cruz', 'Martínez', '954123789', 'alejandro.cruz@gmail.com'),
('Isabella', 'Silva', 'López', '989456321', 'isabella.silva@gmail.com'),
('Roberto', 'Gómez', 'Sánchez', '923987654', 'roberto.gomez@gmail.com'),
('Natalia', 'Hernández', 'Ramírez', '921456789', 'natalia.hernandez@gmail.com'),
('Pedro', 'Mendoza', 'García', '954789123', 'pedro.mendoza@gmail.com'),
('Carolina', 'Sánchez', 'Torres', '989321456', 'carolina.sanchez@gmail.com'),

('Liam', 'Smith', 'Gómez', '912345678', 'liam.smith@gmail.com'),
('Sophia', 'Johnson', 'Hernández', '912345679', 'sophia.johnson@gmail.com'),
('Noah', 'Brown', 'López', '912345680', 'noah.brown@gmail.com'),
('Isabella', 'Davis', 'Rodríguez', '912345681', 'isabella.davis@gmail.com'),
('Ethan', 'Martinez', 'Pérez', '912345682', 'ethan.martinez@gmail.com'),
('Olivia', 'García', 'González', '912345683', 'olivia.garcia@gmail.com'),
('Aiden', 'Wilson', 'Silva', '912345684', 'aiden.wilson@gmail.com'),
('Mia', 'Taylor', 'Molina', '912345685', 'mia.taylor@gmail.com'),
('Lucas', 'Clark', 'Rojas', '912345686', 'lucas.clark@gmail.com'),
('Amelia', 'Lee', 'Santos', '912345687', 'amelia.lee@gmail.com'),
('Mateo', 'Anderson', 'Castro', '912345688', 'mateo.anderson@gmail.com'),
('Emma', 'White', 'Ortega', '912345689', 'emma.white@gmail.com'),
('Sebastián', 'Hall', 'Vargas', '912345690', 'sebastian.hall@gmail.com'),
('Sofía', 'Miller', 'Ramírez', '912345691', 'sofia.miller@gmail.com'),
('Benjamín', 'Moore', 'Cruz', '912345692', 'benjamin.moore@gmail.com'),
('Valentina', 'Adams', 'Morales', '912345693', 'valentina.adams@gmail.com'),
('Daniel', 'Young', 'Delgado', '912345694', 'daniel.young@gmail.com'),
('Emily', 'Thomas', 'Castillo', '912345695', 'emily.thomas@gmail.com'),
('Matías', 'Harris', 'Guzmán', '912345696', 'matias.harris@gmail.com'),
('Camila', 'Lewis', 'Navarro', '912345697', 'camila.lewis@gmail.com');
GO;

INSERT INTO clientes(nombre, apellido_paterno, apellido_materno, telefono)
VALUES
('María', 'García', 'López', '912345678'),
('Carlos', 'Fernández', 'Pacheco', '912345679'),
('Andrea', 'Rodríguez', 'Zambrano', '912345680'),
('Juan', 'Gómez', 'Alvarado', '912345681'),
('Luis', 'Silva', 'Araujo', '912345682'),
('Laura', 'Martínez', 'Landa', '912345683'),
('Diego', 'López', 'Escobar', '912345684'),
('Valeria', 'Sánchez', 'Vargas', '912345685'),
('Alejandro', 'Gutiérrez', 'Mora', '912345686'),
('Camila', 'Pérez', 'Vera', '912345687'),
('Daniel', 'Rojas', 'Guzmán', '912345688'),
('Paola', 'Hernández', 'Cortés', '912345689'),
('Javier', 'Torres', 'Quispe', '912345690'),
('Isabella', 'Castillo', 'Mendoza', '912345691'),
('Manuel', 'Luna', 'Paredes', '912345692'),
('Fernanda', 'Ortiz', 'Montenegro', '912345693'),
('Gonzalo', 'Cruz', 'Zapata', '912345694'),
('Valentina', 'Romero', 'Santos', '912345695'),
('Sebastián', 'Navarro', 'Fuentes', '912345696'),
('Gabriela', 'Pérez', 'Delgado', '912345697'),

('María', 'Torres', 'Ramírez', '912345698'),
('Carlos', 'López', 'Gómez', '912345699'),
('Andrea', 'Hernández', 'Vargas', '912345700'),
('Juan', 'González', 'Silva', '912345701'),
('Luis', 'Martínez', 'Araujo', '912345702'),
('Laura', 'Rodríguez', 'Cortés', '912345703'),
('Diego', 'Fernández', 'Landa', '912345704'),
('Valeria', 'García', 'Quispe', '912345705'),
('Alejandro', 'Pérez', 'Mendoza', '912345706'),
('Camila', 'Gutiérrez', 'Montenegro', '912345707'),
('Daniel', 'Silva', 'Paredes', '912345708'),
('Paola', 'Rojas', 'Zapata', '912345709'),
('Javier', 'Hernández', 'Santos', '912345710'),
('Isabella', 'Navarro', 'Fuentes', '912345711'),
('Manuel', 'Cruz', 'Delgado', '912345712'),
('Fernanda', 'Torres', 'Ramírez', '912345713'),
('Gonzalo', 'López', 'Gómez', '912345714'),
('Valentina', 'Hernández', 'Vargas', '912345715'),
('Sebastián', 'González', 'Silva', '912345716'),
('Gabriela', 'Martínez', 'Araujo', '912345717'),

('Sofía', 'Larsson', 'García', '912345718'),
('Benjamín', 'Rojas', 'López', '912345719'),
('Olivia', 'Santos', 'Fernández', '912345720'),
('Lucas', 'Silva', 'Pérez', '912345721'),
('Martina', 'Smith', 'Gómez', '912345722'),
('Emilia', 'González', 'Martínez', '912345723'),
('Matías', 'Vargas', 'Hernández', '912345724'),
('Isabella', 'Cruz', 'Rodríguez', '912345725'),
('Ignacio', 'Ramírez', 'Torres', '912345726'),
('Valentina', 'Fuentes', 'Luna', '912345727'),
('Emilio', 'Zapata', 'Gutiérrez', '912345728'),
('Renata', 'Sánchez', 'Navarro', '912345729'),
('Maximiliano', 'Flores', 'Morales', '912345730'),
('Josefina', 'Quispe', 'Castro', '912345731'),
('Agustín', 'Delgado', 'Vera', '912345732'),
('Florencia', 'Ortega', 'Cabrera', '912345733'),
('Pedro', 'Montenegro', 'Soto', '912345734'),
('Catalina', 'Paredes', 'Mendoza', '912345735'),
('Bruno', 'Landa', 'Ortiz', '912345736'),
('Antonella', 'Mora', 'Campos', '912345737'),

('Elena', 'Ramírez', 'Sánchez', '912345738'),
('Martín', 'González', 'López', '912345739'),
('Valeria', 'Hernández', 'Fernández', '912345740'),
('Leonardo', 'Silva', 'Pacheco', '912345741'),
('Isabel', 'Lara', 'Gómez', '912345742'),
('Lorenzo', 'Cabrera', 'Martínez', '912345743'),
('Ana', 'Pacheco', 'Hernández', '912345744'),
('Mariano', 'Vargas', 'Rodríguez', '912345745'),
('Lucía', 'Alvarado', 'Torres', '912345746'),
('Santiago', 'Luna', 'Gutiérrez', '912345747'),
('Camila', 'Castillo', 'Navarro', '912345748'),
('Mateo', 'Zambrano', 'Montenegro', '912345749'),
('Valentina', 'Escobar', 'Cruz', '912345750'),
('Emiliano', 'Mendoza', 'Romero', '912345751'),
('Martina', 'Gómez', 'Delgado', '912345752'),
('Joaquín', 'Fuentes', 'Pérez', '912345753'),
('Renata', 'Vera', 'Santos', '912345754'),
('Thiago', 'Delgado', 'Ortega', '912345755'),
('Antonella', 'Romero', 'Ortiz', '912345756'),
('Nicolás', 'Pérez', 'Campos', '912345757'),

('Liam', 'Schmidt', 'Jansen', '912345758'),
('Sophia', 'Van der Berg', 'Müller', '912345759'),
('Noah', 'Andersen', 'Sørensen', '912345760'),
('Emma', 'García', 'Nørgaard', '912345761'),
('Oliver', 'Olsen', 'Jacobsen', '912345762'),
('Ava', 'Leblanc', 'Dupont', '912345763'),
('William', 'Gauthier', 'Dubois', '912345764'),
('Mia', 'Ricci', 'Rossi', '912345765'),
('Alexander', 'Fischer', 'Weber', '912345766'),
('Amelia', 'Becker', 'Müller', '912345767'),
('Henry', 'Van der Meer', 'Bakker', '912345768'),
('Charlotte', 'Lefèvre', 'Leroy', '912345769'),
('James', 'Vásquez', 'Gómez', '912345770'),
('Olivia', 'Antonopoulos', 'Papadopoulos', '912345771'),
('Benjamin', 'Dumont', 'Lefebvre', '912345772'),
('Ella', 'Schröder', 'Müller', '912345773'),
('Daniel', 'Lisowski', 'Nowak', '912345774'),
('Sophie', 'Van den Berg', 'Janssen', '912345775'),
('Jacob', 'Ivanov', 'Petrov', '912345776'),
('Emily', 'Schmidt', 'Wagner', '912345777');
GO;

INSERT INTO dispositivos (descripcion)
VALUES
('Celular'),
('Laptop'),
('PC'),
('Tablet'),
('Smartwatch'),
('Televisor'),
('Consola de videojuegos'),
('Cámara digital'),
('Auriculares inalámbricos'),
('Altavoz Bluetooth'),
('Impresora'),
('Router'),
('Monitor'),
('Reproductor de música'),
('Reproductor de DVD'),
('Aspiradora robot'),
('Drone'),
('Smart Home Hub');
GO;

INSERT INTO gamas(descripcion)
VALUES
('Alta'),
('Media'),
('Baja');
GO;

INSERT INTO reparaciones(clientes_id, servicios_tecnicos_id, tecnicos_id, tiempo_estimado, precio, urgencia, prioridad)
VALUES
(42, 7, 29, 24, 150.00, 3, 'alta'),
(81, 2, 44, 8, 80.00, 4, 'media'),
(15, 9, 16, 72, 50.00, 2, 'baja'),
(67, 4, 51, 48, 120.00, 5, 'alta'),
(98, 1, 11, 168, 200.00, 1, 'media'),
(3, 8, 33, 16, 80.00, 3, 'baja'),
(56, 3, 59, 120, 180.00, 4, 'alta'),
(27, 6, 5, 96, 150.00, 2, 'alta'),
(73, 10, 14, 40, 100.00, 1, 'media'),
(4, 5, 30, 72, 90.00, 3, 'baja'),
(89, 7, 45, 24, 150.00, 5, 'alta'),
(23, 2, 20, 8, 80.00, 2, 'media'),
(47, 9, 55, 48, 120.00, 4, 'alta'),
(75, 1, 21, 168, 200.00, 3, 'media'),
(10, 8, 38, 16, 80.00, 1, 'baja'),
(61, 3, 48, 96, 180.00, 5, 'alta'),
(39, 6, 7, 120, 150.00, 4, 'alta'),
(88, 10, 17, 40, 100.00, 1, 'media'),
(35, 5, 25, 72, 90.00, 3, 'baja'),
(79, 7, 52, 24, 150.00, 2, 'alta'),

(17, 6, 27, 36, 180.00, 5, 'alta'),
(92, 3, 16, 12, 90.00, 2, 'media'),
(32, 10, 39, 60, 120.00, 3, 'baja'),
(54, 7, 54, 96, 200.00, 4, 'alta'),
(7, 2, 5, 144, 80.00, 1, 'media'),
(68, 9, 32, 24, 150.00, 3, 'baja'),
(21, 4, 10, 72, 110.00, 5, 'alta'),
(86, 1, 49, 168, 180.00, 2, 'alta'),
(13, 8, 41, 40, 100.00, 1, 'media'),
(47, 5, 28, 96, 90.00, 3, 'baja'),
(93, 7, 56, 36, 170.00, 4, 'alta'),
(28, 2, 3, 12, 95.00, 2, 'media'),
(66, 9, 20, 60, 130.00, 3, 'baja'),
(39, 4, 7, 120, 160.00, 5, 'alta'),
(74, 1, 46, 168, 180.00, 1, 'media'),
(12, 8, 35, 40, 90.00, 4, 'alta'),
(52, 5, 22, 96, 110.00, 3, 'alta'),
(88, 7, 53, 36, 150.00, 1, 'baja'),
(30, 2, 2, 12, 100.00, 2, 'media'),
(71, 9, 18, 60, 140.00, 3, 'baja'),

(63, 2, 43, 48, 500.00, 4, 'alta'),
(47, 9, 16, 24, 150.00, 2, 'media'),
(88, 6, 34, 60, 250.00, 3, 'baja'),
(29, 3, 27, 72, 350.00, 5, 'alta'),
(16, 7, 10, 96, 100.00, 1, 'media'),
(5, 2, 1, 12, 50.00, 3, 'baja'),
(41, 9, 29, 36, 450.00, 4, 'alta'),
(77, 6, 47, 120, 300.00, 2, 'alta'),
(12, 3, 3, 168, 200.00, 1, 'media'),
(55, 7, 24, 40, 180.00, 5, 'alta'),
(72, 2, 19, 12, 70.00, 3, 'media'),
(39, 9, 41, 60, 320.00, 2, 'baja'),
(82, 6, 52, 96, 280.00, 4, 'alta'),
(23, 3, 7, 168, 150.00, 1, 'media'),
(68, 7, 32, 40, 90.00, 5, 'alta'),
(91, 4, 55, 24, 400.00, 3, 'alta'),
(34, 10, 13, 48, 80.00, 2, 'media'),
(19, 5, 4, 120, 220.00, 4, 'baja'),
(47, 8, 16, 72, 150.00, 1, 'alta'),
(72, 1, 19, 96, 130.00, 5, 'alta'),

(11, 2, 25, 48, 280.00, 4, 'alta'),
(36, 9, 8, 24, 80.00, 2, 'media'),
(53, 6, 42, 60, 200.00, 3, 'baja'),
(84, 3, 15, 72, 150.00, 5, 'alta'),
(68, 7, 31, 96, 90.00, 1, 'media'),
(22, 2, 9, 12, 70.00, 3, 'baja'),
(48, 9, 26, 36, 350.00, 4, 'alta'),
(77, 6, 50, 120, 400.00, 2, 'alta'),
(92, 3, 6, 168, 250.00, 1, 'media'),
(56, 7, 23, 40, 180.00, 5, 'alta'),
(13, 2, 38, 12, 60.00, 3, 'media'),
(29, 9, 33, 60, 320.00, 2, 'baja'),
(75, 6, 57, 96, 280.00, 4, 'alta'),
(17, 3, 13, 168, 200.00, 1, 'media'),
(64, 7, 30, 40, 90.00, 5, 'alta'),
(83, 4, 3, 24, 400.00, 3, 'alta'),
(41, 10, 18, 48, 70.00, 2, 'media'),
(27, 5, 6, 120, 220.00, 4, 'baja'),
(59, 8, 28, 72, 130.00, 1, 'alta'),
(76, 1, 14, 96, 110.00, 5, 'alta'),

(37, 4, 13, 60, 283.50, 4, 'alta'),
(92, 5, 23, 96, 89.25, 3, 'baja'),
(11, 8, 42, 144, 156.80, 2, 'alta'),
(63, 10, 50, 36, 204.25, 1, 'media'),
(27, 6, 5, 48, 185.90, 5, 'alta'),
(14, 1, 8, 168, 118.60, 3, 'media'),
(50, 9, 26, 12, 73.40, 1, 'baja'),
(81, 7, 53, 120, 149.75, 4, 'alta'),
(31, 2, 31, 96, 103.20, 5, 'media'),
(64, 3, 36, 40, 87.50, 2, 'baja'),
(90, 4, 54, 72, 317.80, 4, 'alta'),
(21, 5, 10, 24, 153.25, 1, 'media'),
(79, 6, 52, 60, 278.60, 3, 'baja'),
(44, 7, 34, 168, 355.90, 5, 'alta'),
(16, 8, 10, 40, 96.75, 1, 'media'),
(58, 9, 45, 96, 183.75, 2, 'alta'),
(25, 10, 19, 36, 446.80, 4, 'alta'),
(32, 1, 39, 48, 78.50, 2, 'media'),
(17, 6, 27, 60, 176.80, 5, 'alta'),
(92, 3, 16, 12, 94.25, 2, 'media'),

(1, 5, 21, 72, 63.50, 3, 'media'),
(2, 2, 1, 24, 20.75, 1, 'baja'),
(18, 3, 16, 48, 150.25, 4, 'alta'),
(19, 4, 12, 96, 280.90, 2, 'alta'),
(50, 7, 28, 60, 110.60, 5, 'alta'),
(30, 8, 7, 12, 40.25, 1, 'baja'),
(8, 10, 23, 168, 200.50, 3, 'media'),
(3, 6, 6, 40, 76.80, 4, 'baja'),
(11, 9, 34, 72, 160.75, 2, 'alta'),
(5, 1, 4, 96, 310.90, 5, 'alta'),
(9, 2, 17, 60, 95.60, 1, 'alta'),
(12, 3, 20, 12, 12.25, 3, 'baja'),
(7, 4, 13, 48, 138.90, 4, 'alta'),
(13, 5, 7, 24, 40.60, 2, 'media'),
(15, 7, 19, 168, 180.50, 5, 'alta'),
(4, 8, 8, 40, 62.80, 1, 'baja'),
(20, 10, 15, 72, 180.75, 3, 'alta'),
(6, 6, 9, 96, 260.90, 4, 'alta'),
(17, 9, 18, 60, 92.60, 1, 'media'),
(14, 1, 7, 12, 30.25, 5, 'baja');
GO;

INSERT INTO calificaciones(reparaciones_id, clientes_id, servicios_tecnicos_id, descripcion, puntaje)
VALUES
(25, 35, 5, 'Buena reparación', 4.5),
(80, 72, 2, 'Excelente trabajo', 5),
(47, 18, 7, 'Reparación deficiente', 2.5),
(95, 66, 9, 'Servicio rápido y eficiente', 4),
(62, 10, 3, 'Reparación satisfactoria', 3.8),
(103, 51, 6, 'Mala experiencia, no lo recomiendo', 1.5),
(12, 2, 1, 'Reparación impecable', 5),
(78, 45, 8, 'Trabajo descuidado', 2),
(36, 92, 4, 'Buen servicio al cliente', 4.2),
(55, 22, 10, 'No cumplieron con el plazo de entrega', 3),
(67, 57, 3, 'Reparación rápida pero no solucionó el problema', 2.8),
(19, 8, 9, 'Muy buen trabajo', 4.7),
(41, 28, 2, 'Servicio insatisfactorio', 1.8),
(92, 14, 5, 'Reparación parcialmente exitosa', 3.5),
(8, 48, 6, 'Trato amable y eficiente', 4.3),
(30, 88, 1, 'Reparación de calidad', 4.8),
(58, 60, 10, 'Mal servicio al cliente', 1.2),
(15, 77, 4, 'Reparación incompleta', 2.2),
(50, 38, 7, 'Servicio profesional y rápido', 4.6),
(72, 96, 3, 'Trabajo descuidado, no lo recomiendo', 1.5),

(37, 63, 9, 'Reparación satisfactoria', 4.2),
(98, 3, 5, 'Excelente servicio al cliente', 4.8),
(54, 79, 2, 'Trabajo de mala calidad', 2.5),
(106, 24, 8, 'Reparación rápida pero no duradera', 3.2),
(71, 50, 4, 'Buena atención al detalle', 4.5),
(21, 30, 7, 'Servicio deficiente, tardaron mucho', 1.8),
(89, 18, 1, 'Reparación exitosa, recomendado', 4.7),
(44, 90, 6, 'Mala experiencia, falta de profesionalismo', 2.1),
(112, 7, 10, 'Servicio rápido y eficiente', 4.3),
(58, 82, 3, 'Buen trato al cliente, pero precio elevado', 3.9),
(76, 20, 9, 'Reparación parcialmente exitosa', 3.5),
(31, 55, 2, 'Mala calidad en la reparación', 2.2),
(94, 95, 5, 'Trabajo bien hecho, pero tardaron', 4.1),
(40, 42, 8, 'Reparación incompleta, tuve que regresar', 2.8),
(67, 12, 1, 'Excelente servicio y precio justo', 4.9),
(15, 67, 6, 'Mal servicio al cliente, no cumplieron', 1.5),
(78, 37, 3, 'Reparación de calidad y rápida', 4.6),
(23, 83, 7, 'Servicio deficiente, falta de comunicación', 2.4),
(53, 29, 4, 'Buena atención al cliente, precio alto', 3.7),
(102, 76, 10, 'Reparación insatisfactoria, falta de experiencia', 1.9),

(5, 1, 7, 'Reparación rápida y eficiente', 4.6),
(12, 2, 5, 'Trabajo de alta calidad, recomendado', 4.9),
(20, 3, 3, 'Excelente servicio al cliente', 4.8),
(3, 4, 9, 'Reparación satisfactoria, buen precio', 4.4),
(7, 5, 1, 'Atención al detalle, pero tardaron un poco', 4.2),
(16, 6, 6, 'Mala experiencia, falta de profesionalismo', 2.1),
(25, 7, 2, 'Reparación parcialmente exitosa', 3.5),
(2, 8, 10, 'Trabajo bien hecho, pero tardaron mucho', 3.9),
(9, 9, 4, 'Buen servicio al cliente, precio elevado', 3.7),
(30, 10, 8, 'Reparación rápida y de calidad', 4.6),
(18, 11, 3, 'Mal trato al cliente, no cumplieron', 1.5),
(35, 12, 9, 'Buena atención, pero precio alto', 3.3),
(6, 13, 1, 'Reparación exitosa, recomendado', 4.7),
(22, 14, 6, 'Mala calidad en la reparación', 2.2),
(11, 15, 2, 'Buen servicio, pero tardaron demasiado', 3.1),
(4, 16, 10, 'Reparación incompleta, tuve que regresar', 2.8),
(14, 17, 7, 'Excelente servicio y precio justo', 4.9),
(27, 18, 5, 'Mal servicio al cliente, no cumplieron', 1.5),
(8, 19, 3, 'Buena calidad en la reparación', 4.2),
(13, 20, 9, 'Reparación rápida y eficiente', 4.6),

(5, 1, 3, 'Buena atención al cliente, precio competitivo', 4.4),
(8, 2, 2, 'Reparación eficiente, recomendado', 4.7),
(10, 3, 4, 'Servicio rápido y de calidad', 4.6),
(12, 4, 1, 'Experiencia insatisfactoria, falta de profesionalismo', 2.1),
(15, 5, 5, 'Atención al cliente deficiente, retrasos en la reparación', 1.8),
(18, 6, 7, 'Reparación exitosa, pero precio elevado', 3.5),
(20, 7, 6, 'Excelente servicio al cliente, tiempo de espera aceptable', 4.9),
(22, 8, 8, 'Mala experiencia, falta de comunicación', 1.9),
(25, 9, 9, 'Buen trato al cliente, precio justo', 4.3),
(28, 10, 10, 'Reparación rápida y eficiente', 4.8),
(33, 11, 1, 'Servicio de calidad, personal amable', 4.5),
(35, 12, 3, 'Reparación parcialmente exitosa, se requiere seguimiento', 3.2),
(40, 13, 2, 'Atención al cliente deficiente, falta de compromiso', 2.0),
(45, 14, 4, 'Buena calidad en la reparación, tiempo de espera largo', 3.7),
(50, 15, 5, 'Trato amigable, precios competitivos', 4.6),
(55, 16, 6, 'Mala atención al cliente, falta de puntualidad', 1.6),
(60, 17, 7, 'Reparación exitosa, pero precio elevado', 3.9),
(65, 18, 8, 'Buen servicio al cliente, personal capacitado', 4.2),
(70, 19, 9, 'Reparación eficiente, recomendado', 4.7),
(75, 20, 10, 'Servicio rápido y de calidad', 4.6);
GO;

INSERT INTO citas(clientes_id, servicios_tecnicos_id, fecha, hora)
VALUES
(1, 1, '2022-05-10', '09:30:00'),
(2, 2, '2023-02-15', '14:45:00'),
(3, 3, '2021-09-18', '11:00:00'),
(4, 4, '2023-06-20', '16:15:00'),
(5, 5, '2022-07-07', '13:30:00'),
(6, 6, '2022-03-25', '10:45:00'),
(7, 7, '2023-01-12', '08:30:00'),
(8, 8, '2020-12-03', '15:00:00'),
(9, 9, '2022-08-28', '12:15:00'),
(10, 10, '2021-11-05', '17:30:00'),
(11, 1, '2023-03-12', '09:00:00'),
(12, 2, '2022-04-22', '14:15:00'),
(13, 3, '2021-10-17', '11:30:00'),
(14, 4, '2023-05-23', '16:45:00'),
(15, 5, '2022-06-09', '13:00:00'),
(16, 6, '2022-01-30', '10:15:00'),
(17, 7, '2023-02-05', '08:45:00'),
(18, 8, '2020-11-19', '15:30:00'),
(19, 9, '2022-07-15', '12:45:00'),
(20, 10, '2021-12-28', '17:00:00'),

(21, 1, '2023-01-05', '10:30:00'),
(32, 2, '2023-02-14', '14:00:00'),
(43, 3, '2023-03-21', '11:45:00'),
(54, 4, '2023-04-02', '16:30:00'),
(65, 5, '2023-05-08', '12:00:00'),
(76, 6, '2023-06-17', '09:15:00'),
(87, 7, '2023-07-19', '08:00:00'),
(98, 8, '2023-01-28', '15:45:00'),
(23, 9, '2023-02-09', '12:30:00'),
(34, 10, '2023-03-15', '17:15:00'),
(45, 1, '2023-04-27', '10:00:00'),
(56, 2, '2023-05-01', '14:30:00'),
(67, 3, '2023-06-10', '11:15:00'),
(78, 4, '2023-07-12', '16:00:00'),
(89, 5, '2023-01-14', '12:45:00'),
(30, 6, '2023-02-22', '09:30:00'),
(41, 7, '2023-03-29', '08:15:00'),
(52, 8, '2023-05-06', '15:00:00'),
(63, 9, '2023-06-14', '12:45:00'),
(74, 10, '2023-07-16', '17:30:00'),

(12, 5, '2023-01-10', '11:30:00'),
(43, 8, '2023-02-18', '14:45:00'),
(76, 3, '2023-03-25', '10:15:00'),
(59, 2, '2023-04-05', '16:45:00'),
(87, 1, '2023-05-12', '12:30:00'),
(24, 6, '2023-06-20', '09:45:00'),
(98, 9, '2023-07-22', '08:30:00'),
(19, 4, '2023-01-31', '15:15:00'),
(30, 7, '2023-02-12', '12:00:00'),
(56, 10, '2023-03-19', '17:45:00'),
(67, 5, '2023-04-30', '10:30:00'),
(81, 8, '2023-05-04', '14:00:00'),
(32, 3, '2023-06-13', '11:45:00'),
(45, 2, '2023-07-15', '16:30:00'),
(71, 1, '2023-01-18', '12:00:00'),
(23, 6, '2023-02-26', '09:15:00'),
(98, 9, '2023-03-05', '08:00:00'),
(54, 4, '2023-05-13', '15:45:00'),
(67, 7, '2023-06-24', '12:30:00'),
(89, 10, '2023-07-26', '17:15:00');
GO;

INSERT INTO clientes_por_servicio_tecnico(clientes_id, servicios_tecnicos_id)
VALUES
(1, 5),
(2, 9),
(4, 7),
(5, 3),
(6, 8),
(7, 1),
(8, 6),
(9, 4),
(10, 10),
(11, 3),
(12, 7),
(13, 1),
(14, 9),
(15, 6),
(16, 2),
(17, 10),
(18, 4),
(19, 8),
(20, 5),

(21, 7),
(22, 3),
(23, 9),
(24, 2),
(25, 6),
(26, 10),
(27, 4),
(28, 1),
(29, 5),
(30, 8),
(31, 1),
(32, 9),
(33, 5),
(34, 3),
(35, 10),
(36, 8),
(37, 2),
(38, 7),
(39, 6),
(40, 4),

(41, 5),
(42, 10),
(43, 3),
(44, 8),
(45, 2),
(46, 7),
(47, 1),
(48, 9),
(49, 4),
(50, 6),
(51, 8),
(52, 3),
(53, 2),
(54, 7),
(55, 10),
(56, 5),
(57, 6),
(58, 4),
(59, 1),
(60, 9),

(61, 3),
(62, 9),
(63, 5),
(64, 2),
(65, 7),
(66, 1),
(67, 8),
(68, 4),
(69, 10),
(70, 6),
(71, 7),
(72, 3),
(73, 10),
(74, 4),
(75, 5),
(76, 2),
(77, 9),
(78, 1),
(79, 8),
(80, 6),

(81, 7),
(82, 3),
(83, 9),
(84, 2),
(85, 6),
(86, 8),
(87, 4),
(88, 1),
(89, 5),
(90, 10),
(91, 2),
(92, 8),
(93, 5),
(94, 1),
(96, 4),
(97, 6),
(98, 10),
(99, 7),
(100, 3);

INSERT INTO diagnosticos (reparaciones_id, descripcion)
VALUES
(35, 'Pantalla rota'),
(86, 'Sistema operativo con malware'),
(19, 'Problema de sobrecalentamiento'),
(72, 'Batería agotada'),
(103, 'Problema de conectividad WiFi'),
(57, 'Disco duro dañado'),
(91, 'Problema de reinicio constante'),
(42, 'Teclado defectuoso'),
(65, 'Puerto de carga averiado'),
(28, 'Problema de sonido'),
(97, 'Pantalla táctil no responde'),
(12, 'Problema de tarjeta gráfica'),
(78, 'Bloqueo de patrón de desbloqueo'),
(53, 'Error de sistema operativo'),
(114, 'Problema de señal celular'),
(69, 'Fallo en el lector de huellas digitales'),
(24, 'Dispositivo no enciende'),
(108, 'Problema de lector de CD/DVD'),
(39, 'Error en la cámara'),
(81, 'Problema de carga de la batería'),
-- 30
(17, 'Problema de conector de carga'),
(93, 'Pantalla con líneas verticales'),
(52, 'Dispositivo no reconoce SIM'),
(109, 'Error en el lector de tarjetas de memoria'),
(76, 'Problema de congelamiento del sistema'),
(27, 'Altavoces sin sonido'),
(101, 'Problema de sensibilidad táctil'),
(45, 'Teclas atascadas'),
(89, 'Dispositivo lento'),
(63, 'Problema de encendido intermitente'),
(36, 'Error de reconocimiento facial'),
(111, 'Problema de audio en auriculares'),
(68, 'Fallo en la unidad de DVD'),
(22, 'Cámara no enfoca correctamente'),
(105, 'Problema de vibración'),
(59, 'Batería no carga completamente'),
(97, 'Problema de pantalla en negro'),
(13, 'Error de software'),
(84, 'Dispositivo se reinicia aleatoriamente'),
(30, 'Problema de tarjeta de red'),
(116, 'Botones de volumen no funcionan'),
(73, 'Fallo en el micrófono'),
(49, 'Problema de conexión Bluetooth'),
(91, 'Dispositivo no detecta auriculares'),
(19, 'Error en el lector de huellas'),
(77, 'Problema de sobrecarga de la CPU'),
(40, 'Bloqueo por patrón olvidado'),
(114, 'Fallo en el sistema operativo'),
(81, 'Problema de cobertura de red'),
(25, 'Error en la antena WiFi'),
-- 30
(6, 'Problema de carga lenta'),
(88, 'Pantalla táctil insensible'),
(38, 'Fallo en la conexión USB'),
(103, 'Error en la tarjeta gráfica'),
(72, 'Altavoz distorsionado'),
(17, 'Problema de reinicio constante'),
(97, 'Problema de batería agotada'),
(44, 'Error en el sistema operativo'),
(59, 'Pantalla en blanco'),
(25, 'Dispositivo sobrecalentado'),
(110, 'Problema de señal GPS'),
(53, 'Fallo en el lector de huellas'),
(79, 'Problema de teclado no funcional'),
(32, 'Pantalla con píxeles muertos'),
(116, 'Error de conexión de red'),
(65, 'Problema de altavoz silencioso'),
(21, 'Fallo en la tarjeta de sonido'),
(89, 'Pérdida de datos'),
(41, 'Problema de cámara frontal'),
(107, 'Error en la tarjeta SIM'),
(75, 'Dispositivo no enciende'),
(10, 'Fallo en el sistema de carga'),
(54, 'Problema de conexión HDMI'),
(93, 'Batería se descarga rápidamente'),
(48, 'Pantalla con colores distorsionados'),
(105, 'Error en el sistema de enfriamiento'),
(69, 'Problema de reconocimiento facial'),
(14, 'Fallo en el lector de tarjetas SD'),
(85, 'Problema de micrófono'),
(30, 'Pérdida de audio estéreo');
GO;

-- Modificar la tabla para permitir valores nulos en el campo fecha_fin
ALTER TABLE empleados_por_servicio_tecnico
ALTER COLUMN fecha_fin DATE NULL;
GO;

INSERT INTO empleados_por_servicio_tecnico (servicios_tecnicos_id, tecnicos_id, fecha_inicio, fecha_fin)
VALUES
(1, 15, '2018-06-12', '2019-12-31'),
(3, 40, '2012-03-25', '2013-07-10'),
(2, 9, '2014-09-18', '2016-05-02'),
(4, 25, '2011-11-05', '2012-09-30'),
(1, 50, '2016-08-15', '2018-02-28'),
(5, 3, '2017-04-20', '2020-10-15'),
(3, 36, '2010-07-28', '2011-09-14'),
(2, 11, '2013-09-02', '2014-06-30'),
(1, 18, '2012-01-10', '2014-08-20'),
(4, 33, '2015-05-14', '2017-11-30'),
(1, 44, '2013-12-01', NULL),
(5, 5, '2016-10-10', NULL),
(3, 23, '2012-09-05', NULL),
(2, 8, '2014-07-20', NULL),
(1, 12, '2015-08-18', NULL),
(4, 31, '2016-03-29', NULL),
(1, 48, '2018-04-02', NULL),
(5, 1, '2017-01-15', NULL),
(3, 21, '2013-06-08', NULL),
(2, 7, '2014-12-11', NULL),

(2, 27, '2014-05-10', '2015-11-30'),
(4, 54, '2012-07-18', '2014-03-15'),
(3, 19, '2013-09-22', '2015-06-30'),
(1, 30, '2016-12-05', '2018-08-20'),
(5, 14, '2017-10-21', '2019-05-31'),
(3, 43, '2015-03-17', '2016-11-25'),
(2, 26, '2011-06-08', '2012-12-31'),
(1, 37, '2018-09-14', '2020-04-30'),
(4, 55, '2013-04-01', '2014-11-15'),
(1, 29, '2015-07-20', '2017-02-28'),
(5, 16, '2016-04-12', NULL),
(3, 38, '2012-08-25', NULL),
(2, 24, '2014-11-30', NULL),
(1, 41, '2015-12-18', NULL),
(4, 58, '2016-02-02', NULL),
(1, 57, '2018-01-05', NULL),
(5, 20, '2017-03-15', NULL),
(3, 46, '2013-08-10', NULL),
(2, 28, '2014-06-20', NULL),
(1, 32, '2015-09-28', NULL),

(2, 35, '2017-06-12', '2018-12-31'),
(4, 49, '2015-03-25', '2016-07-10'),
(3, 13, '2013-09-18', '2015-05-02'),
(1, 26, '2014-11-05', '2016-09-30'),
(5, 42, '2016-08-15', '2018-02-28'),
(3, 51, '2017-04-20', '2020-10-15'),
(2, 16, '2010-07-28', '2011-09-14'),
(1, 22, '2013-09-02', '2014-06-30'),
(4, 39, '2012-01-10', '2014-08-20'),
(1, 56, '2015-05-14', '2017-11-30'),
(5, 10, '2013-12-01', NULL),
(3, 30, '2016-10-10', NULL),
(2, 19, '2012-09-05', NULL),
(1, 23, '2014-07-20', NULL),
(4, 45, '2015-08-18', NULL),
(1, 52, '2016-03-29', NULL),
(5, 11, '2018-04-02', NULL),
(3, 17, '2017-01-15', NULL),
(2, 21, '2013-06-08', NULL),

(4, 6, '2019-05-20', '2021-11-30'),
(1, 55, '2017-08-10', '2019-02-15'),
(5, 20, '2016-01-05', '2017-06-30'),
(3, 14, '2014-03-12', '2015-08-20'),
(2, 29, '2013-06-25', '2014-11-15'),
(4, 47, '2015-10-01', '2017-03-31'),
(1, 58, '2018-01-20', NULL),
(5, 2, '2017-03-10', NULL),
(3, 28, '2012-11-15', NULL),
(2, 6, '2014-05-20', NULL),
(1, 7, '2015-08-10', NULL),
(4, 15, '2016-01-05', NULL),
(1, 24, '2017-04-01', NULL),
(5, 9, '2018-06-15', NULL),
(3, 27, '2017-09-01', NULL),
(2, 5, '2016-11-10', NULL),
(1, 8, '2017-03-15', NULL),
(4, 16, '2018-05-01', NULL),
(1, 25, '2019-08-15', NULL),
(5, 12, '2020-11-01', NULL);
GO;

-- New Query
INSERT INTO envios(clientes_id, servicios_tecnicos_id, fecha_de_envio, hora_de_envio, empresa_de_envio)
VALUES
(5, 1, '2023-03-01', '09:00:00', 'Olva Courier'),
(28, 3, '2023-03-02', '10:30:00', 'FedEx'),
(12, 8, '2023-03-03', '14:15:00', 'DHL'),
(7, 4, '2023-03-04', '16:45:00', 'UPS'),
(65, 2, '2023-03-05', '12:00:00', 'Olva Courier'),
(43, 6, '2023-03-06', '17:30:00', 'FedEx'),
(90, 10, '2023-03-07', '08:45:00', 'DHL'),
(17, 5, '2023-03-08', '13:15:00', 'UPS'),
(32, 9, '2023-03-09', '11:30:00', 'Olva Courier'),
(80, 7, '2023-03-10', '18:00:00', 'FedEx'),
(15, 3, '2023-03-11', '09:30:00', 'DHL'),
(50, 2, '2023-03-12', '14:45:00', 'UPS'),
(3, 10, '2023-03-13', '10:15:00', 'Olva Courier'),
(45, 5, '2023-03-14', '16:30:00', 'FedEx'),
(85, 1, '2023-03-15', '08:30:00', 'DHL'),
(10, 6, '2023-03-16', '12:45:00', 'UPS'),
(75, 9, '2023-03-17', '15:00:00', 'Olva Courier'),
(22, 4, '2023-03-18', '11:00:00', 'FedEx'),
(60, 7, '2023-03-19', '19:30:00', 'DHL'),
(95, 8, '2023-03-20', '10:45:00', 'UPS'),
(14, 7, '2023-04-01', '08:30:00', 'DHL'),

(36, 5, '2023-04-02', '15:45:00', 'UPS'),
(88, 9, '2023-04-03', '11:15:00', 'Olva Courier'),
(52, 3, '2023-04-04', '16:00:00', 'FedEx'),
(19, 6, '2023-04-05', '09:45:00', 'DHL'),
(68, 1, '2023-04-06', '14:30:00', 'Olva Courier'),
(25, 2, '2023-04-07', '17:00:00', 'FedEx'),
(72, 8, '2023-04-08', '10:30:00', 'UPS'),
(9, 4, '2023-04-09', '13:45:00', 'DHL'),
(42, 10, '2023-04-10', '18:30:00', 'Olva Courier'),
(78, 5, '2023-04-11', '08:00:00', 'FedEx'),
(23, 3, '2023-04-12', '12:15:00', 'UPS'),
(59, 7, '2023-04-13', '16:45:00', 'DHL'),
(97, 6, '2023-04-14', '09:30:00', 'Olva Courier'),
(32, 1, '2023-04-15', '14:00:00', 'FedEx'),
(66, 4, '2023-04-16', '17:30:00', 'UPS'),
(11, 8, '2023-04-17', '10:00:00', 'DHL'),
(47, 2, '2023-04-18', '13:15:00', 'Olva Courier'),
(83, 10, '2023-04-19', '19:00:00', 'FedEx'),
(27, 9, '2023-04-20', '08:45:00', 'UPS');

INSERT INTO marcas (descripcion)
VALUES
('Samsung'),
('Apple'),
('Huawei'),
('Xiaomi'),
('Sony'),
('LG'),
('Lenovo'),
('Microsoft'),
('HP'),
('Dell'),
('Bose'),
('JBL'),
('Panasonic'),
('Sony'),
('Philips'),
('Nintendo'),
('LG'),

('Motorola'),
('Asus'),
('Acer'),
('Bose'),
('Beats'),
('Sharp'),
('Toshiba'),
('IBM'),
('Google'),
('Amazon'),
('Hisense'),
('Philips'),
('OnePlus'),
('Razer'),
('Vizio'),
('Pioneer'),
('Nokia'),
('TCL'),
('Alienware'),
('Logitech');

INSERT INTO modelos (marcas_id, descripcion)
VALUES
(1, 'Galaxy S10 Plus'),
(2, 'iPhone 12 Pro'),
(3, 'MateBook D14'),
(4, 'Mi 9T'),
(5, 'Xperia 5 II'),
(6, 'Gram 14Z90P'),
(7, 'Legion 5 Pro'),
(8, 'Surface Pro 7'),
(9, 'Pavilion 15'),
(10, 'Inspiron 15'),
(11, 'QuietComfort 35 II'),
(12, 'TUNE 500BT'),
(13, 'Viera GX800'),
(14, 'PlayStation 5'),
(15, '55OLED854/12'),
(16, 'Nintendo Switch'),
(17, 'Xbox Series X'),
(18, 'Galaxy A52'),
(19, 'OLED C1'),
(20, 'Alienware M15 R4'),

(1, 'Galaxy Note 20 Ultra'),
(2, 'iPhone 13 Pro Max'),
(3, 'MateBook X Pro'),
(4, 'Redmi Note 10 Pro'),
(5, 'BRAVIA XR A90J'),
(1, 'Galaxy Tab S7'),
(6, 'Gram 17Z90P'),
(7, 'Legion 7i'),
(2, 'MacBook Pro M1'),
(8, 'Surface Laptop 4'),
(9, 'EliteBook 840 G8'),
(10, 'XPS 13'),
(11, 'SoundLink Revolve+'),
(3, 'FreeBuds Pro'),
(12, 'PartyBox 310'),
(13, 'EZ950'),
(14, 'PlayStation 5 Digital Edition'),
(1, 'Galaxy Watch 4'),
(5, 'BRAVIA XR A80J'),
(6, 'OLED GX'),

(9, 'Elite Dragonfly G2'),
(10, 'Latitude 14'),
(12, 'SoundLink Micro'),
(14, 'WH-1000XM4'),
(16, 'Switch OLED'),
(5, 'BRAVIA XR X90J'),
(3, 'MateBook 14'),
(17, 'Xbox Series S'),
(6, 'C1 Gallery OLED Evo'),
(4, 'Poco X3 Pro'),
(15, 'Ambilight 65OLED935/12'),
(7, 'ThinkPad X1 Carbon'),
(8, 'Surface Book 3'),
(11, 'QuietComfort Earbuds'),
(18, 'Galaxy Tab A7'),
(2, 'iPad Pro'),
(1, 'Galaxy Watch 4 Classic'),
(13, 'LUMIX GH5'),
(19, 'C1 Series QLED'),
(20, 'G502 Hero'),

(21, 'Moto G Power'),
(22, 'ROG Phone 5'),
(23, 'Predator Helios 300'),
(24, 'QuietComfort 35 II'),
(25, 'Studio3 Wireless'),
(26, 'Aquos R3'),
(27, 'Satellite C55'),
(28, 'ThinkPad T14'),
(29, 'Pixel 6 Pro'),
(30, 'Kindle Paperwhite'),
(31, 'H9G Quantum'),
(32, 'PicoPix Max One'),
(33, 'OnePlus 9 Pro'),
(34, 'Razer Blade 15'),
(35, 'M-Series Quantum'),
(36, 'VSX-LX104'),
(37, 'Nokia 8.3 5G'),
(35, 'C715 QLED'),
(36, 'Alienware Aurora R10'),
(37, 'G Pro X'),

(21, 'Moto G Stylus'),
(22, 'ROG Zephyrus G14'),
(23, 'Swift 3'),
(24, 'Sport Earbuds'),
(25, 'Powerbeats Pro'),
(26, 'AQUOS R5G'),
(27, 'Satellite Pro C50'),
(28, 'ThinkCentre M720q'),
(29, 'Pixel Buds A-Series'),
(30, 'Fire HD 10'),
(31, 'U8G Quantum'),
(32, 'C715 4K QLED'),
(33, 'OnePlus 9'),
(34, 'Blade Stealth 13'),
(35, 'OLED65-H1'),
(36, 'VSX-534'),
(37, 'Nokia 5.4'),
(35, 'C825 Mini LED 8K'),
(36, 'Alienware AW2521H'),
(37, 'MX Keys Plus');

-- DELETE FROM modelos
-- WHERE id IN (SELECT id
--             FROM modelos);

-- DBCC CHECKIDENT ('modelos', RESEED, 0);
SELECT COUNT(*)
FROM equipos;

INSERT INTO equipos(dispositivos_id, modelos_id, clientes_id, gamas_id, esta_reportado)
VALUES
-- Celulares
(1, 1, 1, 1, 0),
(1, 2, 2, 1, 0),
(1, 4, 3, 2, 1),
(1, 18, 4, 1, 0),
(1, 21, 5, 2, 0),
(1, 22, 6, 2, 0),
-- Laptops
(2, 3, 7, 3, 0),
(2, 6, 8, 3, 0),
(2, 7, 9, 3, 0),
(2, 9, 10, 3, 0),
(2, 10, 11, 3, 0),
(2, 23, 12, 3, 0),
-- PCs
(3, 10, 13, 2, 0),
(3, 30, 14, 2, 0),
(3, 32, 15, 2, 0),
-- Tablets
(4, 26, 16, 2, 0),
(4, 28, 17, 2, 0),
(4, 31, 18, 2, 0),
-- Smartwatches
(5, 38, 19, 1, 0),
(5, 57, 20, 1, 0),

-- Televisores
(6, 13, 21, 1, 0),
(6, 39, 22, 1, 0),

-- Consolas de videojuegos
(7, 14, 23, 2, 0),
(7, 17, 24, 2, 0),
(7, 37, 25, 2, 0),
(7, 45, 26, 2, 0),

-- Cámaras digitales
(8, 48, 27, 1, 0),

-- Auriculares inalámbricos
(9, 11, 29, 1, 0),
(9, 34, 30, 1, 0),

-- Altavoces Bluetooth
(10, 35, 32, 1, 0),
(10, 50, 33, 1, 0);

INSERT INTO estados_de_reparacion (reparaciones_id, descripcion, fecha)
VALUES
(1, 'Completado', '2023-02-15'),
(2, 'En proceso', '2023-03-10'),
(3, 'En proceso', '2023-06-22'),
(4, 'Pausado', '2023-01-05'),
(5, 'En espera', '2023-04-18'),
(6, 'Completado', '2023-02-27'),
(7, 'Completado', '2023-05-03'),
(8, 'Pausado', '2023-06-12'),
(9, 'En proceso', '2023-01-20'),
(10, 'Completado', '2023-07-07'),
(11, 'En proceso', '2023-03-08'),
(12, 'En espera', '2023-04-30'),
(13, 'Completado', '2023-06-10'),
(14, 'Pausado', '2023-01-25'),
(15, 'En proceso', '2023-05-15'),
(16, 'Completado', '2023-07-02'),
(17, 'En proceso', '2023-02-05'),
(18, 'En espera', '2023-03-28'),
(19, 'Pausado', '2023-06-18'),
(20, 'Completado', '2023-04-12'),

(6, 'En proceso', '2023-02-16'),
(10, 'En proceso', '2023-03-11'),
(23, 'En proceso', '2023-06-23'),
(65, 'Pausado', '2023-01-06'),
(55, 'En espera', '2023-04-19'),
(76, 'En proceso', '2023-02-28'),
(99, 'Completado', '2023-05-04'),
(112, 'Pausado', '2023-06-13'),
(86, 'En proceso', '2023-01-21'),
(112, 'En proceso', '2023-07-08'),
(18, 'En proceso', '2023-03-29'),
(30, 'En espera', '2023-04-25'),
(45, 'Completado', '2023-06-11'),
(62, 'Pausado', '2023-01-26'),
(79, 'En proceso', '2023-05-16'),
(102, 'Completado', '2023-07-03'),
(17, 'En proceso', '2023-02-06'),
(32, 'En espera', '2023-03-30'),
(48, 'Pausado', '2023-06-19'),
(75, 'Completado', '2023-04-13'),

(21, 'En proceso', '2023-02-16'),
(28, 'En espera', '2023-03-11'),
(34, 'En proceso', '2023-06-23'),
(44, 'Pausado', '2023-01-06'),
(57, 'En espera', '2023-04-19'),
(68, 'En proceso', '2023-02-28'),
(85, 'Completado', '2023-05-04'),
(91, 'Pausado', '2023-06-13'),
(98, 'En proceso', '2023-01-21'),
(104, 'En proceso', '2023-07-08'),
(19, 'En proceso', '2023-03-28'),
(27, 'En espera', '2023-04-25'),
(39, 'Completado', '2023-06-10'),
(50, 'Pausado', '2023-01-25'),
(71, 'En proceso', '2023-05-15'),
(80, 'Completado', '2023-07-02'),
(15, 'En proceso', '2023-02-05'),
(33, 'En espera', '2023-03-30'),
(46, 'Pausado', '2023-06-18'),
(78, 'Completado', '2023-04-12');

INSERT INTO horarios (servicios_tecnicos_id, fecha, hora_apertura, hora_cierre)
VALUES
(1, '2023-01-02', '09:00', '19:00'),
(2, '2023-01-03', '09:30', '18:30'),
(3, '2023-01-04', '10:00', '19:00'),
(4, '2023-01-05', '09:00', '17:30'),
(5, '2023-01-06', '10:30', '18:30'),
(6, '2023-01-07', '09:00', '14:00'),
(7, '2023-01-09', '09:30', '19:00'),
(8, '2023-01-10', '09:00', '18:00'),
(9, '2023-01-11', '09:00', '19:00'),
(10, '2023-01-12', '09:30', '17:30'),
(1, '2023-01-16', '09:00', '19:00'),
(2, '2023-01-17', '09:30', '18:30'),
(3, '2023-01-18', '10:00', '19:00'),
(4, '2023-01-19', '09:00', '17:30'),
(5, '2023-01-20', '10:30', '18:30'),
(6, '2023-01-21', '09:00', '14:00'),
(7, '2023-01-23', '09:30', '19:00'),
(8, '2023-01-24', '09:00', '18:00'),
(9, '2023-01-25', '09:00', '19:00'),
(10, '2023-01-26', '09:30', '17:30'),

(3, '2023-01-02', '09:00', '19:00'),
(7, '2023-01-03', '09:30', '18:30'),
(9, '2023-01-04', '10:00', '19:00'),
(5, '2023-01-05', '09:00', '17:30'),
(8, '2023-01-06', '10:30', '18:30'),
(2, '2023-01-07', '09:00', '14:00'),
(10, '2023-01-09', '09:30', '19:00'),
(4, '2023-01-10', '09:00', '18:00'),
(1, '2023-01-11', '09:00', '19:00'),
(6, '2023-01-12', '09:30', '17:30'),
(3, '2023-01-16', '09:00', '19:00'),
(7, '2023-01-17', '09:30', '18:30'),
(9, '2023-01-18', '10:00', '19:00'),
(5, '2023-01-19', '09:00', '17:30'),
(8, '2023-01-20', '10:30', '18:30'),
(2, '2023-01-21', '09:00', '14:00'),
(10, '2023-01-23', '09:30', '19:00'),
(4, '2023-01-24', '09:00', '18:00'),
(1, '2023-01-25', '09:00', '19:00'),
(6, '2023-01-26', '09:30', '17:30'),
(3, '2023-01-28', '10:00', '18:00'),
(7, '2023-01-29', '09:30', '19:00'),
(9, '2023-01-30', '09:00', '18:30'),
(5, '2023-01-31', '10:00', '19:00'),
(8, '2023-02-01', '09:00', '17:30'),
(2, '2023-02-02', '10:30', '18:30'),
(10, '2023-02-04', '09:00', '14:00'),
(4, '2023-02-05', '09:30', '19:00'),
(1, '2023-02-06', '09:00', '18:00'),
(6, '2023-02-07', '09:00', '19:00');

INSERT INTO reclamos (clientes_id, servicios_tecnicos_id, descripcion)
VALUES
(58, 5, 'Sobrecosto injustificado en el servicio técnico.'),
(79, 8, 'Piezas falsas utilizadas en la reparación.'),
(12, 4, 'Retraso en la entrega del servicio técnico.'),
(93, 1, 'Cobro excesivo por la reparación.'),
(27, 9, 'Reparación inadecuada realizada.'),
(36, 3, 'Incapacidad del técnico para resolver el problema.'),
(65, 6, 'Maltrato y falta de profesionalismo del servicio técnico.'),
(45, 10, 'Falta de garantía en la reparación realizada.'),
(21, 7, 'Cobro por servicios no realizados.'),
(82, 2, 'Información engañosa sobre los costos de reparación.'),
(43, 5, 'Falta de solución al problema de mi dispositivo.'),
(74, 9, 'Sobrecargo sin justificación por parte del servicio técnico.'),
(31, 1, 'Daño adicional a mi equipo durante la reparación.'),
(67, 3, 'Falta de comunicación sobre el estado de la reparación.'),
(15, 8, 'Pérdida de una parte importante de mi dispositivo.'),
(52, 4, 'Incumplimiento del plazo de entrega acordado.'),
(88, 10, 'Cobro adicional sin explicación clara.'),
(39, 7, 'Realización de reparaciones innecesarias y cobro injustificado.'),
(61, 2, 'Daño a mi equipo durante la reparación.'),
(76, 6, 'Falta de transparencia en los costos de reparación.'),
(30, 3, 'Incompetencia del técnico para resolver el problema.'),
(55, 5, 'Incumplimiento del plazo de entrega acordado para la reparación.'),
(87, 9, 'Cobro excesivo sin justificación válida.'),
(41, 1, 'Reparación inadecuada y pérdida de datos.'),
(73, 8, 'Mal manejo de mi dispositivo durante la reparación.'),
(19, 10, 'Cobro por servicios no autorizados.'),
(64, 7, 'Negligencia del técnico en la reparación de mi dispositivo.'),
(34, 4, 'Falta de garantía en el servicio técnico.'),
(95, 2, 'Demora injustificada en la entrega de mi equipo reparado.'),
(48, 6, 'Falta de transparencia en los costos de reparación y sobrecargos adicionales.');

INSERT INTO reparaciones_por_equipos (fecha_de_reparacion, reparaciones_id, equipos_dispositivos_id, equipos_modelos_id)
VALUES
('2023-05-31', 1, 1, 1),
('2023-05-31', 2, 1, 2),
('2023-05-31', 3, 2, 3),
('2023-05-31', 4, 2, 6),
('2023-05-31', 5, 3, 10);

INSERT INTO sedes (servicios_tecnicos_id, calle, numero_calle, codigo_postal, ciudad, pais)
VALUES
(1, 'Calle A', 123, 12345, 'Buenos Aires', 'Argentina'),
(3, 'Calle B', 456, 23456, 'São Paulo', 'Brasil'),
(4, 'Calle C', 789, 34567, 'Bogotá', 'Colombia'),
(6, 'Calle D', 987, 45678, 'Ciudad de México', 'México'),
(7, 'Calle E', 654, 56789, 'Lima', 'Perú'),
(8, 'Calle F', 321, 67890, 'Santiago', 'Chile'),
(2, 'Calle G', 654, 78901, 'Montevideo', 'Uruguay'),
(10, 'Calle H', 987, 89012, 'Quito', 'Ecuador'),
(5, 'Calle I', 246, 90123, 'Caracas', 'Venezuela'),
(9, 'Calle J', 135, 01234, 'Lisboa', 'Portugal'),
(1, 'Calle K', 864, 12345, 'Medellín', 'Colombia'),
(3, 'Calle L', 753, 23456, 'Guadalajara', 'México'),
(4, 'Calle M', 582, 34567, 'Barranquilla', 'Colombia'),
(6, 'Calle N', 291, 45678, 'Porto Alegre', 'Brasil'),
(8, 'Calle O', 746, 56789, 'Valparaíso', 'Chile'),
(2, 'Calle P', 139, 67890, 'Punta del Este', 'Uruguay'),
(7, 'Calle Q', 258, 78901, 'Arequipa', 'Perú'),
(10, 'Calle R', 673, 89012, 'Guayaquil', 'Ecuador'),
(5, 'Calle S', 982, 90123, 'Maracaibo', 'Venezuela'),
(9, 'Calle T', 317, 01234, 'Coimbra', 'Portugal'),
(1, 'Calle U', 234, 12345, 'Santiago de Cali', 'Colombia'),
(3, 'Calle V', 567, 23456, 'Santo Domingo', 'República Dominicana'),
(4, 'Calle W', 890, 34567, 'San José', 'Costa Rica'),
(6, 'Calle X', 432, 45678, 'La Paz', 'Bolivia'),
(7, 'Calle Y', 765, 56789, 'Asunción', 'Paraguay'),
(8, 'Calle Z', 987, 67890, 'La Habana', 'Cuba'),
(2, 'Calle AA', 654, 78901, 'Cartagena', 'Colombia'),
(10, 'Calle BB', 321, 89012, 'Panamá', 'Panamá'),
(5, 'Calle CC', 876, 90123, 'Quetzaltenango', 'Guatemala'),
(9, 'Calle DD', 543, 01234, 'San Juan', 'Puerto Rico'),
(1, 'Calle EE', 890, 12345, 'La Serena', 'Chile'),
(3, 'Calle FF', 321, 23456, 'Barquisimeto', 'Venezuela'),
(4, 'Calle GG', 654, 34567, 'Cochabamba', 'Bolivia'),
(6, 'Calle HH', 987, 45678, 'Belo Horizonte', 'Brasil'),
(8, 'Calle II', 654, 56789, 'Valdivia', 'Chile'),
(2, 'Calle JJ', 321, 67890, 'Buenaventura', 'Colombia'),
(7, 'Calle KK', 654, 78901, 'Cusco', 'Perú'),
(10, 'Calle LL', 987, 89012, 'San Salvador', 'El Salvador'),
(5, 'Calle MM', 246, 90123, 'Tegucigalpa', 'Honduras'),
(9, 'Calle NN', 135, 01234, 'Querétaro', 'México');





