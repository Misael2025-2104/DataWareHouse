-- =============================================
-- 1. CREAR BASE DE DATOS DATA WAREHOUSE
-- =============================================
IF DB_ID('VentasDW') IS NULL
BEGIN
    CREATE DATABASE VentasDW;
END
GO

USE VentasDW;
GO

-- =============================================
-- 2. CREAR TABLAS DE DIMENSIONES
-- =============================================

-- Dimensión Cliente
IF OBJECT_ID('dbo.DimCliente', 'U') IS NOT NULL DROP TABLE dbo.DimCliente;
CREATE TABLE dbo.DimCliente (
    ClienteKey      INT IDENTITY(1,1) PRIMARY KEY,
    CodigoCliente   VARCHAR(20)  NOT NULL UNIQUE,
    NombreCompleto  VARCHAR(120) NOT NULL,
    Correo          VARCHAR(100) NULL,
    Ciudad          VARCHAR(80)  NOT NULL,
    Pais            VARCHAR(60)  NOT NULL DEFAULT 'República Dominicana',
    FechaCarga      DATETIME     NOT NULL DEFAULT GETDATE()
);

-- Dimensión Producto
IF OBJECT_ID('dbo.DimProducto', 'U') IS NOT NULL DROP TABLE dbo.DimProducto;
CREATE TABLE dbo.DimProducto (
    ProductoKey     INT IDENTITY(1,1) PRIMARY KEY,
    CodigoProducto  VARCHAR(20)    NOT NULL UNIQUE,
    NombreProducto  VARCHAR(120)   NOT NULL,
    Categoria       VARCHAR(60)    NOT NULL,
    Marca           VARCHAR(60)    NOT NULL,
    PrecioUnitario  DECIMAL(12,2)  NOT NULL,
    FechaCarga      DATETIME       NOT NULL DEFAULT GETDATE()
);

-- Dimensión Sucursal
IF OBJECT_ID('dbo.DimSucursal', 'U') IS NOT NULL DROP TABLE dbo.DimSucursal;
CREATE TABLE dbo.DimSucursal (
    SucursalKey     INT IDENTITY(1,1) PRIMARY KEY,
    CodigoSucursal  VARCHAR(20)  NOT NULL UNIQUE,
    NombreSucursal  VARCHAR(100) NOT NULL,
    Provincia       VARCHAR(80)  NOT NULL,
    Activo          BIT          NOT NULL DEFAULT 1,
    FechaCarga      DATETIME     NOT NULL DEFAULT GETDATE()
);

-- Dimensión Tiempo
IF OBJECT_ID('dbo.DimTiempo', 'U') IS NOT NULL DROP TABLE dbo.DimTiempo;
CREATE TABLE dbo.DimTiempo (
    TiempoKey       INT          PRIMARY KEY, -- Formato YYYYMMDD (ej. 20261124)
    Fecha           DATE         NOT NULL UNIQUE,
    Anio            INT          NOT NULL,
    Mes             INT          NOT NULL,
    NombreMes       VARCHAR(20)  NOT NULL,
    Dia             INT          NOT NULL,
    NombreDia       VARCHAR(20)  NOT NULL,
    Trimestre       INT          NOT NULL
);
GO

-- =============================================
-- 3. CARGAR DATOS EN LAS DIMENSIONES
-- =============================================

INSERT INTO dbo.DimCliente (CodigoCliente, NombreCompleto, Correo, Ciudad, Pais)
VALUES
    ('CLI-001', 'Misael Cuello', 'misael.cuello@ejemplo.com', 'Santo Domingo', 'República Dominicana'),
    ('CLI-002', 'Ana Gómez', 'ana.gomez@ejemplo.com', 'Santiago', 'República Dominicana'),
    ('CLI-003', 'Carlos Pérez', 'carlos.perez@ejemplo.com', 'San Cristóbal', 'República Dominicana'),
    ('CLI-004', 'Lucía Martínez', 'lucia.martinez@ejemplo.com', 'La Romana', 'República Dominicana');

INSERT INTO dbo.DimProducto (CodigoProducto, NombreProducto, Categoria, Marca, PrecioUnitario)
VALUES
    ('PRD-001', 'Laptop 15 Pulgadas', 'Tecnología', 'TechBrand', 38500.00),
    ('PRD-002', 'Mouse Inalámbrico', 'Accesorios', 'ClickPro', 950.00),
    ('PRD-003', 'Monitor 24 Pulgadas', 'Tecnología', 'ViewMax', 11200.00),
    ('PRD-004', 'Teclado Mecánico', 'Accesorios', 'KeyMaster', 2400.00);

INSERT INTO dbo.DimSucursal (CodigoSucursal, NombreSucursal, Provincia, Activo)
VALUES
    ('SUC-01', 'Sucursal Central', 'Distrito Nacional', 1),
    ('SUC-02', 'Sucursal Cibao', 'Santiago', 1),
    ('SUC-03', 'Sucursal Sur', 'San Cristóbal', 1);

INSERT INTO dbo.DimTiempo (TiempoKey, Fecha, Anio, Mes, NombreMes, Dia, NombreDia, Trimestre)
VALUES
    (20261122, '2026-11-22', 2026, 11, 'Noviembre', 22, 'Domingo', 4),
    (20261123, '2026-11-23', 2026, 11, 'Noviembre', 23, 'Lunes', 4),
    (20261124, '2026-11-24', 2026, 11, 'Noviembre', 24, 'Martes', 4);
GO

-- =============================================
-- 4. CONSULTAS DE VERIFICACIÓN / EVIDENCIA
-- =============================================
SELECT 'DimCliente'  AS Tabla, COUNT(*) AS TotalFilas FROM dbo.DimCliente
UNION ALL
SELECT 'DimProducto' AS Tabla, COUNT(*) AS TotalFilas FROM dbo.DimProducto
UNION ALL
SELECT 'DimSucursal' AS Tabla, COUNT(*) AS TotalFilas FROM dbo.DimSucursal
UNION ALL
SELECT 'DimTiempo'   AS Tabla, COUNT(*) AS TotalFilas FROM dbo.DimTiempo;

SELECT * FROM dbo.DimCliente;
SELECT * FROM dbo.DimProducto;
SELECT * FROM dbo.DimSucursal;
SELECT * FROM dbo.DimTiempo;
GO