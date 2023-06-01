# Security Repair Database

**Descripción** 

- Este repositorio contiene la implementación de una base de datos relacional diseñada para gestionar los servicios técnicos de reparación de dispositivos electrónicos, como celulares, computadoras, televisores y consolas de videojuegos. El objetivo principal de esta base de datos es proporcionar una mejor organización en las reparaciones, agilizar la comunicación con los clientes y facilitar la gestión de envíos internacionales hacia otros servicios de reparación fuera del país o la ciudad.

**Modelo físico de datos**
[![Logical-Data-Model-Security-Repair.png](https://i.postimg.cc/kM8Drh7P/Logical-Data-Model-Security-Repair.png)](https://postimg.cc/mhLTCjcm)

**Identificación de los principales Bounded Context**
[![Bounded-Context.jpg](https://i.postimg.cc/vZSGxWGv/Bounded-Context.jpg)](https://postimg.cc/ZW3G1vB9)

**Características Principales** 
- La base de datos ha sido desarrollada utilizando el IDE DataGrip, un entorno de desarrollo integrado (IDE) especializado en la administración de bases de datos relacionales. Las principales características de esta base de datos incluyen:

**Tablas y Sentencias DDL:**  Se han creado diversas tablas para almacenar información relevante, como clientes, servicios técnicos, equipos, etc. Estas tablas se han definido utilizando sentencias DDL (Data Definition Language) para especificar la estructura y las restricciones de los datos almacenados.

**Queries con Subqueries:**  Se han implementado consultas que involucran subqueries para realizar operaciones más complejas y obtener información detallada sobre los servicios técnicos, clientes y equipos. Estas subqueries permiten filtrar y combinar datos de diferentes tablas para obtener resultados específicos.

**Joins:**  Los joins se han utilizado para combinar datos de diferentes tablas en base a una condición de unión. Esto es especialmente útil para obtener información relacionada de diferentes entidades, como vincular un servicio técnico con su respectivo cliente o equipo.

**Vistas:**  Se han creado vistas que ofrecen una representación lógica de los datos almacenados en la base de datos. Estas vistas permiten simplificar y reutilizar consultas complejas, proporcionando una capa de abstracción sobre las tablas subyacentes.

[![temporal-datagrip.png](https://i.postimg.cc/XNDLhqNz/temporal-datagrip.png)](https://postimg.cc/23hnLzZQ)

### Queries realizadas de prueba
```sql
-- Listar a los servicios técnicos (nombre) y el nombre de las ciudades y el país en el cual se encuentran

SELECT st.nombre nombre_servicio_tecnico,s.pais, s.ciudad ciudad
FROM servicios_tecnicos st
JOIN sedes s
ON st.id = s.servicios_tecnicos_id
GROUP BY st.nombre, s.pais, s.ciudad;
```

``` sql
-- Listar los servicios técnicos que tienen una sede en un país específico.
SELECT servicios_tecnicos_id, st.nombre, COUNT(*) quantity
FROM sedes s
JOIN servicios_tecnicos st
ON s.servicios_tecnicos_id = st.id
WHERE pais = 'Perú'
GROUP BY servicios_tecnicos_id, st.nombre;
```
``` sql
--  ¿Cuál es el promedio de puntaje de calificaciones recibidas por cada servicio técnico?
SELECT st.nombre servicio_tecnico, ROUND(AVG(puntaje), 2) puntaje_promedio
FROM calificaciones c
JOIN servicios_tecnicos st
ON c.servicios_tecnicos_id = st.id
GROUP BY st.nombre;
```

### Requisitos de Implementación
Para implementar y utilizar esta base de datos, se recomienda tener instalado y configurado el IDE DataGrip, junto con un sistema de gestión de bases de datos relacional compatible, como SQL Server.

[![servicio-tecnico-image.png](https://i.postimg.cc/G2DMx1Gp/servicio-tecnico-image.png)](https://postimg.cc/N9g7QSNh)
