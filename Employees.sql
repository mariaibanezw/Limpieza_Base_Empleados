SELECT * INTO Employees2 FROM base_original_empleados;

SELECT * FROM Employees2; 

SELECT * FROM Original_Database; 

-- Cambiar los nombres de las columnas
EXEC sp_rename 'Employees2.[Id?empleado]', 'Id', 'COLUMN';

EXEC sp_rename 'Employees2.[Apellido]', 'Last_Name', 'COLUMN'

EXEC sp_rename 'Employees2.[birth_date]', 'Birth_Date', 'COLUMN';

EXEC sp_rename 'Employees2.[género]', 'Gender', 'COLUMN';

EXEC sp_rename 'Employees2.[area]', 'Area', 'COLUMN';

EXEC sp_rename 'Employees2.[salary]', 'Salary', 'COLUMN';

EXEC sp_rename 'Employees2.[star_date]', 'Star_Date', 'COLUMN';

EXEC sp_rename 'Employees2.[finish_date]', 'Finish_Date', 'COLUMN';

EXEC sp_rename 'Employees2.[promotion_date]', 'Promotion', 'COLUMN';

EXEC sp_rename 'Employees2.[type]', 'Type', 'COLUMN';

SELECT Id,
COUNT(*) AS Cantidad_duplicados
FROM Employees
GROUP BY Id
HAVING COUNT (*)>1;

SELECT Name FROM Employees2
WHERE LEN(Name) - LEN(TRIM(Name)) > 0;

SELECT
Name,
TRIM(Name) AS Name
FROM Employees2
WHERE LEN(Name) - LEN(TRIM(Name)) > 0;

UPDATE Employees2 SET Gender =
	CASE 
        WHEN Gender ='hombre' THEN 'male'
        WHEN Gender = 'mujer' THEN 'female'
        ELSE 'Other'
    END;