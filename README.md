# 📌 Limpieza de datos con SQL Server

## Descripción del proyecto

Desarrollé este proyecto como un ejercicio práctico de limpieza y normalización de datos utilizando SQL Server. El dataset, proveniente de un archivo CSV con información de empleados, presentaba diversos desafíos: nombres de columnas inconsistentes, valores faltantes y errores tipográficos.
Mediante consultas SQL, diseñé e implementé un proceso de limpieza que mejoró la calidad y la estructura del conjunto de datos, garantizando que la información final fuera precisa, coherente y lista para su análisis.

--- 

## Contenido
1. [Objetivo general](#objetivo-general)
2. [Herramientas utilizadas](#herramientas-utilizadas)
3. [Conjunto de datos](#conjunto-de-datos)
4. [Pasos realizados](#pasos-realizados)

   - [Paso 1: Estandarización de los nombres de los campos]()
   - [Paso 2: Eliminación de datos duplicados]()
   - [Paso 3: Estandarización de datos]()
   - [Paso 4: Nuevas columnas de edad y antiguedad]()
      
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

- #### Creación de base de datos 
Se creo una nueva base llamada "CleanDatabase" en donde se alojó la tabla principal con los datos de los empleados.

- #### Importación de los datos de un archivo CSV
A continuación se muestra una vista previa del conjunto de datos originales, con una cantidad de 22.223 registros.

![Imagen 1](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/73bb25d3e9221d1425f1dd2cd06aa5b8dec43a16/Imagenes/imagen-01.png)

- #### Copia de la tabla original
Para preservar la integridad de los datos originales, se duplicó la tabla base y se realizaron las transformaciones sobre una nueva tabla de trabajo llamada "Employees".

---

## 🡲 PASO 1: Modificación de la estructura de la tabla
- #### Cambio de los nombres de las columnas
Se estandarizó el formato de los nombres de las columnas para asegurar uniformidad y facilitar su interpretación y uso en futuras consultas.

![Imagen 2](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/73bb25d3e9221d1425f1dd2cd06aa5b8dec43a16/Imagenes/imagen-02.png)

---

## 🡲 PASO 2: Eliminación de datos duplicados
La presencia de registros duplicados puede alterar los resultados del análisis y afectar la precisión de las visualizaciones, dando lugar a conclusiones erróneas.


- #### Detectar los valores duplicados
Se utilizó una sentencia `GROUP BY` combinada con `HAVING COUNT(*) > 1` para agrupar por ID y detectar aquellos registros que aparecían más de una vez en la tabla.

![Imagen 4](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/73bb25d3e9221d1425f1dd2cd06aa5b8dec43a16/Imagenes/imagen-04.png)

Resultado obtenido de la consulta:

![Imagen 3](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/73bb25d3e9221d1425f1dd2cd06aa5b8dec43a16/Imagenes/imagen-03.png)


- #### Creación de tabla sin duplicados
Una vez detectado los valores duplicados, se renombró la tabla "Employees" como "EmployeesConDuplicados. 
A partir de allí, se creó una **tabla temporal** con los registros únicos, para luego crear una nueva tabla llamada "Employees" y continuar con el proceso de limpieza.

---

## 🡲 PASO 3: Estandarización de datos
- #### Eliminación de los espacios en blanco
Para asegurar la consistencia en los nombres y apellidos de los empleados, se aplicó la función `TRIM()` con el objetivo de eliminar los espacios en blanco al inicio y al final de cada valor.

![Imagen 6](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/73bb25d3e9221d1425f1dd2cd06aa5b8dec43a16/Imagenes/imagen-06.png)

Resultado de la consulta:

![Imagen 5](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/73bb25d3e9221d1425f1dd2cd06aa5b8dec43a16/Imagenes/imagen-05.png)

Una vez detectados los espacios en blanco, se realiza una actualización eliminando los mismos.

- #### Cambio de datos de la columna Type
Los datos de la columna `Type` contenían valores numéricos donde 0 representaba "Remote" y 1 correspondía a "Hybrid". Para mejorar la legibilidad y facilitar el análisis, estos valores fueron reemplazados por sus respectivas descripciones en texto.

![Imagen 7](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/73bb25d3e9221d1425f1dd2cd06aa5b8dec43a16/Imagenes/imagen-07.png)

- #### Cambio de datos de la columna Gender
Los valores de la columna `Gender` se encontraban en español, por lo que fueron traducidos al inglés para unificar el idioma del conjunto de datos y mantener la consistencia en el análisis.

![Imagen 8](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/73bb25d3e9221d1425f1dd2cd06aa5b8dec43a16/Imagenes/imagen-08.png)

Consulta de prueba y de actualización de los datos:

![Imagen 9](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/73bb25d3e9221d1425f1dd2cd06aa5b8dec43a16/Imagenes/imagen-09.png)

- #### Cambio del tipo de dato de la columna Salary
La columna `Salary` se encontraba en formato `VARCHAR`, lo que impedía realizar cálculos numéricos. Para convertirla al tipo de dato `INT`, fue necesario eliminar previamente el signo de pesos ($) y las comas (',') que formaban parte del formato original.

![Imagen 10](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/ed133fa1575ebb22692753086d8f82a78978dd74/Imagenes/imagen-10.png)

Actualizar los valores y transmorfación de los mismos a tipo de dato `INT`:

![Imagen 11](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/1fae24a9225542b9fba43ca3774544884e8c8095/Imagenes/imagen-11.png)

- #### Cambio del tipo de dato de la columna Birth Date
Las columnas `Birth_Date` y `Finish_Date` estaban en formato `VARCHAR`, con los valores de fecha en un orden incorrecto (por ejemplo, con el día, mes y año invertidos). Por ello, fue necesario reordenar los valores y convertirlos posteriormente al tipo de dato `DATE`, para facilitar su análisis y manipulación.

![Imagen 12](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/5cbf2b893931c5ea8d168376bd997047ef25cc58/Imagenes/imagen-12.png)

Cambio de tipo de dato: 

![Imagen 13](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/b8f77954a6bf1abb94a6833239d1e4f847945685/Imagenes/imagen-13.png)

## 🡲 PASO 4: Nuevas columnas de edad y antigüedad
Se generaron dos nuevas columnas utilizando funciones de fecha en SQL:
- Una columna `Edad`, calculada a partir de la diferencia entre la fecha actual y la columna `Birth_Date`.
- Otra columna `Antigüedad`, calculada como el tiempo transcurrido desde la fecha de ingreso (Star_Date) hasta la fecha actual.

Creación de nueva columna `Edad` y calculo de los datos:

![Imagen 14](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/8fa705f5f2797b6ebd27e2e13e85f06c306401f8/Imagenes/imagen-14.png)

Creación de nueva columna `Antigüedad` y calculo de los datos:

![Imagen 15](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/441ee4b9d081afe30e0eff0cbeb177ed6bf1c064/Imagenes/imagen-15.png)

Resultados obtenidos:

![Imagen 16](https://github.com/mariaibanezw/Limpieza_base_empleados/blob/25e588feeb6923f9fb949fb3865dce0ab7634f74/Imagenes/imagen-16.png)

---

## 5. Resultado final
Este proyecto de limpieza y transformación de datos en SQL permitió convertir un dataset desordenado y poco funcional en una base de datos estructurada, coherente y lista para el análisis.

- Se eliminaron registros duplicados y errores que comprometían la calidad del análisis
- Se normalizaron y estandarizaron los campos para lograr una estructura homogénea
- Se optimizó el dataset reduciendo valores nulos y asegurando mayor precisión

Este tipo de procesos es fundamental en cualquier etapa de análisis de datos, ya que garantiza que la información sea confiable, reutilizable y lista para alimentar visualizaciones, reportes o modelos de predicción.



---

## Contacto
Para consultas, puedes contactarme a través de:

[Mail](mailto:maria.ibanezw@gmail.com)

[LinkedIn](https://www.linkedin.com/in/mariadelmaribanezw/) 

