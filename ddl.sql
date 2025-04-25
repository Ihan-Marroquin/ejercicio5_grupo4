-- ddl.sql

-- Limpieza de tablas
DROP TABLE IF EXISTS detalle_pedido;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS inventario;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS auditoria;

-- Usuarios
CREATE TABLE usuarios (
    usuario_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT NOW()
);

-- Productos
CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT NOW()
);

-- Pedidos
CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(usuario_id),
    fecha_pedido TIMESTAMP DEFAULT NOW(),
    estado VARCHAR(30) DEFAULT 'pendiente'
);

-- Detalle_pedido
CREATE TABLE detalle_pedido (
    detalle_id SERIAL PRIMARY KEY,
    pedido_id INT REFERENCES pedidos(pedido_id) ON DELETE CASCADE,
    producto_id INT REFERENCES productos(producto_id),
    cantidad INT NOT NULL CHECK(cantidad > 0)
);

-- Inventario
CREATE TABLE inventario (
    producto_id INT PRIMARY KEY REFERENCES productos(producto_id),
    stock INT NOT NULL CHECK(stock >= 0)
);

-- Auditoria
CREATE TABLE auditoria (
    id SERIAL PRIMARY KEY,
    tabla TEXT NOT NULL,
    operacion TEXT NOT NULL,
    registro_id INT,
    datos_anterior JSONB,
    datos_nuevo JSONB,
    fecha TIMESTAMP DEFAULT NOW()
);