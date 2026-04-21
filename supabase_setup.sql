-- ============================================================
-- FERRETERÍA "TICO" — Script de configuración para Supabase
-- Práctica 3.1 — Bases de Datos — ESCOM — IPN
--
-- INSTRUCCIONES:
-- 1. Ve a supabase.com y crea una cuenta gratuita
-- 2. Crea un nuevo proyecto
-- 3. Ve a SQL Editor y pega TODO este script
-- 4. Haz clic en "Run"
-- ============================================================

-- Tabla categorias
CREATE TABLE IF NOT EXISTS categoria (
  id       SERIAL PRIMARY KEY,
  nombre   VARCHAR(50) NOT NULL
);

-- Tabla productos
CREATE TABLE IF NOT EXISTS producto (
  id           SERIAL PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  marca        VARCHAR(50),
  precio       DECIMAL(10,2) NOT NULL CHECK (precio > 0),
  stock        INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
  id_categoria INT NOT NULL REFERENCES categoria(id) ON DELETE RESTRICT
);

-- Habilitar acceso público (Row Level Security deshabilitado para demo)
ALTER TABLE categoria ENABLE ROW LEVEL SECURITY;
ALTER TABLE producto  ENABLE ROW LEVEL SECURITY;

-- Políticas de acceso público (para la práctica)
CREATE POLICY "Acceso público categoria"
  ON categoria FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Acceso público producto"
  ON producto FOR ALL USING (true) WITH CHECK (true);

-- ── DATOS DE PRUEBA ─────────────────────────────────────────
INSERT INTO categoria (nombre) VALUES
  ('Herramientas'),
  ('Plomería'),
  ('Eléctrico'),
  ('Pintura'),
  ('Jardinería');

INSERT INTO producto (nombre, marca, precio, stock, id_categoria) VALUES
  ('Martillo de uña 16oz',       'Truper',    189.00, 24, 1),
  ('Desarmador Phillips #2',     'Stanley',    65.00,  3, 1),
  ('Pinzas de corte 7"',         'Urrea',      98.00, 12, 1),
  ('Llave adjustable 10"',       'Truper',    145.00,  8, 1),
  ('Llave de paso 1/2"',         'Urrea',     120.00, 15, 2),
  ('Tubo PVC 1/2" x metro',      'Amanco',     28.00, 50, 2),
  ('Codo PVC 90° 1/2"',          'Amanco',      8.50, 80, 2),
  ('Foco LED 10W',               'Philips',    45.00,  2, 3),
  ('Cable cal. 12 rollo 100m',   'Condumex',  850.00,  6, 3),
  ('Interruptor sencillo',       'Volteck',    32.00, 20, 3),
  ('Pintura vinílica blanca 4L', 'Comex',     280.00, 18, 4),
  ('Brocha 3"',                  'Purdy',      95.00,  1, 4),
  ('Rodillo 9" con charola',     'Shur-Line',  75.00,  9, 4),
  ('Manguera 15m',               'Truper',    189.00, 11, 5),
  ('Pala cuadrada',              'Truper',    235.00,  4, 5);
