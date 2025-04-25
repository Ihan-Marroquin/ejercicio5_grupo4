# Tienda de Papelería Personalizada

Repositorio con los scripts SQL para crear, poblar y auditar la base de datos de una tienda de papelería personalizada (cuadernos, tarjetas y agendas). Incluye triggers para auditoría de cambios en la tabla `productos`.

---

## 📂 Estructura del Proyecto

```text
.
├── ddl.sql                     # Definición de tablas y esquema
├── Ejercicio 5 - Grupo 4.pdf   # Respuestas a las preguntas planteadas a este ejercicio
├── triggers.sql                # Función de auditoría y triggers (INSERT, UPDATE, DELETE, TRUNCATE)
├── data.sql                    # Datos de ejemplo (usuarios, productos, inventario, pedidos)
├── dml.sql                     # Mini DML para probar y evidenciar los triggers
└── README.md                   # Este documento
```
---

## 💡 Orden de Ejecucion
1.`ddl.sql`

2.`triggers.sql`

3.`data.sql`

4.`dml.sql`

---
## 🚀 Instrucciones de Ejecución
## 1. Crear esquema
En PgAdmin, abra y ejecute `ddl.sql` para crear todas las tablas y relaciones.

## 2. Agregar triggers
Abra y ejecute `triggers.sql` para definir la función de auditoría y los triggers en productos.

## 3. Poblar datos de ejemplo
Abra y ejecute `data.sql` para insertar:

    - 10 usuarios
    - 15 productos
    - Stock inicial (100 unidades cada producto)
    - 30 pedidos de prueba
    
## 4. Probar auditoría
Abra y ejecute `dml.sql` para:

    - INSERT / UPDATE / DELETE de un “Producto Test”
    - TRUNCATE en cascada (detalle_pedido, productos)
    - SELECT sobre auditoria para verificar los eventos

---

## 📋 Descripción de Scripts
## 1. ddl.sql
Define las tablas:

   - `usuarios`
   - `productos`
   - `pedidos`
   - `detalle_pedido`
   - `inventario`
   - `auditoria`
   - Incluye claves primarias, foráneas y restricciones CHECK.

## 2. triggers.sql
Limpia triggers y función previos.

Crea fn_auditar() en PL/pgSQL, que registra en auditoria los eventos:
   - BEFORE/AFTER INSERT
   - BEFORE/AFTER UPDATE
   - BEFORE/AFTER DELETE
   - BEFORE/AFTER TRUNCATE
   - Triggers sobre productos.

## 3. data.sql
Inserta:
   
   - 10 usuarios de ejemplo
   - 15 productos con distintos tipos (cuaderno, tarjeta, agenda)
   - Inicializa inventario con stock = 100
   - 30 pedidos de prueba con detalles históricos

## 4. dml.sql
Mini DML para evidenciar la auditoría:

   - INSERT de “Producto Test”
   - UPDATE de precio y descripción
   - DELETE del registro
   - TRUNCATE en cascada (detalle_pedido, productos)
   - SELECT de auditoria
