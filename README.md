# Carga de Dimensiones — Data Warehouse (`VentasDW`)

Repositorio con el script SQL para crear la base de datos del Data Warehouse (`VentasDW`), modelar las tablas de dimensiones y cargar los registros iniciales.

## Tablas de dimensión creadas
- **DimCliente**: información de clientes (`ClienteKey`, `CodigoCliente`, `NombreCompleto`, `Correo`, `Ciudad`, `Pais`, `FechaCarga`).
- **DimProducto**: catálogo de productos (`ProductoKey`, `CodigoProducto`, `NombreProducto`, `Categoria`, `Marca`, `PrecioUnitario`, `FechaCarga`).
- **DimSucursal**: sucursales operativas (`SucursalKey`, `CodigoSucursal`, `NombreSucursal`, `Provincia`, `Activo`, `FechaCarga`).
- **DimTiempo**: calendario con llave numérica `YYYYMMDD` (`TiempoKey`, `Fecha`, `Anio`, `Mes`, `NombreMes`, `Dia`, `NombreDia`, `Trimestre`).

## Ejecución
1. Abrir el archivo SQL en **SQL Server Management Studio (SSMS)**.
2. Ejecutar el script completo (`F5`) para crear `VentasDW`, definir las tablas y poblar los datos.
3. Verificar los conteos y registros con las consultas `SELECT` al final del script.
