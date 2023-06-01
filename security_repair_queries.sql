-- ¿Cuántos clientes y técnicos se han registrado en la base de datos?

SELECT COUNT(*) total_clientes
FROM clientes;

SELECT COUNT(*) total_tecnicos
FROM tecnicos;

-- Listar a los servicios técnicos (nombre) y el nombre de las ciudades y el país en el cual se encuentran

SELECT st.nombre nombre_servicio_tecnico,s.pais, s.ciudad ciudad
FROM servicios_tecnicos st
JOIN sedes s
ON st.id = s.servicios_tecnicos_id
GROUP BY st.nombre, s.pais, s.ciudad;

-- Listar los servicios técnicos que tienen una sede en un país específico.
SELECT servicios_tecnicos_id, st.nombre, COUNT(*) quantity
FROM sedes s
JOIN servicios_tecnicos st
ON s.servicios_tecnicos_id = st.id
WHERE pais = 'Perú'
GROUP BY servicios_tecnicos_id, st.nombre;

-- ¿Cuál es el tiempo estimado(horas) promedio de reparación para todas las reparaciones realizadas en mayo de 2023?
SELECT *
FROM reparaciones;

SELECT *
FROM reparaciones_por_equipos
WHERE YEAR(fecha_de_reparacion) = 2023 AND MONTH(fecha_de_reparacion) = 5;

SELECT AVG(tiempo_estimado) promedio
FROM reparaciones r
JOIN reparaciones_por_equipos rpe
ON r.id = rpe.reparaciones_id
WHERE rpe.reparaciones_id IN (SELECT reparaciones_id
                             FROM reparaciones_por_equipos
                             WHERE YEAR(fecha_de_reparacion) = 2023
                                   AND MONTH(fecha_de_reparacion) = 5);

--  ¿Cuál es el promedio de puntaje de calificaciones recibidas por cada servicio técnico?
SELECT st.nombre servicio_tecnico, ROUND(AVG(puntaje), 2) puntaje_promedio
FROM calificaciones c
JOIN servicios_tecnicos st
ON c.servicios_tecnicos_id = st.id
GROUP BY st.nombre;

-- ¿Cuál ha sido el servicio técnico con mayor y menor puntaje promedio?

CREATE VIEW v_puntaje_promedio_por_servicio_tecnico AS
SELECT st.nombre servicio_tecnico, ROUND(AVG(puntaje), 2) puntaje_promedio
FROM calificaciones c
JOIN servicios_tecnicos st
ON c.servicios_tecnicos_id = st.id
GROUP BY st.nombre;

-- Mayor puntaje
SELECT MAX(puntaje_promedio)
FROM v_puntaje_promedio_por_servicio_tecnico;

-- Menor puntaje
SELECT MIN(puntaje_promedio)
FROM v_puntaje_promedio_por_servicio_tecnico;

SELECT servicio_tecnico, puntaje_promedio puntaje_mayor
FROM v_puntaje_promedio_por_servicio_tecnico
WHERE puntaje_promedio = (SELECT MAX(puntaje_promedio)
                          FROM v_puntaje_promedio_por_servicio_tecnico);

SELECT servicio_tecnico, puntaje_promedio puntaje_menor
FROM v_puntaje_promedio_por_servicio_tecnico
WHERE puntaje_promedio = (SELECT MIN(puntaje_promedio)
                          FROM v_puntaje_promedio_por_servicio_tecnico);

--NEW QUERIES
--  ¿Cuántos dispositivos han sido reparados por un servicio técnico específico?
SELECT st.nombre servicio_tecnico, COUNT(*) quantity
FROM reparaciones r
JOIN servicios_tecnicos st
ON r.servicios_tecnicos_id = st.id
WHERE st.nombre = 'ElectroLab'
GROUP BY  st.nombre;

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

-- ¿Cuál es el promedio de precio de las reparaciones por cada servicio técnico?
SELECT st.nombre, ROUND(AVG(precio), 4) promedio
FROM reparaciones r
JOIN servicios_tecnicos st
ON r.servicios_tecnicos_id = st.id
GROUP BY st.nombre;

-- ¿Cuál es el horario de atención de un servicio técnico en particular para un día y mes específico?

SELECT st.nombre servicio_tecnico, h.hora_apertura, h.hora_cierre
FROM horarios h
JOIN servicios_tecnicos st
ON h.servicios_tecnicos_id = st.id
WHERE servicios_tecnicos_id = 9
      AND fecha = '2023-01-30';