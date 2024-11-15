-- Todas las inserciones realizadas en el archivo "Transacciones.sql" son meramente demostrativas y no deben ejecutarse sin antes
   actualizar los argumentos de 'VALUES' para simular una inserción hipotética que no conflictúe con las IDs demostrativas ya existentes
   incorporadas mediante los scripts de inserción provistos en entregas anteriores.

-- Toda comparación en la cual uno de los argumentos sea el mismo nombre del atributo aunado a un arroba
   (por ejemplo: usuario = @usuario) hace referencia a la comparación del atributo de una tabla, con un dato provisto por
   la persona que haga uso del script. 

   EJEMPLO: 

   WHERE usuario = @usuario  ========>  WHERE usuario = H3li0S44

-- Ejecutar el script sin previamente reemplazar el atributo acompañado de un @ por un 
   dato que simule un dato real NO PERMITIRÁ el correcto testeo del código.

-- Soy plenamente consciente de ambos escenarios, y reitero, NO SE TRATA DE ERRORES. El testeo del código es realizable en su
   totalidad siempre y cuando se sigan las instrucciones pertinentes.
