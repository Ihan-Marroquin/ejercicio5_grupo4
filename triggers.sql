-- triggers.sql

-- Limpieza de triggers y función previos
DROP TRIGGER IF EXISTS trg_before_insert_productos ON productos;
DROP TRIGGER IF EXISTS trg_after_insert_productos ON productos;
DROP TRIGGER IF EXISTS trg_before_update_productos ON productos;
DROP TRIGGER IF EXISTS trg_after_update_productos ON productos;
DROP TRIGGER IF EXISTS trg_before_delete_productos ON productos;
DROP TRIGGER IF EXISTS trg_after_delete_productos ON productos;
DROP TRIGGER IF EXISTS trg_before_truncate_productos ON productos;
DROP TRIGGER IF EXISTS trg_after_truncate_productos ON productos;

DROP FUNCTION IF EXISTS fn_auditar();

-- Función de auditoría
CREATE OR REPLACE FUNCTION fn_auditar() RETURNS TRIGGER AS $$
DECLARE
  pk_val INTEGER;
BEGIN
  IF TG_OP = 'TRUNCATE' THEN
    INSERT INTO auditoria(tabla, operacion, fecha)
    VALUES (TG_TABLE_NAME, TG_OP, NOW());
    RETURN NULL;
  END IF;

  -- Determinar el valor de la PK según la operación
  IF TG_OP = 'INSERT' THEN
    pk_val := NEW.producto_id;
  ELSE
    pk_val := OLD.producto_id;
  END IF;

  INSERT INTO auditoria (
    tabla, operacion, registro_id, datos_anterior, datos_nuevo, fecha
  ) VALUES (
    TG_TABLE_NAME,
    TG_OP,
    pk_val,
    to_jsonb(OLD),
    to_jsonb(NEW),
    NOW()
  );

  RETURN CASE
    WHEN TG_OP = 'DELETE' THEN OLD
    ELSE NEW
  END;
END;
$$ LANGUAGE plpgsql;

-- Trigger Before para insert de productos
CREATE TRIGGER trg_before_insert_productos
  BEFORE INSERT  ON productos FOR EACH ROW EXECUTE FUNCTION fn_auditar();

-- Trigger After para insert de productos
CREATE TRIGGER trg_after_insert_productos
  AFTER INSERT   ON productos FOR EACH ROW EXECUTE FUNCTION fn_auditar();

-- Trigger Before para update de productos
CREATE TRIGGER trg_before_update_productos
BEFORE UPDATE ON productos FOR EACH ROW EXECUTE FUNCTION fn_auditar();

-- Trigger After para update de productos
CREATE TRIGGER trg_after_update_productos
AFTER UPDATE ON productos FOR EACH ROW EXECUTE FUNCTION fn_auditar();

-- Trigger Before para delete de productos
CREATE TRIGGER trg_before_delete_productos
BEFORE DELETE ON productos FOR EACH ROW EXECUTE FUNCTION fn_auditar();

-- Trigger After para delete de productos
CREATE TRIGGER trg_after_delete_productos
AFTER DELETE ON productos FOR EACH ROW EXECUTE FUNCTION fn_auditar();

-- Trigger Before para truncate de productos
CREATE TRIGGER trg_before_truncate_productos
BEFORE TRUNCATE ON productos EXECUTE FUNCTION fn_auditar();

-- Trigger After para truncate de productos
CREATE TRIGGER trg_after_truncate_productos
AFTER TRUNCATE ON productos EXECUTE FUNCTION fn_auditar();