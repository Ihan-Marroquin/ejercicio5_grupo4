-- data.sql

-- 10 usuarios de ejemplo
INSERT INTO usuarios (nombre, email) VALUES
('Ana López','ana.lopez@example.com'),
('Carlos Pérez','carlos.perez@example.com'),
('María Gómez','maria.gomez@example.com'),
('Luis Rodríguez','luis.rodriguez@example.com'),
('Sofía Fernández','sofia.fernandez@example.com'),
('Diego Martínez','diego.martinez@example.com'),
('Elena Ramírez','elena.ramirez@example.com'),
('Jorge Morales','jorge.morales@example.com'),
('Valeria Torres','valeria.torres@example.com'),
('Miguel Castillo','miguel.castillo@example.com');

-- 15 productos
INSERT INTO productos (nombre, tipo, precio, descripcion) VALUES
('Cuaderno Clásico','cuaderno',12.50,'Tamaño A5, 100 hojas rayadas'),
('Cuaderno Dibujo','cuaderno',15.00,'Tamaño A4, 80 hojas en blanco'),
('Tarjeta Cumpleaños','tarjeta',3.00,'Diseño floral, tamaño 10x15cm'),
('Tarjeta Agradecimiento','tarjeta',2.50,'Diseño minimalista'),
('Agenda 2025','agenda',20.00,'Agenda anual con secciones semanales'),
('Agenda Bolsillo','agenda',10.00,'Tamaño pequeño para llevar'),
('Cuaderno Personalizado','cuaderno',18.00,'Portada a medida y papel premium'),
('Tarjeta Invitación','tarjeta',4.00,'Personalizable'),
('Agenda Ejecutiva','agenda',25.00,'Portada de cuero sintético'),
('Cuaderno Espiral','cuaderno',14.00,'Anillas metálicas'),
('Tarjeta Feliz Navidad','tarjeta',3.50,'Temática navideña'),
('Agenda Planificador','agenda',22.00,'Secciones de objetivos mensuales'),
('Cuaderno Bolsillo','cuaderno',11.00,'Pequeño y ligero'),
('Tarjeta Boda','tarjeta',5.00,'Diseño elegante'),
('Agenda Creativa','agenda',30.00,'Incluir stickers y plantillas');

-- Inicializar inventario
INSERT INTO inventario (producto_id, stock)
SELECT producto_id, 100 FROM productos;

-- 30 pedidos de prueba con detalles
DO $$
BEGIN
  FOR i IN 1..30 LOOP
    INSERT INTO pedidos (usuario_id, estado)
    VALUES ((i % 10) + 1, 'procesando');
    PERFORM pg_sleep(0); -- asegurar IDs
    INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad)
    VALUES (currval('pedidos_pedido_id_seq'), ((i % 15) + 1), ((i % 5) + 1));
  END LOOP;
END$$;