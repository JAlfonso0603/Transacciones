-- ----------------------------------------------------------------------------------------------------

-- Proyecto: Control de Informacion para una Biblioteca de Mangas:
-- Titulo: Transacciones, Bloqueos y Niveles de aislamiento
-- Equipo: Jose Antonio Gonzalez Cardenas | Emmanuel Saldaña Alvarez | Jesus Alfonso Cuevas Avila

-- ----------------------------------------------------------------------------------------------------

-- Usar la Base de Datos
USE Biblioteca_Mangas;


-- 1. Agregar una nueva Imprenta y un Lote asociado
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRY
    INSERT INTO Imprentas (nombreImp, direccionImp, CP_Imp, paisImp, telefonoImp, emailImp)
    VALUES ('Mario Prado', 'Calle Uno 123', '12345', 'España', '911234567', 'simple@imprenta.com');

    INSERT INTO Lotes (idImprenta, fechaImpresion, cantidadMangas)
    VALUES (SCOPE_IDENTITY(), GETDATE(), 100);
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error: ' + ERROR_MESSAGE(); 
END CATCH;


-- 2. Insertar un nuevo Distribuidor y un Lote asignado a él
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRY
    INSERT INTO Distribuidores (nombreDistribuidor, telefonoDist, emailDist, direccionDist)
    VALUES ('Alejandro Chavez', '912 345 6787', 'simple@distribuidor.com', 'Av. Dos 456, Madrid');

    INSERT INTO DetalleLotes (idDistribuidor, idLote)
    VALUES (SCOPE_IDENTITY(), 1);
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH;


-- 3. Insertar una nueva Sucursal
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRY
    INSERT INTO Sucursales (idUbicacion, idDistribuidor, nombreSuc, direccionSuc, telefonoSuc)
    VALUES (1, 1, 'Akiba Comics', 'Calle Tres 789, Barcelona', '933 456 7892');
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH;


-- 4. Actualizar el teléfono de una Imprenta
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRY
    UPDATE Imprentas
    SET telefonoImp = '987 654 3211' -- El campo que deseas actualizar
    WHERE idImprenta = 1; -- El ID del Imprenta que deseas actualizar
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH;


-- 5. Eliminar un Distribuidor y sus filas relacionadas
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRY
    DELETE FROM DetalleLotes
    WHERE idDistribuidor = 11;  -- El ID del distribuidor que deseas eliminar

    DELETE FROM Distribuidores
    WHERE idDistribuidor = 11;
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH;


-- ----------------------------------------------------------------------------------------------------

--Seleccionar Tablas
SELECT * FROM Imprentas;
SELECT * FROM Distribuidores;
SELECT * FROM Lotes;
SELECT * FROM DetalleLotes;
SELECT * FROM Sucursales;
SELECT * FROM UbicacionFisica;

