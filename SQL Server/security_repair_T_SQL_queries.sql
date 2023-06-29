use security_repair;

-- ¿Cuál ha sido el servicio técnico con mayor puntaje promedio?

CREATE VIEW v_puntaje_promedio_por_servicio_tecnico AS
SELECT st.nombre servicio_tecnico, ROUND(AVG(puntaje), 2) puntaje_promedio
FROM calificaciones c
JOIN servicios_tecnicos st
ON c.servicios_tecnicos_id = st.id
GROUP BY st.nombre;

-- Mayor puntaje
SELECT MAX(puntaje_promedio)
FROM v_puntaje_promedio_por_servicio_tecnico;

SELECT servicio_tecnico, puntaje_promedio puntaje_mayor
FROM v_puntaje_promedio_por_servicio_tecnico
WHERE puntaje_promedio = (SELECT MAX(puntaje_promedio)
                          FROM v_puntaje_promedio_por_servicio_tecnico);
GO

CREATE FUNCTION f_servicio_tecnico_con_mayor_puntaje_promedio ()
RETURNS TABLE
RETURN
    SELECT servicio_tecnico, puntaje_promedio puntaje_mayor
    FROM v_puntaje_promedio_por_servicio_tecnico
    WHERE puntaje_promedio = (SELECT MAX(puntaje_promedio)
                              FROM v_puntaje_promedio_por_servicio_tecnico)
GO

SELECT *
FROM f_servicio_tecnico_con_mayor_puntaje_promedio ();

-- ¿Cuál ha sido el servicio técnico con menor puntaje promedio?

-- Menor puntaje
SELECT MIN(puntaje_promedio)
FROM v_puntaje_promedio_por_servicio_tecnico;

SELECT servicio_tecnico, puntaje_promedio puntaje_menor
FROM v_puntaje_promedio_por_servicio_tecnico
WHERE puntaje_promedio = (SELECT MIN(puntaje_promedio)
                          FROM v_puntaje_promedio_por_servicio_tecnico);

CREATE FUNCTION f_servicio_tecnico_con_menor_puntaje_promedio ()
RETURNS TABLE
RETURN
    SELECT servicio_tecnico, puntaje_promedio puntaje_menor
    FROM v_puntaje_promedio_por_servicio_tecnico
    WHERE puntaje_promedio = (SELECT MIN(puntaje_promedio)
                              FROM v_puntaje_promedio_por_servicio_tecnico)
GO

SELECT *
FROM f_servicio_tecnico_con_menor_puntaje_promedio();

-- -------------------------------------------------------------------------------
-- ¿Cuántos dispositivos han sido reparados por un servicio técnico específico?

SELECT st.nombre servicio_tecnico, COUNT(*) quantity
FROM reparaciones r
JOIN servicios_tecnicos st
ON r.servicios_tecnicos_id = st.id
WHERE st.nombre = 'ElectroLab'
GROUP BY  st.nombre;

CREATE FUNCTION f_dispositivos_reparados_por_un_servicio_tecnico (@nombre VARCHAR(100))
RETURNS TABLE
RETURN
    SELECT st.nombre servicio_tecnico, COUNT(*) quantity
    FROM reparaciones r
    JOIN servicios_tecnicos st
    ON r.servicios_tecnicos_id = st.id
    WHERE st.nombre = @nombre
    GROUP BY  st.nombre;

SELECT *
FROM f_dispositivos_reparados_por_un_servicio_tecnico ('ElectroLab')



-- ¿Cuántas reparaciones están en estado completado de un servicio tecnico específico?

SELECT st.nombre servicio_tecnico, e.descripcion estado, COUNT(*) quantity
FROM estados_de_reparacion e
JOIN reparaciones r
ON e.reparaciones_id = r.id
JOIN servicios_tecnicos st
ON r.servicios_tecnicos_id = st.id
WHERE r.servicios_tecnicos_id = 3
      AND e.descripcion = 'Completado'
GROUP BY st.nombre, e.descripcion;


CREATE PROCEDURE usp_cantidad_reparaciones_completado
@estado VARCHAR(100),
@servicio_tecnico VARCHAR(100)
AS
BEGIN
    SELECT st.nombre servicio_tecnico, e.descripcion estado, COUNT(*) quantity
    FROM estados_de_reparacion e
    JOIN reparaciones r
    ON e.reparaciones_id = r.id
    JOIN servicios_tecnicos st
    ON r.servicios_tecnicos_id = st.id
    WHERE st.nombre = @servicio_tecnico
          AND e.descripcion = @estado
    GROUP BY st.nombre, e.descripcion;
END;
GO

EXEC usp_cantidad_reparaciones_completado 'Completado', 'ElectroLab'



-- ¿Cuál es el horario de atención de un servicio técnico en particular para un día y mes específico?

SELECT st.nombre servicio_tecnico, h.hora_apertura, h.hora_cierre
FROM horarios h
JOIN servicios_tecnicos st
ON h.servicios_tecnicos_id = st.id
WHERE servicios_tecnicos_id = 9
      AND fecha = '2023-01-30';

CREATE PROCEDURE usp_horario_de_atencion_de_un_servicio_tecnico
@servicio_tecnico VARCHAR(100),
@fecha DATE
AS
BEGIN
    SELECT st.nombre servicio_tecnico, h.hora_apertura, h.hora_cierre
    FROM horarios h
    JOIN servicios_tecnicos st
    ON h.servicios_tecnicos_id = st.id
    WHERE st.nombre = @servicio_tecnico
          AND fecha = @fecha;
END;
GO

EXEC usp_horario_de_atencion_de_un_servicio_tecnico 'iFix', '2023-01-30'
GO



-- Obtener el número total de reparaciones con urgencia 5 completadas por un servicio técnico en particular.

SELECT TOP(50) *
FROM reparaciones;

SELECT nombre
FROM servicios_tecnicos
GO

-- MegaTech
-- TechSupport
-- SmartFix
-- GlobalTech
-- iRepair
-- TechMaster
-- ElectroLab
-- TechGenius
-- iFix
-- GadgetFix

SELECT *
FROM estados_de_reparacion;
GO

SELECT st.nombre, COUNT(*) quantity
FROM servicios_tecnicos st
JOIN reparaciones r
ON st.id = r.servicios_tecnicos_id
JOIN estados_de_reparacion edr
ON r.id = edr.reparaciones_id
WHERE r.urgencia = 5
      AND edr.descripcion = 'Completado'
      AND st.nombre = 'TechMaster'
GROUP BY st.nombre;
GO


CREATE FUNCTION f_total_de_reparaciones_por_urgencia (@urgencia INT, @estado VARCHAR(100), @servicio_tecnico VARCHAR(100))
RETURNS TABLE
RETURN
    SELECT st.nombre, COUNT(*) quantity
    FROM servicios_tecnicos st
    JOIN reparaciones r
    ON st.id = r.servicios_tecnicos_id
    JOIN estados_de_reparacion edr
    ON r.id = edr.reparaciones_id
    WHERE r.urgencia = @urgencia
          AND edr.descripcion = @estado
          AND st.nombre = @servicio_tecnico
    GROUP BY st.nombre;
GO

SELECT *
FROM f_total_de_reparaciones_por_urgencia(5, 'Completado', 'TechMaster');



-- Obtener la duración (horas) promedio de las reparaciones realizadas por un técnico específico.
SELECT TOP(50) *
FROM reparaciones;

SELECT st.nombre, AVG(tiempo_estimado) quantity
FROM servicios_tecnicos st
JOIN reparaciones r
ON st.id = r.servicios_tecnicos_id
WHERE st.nombre = 'iFix'
GROUP BY st.nombre;

CREATE FUNCTION f_promedio_de_horas_de_reparacion (@nombre VARCHAR(100))
RETURNS INT
BEGIN
    DECLARE @quantity INT

    SELECT @quantity = AVG(tiempo_estimado)
    FROM servicios_tecnicos st
    JOIN reparaciones r
    ON st.id = r.servicios_tecnicos_id
    WHERE st.nombre = @nombre
    GROUP BY st.nombre;

    RETURN @quantity
END;
GO


PRINT (CONCAT('Cantidad de horas: ', dbo.f_promedio_de_horas_de_reparacion('iFix')));


-- Obtener la lista de clientes que han dejado una calificación baja para un servicio técnico en particular.

-- Calificación baja: < 2.0
SELECT *
FROM calificaciones;

SELECT cl.nombre + ' ' + cl.apellido_paterno + ' ' + cl.apellido_materno fullname, c.descripcion
FROM servicios_tecnicos st
JOIN calificaciones c
ON st.id = c.servicios_tecnicos_id
JOIN clientes cl
ON c.clientes_id = cl.id
WHERE st.nombre = 'SmartFix'
      AND c.puntaje <= 2.0;
GO

-- Aplicación de cursores

CREATE PROCEDURE usp_lista_de_clientes_con_calificacion_baja
@nombre_servicio_tecnico VARCHAR(100)
AS
BEGIN
    DECLARE @nombre_cliente VARCHAR(100),
    @primer_apellido VARCHAR(100),
    @segundo_apellido VARCHAR(100),
    @descripcion VARCHAR(255)

    DECLARE cursor_calificaciones CURSOR
    FOR
    SELECT cl.nombre, cl.apellido_paterno, cl.apellido_materno, c.descripcion
    FROM servicios_tecnicos st
    JOIN calificaciones c
    ON st.id = c.servicios_tecnicos_id
    JOIN clientes cl
    ON c.clientes_id = cl.id
    WHERE st.nombre = @nombre_servicio_tecnico
          AND c.puntaje <= 2.0

    OPEN cursor_calificaciones;

    FETCH cursor_calificaciones INTO
    @nombre_cliente, @primer_apellido, @segundo_apellido, @descripcion;

    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        PRINT(CONCAT('Fullname: ', @nombre_cliente, ' ', @primer_apellido, ' ', @segundo_apellido, '     Description: ', @descripcion))

        FETCH cursor_calificaciones INTO
        @nombre_cliente, @primer_apellido, @segundo_apellido, @descripcion;
    END;

    CLOSE cursor_calificaciones
    DEALLOCATE cursor_calificaciones
END;

EXEC usp_lista_de_clientes_con_calificacion_baja 'GadgetFix'


-- Obtener el número de reparaciones realizadas para cada modelo de dispositivo en un rango de fechas específico.

SELECT *
FROM reparaciones_por_equipos;


SELECT m.descripcion, COUNT(*) quantity
FROM reparaciones_por_equipos
JOIN equipos e
ON reparaciones_por_equipos.equipos_dispositivos_id = e.dispositivos_id
   AND reparaciones_por_equipos.equipos_modelos_id = e.modelos_id
JOIN modelos m
ON e.modelos_id = m.id
JOIN dispositivos d
ON e.dispositivos_id = d.id
WHERE fecha_de_reparacion BETWEEN '2023-05-31' AND  '2023-07-31'
GROUP BY m.descripcion;

CREATE PROCEDURE usp_cantidad_de_reparaciones_por_modelo_en_rango_de_fechas
@fecha_inicio DATE,
@fecha_fin DATE
AS
BEGIN
    SELECT m.descripcion, COUNT(*) quantity
    FROM reparaciones_por_equipos
    JOIN equipos e
    ON reparaciones_por_equipos.equipos_dispositivos_id = e.dispositivos_id
       AND reparaciones_por_equipos.equipos_modelos_id = e.modelos_id
    JOIN modelos m
    ON e.modelos_id = m.id
    JOIN dispositivos d
    ON e.dispositivos_id = d.id
    WHERE fecha_de_reparacion BETWEEN @fecha_inicio AND  @fecha_fin
    GROUP BY m.descripcion;
END;

EXEC usp_cantidad_de_reparaciones_por_modelo_en_rango_de_fechas '2023-05-31', '2023-07-31';



-- Obtener el número total de reparaciones realizadas por cada servicio técnico en un mes específico.


CREATE FUNCTION f_reparaciones_realizadas_por_mes (@mes INT)
RETURNS TABLE
RETURN
    SELECT s.nombre, COUNT (*) quantity
    FROM reparaciones_por_equipos rpe
    JOIN reparaciones r2
    ON rpe.reparaciones_id = r2.id
    JOIN servicios_tecnicos s
    ON r2.servicios_tecnicos_id = s.id
    WHERE MONTH(fecha_de_reparacion) = @mes
    GROUP BY s.nombre
GO

SELECT *
FROM dbo.f_reparaciones_realizadas_por_mes(5);
