using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Sistema.Datos.Migrations
{
    public partial class _2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "categoria",
                columns: table => new
                {
                    idcategoria = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    nombre = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: false),
                    descripcion = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    condicion = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_categoria", x => x.idcategoria);
                });

            migrationBuilder.CreateTable(
                name: "configuracion",
                columns: table => new
                {
                    idconfiguracion = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    descripcion = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    valor = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_configuracion", x => x.idconfiguracion);
                });

            migrationBuilder.CreateTable(
                name: "persona",
                columns: table => new
                {
                    idpersona = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    tipo_persona = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    nombre = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    tipo_documento = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    num_documento = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    direccion = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    telefono = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    email = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_persona", x => x.idpersona);
                });

            migrationBuilder.CreateTable(
                name: "rol",
                columns: table => new
                {
                    idrol = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    nombre = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    descripcion = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    condicion = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_rol", x => x.idrol);
                });

            migrationBuilder.CreateTable(
                name: "tipoArticulo",
                columns: table => new
                {
                    idTipoArticulo = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    tipoArticulo = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    condicion = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_tipoArticulo", x => x.idTipoArticulo);
                });

            migrationBuilder.CreateTable(
                name: "articulo",
                columns: table => new
                {
                    idarticulo = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    idcategoria = table.Column<int>(type: "int", nullable: false),
                    codigo = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    nombre = table.Column<string>(type: "nvarchar(40)", maxLength: 40, nullable: true),
                    precio_venta = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    precio_compra = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    stock = table.Column<int>(type: "int", nullable: false),
                    descripcion = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    condicion = table.Column<bool>(type: "bit", nullable: false),
                    foto = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    iva = table.Column<bool>(type: "bit", nullable: false),
                    utilidad = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_articulo", x => x.idarticulo);
                    table.ForeignKey(
                        name: "FK_articulo_categoria_idcategoria",
                        column: x => x.idcategoria,
                        principalTable: "categoria",
                        principalColumn: "idcategoria",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "usuario",
                columns: table => new
                {
                    idusuario = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    idrol = table.Column<int>(type: "int", nullable: false),
                    nombre = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    tipo_documento = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    num_documento = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    direccion = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    telefono = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    password_hash = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    password_salt = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    condicion = table.Column<bool>(type: "bit", nullable: false),
                    foto = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_usuario", x => x.idusuario);
                    table.ForeignKey(
                        name: "FK_usuario_rol_idrol",
                        column: x => x.idrol,
                        principalTable: "rol",
                        principalColumn: "idrol",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "articulo_tipoArticulo",
                columns: table => new
                {
                    idarticulo = table.Column<int>(type: "int", nullable: false),
                    idtipoArticulo = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_articulo_tipoArticulo", x => new { x.idarticulo, x.idtipoArticulo });
                    table.ForeignKey(
                        name: "FK_articulo_tipoArticulo_articulo_idarticulo",
                        column: x => x.idarticulo,
                        principalTable: "articulo",
                        principalColumn: "idarticulo",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_articulo_tipoArticulo_tipoArticulo_idtipoArticulo",
                        column: x => x.idtipoArticulo,
                        principalTable: "tipoArticulo",
                        principalColumn: "idTipoArticulo",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ingreso",
                columns: table => new
                {
                    idingreso = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    idproveedor = table.Column<int>(type: "int", nullable: false),
                    idusuario = table.Column<int>(type: "int", nullable: false),
                    tipo_comprobante = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    serie_comprobante = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    num_comprobante = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    fecha_hora = table.Column<DateTime>(type: "datetime2", nullable: false),
                    impuesto12 = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    impuesto0 = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    total = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    estado = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ingreso", x => x.idingreso);
                    table.ForeignKey(
                        name: "FK_ingreso_persona_idproveedor",
                        column: x => x.idproveedor,
                        principalTable: "persona",
                        principalColumn: "idpersona",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ingreso_usuario_idusuario",
                        column: x => x.idusuario,
                        principalTable: "usuario",
                        principalColumn: "idusuario",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "venta",
                columns: table => new
                {
                    idventa = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    idcliente = table.Column<int>(type: "int", nullable: false),
                    idusuario = table.Column<int>(type: "int", nullable: false),
                    tipo_comprobante = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    serie_comprobante = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    num_comprobante = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    fecha_hora = table.Column<DateTime>(type: "datetime2", nullable: false),
                    impuesto12 = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    impuesto0 = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    descuento = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    total = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    subtotal = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    estado = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_venta", x => x.idventa);
                    table.ForeignKey(
                        name: "FK_venta_persona_idcliente",
                        column: x => x.idcliente,
                        principalTable: "persona",
                        principalColumn: "idpersona",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_venta_usuario_idusuario",
                        column: x => x.idusuario,
                        principalTable: "usuario",
                        principalColumn: "idusuario",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "detalle_ingreso",
                columns: table => new
                {
                    iddetalle_ingreso = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    idingreso = table.Column<int>(type: "int", nullable: false),
                    idarticulo = table.Column<int>(type: "int", nullable: false),
                    cantidad = table.Column<int>(type: "int", nullable: false),
                    precio_compra = table.Column<decimal>(type: "decimal(16,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_detalle_ingreso", x => x.iddetalle_ingreso);
                    table.ForeignKey(
                        name: "FK_detalle_ingreso_articulo_idarticulo",
                        column: x => x.idarticulo,
                        principalTable: "articulo",
                        principalColumn: "idarticulo",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_detalle_ingreso_ingreso_idingreso",
                        column: x => x.idingreso,
                        principalTable: "ingreso",
                        principalColumn: "idingreso",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "detalle_venta",
                columns: table => new
                {
                    iddetalle_venta = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    idventa = table.Column<int>(type: "int", nullable: false),
                    idarticulo = table.Column<int>(type: "int", nullable: false),
                    cantidad = table.Column<int>(type: "int", nullable: false),
                    precio_venta = table.Column<decimal>(type: "decimal(16,2)", nullable: false),
                    descuento = table.Column<decimal>(type: "decimal(16,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_detalle_venta", x => x.iddetalle_venta);
                    table.ForeignKey(
                        name: "FK_detalle_venta_articulo_idarticulo",
                        column: x => x.idarticulo,
                        principalTable: "articulo",
                        principalColumn: "idarticulo",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_detalle_venta_venta_idventa",
                        column: x => x.idventa,
                        principalTable: "venta",
                        principalColumn: "idventa",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "rol",
                columns: new[] { "idrol", "condicion", "descripcion", "nombre" },
                values: new object[] { 1, true, "Administrador de sitio", "Administrador" });

            migrationBuilder.InsertData(
                table: "rol",
                columns: new[] { "idrol", "condicion", "descripcion", "nombre" },
                values: new object[] { 2, true, "Vendedor de sitio", "Vendedor" });

            migrationBuilder.InsertData(
                table: "rol",
                columns: new[] { "idrol", "condicion", "descripcion", "nombre" },
                values: new object[] { 3, true, "Almacenero de sitio", "Almacenero" });

            migrationBuilder.InsertData(
                table: "usuario",
                columns: new[] { "idusuario", "condicion", "direccion", "email", "foto", "idrol", "nombre", "num_documento", "password_hash", "password_salt", "telefono", "tipo_documento" },
                values: new object[] { 1, true, "Magdalena", "adrian-2222@hotmail.com", "", 1, "Adrian Ortiz", "1718348053", new byte[] { 217, 195, 179, 138, 110, 192, 162, 19, 55, 157, 45, 138, 16, 161, 0, 112, 12, 54, 169, 81, 255, 106, 101, 171, 101, 94, 164, 74, 46, 231, 40, 238, 196, 104, 41, 146, 28, 21, 95, 180, 128, 59, 3, 236, 133, 188, 198, 54, 27, 200, 187, 70, 87, 11, 106, 190, 195, 78, 51, 28, 9, 1, 103, 233 }, new byte[] { 181, 75, 154, 220, 218, 75, 10, 52, 0, 232, 84, 149, 230, 155, 101, 181, 18, 130, 112, 16, 82, 211, 235, 144, 12, 32, 128, 29, 195, 181, 11, 124, 128, 20, 110, 40, 221, 50, 150, 227, 130, 115, 153, 84, 64, 92, 236, 60, 208, 162, 5, 14, 39, 251, 195, 145, 85, 103, 188, 104, 90, 88, 128, 97, 168, 35, 83, 104, 164, 50, 81, 85, 65, 121, 239, 222, 251, 122, 67, 8, 0, 94, 162, 184, 231, 207, 127, 201, 195, 128, 179, 45, 119, 217, 94, 146, 173, 172, 138, 95, 181, 244, 37, 116, 152, 42, 75, 198, 44, 186, 182, 93, 239, 222, 92, 66, 3, 93, 6, 158, 124, 58, 19, 35, 204, 107, 139, 215 }, "0983740668", "Cedula" });

            migrationBuilder.CreateIndex(
                name: "IX_articulo_idcategoria",
                table: "articulo",
                column: "idcategoria");

            migrationBuilder.CreateIndex(
                name: "IX_articulo_tipoArticulo_idtipoArticulo",
                table: "articulo_tipoArticulo",
                column: "idtipoArticulo");

            migrationBuilder.CreateIndex(
                name: "IX_detalle_ingreso_idarticulo",
                table: "detalle_ingreso",
                column: "idarticulo");

            migrationBuilder.CreateIndex(
                name: "IX_detalle_ingreso_idingreso",
                table: "detalle_ingreso",
                column: "idingreso");

            migrationBuilder.CreateIndex(
                name: "IX_detalle_venta_idarticulo",
                table: "detalle_venta",
                column: "idarticulo");

            migrationBuilder.CreateIndex(
                name: "IX_detalle_venta_idventa",
                table: "detalle_venta",
                column: "idventa");

            migrationBuilder.CreateIndex(
                name: "IX_ingreso_idproveedor",
                table: "ingreso",
                column: "idproveedor");

            migrationBuilder.CreateIndex(
                name: "IX_ingreso_idusuario",
                table: "ingreso",
                column: "idusuario");

            migrationBuilder.CreateIndex(
                name: "IX_usuario_idrol",
                table: "usuario",
                column: "idrol");

            migrationBuilder.CreateIndex(
                name: "IX_venta_idcliente",
                table: "venta",
                column: "idcliente");

            migrationBuilder.CreateIndex(
                name: "IX_venta_idusuario",
                table: "venta",
                column: "idusuario");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "articulo_tipoArticulo");

            migrationBuilder.DropTable(
                name: "configuracion");

            migrationBuilder.DropTable(
                name: "detalle_ingreso");

            migrationBuilder.DropTable(
                name: "detalle_venta");

            migrationBuilder.DropTable(
                name: "tipoArticulo");

            migrationBuilder.DropTable(
                name: "ingreso");

            migrationBuilder.DropTable(
                name: "articulo");

            migrationBuilder.DropTable(
                name: "venta");

            migrationBuilder.DropTable(
                name: "categoria");

            migrationBuilder.DropTable(
                name: "persona");

            migrationBuilder.DropTable(
                name: "usuario");

            migrationBuilder.DropTable(
                name: "rol");
        }
    }
}
