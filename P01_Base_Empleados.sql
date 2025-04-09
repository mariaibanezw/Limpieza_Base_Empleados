----------------------------------------------------
------------ PROYECTO LIMPIEZA DE DATOS ------------
----------------------------------------------------

-- Creas una base de datos
CREATE DATABASE CleanDatabase;
USE CleanDatabase;

-- Importacion de archivo CSV
-- Cuando importamos el archivo CSV se crea la tabla

-- Duplicado de tabla 
SELECT * INTO Clean FROM CSV;

-- Cambio del nombre de la tabla
EXEC sp_rename 'CSV', 'SinLimpiar';
EXEC sp_rename 'Clean', 'Limpieza';

-- Ver la tabla
SELECT * FROM Limpieza; 

-- Cambiar los nombres de las columnas
EXEC sp_rename 'Limpieza.[Id?empleado]', 'Id', 'COLUMN';

EXEC sp_rename 'Limpieza.[Apellido]', 'Last_Name', 'COLUMN'

EXEC sp_rename 'Limpieza.[birth_date]', 'Birth_Date', 'COLUMN';

EXEC sp_rename 'Limpieza.[género]', 'Gender', 'COLUMN';

EXEC sp_rename 'Limpieza.[area]', 'Area', 'COLUMN';

EXEC sp_rename 'Limpieza.[salary]', 'Salary', 'COLUMN';

EXEC sp_rename 'Limpieza.[star_date]', 'Star_Date', 'COLUMN';

EXEC sp_rename 'Limpieza.[finish_date]', 'Finish_Date', 'COLUMN';

EXEC sp_rename 'Limpieza.[promotion_date]', 'Promotion', 'COLUMN';

EXEC sp_rename 'Limpieza.[type]', 'Type', 'COLUMN';

-- Contar la cantidad de filas (22.223) y cantidad de valores distintos para saber si hay duplicados (22.214)
SELECT COUNT(*)
FROM Limpieza;

SELECT COUNT(DISTINCT Id_Empleado)
FROM Limpieza;

-- Identidicar cuales son los id duplicados y cuantas veces se repiten
SELECT Id,
COUNT(*) AS Cantidad_duplicados
FROM Limpieza
GROUP BY Id
HAVING COUNT (*)>1;

-- Subconsulta para contar el total de duplicados usando la consulta del item anterior
SELECT COUNT(*) AS Cantidad_duplicados
FROM( 
	SELECT Id,
	COUNT(*) AS cantidad_duplicados
	FROM Limpieza
	GROUP BY Id
	HAVING COUNT (*)>1
) AS Subconsulta;

-- Renombrar la tabla
EXEC sp_rename 'Limpieza', 'LimpiezaConDuplicado'

-- Selecciona todos los valores unicos de la tabla con duplicados y crea una tabla temporal con dichos valores
SELECT DISTINCT * INTO #Temp_Limpieza FROM LimpiezaConDuplicado;

SELECT * FROM #Temp_Limpieza;

-- Se crea la tabla Limpieza seleccionando todos los valores de la tabla temporal
SELECT * INTO Limpieza FROM #Temp_Limpieza;

-- VER TABLA 
SELECT * FROM Limpieza;


-- Se analizan los nombres y apellidos que tienen espacio adelante y atras
SELECT Name FROM Limpieza
WHERE LEN(Name) - LEN(TRIM(Name)) > 0;

SELECT Last_Name FROM Limpieza
WHERE LEN(Last_Name) - LEN(TRIM(Last_Name)) > 0;

-- Antes de hacer la correccion de los nombres, verificar si la sintaxis esta bien
SELECT
Name,
TRIM(Name) AS Name
FROM Limpieza
WHERE LEN(Name) - LEN(TRIM(Name)) > 0;

SELECT
Last_Name,
TRIM(Last_Name) AS Last_Name
FROM Limpieza
WHERE LEN(Last_Name) - LEN(TRIM(Last_Name)) > 0;

-- Una vez que vimos que la sintaxis funciona, corregimos los datos de nombre y apellido. 
UPDATE Limpieza SET Name = TRIM(Name)
WHERE LEN(Name) - LEN(TRIM(Name)) > 0;

UPDATE Limpieza SET Last_Name = TRIM(Last_Name)
WHERE LEN(Last_Name) - LEN(TRIM(Last_Name)) > 0;

-- Si tenemos varios espacios entre palabras.
SELECT Area 
FROM Limpieza
WHERE PATINDEX('%  %', Area) > 0;

-- Cambiar los datos de la columna Type.
SELECT Type,
    CASE 
        WHEN Type = '1' THEN 'Remote'
        WHEN Type = '0' THEN 'Hybrid'
        ELSE 'Otro'
    END AS Ejemplo
FROM Limpieza;

UPDATE Limpieza SET Type = CASE 
        WHEN Type = '1' THEN 'Remote'
        WHEN Type = '0' THEN 'Hybrid'
        ELSE 'Otro'
    END;

-- Cambiar los datos de la columna Gender. 
SELECT Gender,
    CASE 
        WHEN Gender = 'hombre' THEN 'male'
        WHEN Gender = 'mujer' THEN 'female'
        ELSE 'Other'
    END AS Ejemplo
FROM Limpieza;

UPDATE Limpieza SET Gender =
	CASE 
        WHEN Gender ='hombre' THEN 'male'
        WHEN Gender = 'mujer' THEN 'female'
        ELSE 'Other'
    END;


-- La columna de salario esta en formato varchar y tenemos que pasarla a decimal.
SELECT Salary, 
	TRIM(REPLACE(REPLACE(Salary,'$', ''), ',',''))
FROM Limpieza;

UPDATE Limpieza SET Salary = TRIM(REPLACE(REPLACE(Salary,'$', ''), ',',''));

-- Tengo datos mal cargados, voy a corregir la planilla. Con esta formula toma los valores que nos son decimales
SELECT Id, Salary
FROM Limpieza
WHERE TRY_CAST(Salary AS DECIMAL(18,2)) IS NULL AND Salary IS NOT NULL;

-- 00-1485605 - 4/13/1991
-- 47-5184730 - 1/27/2002
-- 61-9139404 - 11/22/1998

SELECT * FROM Limpieza
WHERE Id = '00-1485605';

SELECT * FROM Limpieza
WHERE Id = '47-5184730';

SELECT * FROM Limpieza
WHERE Id = '61-9139404';


-- Cambiar valores incorrectos
UPDATE Limpieza  
SET Name = 'Lurette'  
WHERE id = '61-9139404'; 

UPDATE Limpieza  
SET Last_Name = 'Mitchelhill'  
WHERE id = '61-9139404'; 

UPDATE Limpieza  
SET Gender = 'male'  
WHERE id = '61-9139404';

UPDATE Limpieza  
SET Birth_Date = '4/13/1991'  
WHERE id = '00-1485605';

UPDATE Limpieza  
SET Area = 'Services'  
WHERE id = '61-9139404';

UPDATE Limpieza  
SET Salary = '12068'  
WHERE id = '61-9139404';

UPDATE Limpieza  
SET Star_Date = '3/30/2008'  
WHERE id = '61-9139404';

UPDATE Limpieza  
SET Type = 'Remote'  
WHERE id = '61-9139404';


-- Cambiar el tipo de dato de Salary, varchar a Decimal. 
FROM Limpieza  
WHERE TRY_CAST(Salary AS DECIMAL(10,2)) IS NULL AND Salary IS NOT NULL;

ALTER TABLE Limpieza
ALTER COLUMN Salary int;


---------------------------------------------
SELECT * FROM Limpieza;
SELECT * FROM LimpiezaConDuplicado;
---------------------------------------------

--Cambiar el tipo de dato, de varchar a date de la columna de star date
ALTER TABLE Limpieza  
ALTER COLUMN Star_Date date;

EXEC sp_help Limpieza;


-- Tanto la columna de Birth_Date y Finish_Date tiene varias fechas con formatos diferentes, por lo tanto tenemos que corregir dichos datos para poder pasar de varchar a date
SELECT Birth_Date
FROM Limpieza
WHERE 
    TRY_CONVERT(DATE, Birth_Date, 103) IS NULL 
    AND TRY_CONVERT(DATE, Birth_Date, 101) IS NULL; -- como no hay resultado significa que esta bien las fechas


-- Con esta sintaxis cambio el formato de las fechas para poder pasar el tipo de dato de varchar a date
UPDATE Limpieza
SET Birth_Date = 
    CASE 
        WHEN TRY_CONVERT(DATE, Birth_Date, 103) IS NOT NULL 
             THEN FORMAT(TRY_CONVERT(DATE, Birth_Date, 103), 'yyyy-MM-dd') 
        WHEN TRY_CONVERT(DATE, Birth_Date, 101) IS NOT NULL 
             THEN FORMAT(TRY_CONVERT(DATE, Birth_Date, 101), 'yyyy-MM-dd') 
        ELSE NULL  -- Si la conversión falla, se deja NULL
    END;

-- Tranformo el tipo de dato de Birth_Date de varchar a date
ALTER TABLE Limpieza  
ALTER COLUMN Birth_Date DATE;

-- Contar la cantidad de filas que tienen un espacio y no lo toma como nulo: 18282
SELECT 
COUNT(Finish_Date)
FROM Limpieza 
WHERE Finish_Date = '';


-- Contar las cantidad de filas que tienen fechas: 3932
SELECT 
COUNT(*) AS Cantidad
FROM Limpieza
WHERE Finish_Date IS NOT NULL AND Finish_Date <> '';

-- Pasar todos los registros que tienen espacio vacio a null. 
UPDATE Limpieza
SET Finish_Date = NULL
WHERE LTRIM(RTRIM(Finish_Date)) = '';

-- Verificar el cambio de formato de fecha.
SELECT Finish_Date, TRY_CONVERT(DATE, LEFT(Finish_Date, 10), 120) AS New_Date
FROM Limpieza; -- como funciona bien ahora hacemos la actualizacion  del dato

UPDATE Limpieza
SET Finish_Date = TRY_CONVERT(DATE, LEFT(Finish_Date, 10), 120);


---------------------------------------------
SELECT * FROM Limpieza;
---------------------------------------------


-- Contar la cantidad de filas que hay fecha.
SELECT COUNT(*) AS fechas
FROM Limpieza
WHERE ISDATE(Promotion) = 1;

SELECT *
FROM Limpieza
WHERE ISDATE(Promotion) = 1;

-- Cambiar el formato de la fecha. Primero verificamos si lo hicimos bien 
SELECT Promotion AS FechaOriginal, 
       CONVERT(DATE, Promotion, 107) AS FechaConvertida
FROM Limpieza
WHERE ISDATE(Promotion) = 1; 

UPDATE Limpieza
SET Promotion = CONVERT(DATE, Promotion, 107)
WHERE ISDATE(Promotion) = 1;


-- Cambiar las filas vacias a nulas
SELECT 
id,
promotion,
NULLIF(Promotion, '') AS PROMOTION
FROM Limpieza;

 UPDATE Limpieza
 SET Promotion = NULL
 WHERE Promotion = ' ';

 -- Ver las columnas que tienen fecha en la columna Promotion
 SELECT
 id,
 Promotion
 FROM Limpieza
 WHERE ISDATE(Promotion) = 1;

 -- Creacion de una nueva columna para la edad de los empleados
ALTER TABLE Limpieza  
ADD Age INT;

-- Calcular la edad de los empleados
SELECT
Id,
Birth_Date,
DATEDIFF(year, Birth_Date, GETDATE()) AS Edad
FROM Limpieza;

-- Cargar datos de edad en la nueva columna
UPDATE Limpieza
SET Age = DATEDIFF(year, Birth_Date, GETDATE());


-- Calcular los años trabajados
SELECT 
Name, 
Star_Date,
DATEDIFF(YEAR, Star_Date, GETDATE()) AS Antiguedad
FROM Limpieza;

-- Agregar columna para obtener los años de antiguedad en la empresa
ALTER TABLE Limpieza
ADD Antigüedad int;


-- Agregar los valores a la nueva columna
UPDATE Limpieza
SET Antigüedad = DATEDIFF(YEAR, Star_Date, GETDATE());


--Cambiar el nombre de la columna a ingles
EXEC sp_rename 'Limpieza.[Antigüedad]', 'Seniority', 'COLUMN';


SELECT Finish_Date
FROM Limpieza
WHERE ISDATE(Finish_Date)=1;


--Cambiar el nombre de la tabla
EXEC sp_rename 'Limpieza', 'Employees';



-----------------------------------------------------
---------------- ANALISIS EXPLORATORIO --------------
-----------------------------------------------------
-- ¿Cuantos empleados tiene la empresa? ¿Cuantos son mujeres y cuantos varones?
SELECT 
COUNT(Id)
FROM Employees;

SELECT
Gender,
COUNT(*) AS Number
FROM Employees
GROUP BY Gender;

-- ¿Cuál es el porcentaje de empleados por departamento? ¿Cuáles son los 5 departamentos con mayor cantidad de empleados?
SELECT 
    Area, 
    COUNT(*) AS N_Employees, 
    CAST(ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM Employees), 2) AS DECIMAL(5,2)) AS 'Percentage'
FROM Employees
GROUP BY Area
ORDER BY 'Percentage' DESC;

SELECT TOP (5)
    Area, 
    COUNT(*) AS N_Employees 
FROM Employees
GROUP BY Area
ORDER BY N_Employees DESC;

-- ¿Cuál es el salario promedio, mínimo y máximo en cada departamento?
SELECT
AVG(Salary) AS Avg_Salary,
MIN(Salary)AS Min_Salary,
MAX(Salary) AS Max_Salary
FROM Employees;

-- ¿Cuáles son las edades más comunes dentro de la empresa?
SELECT
MIN(Age) AS Min_Age,
MAX(Age) AS Max_Age
FROM Employees


SELECT 
    CASE
        WHEN Age BETWEEN 18 AND 29 THEN '18-29 years old'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39 years old'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49 years old'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59 years old'
        ELSE '60 or more'
    END AS Age_Range,
    COUNT(*) AS N_Employees
FROM Employees
GROUP BY 
    CASE
        WHEN Age BETWEEN 18 AND 29 THEN '18-29 years old'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39 years old'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49 years old'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59 years old'
        ELSE '60 or more'
    END
ORDER BY Age_Range;


-- ¿Que area tiene los mejores sueldos?
SELECT 
Area, 
AVG(Salary) AS AVG_Salary
FROM Employees
GROUP BY Area
ORDER BY AVG_Salary DESC;