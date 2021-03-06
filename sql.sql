USE [master]
GO
/****** Object:  Database [dbsistema]    Script Date: 04/10/2021 20:42:30 ******/
CREATE DATABASE [dbsistema]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbsistema', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\dbsistema.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbsistema_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\dbsistema_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dbsistema] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbsistema].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbsistema] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbsistema] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbsistema] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbsistema] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbsistema] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbsistema] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [dbsistema] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbsistema] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbsistema] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbsistema] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbsistema] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbsistema] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbsistema] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbsistema] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbsistema] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbsistema] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbsistema] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbsistema] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbsistema] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbsistema] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbsistema] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbsistema] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbsistema] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbsistema] SET  MULTI_USER 
GO
ALTER DATABASE [dbsistema] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbsistema] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbsistema] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbsistema] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [dbsistema] SET DELAYED_DURABILITY = DISABLED 
GO
USE [dbsistema]
GO
/****** Object:  Table [dbo].[articulo]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[articulo](
	[idarticulo] [int] IDENTITY(1,1) NOT NULL,
	[idcategoria] [int] NOT NULL,
	[codigo] [varchar](50) NULL,
	[nombre] [varchar](100) NOT NULL,
	[precio_venta] [decimal](11, 2) NULL,
	[stock] [int] NOT NULL,
	[descripcion] [varchar](256) NULL,
	[condicion] [bit] NOT NULL DEFAULT ((1)),
	[foto] [varchar](255) NULL,
	[iva] [bit] NOT NULL,
	[utilidad] [int] NULL,
	[precio_compra] [decimal](11, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[idarticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[articulo_tipoArticulo]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[articulo_tipoArticulo](
	[idarticulo] [int] NOT NULL,
	[idtipoArticulo] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[categoria]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[categoria](
	[idcategoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](256) NULL,
	[condicion] [bit] NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[idcategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[configuracion]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[configuracion](
	[descripcion] [varchar](255) NULL,
	[valor] [varchar](255) NULL,
	[idconfiguracion] [int] IDENTITY(2,1) NOT NULL,
 CONSTRAINT [PK__configur__3213E83F83662A2A] PRIMARY KEY CLUSTERED 
(
	[idconfiguracion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[detalle_ingreso]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_ingreso](
	[iddetalle_ingreso] [int] IDENTITY(1,1) NOT NULL,
	[idingreso] [int] NOT NULL,
	[idarticulo] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio_compra] [decimal](11, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iddetalle_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[detalle_venta]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_venta](
	[iddetalle_venta] [int] IDENTITY(1,1) NOT NULL,
	[idventa] [int] NOT NULL,
	[idarticulo] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio_venta] [decimal](11, 2) NOT NULL,
	[descuento] [decimal](11, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iddetalle_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ingreso]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ingreso](
	[idingreso] [int] IDENTITY(1,1) NOT NULL,
	[idproveedor] [int] NOT NULL,
	[idusuario] [int] NOT NULL,
	[tipo_comprobante] [varchar](20) NOT NULL,
	[serie_comprobante] [varchar](7) NULL,
	[num_comprobante] [varchar](10) NOT NULL,
	[fecha_hora] [date] NOT NULL,
	[impuesto12] [decimal](11, 2) NULL,
	[total] [decimal](11, 2) NOT NULL,
	[estado] [varchar](20) NOT NULL,
	[impuesto0] [decimal](11, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[idingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[persona]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[persona](
	[idpersona] [int] IDENTITY(1,1) NOT NULL,
	[tipo_persona] [varchar](20) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[tipo_documento] [varchar](20) NULL,
	[num_documento] [varchar](20) NULL,
	[direccion] [varchar](70) NULL,
	[telefono] [varchar](20) NULL,
	[email] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idpersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[rol]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[rol](
	[idrol] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](30) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[condicion] [bit] NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[idrol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tipoArticulo]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tipoArticulo](
	[idTipoArticulo] [int] IDENTITY(1,1) NOT NULL,
	[tipoArticulo] [varchar](255) NOT NULL,
	[condicion] [bit] NULL,
 CONSTRAINT [PK__tipo__3213E83F8BA7A84C] PRIMARY KEY CLUSTERED 
(
	[idTipoArticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuario](
	[idusuario] [int] IDENTITY(1,1) NOT NULL,
	[idrol] [int] NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[tipo_documento] [varchar](20) NULL,
	[num_documento] [varchar](20) NULL,
	[direccion] [varchar](70) NULL,
	[telefono] [varchar](20) NULL,
	[email] [varchar](50) NOT NULL,
	[password_hash] [varbinary](max) NOT NULL,
	[password_salt] [varbinary](max) NOT NULL,
	[condicion] [bit] NULL CONSTRAINT [DF__usuario__condici__1DE57479]  DEFAULT ((1)),
	[foto] [varchar](255) NULL,
 CONSTRAINT [PK__usuario__080A9743E16FB37A] PRIMARY KEY CLUSTERED 
(
	[idusuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[venta]    Script Date: 04/10/2021 20:42:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[venta](
	[idventa] [int] IDENTITY(1,1) NOT NULL,
	[idcliente] [int] NOT NULL,
	[idusuario] [int] NOT NULL,
	[tipo_comprobante] [varchar](20) NOT NULL,
	[serie_comprobante] [varchar](7) NULL,
	[num_comprobante] [varchar](10) NOT NULL,
	[fecha_hora] [date] NOT NULL,
	[impuesto12] [decimal](11, 2) NOT NULL,
	[total] [decimal](11, 2) NOT NULL,
	[estado] [varchar](20) NOT NULL,
	[impuesto0] [decimal](11, 2) NULL,
	[descuento] [decimal](11, 2) NULL,
	[subtotal] [decimal](11, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[idventa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[articulo] ON 

INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (27, 2020, N'asdfg', N'sopa', CAST(1.00 AS Decimal(11, 2)), 9, N'gfjhfjgfgfhgfh', 1, N'', 1, 10, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (29, 11, N'qqqqq', N'arroz2', CAST(2.15 AS Decimal(11, 2)), 25, N'uiyiuhiuhjjhkkj', 1, N'20210811204630-arroz.jpg', 1, 12, CAST(1.94 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (30, 1003, N'87989', N'cuya', CAST(3.45 AS Decimal(11, 2)), 50, N'iuyiuyiuiuyiuyiu', 1, N'', 0, 13, CAST(3.20 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (31, 2, N'cscscscs74', N'casa de 7 pisis 22222222', CAST(6.00 AS Decimal(11, 2)), 23, N'casa con garage y patio2222222222', 1, N'', 0, 10, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (32, 2022, N'12345', N'PAn1pAn1', CAST(9.66 AS Decimal(11, 2)), 12, N'descripco', 1, N'', 1, 10, CAST(9.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (33, 2014, N'12323', N'jamon', CAST(6.49 AS Decimal(11, 2)), 105, N'jhggggggggggggggggggggg', 1, N'', 0, 10, CAST(6.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (34, 2016, N'12321', N'pizza', CAST(10.00 AS Decimal(11, 2)), 1, N'jhjkhkjhkkjhkhkjhkj', 1, N'', 0, 10, CAST(9.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (37, 2003, N'pr123', N'prueba1', CAST(90.00 AS Decimal(11, 2)), 1, N'prueba1', 1, N'', 0, 10, CAST(87.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (38, 2017, N'pr234', N'prueba2', CAST(77.00 AS Decimal(11, 2)), 1, N'prueba2', 1, N'', 1, 13, CAST(65.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (39, 1003, N'pr345', N'prueba3', CAST(4.99 AS Decimal(11, 2)), 2, N'prueba3', 1, N'', 0, 12, CAST(4.20 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (40, 2017, N'pr456', N'prueba4', CAST(6.00 AS Decimal(11, 2)), 1, N'prueba4', 1, N'', 1, 20, CAST(5.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (41, 2017, N'pr567', N'prueba5', CAST(7.15 AS Decimal(11, 2)), 1, N'prueba5', 1, N'', 0, 15, CAST(6.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (43, 2016, N'pr678', N'prueba6', CAST(1.04 AS Decimal(11, 2)), 1, N'prueba6', 1, N'', 1, 25, CAST(0.64 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (49, 2003, N'gg7666', N'ggjhgjhgjhgjgjh', CAST(1.00 AS Decimal(11, 2)), 2, N'jhkjkj', 0, N'', 1, 0, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (50, 1003, N'65438', N'pruebautilida', CAST(49.50 AS Decimal(11, 2)), 17, N'pruebautilida', 1, N'', 1, 10, CAST(45.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (51, 11, N'33344', N'pruehui', CAST(87.00 AS Decimal(11, 2)), 6, N'jfjhfhfhg', 1, NULL, 1, 10, CAST(89.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (54, 1, N'qqqqwwe', N'qqqqwwe', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (71, 11, N'qqqqwwe', N'qqqqwwe2', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (74, 11, N'qqqqwwe', N'qqqqwwe3', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (76, 11, N'qqqqwwe', N'qqqqwwe4', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (78, 11, N'qqqqwwe', N'qqqqwwe5', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (80, 11, N'qqqqwwe', N'qqqqwwe6', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (81, 11, N'qqqqwwe', N'qqqqwwe7', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (85, 11, N'qqqqwwe', N'qqqqwwe8', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (87, 11, N'qqqqwwe', N'qqqqwwe9', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (89, 11, N'qqqqwwe', N'qqqqwwe10', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (90, 11, N'qqqqwwe', N'qqqqwwe11', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (91, 1003, N'lpolpo', N'lpolpo', CAST(1.07 AS Decimal(11, 2)), 1, N'jh', 1, N'', 1, 7, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (92, 11, N'qqqqwwe', N'qqqqwwe12', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (93, 11, N'qqqqwwe', N'qqqqwwe13', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'20210624120553-d.jpg', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (94, 11, N'qqqqwwe', N'qqqqwwe14', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (95, 2003, N'ygt65', N'hgfhgfhgf', CAST(1.04 AS Decimal(11, 2)), 1, N'kjgkjhghgjhjh', 1, N'', 1, 4, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (97, 2014, N'hjhjk', N'kjhkjhkjhkjkjkj', CAST(1.08 AS Decimal(11, 2)), 1, N'lklkjlkjlkjlkjlkjlkjlk', 1, N'', 1, 8, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (98, 11, N'qqqqwwe', N'qqqqwwe15', CAST(3.00 AS Decimal(11, 2)), 4, N'dddjiuighgjhgh', 1, N'ddkjjkhkjh', 1, 3, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (99, 1005, N'iuyu78', N'tyutuytuytuytu', CAST(1.06 AS Decimal(11, 2)), 1, N'uytuytuytuytuytuytu', 1, N'', 1, 6, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (100, 2016, N'y75rf', N'gfhghghgfggg', CAST(1.06 AS Decimal(11, 2)), 2, N'fhgfhgfhfhghgfhfghgfh', 0, N'', 1, 6, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (101, 2034, N'cccft', N'pruebachk', CAST(1.04 AS Decimal(11, 2)), 1, N'pr ch', 1, N'', 1, 4, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion], [foto], [iva], [utilidad], [precio_compra]) VALUES (102, 2003, N'sfghj', N'hghgfghf', CAST(1.04 AS Decimal(11, 2)), 1, N'gggggggggggggggg', 1, N'20210629220153-a.jpg', 1, 4, CAST(1.00 AS Decimal(11, 2)))
SET IDENTITY_INSERT [dbo].[articulo] OFF
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (29, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (30, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (37, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (37, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (74, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (74, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (76, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (76, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (78, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (78, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (80, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (80, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (87, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (87, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (89, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (89, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (90, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (90, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (98, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (98, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (100, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (100, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (101, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (101, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (101, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (29, 11)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (30, 8)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (31, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (31, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (31, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (31, 8)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (32, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (40, 8)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (100, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (100, 8)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (39, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (43, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (102, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (90, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (92, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (92, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (92, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (93, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (93, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (94, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (94, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (93, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (93, 8)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (99, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (99, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (97, 7)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (39, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (39, 8)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (76, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (95, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (95, 8)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (43, 2)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (49, 1)
INSERT [dbo].[articulo_tipoArticulo] ([idarticulo], [idtipoArticulo]) VALUES (49, 8)
SET IDENTITY_INSERT [dbo].[categoria] ON 

INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (1, N'Leche', N'Leche de vaca', 0)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2, N'oficina', N'articulos', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (11, N'Coomida', N'michus', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (1003, N'nueva', N'categoria', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (1005, N'casas', N'kkkkkkkk', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2003, N'Lechess', N'jeje leche', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2014, N'prueba 22', N'22 prueba', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2016, N'prueba 221', N'22 prueba', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2017, N'cat1cat1', N'detdes1', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2018, N'cat2jjjjjj', N'detdes2', 0)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2019, N'cat3', N'detdes', 0)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2020, N'cat4', N'detdes', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2021, N'cat5', N'detdes5', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2022, N'pan19', N'pan1', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2023, N'pan2', N'pan2', 0)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2033, N'lkjlk', N'lkjlkjlk', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2034, N'ccccc', N'cccccc', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2036, N'drtjioooooo', N'qase', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2037, N'drtjioooooollll', N'qase', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2038, N'okijhytfr', N'bbbbbbbbbbbb', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2039, N'zurbano', N'mijin', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2040, N'jiuytreeee', N'hgjhgjhgjhj', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2041, N'mbmnbmnmnnb', N'nbmnbmbnmn', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2042, N'jiurdrdtrdttrd', N'dtrdtrdtrdtrt', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2043, N'ventanas', N'ventanas carros.', 0)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2044, N'asdfrt', N'ffff', 0)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2045, N'pruebade notification', N'prueba de notofocationja', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2046, N'asert', N'aszxc', 1)
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2047, N'llkop', N'lkkop', 1)
SET IDENTITY_INSERT [dbo].[categoria] OFF
SET IDENTITY_INSERT [dbo].[configuracion] ON 

INSERT [dbo].[configuracion] ([descripcion], [valor], [idconfiguracion]) VALUES (N'Iva', N'12', 2)
INSERT [dbo].[configuracion] ([descripcion], [valor], [idconfiguracion]) VALUES (N'Serie', N'001', 5)
SET IDENTITY_INSERT [dbo].[configuracion] OFF
SET IDENTITY_INSERT [dbo].[detalle_ingreso] ON 

INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1, 21, 29, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (2, 21, 31, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (3, 21, 30, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (4, 22, 29, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (5, 22, 31, 4, CAST(4.56 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (6, 22, 30, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (7, 23, 30, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (8, 23, 33, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (9, 23, 32, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (10, 45, 30, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (11, 45, 33, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (12, 47, 30, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (13, 47, 33, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (14, 48, 30, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (15, 48, 33, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (16, 49, 31, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (17, 49, 30, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (18, 49, 33, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (19, 50, 31, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (20, 50, 30, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (21, 51, 31, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (22, 51, 30, 19, CAST(1.80 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (23, 51, 33, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (24, 52, 29, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (25, 52, 31, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (26, 53, 33, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (27, 53, 30, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (28, 54, 29, 74, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (29, 54, 31, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (30, 54, 30, 74, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (31, 55, 30, 74, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (32, 55, 33, 74, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (33, 55, 29, 74, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (34, 58, 29, 4, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (35, 59, 29, 4, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (36, 60, 29, 4, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (37, 61, 29, 4, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (38, 62, 43, 5, CAST(6.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (43, 64, 29, 10, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (46, 66, 29, 1, CAST(1.12 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (47, 66, 31, 1, CAST(6.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (48, 68, 31, 13, CAST(5.40 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (53, 71, 33, 10, CAST(2.07 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (54, 72, 31, 1, CAST(5.73 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (65, 72, 33, 2, CAST(3.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (66, 71, 31, 6, CAST(6.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (67, 78, 30, 1, CAST(5.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (68, 78, 33, 1, CAST(1.18 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (69, 79, 31, 1, CAST(5.73 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (70, 79, 32, 1, CAST(7.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (71, 80, 31, 1, CAST(5.73 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (72, 80, 33, 1, CAST(1.18 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (73, 81, 29, 12, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (74, 81, 30, 7, CAST(8.45 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (75, 82, 29, 10, CAST(2.50 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (76, 82, 31, 10, CAST(5.50 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (78, 84, 29, 10, CAST(2.50 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (79, 84, 31, 10, CAST(5.50 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (80, 85, 29, 10, CAST(2.50 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (81, 85, 31, 10, CAST(5.50 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (82, 86, 29, 10, CAST(3.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (83, 86, 30, 10, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (84, 86, 31, 10, CAST(8.60 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (85, 87, 29, 10, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (86, 88, 27, 10, CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1086, 1088, 31, 10, CAST(6.50 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1087, 1088, 32, 10, CAST(8.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1088, 1089, 29, 10, CAST(5.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1089, 1089, 30, 10, CAST(5.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1090, 1090, 29, 10, CAST(30.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1091, 1090, 30, 15, CAST(20.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1092, 1091, 39, 5, CAST(5.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1093, 1091, 41, 10, CAST(8.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1094, 1092, 31, 1, CAST(6.04 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1095, 1092, 33, 1, CAST(5.73 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1096, 1093, 29, 10, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1097, 1093, 31, 10, CAST(6.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1098, 1093, 30, 10, CAST(5.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1099, 1094, 29, 100, CAST(3.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1100, 1094, 33, 2, CAST(76.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1101, 1095, 29, 10, CAST(2.45 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1102, 1095, 39, 1, CAST(4.40 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1103, 1096, 31, 1, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1104, 1096, 29, 1, CAST(2.15 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1105, 1097, 29, 1, CAST(2.15 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1106, 1097, 31, 1, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1107, 1098, 29, 1, CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1108, 1099, 29, 1, CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1109, 1099, 31, 1, CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1110, 1100, 29, 1, CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1111, 1100, 33, 1, CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1112, 1101, 29, 1, CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1123, 1114, 31, 1, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1124, 1114, 32, 1, CAST(8.99 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1125, 1115, 29, 10, CAST(2.05 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1126, 1115, 30, 20, CAST(3.50 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1130, 1117, 31, 1, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1131, 1117, 49, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1135, 1121, 31, 1, CAST(4.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1136, 1121, 100, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1137, 1122, 31, 1, CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1138, 1122, 100, 1, CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio_compra]) VALUES (1139, 1123, 31, 1, CAST(4.00 AS Decimal(11, 2)))
SET IDENTITY_INSERT [dbo].[detalle_ingreso] OFF
SET IDENTITY_INSERT [dbo].[detalle_venta] ON 

INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (1, 1, 29, 3, CAST(23.00 AS Decimal(11, 2)), CAST(2.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (2, 1, 31, 2, CAST(5.00 AS Decimal(11, 2)), CAST(1.45 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (3, 2, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (4, 2, 30, 1, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (5, 3, 30, 1, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (6, 3, 101, 1, CAST(1.04 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (11, 6, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (12, 6, 49, 1, CAST(1.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (13, 7, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (14, 8, 30, 1, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (15, 8, 49, 1, CAST(1.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (16, 9, 30, 1, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (17, 11, 29, 1, CAST(2.15 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (18, 11, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (19, 12, 29, 1, CAST(2.15 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (20, 12, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (21, 12, 30, 1, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (22, 13, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (23, 14, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (24, 15, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (25, 16, 30, 1, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (26, 17, 30, 1, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (27, 18, 30, 1, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (28, 19, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (29, 20, 29, 1, CAST(2.15 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (30, 21, 29, 1, CAST(2.15 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (31, 22, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (32, 23, 29, 1, CAST(2.15 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (33, 24, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (34, 24, 49, 1, CAST(1.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (35, 25, 27, 2, CAST(1.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (36, 26, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (37, 27, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (38, 28, 30, 1, CAST(3.45 AS Decimal(11, 2)), CAST(10.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (39, 28, 92, 1, CAST(3.00 AS Decimal(11, 2)), CAST(15.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (40, 31, 29, 1, CAST(2.15 AS Decimal(11, 2)), CAST(10.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (41, 31, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(5.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (42, 32, 30, 1, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (43, 32, 49, 10, CAST(1.00 AS Decimal(11, 2)), CAST(5.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (44, 37, 29, 1, CAST(2.15 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (45, 38, 27, 1, CAST(1.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (46, 39, 29, 1, CAST(2.15 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (47, 39, 31, 2, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (48, 42, 29, 10, CAST(2.15 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (49, 42, 31, 10, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (50, 43, 30, 10, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (51, 43, 33, 65, CAST(6.49 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (52, 44, 30, 50, CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (53, 44, 33, 105, CAST(6.49 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio_venta], [descuento]) VALUES (54, 45, 31, 1, CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
SET IDENTITY_INSERT [dbo].[detalle_venta] OFF
SET IDENTITY_INSERT [dbo].[ingreso] ON 

INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1, 1, 6, N'Factura', N'123', N'0000008769', CAST(N'2019-08-19' AS Date), CAST(12.00 AS Decimal(11, 2)), CAST(100.00 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (21, 3, 6, N'factura', N'123', N'0909098765', CAST(N'2021-04-14' AS Date), CAST(0.36 AS Decimal(11, 2)), CAST(3.36 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (22, 3, 6, N'Recibo', N'123', N'0909098765', CAST(N'2021-04-14' AS Date), CAST(2.43 AS Decimal(11, 2)), CAST(22.67 AS Decimal(11, 2)), N'Anulado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (23, 16, 6, N'factura', N'123', N'0987656788', CAST(N'2021-04-15' AS Date), CAST(0.36 AS Decimal(11, 2)), CAST(3.36 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (45, 3, 6, N'factura', N'123', N'0909098722', CAST(N'2021-04-16' AS Date), CAST(0.24 AS Decimal(11, 2)), CAST(2.24 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (47, 3, 6, N'factura', N'123', N'0909098722', CAST(N'0001-01-01' AS Date), CAST(0.24 AS Decimal(11, 2)), CAST(2.24 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (48, 3, 6, N'factura', N'123', N'0909098722', CAST(N'2021-04-16' AS Date), CAST(0.24 AS Decimal(11, 2)), CAST(2.24 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (49, 3, 6, N'factura', N'123', N'7654323456', CAST(N'2021-04-07' AS Date), CAST(0.36 AS Decimal(11, 2)), CAST(3.36 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (50, 3, 6, N'factura', N'123', N'6543456789', CAST(N'2021-04-01' AS Date), CAST(0.24 AS Decimal(11, 2)), CAST(2.24 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (51, 3, 6, N'factura', N'123', N'8765654329', CAST(N'2021-04-16' AS Date), CAST(4.34 AS Decimal(11, 2)), CAST(40.54 AS Decimal(11, 2)), N'Anulado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (52, 16, 6, N'factura', N'123', N'8765498765', CAST(N'2021-02-01' AS Date), CAST(0.24 AS Decimal(11, 2)), CAST(2.24 AS Decimal(11, 2)), N'Anulado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (53, 3, 6, N'Recibo', N'345', N'4567888876', CAST(N'2021-04-01' AS Date), CAST(0.24 AS Decimal(11, 2)), CAST(2.24 AS Decimal(11, 2)), N'Anulado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (54, 3, 6, N'Factura', N'123', N'1234567876', CAST(N'2021-04-01' AS Date), CAST(17.88 AS Decimal(11, 2)), CAST(166.88 AS Decimal(11, 2)), N'Anulado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (55, 3, 6, N'Factura', N'123', N'3456234566', CAST(N'2021-04-09' AS Date), CAST(26.64 AS Decimal(11, 2)), CAST(248.64 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (58, 3, 6, N'Factura', N'123', N'4345672345', CAST(N'2021-05-08' AS Date), CAST(23.00 AS Decimal(11, 2)), CAST(33.00 AS Decimal(11, 2)), N'Anulado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (59, 3, 6, N'Factura', N'123', N'5656453456', CAST(N'2021-05-08' AS Date), CAST(3.00 AS Decimal(11, 2)), CAST(9.00 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (60, 3, 6, N'Factura', N'123', N'5644446678', CAST(N'2021-05-08' AS Date), CAST(3.00 AS Decimal(11, 2)), CAST(9.00 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (61, 3, 6, N'Factura', N'234', N'2344322343', CAST(N'2021-05-08' AS Date), CAST(4.00 AS Decimal(11, 2)), CAST(32.00 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (62, 3, 6, N'Factura', N'543', N'7654327654', CAST(N'2021-05-08' AS Date), CAST(6.00 AS Decimal(11, 2)), CAST(667.00 AS Decimal(11, 2)), N'Anulado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (63, 3, 6, N'Factura', N'232', N'2323232323', CAST(N'2021-05-07' AS Date), CAST(10.80 AS Decimal(11, 2)), CAST(220.80 AS Decimal(11, 2)), N'Aceptado', CAST(60.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (64, 3, 6, N'Factura', N'232', N'2323232323', CAST(N'2021-05-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(40.00 AS Decimal(11, 2)), N'Aceptado', CAST(20.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (65, 3, 6, N'Recibo', N'766', N'7687678767', CAST(N'2021-05-07' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(14.24 AS Decimal(11, 2)), N'Aceptado', CAST(7.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (66, 3, 6, N'Recibo', N'766', N'7687678767', CAST(N'2021-05-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(14.24 AS Decimal(11, 2)), N'Aceptado', CAST(7.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (68, 3, 6, N'Recibo', N'123', N'3334445432', CAST(N'2021-05-09' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(140.40 AS Decimal(11, 2)), N'Anulado', CAST(70.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (69, 3, 6, N'Recibo', N'445', N'5545545546', CAST(N'2021-05-08' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(51.48 AS Decimal(11, 2)), N'Anulado', CAST(21.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (70, 3, 6, N'Recibo', N'445', N'5545545546', CAST(N'2021-05-08' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(51.48 AS Decimal(11, 2)), N'Anulado', CAST(21.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (71, 3, 6, N'Recibo', N'445', N'5545545546', CAST(N'2021-05-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(41.40 AS Decimal(11, 2)), N'Anulado', CAST(21.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (72, 3, 6, N'Factura', N'765', N'6667776567', CAST(N'2021-05-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(11.46 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (73, 3, 6, N'Factura', N'123', N'6767675678', CAST(N'2021-05-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(13.82 AS Decimal(11, 2)), N'Aceptado', CAST(7.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (74, 3, 6, N'Factura', N'123', N'6767675678', CAST(N'2021-05-10' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(13.82 AS Decimal(11, 2)), N'Aceptado', CAST(7.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (75, 3, 6, N'Factura', N'123', N'6767675678', CAST(N'2021-04-09' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(13.82 AS Decimal(11, 2)), N'Aceptado', CAST(7.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (76, 16, 6, N'Recibo', N'123', N'6767675678', CAST(N'2021-05-06' AS Date), CAST(1.44 AS Decimal(11, 2)), CAST(13.44 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (77, 3, 6, N'Factura', N'345', N'5554443456', CAST(N'2021-05-08' AS Date), CAST(0.60 AS Decimal(11, 2)), CAST(7.96 AS Decimal(11, 2)), N'Aceptado', CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (78, 3, 6, N'Factura', N'345', N'5554443456', CAST(N'2021-05-09' AS Date), CAST(0.60 AS Decimal(11, 2)), CAST(7.96 AS Decimal(11, 2)), N'Anulado', CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (79, 3, 6, N'Factura', N'654', N'7654323456', CAST(N'2021-05-08' AS Date), CAST(0.84 AS Decimal(11, 2)), CAST(19.30 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (80, 3, 6, N'Factura', N'345', N'2343452347', CAST(N'2021-05-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(13.82 AS Decimal(11, 2)), N'Aceptado', CAST(7.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (81, 16, 6, N'Recibo', N'122', N'1234343421', CAST(N'2021-05-08' AS Date), CAST(7.10 AS Decimal(11, 2)), CAST(114.25 AS Decimal(11, 2)), N'Aceptado', CAST(24.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (82, 3, 6, N'Factura', N'223', N'5455556667', CAST(N'2021-05-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(160.00 AS Decimal(11, 2)), N'Aceptado', CAST(80.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (83, 3, 6, N'Factura', N'434', N'3434343455', CAST(N'2021-05-09' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(160.00 AS Decimal(11, 2)), N'Anulado', CAST(80.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (84, 3, 6, N'Factura', N'434', N'3434343455', CAST(N'2021-05-07' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(160.00 AS Decimal(11, 2)), N'Aceptado', CAST(80.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (85, 3, 6, N'Recibo', N'654', N'7654345676', CAST(N'2021-05-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(160.00 AS Decimal(11, 2)), N'Anulado', CAST(80.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (86, 3, 6, N'Factura', N'654', N'7654387654', CAST(N'2021-05-08' AS Date), CAST(2.40 AS Decimal(11, 2)), CAST(254.40 AS Decimal(11, 2)), N'Anulado', CAST(116.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (87, 3, 6, N'Factura', N'654', N'7676767543', CAST(N'2021-05-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(80.00 AS Decimal(11, 2)), N'Anulado', CAST(40.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (88, 3, 6, N'Factura', N'123', N'3232323211', CAST(N'2021-05-13' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(20.00 AS Decimal(11, 2)), N'Anulado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1088, 16, 6, N'Factura', N'567', N'7657657657', CAST(N'2021-05-12' AS Date), CAST(9.60 AS Decimal(11, 2)), CAST(219.60 AS Decimal(11, 2)), N'Anulado', CAST(65.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1089, 3, 6, N'Factura', N'234', N'8989898989', CAST(N'2021-05-13' AS Date), CAST(12.00 AS Decimal(11, 2)), CAST(112.00 AS Decimal(11, 2)), N'Anulado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1090, 16, 6, N'Factura', N'765', N'7654387698', CAST(N'2021-05-13' AS Date), CAST(72.00 AS Decimal(11, 2)), CAST(672.00 AS Decimal(11, 2)), N'Anulado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1091, 16, 6, N'Recibo', N'343', N'3448764987', CAST(N'2021-05-13' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(210.00 AS Decimal(11, 2)), N'Anulado', CAST(105.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1092, 16, 6, N'Factura', N'433', N'3434348765', CAST(N'2021-05-13' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(23.54 AS Decimal(11, 2)), N'Anulado', CAST(12.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1093, 3, 6, N'Factura', N'765', N'7656765432', CAST(N'2021-05-01' AS Date), CAST(10.80 AS Decimal(11, 2)), CAST(220.80 AS Decimal(11, 2)), N'Anulado', CAST(60.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1094, 3, 6, N'Factura', N'123', N'6667775675', CAST(N'2021-05-15' AS Date), CAST(36.00 AS Decimal(11, 2)), CAST(640.00 AS Decimal(11, 2)), N'Anulado', CAST(152.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1095, 16, 6, N'Factura', N'678', N'7654567898', CAST(N'2021-05-15' AS Date), CAST(2.94 AS Decimal(11, 2)), CAST(36.24 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1096, 16, 6, N'Factura', N'786', N'7656565432', CAST(N'2021-05-16' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(10.41 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1097, 16, 6, N'Factura', N'456', N'7654345678', CAST(N'2021-05-12' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(6.41 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1098, 3, 6, N'Recibo', N'345', N'9876543765', CAST(N'2021-05-19' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(2.41 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1099, 16, 6, N'Factura', N'654', N'6546547654', CAST(N'2021-05-06' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(6.15 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1100, 3, 6, N'Factura', N'765', N'7654387654', CAST(N'2021-05-19' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(8.41 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1101, 3, 6, N'Factura', N'543', N'6543276543', CAST(N'2021-05-19' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(2.41 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1102, 3, 6, N'Factura', N'876', N'6543276543', CAST(N'2021-05-19' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(3.00 AS Decimal(11, 2)), N'Aceptado', CAST(3.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1103, 3, 6, N'Recibo', N'765', N'8767676787', CAST(N'2021-05-19' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(5.41 AS Decimal(11, 2)), N'Aceptado', CAST(3.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1104, 3, 6, N'Recibo', N'765', N'8767676787', CAST(N'2021-05-19' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(5.41 AS Decimal(11, 2)), N'Aceptado', CAST(3.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1105, 3, 6, N'Recibo', N'765', N'8767676787', CAST(N'2021-05-20' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(5.41 AS Decimal(11, 2)), N'Aceptado', CAST(3.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1106, 3, 6, N'Factura', N'344', N'3434348765', CAST(N'2021-05-13' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(14.07 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1107, 3, 6, N'Factura', N'323', N'2323454567', CAST(N'2021-05-19' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(14.07 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1108, 3, 6, N'Factura', N'122', N'2323456783', CAST(N'2021-05-19' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(14.07 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1109, 3, 6, N'Factura', N'122', N'2323456783', CAST(N'2021-05-19' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(14.07 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1110, 3, 6, N'Factura', N'122', N'2323456783', CAST(N'2021-05-12' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(14.07 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1111, 3, 6, N'Factura', N'122', N'2323456783', CAST(N'2021-05-19' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(14.07 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1112, 3, 6, N'Factura', N'122', N'2323456783', CAST(N'2021-05-19' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(14.07 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1113, 3, 6, N'Factura', N'122', N'2323456783', CAST(N'2021-05-19' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(14.07 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1114, 3, 6, N'Factura', N'122', N'2323456783', CAST(N'2021-05-19' AS Date), CAST(1.08 AS Decimal(11, 2)), CAST(14.07 AS Decimal(11, 2)), N'Anulado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1115, 3, 6, N'Factura', N'654', N'5432345678', CAST(N'2021-05-19' AS Date), CAST(2.46 AS Decimal(11, 2)), CAST(92.96 AS Decimal(11, 2)), N'Aceptado', CAST(70.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1116, 3, 6, N'Factura', N'657', N'8768768765', CAST(N'2021-06-05' AS Date), CAST(0.08 AS Decimal(11, 2)), CAST(15.72 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1117, 3, 6, N'Factura', N'342', N'8765456765', CAST(N'2021-06-16' AS Date), CAST(0.12 AS Decimal(11, 2)), CAST(5.12 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1118, 3, 6, N'Factura', N'678', N'6545456543', CAST(N'2021-07-03' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(13.00 AS Decimal(11, 2)), N'Aceptado', CAST(13.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1119, 3, 6, N'Factura', N'678', N'6545456543', CAST(N'2021-07-03' AS Date), CAST(0.12 AS Decimal(11, 2)), CAST(14.12 AS Decimal(11, 2)), N'Aceptado', CAST(13.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1120, 3, 6, N'Factura', N'678', N'6545456543', CAST(N'2021-07-03' AS Date), CAST(0.12 AS Decimal(11, 2)), CAST(14.12 AS Decimal(11, 2)), N'Aceptado', CAST(13.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1121, 16, 6, N'Factura', N'1123', N'3454543567', CAST(N'2021-07-03' AS Date), CAST(0.12 AS Decimal(11, 2)), CAST(5.12 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1122, 3, 6, N'Recibo', N'5667', N'6678787650', CAST(N'2021-07-01' AS Date), CAST(0.12 AS Decimal(11, 2)), CAST(5.12 AS Decimal(11, 2)), N'Anulado', CAST(4.00 AS Decimal(11, 2)))
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0]) VALUES (1123, 3, 6, N'Factura', N'765', N'6543219876', CAST(N'2021-07-03' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(4.00 AS Decimal(11, 2)), N'Aceptado', CAST(4.00 AS Decimal(11, 2)))
SET IDENTITY_INSERT [dbo].[ingreso] OFF
SET IDENTITY_INSERT [dbo].[persona] ON 

INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (1, N'Cliente', N'nomCli2a', N'Cedula', N'1654777652', N'direcc2', N'0987655432', N'per2@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (2, N'Cliente', N'freer3a', N'Cedula', N'567656557577', N'diercc3', N'567576576575', N'ema56@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (3, N'Proveedor', N'prov2a', N'Cedula', N'2367654723', N'direpro3', N'777654523', N'prov2@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (4, N'Cliente', N'gjhgjajghj', N'-Seleccione tipo-', N'7777777777777', N'gjjhgjhgjhjhj', N'76787688', N'hjjhjhgj@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (5, N'Cliente', N'gjhjhgjgja', N'-Seleccione tipo-', N'88888888888', N'ytuytyuuy', N'78687876', N'hjgjjj@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (6, N'Cliente', N'joiouaa', N'-Seleccione-', N'8768768768', N'tuytutytuytu', N'78787', N'jhghg@dfr.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (7, N'Cliente', N'jhgjhgjhgja', N'-Seleccione-', N'78768687878', N'hgjjhjhjh', N'7676787', N'jhgjhjh@gjhghj,kjh')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (8, N'Cliente', N'hgjhgjhga', N'2', N'876877868', N'jhjgh', N'jhgjhgjh', N'jhgjhg@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (9, N'Cliente', N'huhuhuua', N'2', N'1718234898001', N'jhkjhjhhkjhkkj', N'8798799', N'huhuh@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (10, N'Cliente', N'hiuhiuha', N'2', N'768687888788', N'fhgfhhg', N'434543554', N'gfhhgh')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (11, N'Cliente', N'uyiuyiuyiuyiua', N'1', N'9898989898', N'ggjhgjhgjhgjjjhg', N'8768878', N'azsd@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (12, N'Cliente', N'tupac', N'Ruc', N'1234554321', N'jkjkghghhjgjhgjgjhgjh', N'2349876', N'tupac@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (13, N'Cliente', N'pasaport', N'Pasaporte', N'0987654321234', N'hgjgjhghgjhghhj', N'7654324', N'pasap@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (14, N'Cliente', N'freer3a', N'Pasaporte', N'567656557599', N'diercc3', N'567576576575', N'ema4@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (15, N'Cliente', N'freer3a', N'Pasaporte', N'567656557599', N'diercc3', N'567576576575', N'ema99@gmail.com')
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (16, N'Proveedor', N'prueb', N'Ruc', N'9999988888777', N'dieccion jjjjj', N'8765432', N'prov@gmail.com')
SET IDENTITY_INSERT [dbo].[persona] OFF
SET IDENTITY_INSERT [dbo].[rol] ON 

INSERT [dbo].[rol] ([idrol], [nombre], [descripcion], [condicion]) VALUES (1, N'Administrador', N'Administrador de sistema', 1)
INSERT [dbo].[rol] ([idrol], [nombre], [descripcion], [condicion]) VALUES (2, N'Almacenero', N'Almacena informe de productos', 1)
INSERT [dbo].[rol] ([idrol], [nombre], [descripcion], [condicion]) VALUES (3, N'Vendedor', N'Realiza ventas', 1)
SET IDENTITY_INSERT [dbo].[rol] OFF
SET IDENTITY_INSERT [dbo].[tipoArticulo] ON 

INSERT [dbo].[tipoArticulo] ([idTipoArticulo], [tipoArticulo], [condicion]) VALUES (1, N'Tipo F', 1)
INSERT [dbo].[tipoArticulo] ([idTipoArticulo], [tipoArticulo], [condicion]) VALUES (2, N'Tipo G', 1)
INSERT [dbo].[tipoArticulo] ([idTipoArticulo], [tipoArticulo], [condicion]) VALUES (7, N'Tipo D', 1)
INSERT [dbo].[tipoArticulo] ([idTipoArticulo], [tipoArticulo], [condicion]) VALUES (8, N'Tipo E', 1)
INSERT [dbo].[tipoArticulo] ([idTipoArticulo], [tipoArticulo], [condicion]) VALUES (9, N'Tipo A', 1)
INSERT [dbo].[tipoArticulo] ([idTipoArticulo], [tipoArticulo], [condicion]) VALUES (10, N'Tipo B', 1)
INSERT [dbo].[tipoArticulo] ([idTipoArticulo], [tipoArticulo], [condicion]) VALUES (11, N'Tipo C', 1)
SET IDENTITY_INSERT [dbo].[tipoArticulo] OFF
SET IDENTITY_INSERT [dbo].[usuario] ON 

INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion], [foto]) VALUES (1, 1, N'josema', N'Ruc', N'123987', N'el valle', N'3333333', N'asd@gmail.com', 0xDB97505935F3000FEF41B1B234370F94002E4ACF0E74F40CEBE93288F762C320B2CD09056DA440BD194E309E95DCA721B0D03125143080842D146321BE0A875C, 0x86CF298E248408C10664BB788520858DAB178E1EBEFAF3A0A53F088A2D8E2925BBFB219BE3A090A606E9813EEF51C77AF91E9E2C4199DF8DEF095BADA1AB4FF461FFEF901D991771EBE1FD43D9B8C20F811C74B9D93C0E6AEB41E0A05932E8B3FB7DCF325F22D96309AC6F858B15E1F225C6ABD8CC3FDD61463C8577827C1634, 1, N'')
INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion], [foto]) VALUES (2, 3, N'manuela2', N'Cedula', N'172134442', N'rodrigo de chavez 2', N'0999888762', N'juan@gmail.com', 0x26D628DD551A657A05E31E66C393E16BCEA65EC2ACDDCA730129527B2CB3F6F2FF6327491F22EE5E24D341AC8C9E45EE2CB1E90B4124F985F5BBE42DA90E9EBA, 0xB52E49799DAAF6A88257F47B30F1AE509C297D93A8A063276E0928E677429C32B9D9B31F3789A2E158CD5BB571E1ABC8D91E6E3A5E59BE2DDD7274C429A90A7927D1364DD2A0ABF3659B4FC8C523754E7CDE3AD4C64391E92AADAB750BE8CB2803B98B307C5238689E4307D455D973794EDE5BDF495EC1ECA576D840346C7A50, 1, N'')
INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion], [foto]) VALUES (4, 2, N'oswaldo2', N'Ruc', N'1234554321', N'chilibulo2', N'12343212', N'oswaldo2@gmail.com', 0xBDA51BAD39F021622427A59A74C9AE828678A241AE123853F84C0B74A7069ED69349BE24C2153EFF98E5D6DAC8F72B5C8E7BCFB59B4E6E32686ADB75603606B4, 0x87DE9B65BB91CE35545F87B5475A5D42799DA93C219102BB81268B8D1BCBE83CE1A19F6B1F37811B72BA057A3A25CBF402E1A3E19527732A36262C7E235807CBEC7970A05AAF8BD4575A6683B091BBB4C7536A3AFA059F966504B2A9A41B56FBACF0913B0F15CC1977E4E88A11D98F1DDBEE940635C0F1DD9DA073048D0BFDC8, 1, N'')
INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion], [foto]) VALUES (5, 2, N'juan piguabe', N'Cedula', N'1718234765', N'direccion casa ', N'323765', N'juan2@gmail.com', 0xE34ABB5941D27539A32468F92B5851F5A6542D921D59A5C953051D498CE3C45E0DA8BB9E3ED5DC65AFA2469CD19EA9D6E14425B09AD9766E5D92ABC66DB5A6DC, 0x0A151DC317F0D2E617354C6EA6BB8193192F8841911B234BFC178D1E27C6826CF388BCF04B44A86331855ACA39A2613389BA1F9C3C38A73494AB0E718EC7AF888869D815F3363FCDE676A45BD8A93744CDC27A765F0FC3FF0E1A86718F11909302794D3E9785EF56FBBD52C7366522657CEEEB49E77252F8A30EC2CCBDBEBEE5, 1, N'')
INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion], [foto]) VALUES (6, 1, N'Adrián Ortiz', N'Cedula', N'1718348053', N'magdalena-Oe10-235', N'2223339', N'adrian-2222@hotmail.com', 0xA1C3CE7269292E21CDE3AC0461E71E9750AB21A5B29CD3F90B81C8530523704E529DA39644F8381B66135A001FCAEE15A52ED01BFB4F142C5CC7670F696C7ED1, 0x37733B7012D868ECAB8882B3723DF261E2E9FBCA78F558B0A68729B20D21764F88385228276B5A06980A5C18A9B3B564C6DFEBF0F0C7FC8323AC2CC1EE7B47BC483D9BC05B0143B641EA82D6F0F878AF1AA0AD01D49EBDCFA4CEB2CA6A4B9933D34A7EB414136B75138CFA7119B0369138926AB0FDFDD72079DC0BCD7E9EEDE4, 1, N'20210811204547-capamerica.jpg')
INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion], [foto]) VALUES (7, 3, N'desirek1', N'Ruc', N'1234567890', N'direccion desirek1', N'3345555', N'desirek1@gmail.com', 0x061C537792E71CAC35A4C5D0A6AB97E1B926FFD19BC631302AAFD661AD0DAD88CC0F6C0AE52C055A3651B48CA27BFD6A8A162EB902B4B4E9B10E3B18408919B1, 0x6C86EBFF7044018CDE821C75DFA6FC11CE5DC4F25B966D28E60EF6B2E8BFE625870295794107B41F1C406C49AD454D027EFBC7D3D0FB2419B99890C9F7A4C7C9DC76881EA4A2A2ED0061988DDD002FC5B4F4D5A252ACB4428A04911A15291EB95ACEF726C1AF7F7A59ECF44883C7C858B2AF2BE43815707BA1D2FA640A17C147, 1, N'')
SET IDENTITY_INSERT [dbo].[usuario] OFF
SET IDENTITY_INSERT [dbo].[venta] ON 

INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (1, 3, 5, N'Factura', N'123', N'1', CAST(N'2021-06-11' AS Date), CAST(12.00 AS Decimal(11, 2)), CAST(112.00 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (2, 1, 6, N'Factura', N'123', N'2', CAST(N'2021-07-05' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(9.45 AS Decimal(11, 2)), N'Aceptado', CAST(9.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (3, 12, 6, N'Factura', N'123', N'3', CAST(N'2021-01-02' AS Date), CAST(0.12 AS Decimal(11, 2)), CAST(4.61 AS Decimal(11, 2)), N'Aceptado', CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (4, 6, 6, N'Factura', N'345', N'4', CAST(N'2021-02-03' AS Date), CAST(1.16 AS Decimal(11, 2)), CAST(26.82 AS Decimal(11, 2)), N'Aceptado', CAST(16.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (5, 6, 6, N'Factura', N'345', N'5', CAST(N'2021-02-09' AS Date), CAST(1.16 AS Decimal(11, 2)), CAST(26.82 AS Decimal(11, 2)), N'Aceptado', CAST(16.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (6, 1, 6, N'Factura', N'123', N'6', CAST(N'2021-03-03' AS Date), CAST(0.12 AS Decimal(11, 2)), CAST(7.12 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (7, 2, 6, N'Factura', N'123', N'7', CAST(N'2021-07-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(6.00 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (8, 13, 6, N'Factura', N'123', N'8', CAST(N'2021-07-08' AS Date), CAST(0.12 AS Decimal(11, 2)), CAST(4.57 AS Decimal(11, 2)), N'Aceptado', CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (9, 2, 6, N'Factura', N'123', N'9', CAST(N'2021-07-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(3.45 AS Decimal(11, 2)), N'Aceptado', CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (11, 1, 6, N'Factura', N'123', N'10', CAST(N'2021-07-08' AS Date), CAST(0.23 AS Decimal(11, 2)), CAST(8.38 AS Decimal(11, 2)), N'Aceptado', CAST(5.40 AS Decimal(11, 2)), CAST(0.82 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (12, 4, 6, N'Factura', N'123', N'11', CAST(N'2021-07-08' AS Date), CAST(0.23 AS Decimal(11, 2)), CAST(11.14 AS Decimal(11, 2)), N'Aceptado', CAST(8.98 AS Decimal(11, 2)), CAST(0.69 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (13, 1, 6, N'Factura', N'123', N'12', CAST(N'2021-07-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(5.70 AS Decimal(11, 2)), N'Aceptado', CAST(5.70 AS Decimal(11, 2)), CAST(0.30 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (14, 2, 6, N'Factura', N'001', N'13', CAST(N'2021-07-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(6.00 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (15, 11, 6, N'Factura', N'001', N'14', CAST(N'2021-07-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(6.00 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (16, 5, 6, N'Factura', N'001', N'15', CAST(N'2021-07-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(3.45 AS Decimal(11, 2)), N'Aceptado', CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (17, 13, 6, N'Factura', N'001', N'16', CAST(N'2021-07-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(3.45 AS Decimal(11, 2)), N'Aceptado', CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (18, 2, 6, N'Factura', N'001', N'17', CAST(N'2021-07-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(3.45 AS Decimal(11, 2)), N'Aceptado', CAST(3.45 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (19, 1, 6, N'Factura', N'001', N'18', CAST(N'2021-07-08' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(6.00 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (20, 1, 6, N'Factura', N'001', N'19', CAST(N'2021-07-09' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(2.41 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (21, 2, 6, N'Factura', N'001', N'0000000099', CAST(N'2021-07-09' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(2.41 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (22, 2, 6, N'Factura', N'001', N'0000000100', CAST(N'2021-07-09' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(6.00 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (23, 2, 6, N'Factura', N'001', N'0000000101', CAST(N'2021-07-09' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(2.41 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (24, 6, 6, N'Factura', N'001', N'0000000102', CAST(N'2021-07-11' AS Date), CAST(0.12 AS Decimal(11, 2)), CAST(7.12 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (25, 11, 6, N'Factura', N'001', N'0000000103', CAST(N'2021-07-12' AS Date), CAST(0.23 AS Decimal(11, 2)), CAST(2.13 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)), CAST(0.10 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (26, 9, 6, N'Factura', N'001', N'0000000104', CAST(N'2021-07-12' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(5.40 AS Decimal(11, 2)), N'Aceptado', CAST(5.40 AS Decimal(11, 2)), CAST(0.60 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (27, 1, 6, N'Factura', N'001', N'0000000105', CAST(N'2021-07-12' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(5.40 AS Decimal(11, 2)), N'Aceptado', CAST(5.40 AS Decimal(11, 2)), CAST(0.60 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (28, 2, 6, N'Factura', N'001', N'0000000106', CAST(N'2021-07-12' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(5.66 AS Decimal(11, 2)), N'Aceptado', CAST(5.66 AS Decimal(11, 2)), CAST(0.79 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (31, 2, 6, N'Factura', N'001', N'0000000107', CAST(N'2021-07-12' AS Date), CAST(0.23 AS Decimal(11, 2)), CAST(7.87 AS Decimal(11, 2)), N'Aceptado', CAST(5.70 AS Decimal(11, 2)), CAST(0.52 AS Decimal(11, 2)), CAST(8.15 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (32, 2, 6, N'Factura', N'001', N'0000000108', CAST(N'2021-07-12' AS Date), CAST(1.14 AS Decimal(11, 2)), CAST(14.09 AS Decimal(11, 2)), N'Anulado', CAST(3.45 AS Decimal(11, 2)), CAST(0.50 AS Decimal(11, 2)), CAST(13.45 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (37, 2, 6, N'Factura', N'001', N'0000000109', CAST(N'2021-07-12' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(2.41 AS Decimal(11, 2)), N'Aceptado', CAST(0.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(2.15 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (38, 1, 6, N'Factura', N'001', N'0000000110', CAST(N'2021-07-12' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)), N'Aceptado', CAST(1.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (39, 1, 6, N'Factura', N'001', N'0000000111', CAST(N'2021-07-12' AS Date), CAST(0.26 AS Decimal(11, 2)), CAST(14.41 AS Decimal(11, 2)), N'Aceptado', CAST(12.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(14.15 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (42, 12, 6, N'Factura', N'001', N'0000000112', CAST(N'2021-07-12' AS Date), CAST(2.58 AS Decimal(11, 2)), CAST(84.08 AS Decimal(11, 2)), N'Anulado', CAST(60.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(81.50 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (43, 2, 6, N'Factura', N'001', N'0000000113', CAST(N'2021-07-12' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(456.35 AS Decimal(11, 2)), N'Anulado', CAST(456.35 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(456.35 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (44, 2, 6, N'Factura', N'001', N'0000000114', CAST(N'2021-07-12' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(853.95 AS Decimal(11, 2)), N'Anulado', CAST(853.95 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(853.95 AS Decimal(11, 2)))
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [serie_comprobante], [num_comprobante], [fecha_hora], [impuesto12], [total], [estado], [impuesto0], [descuento], [subtotal]) VALUES (45, 1, 6, N'Factura', N'001', N'0000000115', CAST(N'2021-07-16' AS Date), CAST(0.00 AS Decimal(11, 2)), CAST(6.00 AS Decimal(11, 2)), N'Aceptado', CAST(6.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)), CAST(6.00 AS Decimal(11, 2)))
SET IDENTITY_INSERT [dbo].[venta] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__articulo__72AFBCC6121B1C4C]    Script Date: 04/10/2021 20:42:30 ******/
ALTER TABLE [dbo].[articulo] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__categori__72AFBCC6327D5033]    Script Date: 04/10/2021 20:42:30 ******/
ALTER TABLE [dbo].[categoria] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[articulo]  WITH CHECK ADD FOREIGN KEY([idcategoria])
REFERENCES [dbo].[categoria] ([idcategoria])
GO
ALTER TABLE [dbo].[articulo_tipoArticulo]  WITH CHECK ADD  CONSTRAINT [articuloFk] FOREIGN KEY([idarticulo])
REFERENCES [dbo].[articulo] ([idarticulo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[articulo_tipoArticulo] CHECK CONSTRAINT [articuloFk]
GO
ALTER TABLE [dbo].[articulo_tipoArticulo]  WITH CHECK ADD  CONSTRAINT [tipoArticuloFk] FOREIGN KEY([idtipoArticulo])
REFERENCES [dbo].[tipoArticulo] ([idTipoArticulo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[articulo_tipoArticulo] CHECK CONSTRAINT [tipoArticuloFk]
GO
ALTER TABLE [dbo].[detalle_ingreso]  WITH CHECK ADD FOREIGN KEY([idarticulo])
REFERENCES [dbo].[articulo] ([idarticulo])
GO
ALTER TABLE [dbo].[detalle_ingreso]  WITH CHECK ADD FOREIGN KEY([idingreso])
REFERENCES [dbo].[ingreso] ([idingreso])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[detalle_venta]  WITH CHECK ADD FOREIGN KEY([idarticulo])
REFERENCES [dbo].[articulo] ([idarticulo])
GO
ALTER TABLE [dbo].[detalle_venta]  WITH CHECK ADD FOREIGN KEY([idventa])
REFERENCES [dbo].[venta] ([idventa])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ingreso]  WITH CHECK ADD FOREIGN KEY([idproveedor])
REFERENCES [dbo].[persona] ([idpersona])
GO
ALTER TABLE [dbo].[ingreso]  WITH CHECK ADD  CONSTRAINT [FK__ingreso__idusuar__22AA2996] FOREIGN KEY([idusuario])
REFERENCES [dbo].[usuario] ([idusuario])
GO
ALTER TABLE [dbo].[ingreso] CHECK CONSTRAINT [FK__ingreso__idusuar__22AA2996]
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [FK__usuario__idrol__1ED998B2] FOREIGN KEY([idrol])
REFERENCES [dbo].[rol] ([idrol])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK__usuario__idrol__1ED998B2]
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD FOREIGN KEY([idcliente])
REFERENCES [dbo].[persona] ([idpersona])
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [FK__venta__idusuario__2A4B4B5E] FOREIGN KEY([idusuario])
REFERENCES [dbo].[usuario] ([idusuario])
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [FK__venta__idusuario__2A4B4B5E]
GO
USE [master]
GO
ALTER DATABASE [dbsistema] SET  READ_WRITE 
GO
