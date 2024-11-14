-- Usar la Base de Datos
USE Biblioteca_Mangas;

-- 1. Transacción para realizar un prestamo
BEGIN TRANSACTION
INSERT INTO Prestamos (idSucursal, idUsuario, totalMangas, fechaPres, fechaDevSR, fechaDev, estadoPre) VALUES (1, 1, 5, '2024-11-01', '2024-11-15', NULL, 'Aceptado')
IF EXISTS(
    SELECT 1 FROM Prestamos
    WHERE idUsuario = 1 AND estadoPre = 'Atrasado'
)
BEGIN
    PRINT('El préstamo no puede realizarse: Existen préstamos atrasados.')
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    PRINT('La operación se realizó exitosamente.')
    COMMIT TRANSACTION;
END

-- 2. Transacción para realizar un apartado
BEGIN TRANSACTION
INSERT INTO Apartados (idUsuario, idManga, fechaApartado, fechaLimite, estado) VALUES (1, 1, '2024-11-01', '2024-11-15', 'Pendiente')
IF EXISTS(
    SELECT 1 FROM Prestamos
    WHERE idUsuario = 1 AND estadoPre = 'Atrasado'
)
BEGIN
    PRINT('El apartado no puede realizarse: Existen préstamos atrasados.')
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    PRINT('La operación se realizó exitosamente.')
    COMMIT TRANSACTION;
END

-- 3. Transacción para la inserción de un nuevo usuario.
BEGIN TRANSACTION
INSERT INTO Usuarios (idGrupo, nombrePila, apePat, apeMat, usuario, password, habilitado) VALUES (2,'Juan', 'Torres', 'Mendoza', 'juan.t', 'password10', 1)
IF EXISTS (
    SELECT 1 FROM Usuarios
    WHERE usuario = @nuevoUsuario
)
    BEGIN 
        PRINT('Nombre de usuario no disponible.')
        ROLLBACK TRANSACTION;
    END
ELSE
    BEGIN
        PRINT('Inserción realizada con éxito')
    END

-- 4. Upgrade de cuenta de Cliente a cuenta de Empleado
BEGIN TRANSACTION
UPDATE Usuarios
SET idGrupo = 2
WHERE idUsuario = 1 -- ID del Usuario a actualizar
IF ((SELECT idGrupo FROM Usuarios WHERE idUsuario = 1) = 1) -- El usuario debe pertenecer inicialmente al grupo "Clientes"
    BEGIN
        PRINT('Actualización realizada con éxito')
        COMMIT TRANSACTION
    END
ELSE
    BEGIN
        PRINT('Error: El usuario ya tiene el rol de emplado.')
        ROLLBACK TRANSACTION
    END

-- 5. Check de préstamos atrasados de un cliente

BEGIN TRANSACTION
UPDATE Prestamos
SET estadoPre = 'Atrasado'
WHERE (GETDATE() > fechaDevSR) AND idUsuario = 1
IF((SELECT COUNT(estadoPre) FROM Prestamos WHERE(estadoPre = 'Atrasado')) > 1)
    BEGIN 
        UPDATE Usuarios
        SET habilitado = 0
        WHERE idUsuario = 1
        PRINT('El usuario ha sido deshabilitado: Reincidencia en retardos.')
        COMMIT TRANSACTION
    END
ELSE
    BEGIN
        PRINT('El usuario no tiene retardos.')
        ROLLBACK TRANSACTION
    END