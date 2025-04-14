# 📌 Limpieza de datos con SQL Server

## Descripción del proyecto

Desarrollé este proyecto como un ejercicio práctico de limpieza y normalización de datos utilizando SQL Server. El dataset, proveniente de un archivo CSV con información de empleados, presentaba diversos desafíos: nombres de columnas inconsistentes, valores faltantes y errores tipográficos.
Mediante consultas SQL, diseñé e implementé un proceso de limpieza que mejoró la calidad y la estructura del conjunto de datos, garantizando que la información final fuera precisa, coherente y lista para su análisis.

--- 

## Contenido
1. [1. Objetivo general](#objetivo-general)
2. [Herramientas utilizadas](#herramientas-utilizadas)
3. [Conjunto de datos](#conjunto-de-datos)
4. [Pasos realizados](#pasos-realizados)

   - [Paso 1: Estandarización de los nombres de los campos]()
   - [Paso 2: Eliminación de datos duplicados]()
   - 
5. [Resultado final](#resultado-final)

--- 

## 1. Objetivo general

El objetivo de este proyecto es optimizar la calidad de los datos de empleados de una empresa a través de procesos de limpieza, normalización y estandarización utilizando SQL Server.

Entre los principales objetivos se encuentran:

- Detectar y corregir errores e inconsistencias en los datos

- Estandarizar los campos para asegurar coherencia y uniformidad

- Garantizar que la tabla final sea clara, funcional y fácilmente reutilizable para futuros análisis

--- 

## 2. Herramientas utilizadas

**SQL Server:** Limpieza, transformación y modelado de los datos.

--- 

## 3. Conjunto de datos
Los datos crudos estan en formato CSV. Estos contienen información de los empleados de la empresa como: nombre, apellido, fecha de nacimiento, el area en la que trabajan dentro de empresa, la fecha de ingreso y si es el caso, la fecha de finalizacion de su contrato.

--- 

## 4. Pasos realizados

- ### Creación de base de datos 
Se creo una nueva base llamada "CleanDatabase" en donde se alojó la tabla principal con los datos de los empleados.

- ### Importación de los datos de un archivo CSV
A continuación se muestra una vista previa del conjunto de datos originales, con una cantidad de 22.223 registros.

![Imagen 1](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/12b0595c266c97041cb89f114b03bf2b5769ca31/Imagenes/imagen-1.png)

- ### Copia de la tabla original
Para preservar la integridad de los datos originales, se duplicó la tabla base y se realizaron las transformaciones sobre una nueva tabla de trabajo llamada "Employees".

---

## 🡲 PASO 1: Modificación de la estructura de la tabla
- ### Cambio de los nombres de las columnas
Se estandarizó el formato de los nombres de las columnas para asegurar uniformidad y facilitar su interpretación y uso en futuras consultas.

![Imagen 2](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/e9556e4232d0f6d88c43773a9f31a2e43522f408/Imagenes/imagen-2.png)

---

## 🡲 PASO 2: Eliminación de datos duplicados
La presencia de registros duplicados puede alterar los resultados del análisis y afectar la precisión de las visualizaciones, dando lugar a conclusiones erróneas.

- ### Detectar los valores duplicados
Se utilizó una sentencia `GROUP BY` combinada con `HAVING COUNT(*) > 1` para agrupar por ID y detectar aquellos registros que aparecían más de una vez en la tabla.

![Imagen 4](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/4ed146a36a1587f87f57068c1b7b8f9ae808abef/Imagenes/imagen-4.png)

Resultado obtenido de la consulta:

![Imagen 3](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/0300768e90477d5212a8eef794bcbf4de4fa43dc/Imagenes/imagen-3.png)

- ### Creación de tabla sin duplicados
Una vez detectado los valores duplicados, se renombró la tabla "Employees" como "EmployeesConDuplicados. 
A partir de allí, se creó una **tabla temporal** con los registros únicos, para luego crear una nueva tabla llamada "Employees" y continuar con el proceso de limpieza.

---

## 🡲 PASO 3: Estandarización de datos
- ### Eliminación de los espacios en blanco
Para asegurar la consistencia en los nombres y apellidos de los empleados, se aplicó la función `TRIM()` con el objetivo de eliminar los espacios en blanco al inicio y al final de cada valor.

![Imagen 6](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/1b289199d58d397b8e02cba065c19f92dedbfc23/Imagenes/imagen-6.png)

Resultado de la consulta:

![Imagen 5](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/6fa35fe7c72367bf190946a3132734121cb766e0/Imagenes/imagen-5.png)

Una vez detectados los espacios en blanco, se realiza una actualización eliminando los mismos.

- ### Cambio de datos de la columna Type
Los datos de la columna Type, continen los números 0=

![Imagen 7]()
  
---

## Resultado final

- Datos estandarizados y listos para análisis.
- Eliminación de inconsistencias y mejora en la calidad del dataset.
- Base de datos más eficiente y organizada.

---

## Contacto
Para consultas, puedes contactarme a través de:

[Mail](mailto:maria.ibanezw@gmail.com)
[LinkedIn](https://www.linkedin.com/in/mariadelmaribanezw/) 

