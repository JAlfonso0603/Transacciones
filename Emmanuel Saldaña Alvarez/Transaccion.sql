USE Biblioteca_Mangas;

----------

BEGIN TRANSACTION;
    INSERT INTO Artistas (nombreArt, fechaNac, nacionalidadArt, numeroObrasArt)
    VALUES ('Katsuhiro Otomo', '1954-04-14', 'Japonesa', 10);
IF @@ERROR = 0
    COMMIT;
ELSE
    ROLLBACK;

----------

BEGIN TRANSACTION;
    UPDATE Generos
    SET nombreGen = 'Seinen'
    WHERE idGenero = 1;
IF @@ERROR = 0
    COMMIT;
ELSE
    ROLLBACK;

----------

BEGIN TRANSACTION;
    INSERT INTO Mangas (idGenero, idUbicacion, idEditorial, idAutor, idTraductor, nombreManga, capituloManga, paginasManga)
    VALUES (1, 1, 1, 1, 1, 'Dragon Ball', 1, 200);
IF @@ERROR = 0
    COMMIT;
ELSE
    ROLLBACK;

----------

BEGIN TRANSACTION;
    DECLARE @idTraductor INT;
    INSERT INTO Traductores (idEditorial, nombreTrad, idiomas)
    VALUES (1, 'Juan Pérez', 'Japonés - Español');
    SET @idTraductor = SCOPE_IDENTITY();
    UPDATE Traductores
    SET idiomas = 'Japonés - Español - Inglés'
    WHERE idTraductor = @idTraductor;
IF @@ERROR = 0
    COMMIT;
ELSE
    ROLLBACK;

----------

BEGIN TRANSACTION;
	UPDATE Artistas
	SET nombreArt  = 'Juan'
    WHERE idArtista = 2;
IF @@ERROR = 0
    COMMIT;
ELSE
    ROLLBACK;