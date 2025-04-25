-- dml.sql para verificar triggers en tabla productos

-- INSERT
INSERT INTO productos (nombre, tipo, precio, descripcion)
VALUES ('Producto Test','cuaderno',9.99,'Descripción de prueba');

-- UPDATE
UPDATE productos
SET precio = 11.99,
    descripcion = 'Descripción actualizada de prueba'
WHERE nombre = 'Producto Test';

-- DELETE
DELETE FROM productos
WHERE nombre = 'Producto Test';

-- TRUNCATE
TRUNCATE TABLE detalle_pedido, productos CASCADE;

-- Consultar auditoría
SELECT * FROM auditoria
WHERE tabla = 'productos'
ORDER BY fecha;