-- ============================================================
-- FERRETERÍA "TICO" — Script de configuración para Supabase
-- Práctica 3.1 — ESCOM — IPN · Grupo 3CV2
-- ============================================================

-- 1. TABLAS MAESTRAS (Base)
CREATE TABLE IF NOT EXISTS categoria (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS producto (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  marca VARCHAR(50),
  precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
  stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
  id_categoria INT NOT NULL REFERENCES categoria(id) ON DELETE RESTRICT
);

-- 2. NUEVAS TABLAS (Requerimientos de la entrevista)
CREATE TABLE IF NOT EXISTS proveedor (
  id SERIAL PRIMARY KEY,
  empresa VARCHAR(100) NOT NULL,
  telefono VARCHAR(20),
  direccion TEXT,
  contacto VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS empleado (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  telefono VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS cliente (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  telefono VARCHAR(20)
);

-- Relación N:M entre Productos y Proveedores
CREATE TABLE IF NOT EXISTS producto_proveedor (
  id_producto INT REFERENCES producto(id) ON DELETE CASCADE,
  id_proveedor INT REFERENCES proveedor(id) ON DELETE CASCADE,
  PRIMARY KEY (id_producto, id_proveedor)
);

-- Gestión de Ventas
CREATE TABLE IF NOT EXISTS venta (
  id SERIAL PRIMARY KEY,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total DECIMAL(10,2) DEFAULT 0,
  id_cliente INT REFERENCES cliente(id) ON DELETE SET NULL,
  id_empleado INT REFERENCES empleado(id) NOT NULL
);

-- Detalle de Ventas
CREATE TABLE IF NOT EXISTS venta_detalle (
  id_venta INT REFERENCES venta(id) ON DELETE CASCADE,
  id_producto INT REFERENCES producto(id),
  cantidad INT NOT NULL CHECK (cantidad > 0),
  precio_unitario DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_venta, id_producto)
);

-- 3. LÓGICA AUTOMÁTICA (Trigger para stock)
CREATE OR REPLACE FUNCTION actualizar_stock_venta()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE producto 
  SET stock = stock - NEW.cantidad
  WHERE id = NEW.id_producto;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_actualizar_stock
AFTER INSERT ON venta_detalle
FOR EACH ROW EXECUTE FUNCTION actualizar_stock_venta();

-- 4. SEGURIDAD (Habilitar acceso público para la práctica)
ALTER TABLE categoria ENABLE ROW LEVEL SECURITY;
ALTER TABLE producto ENABLE ROW LEVEL SECURITY;
ALTER TABLE proveedor ENABLE ROW LEVEL SECURITY;
ALTER TABLE empleado ENABLE ROW LEVEL SECURITY;
ALTER TABLE cliente ENABLE ROW LEVEL SECURITY;
ALTER TABLE venta ENABLE ROW LEVEL SECURITY;
ALTER TABLE venta_detalle ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Acceso público general" ON categoria FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso público general" ON producto FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso público general" ON proveedor FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso público general" ON empleado FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso público general" ON cliente FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso público general" ON venta FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso público general" ON venta_detalle FOR ALL USING (true) WITH CHECK (true);

-- 5. DATOS DE PRUEBA ACTUALIZADOS
INSERT INTO categoria (nombre) VALUES ('Herramientas'), ('Plomería'), ('Eléctrico'), ('Pintura');
INSERT INTO empleado (nombre, telefono) VALUES ('Laura Navarrete', '5512345678'), ('Diego Patiño', '5587654321');
INSERT INTO cliente (nombre, telefono) VALUES ('Cliente General', '0000000000');
INSERT INTO proveedor (empresa, contacto) VALUES ('Truper', 'Ing. Herramientas'), ('Comex', 'Lic. Color');

INSERT INTO producto (nombre, marca, precio, stock, id_categoria) VALUES
('Martillo 16oz', 'Truper', 189.00, 24, 1),
('Foco LED 10W', 'Philips', 45.00, 2, 3);
