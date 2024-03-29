USE [master]
GO
/****** Object:  Database [Projeto_Airbooking]    Script Date: 05/01/2023 19:52:56 ******/
CREATE DATABASE [Projeto_Airbooking]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Alojamento', FILENAME = N'c:\databases\Alojamento.mdf' , SIZE = 8192KB , MAXSIZE = 1048576KB , FILEGROWTH = 20%), 
 FILEGROUP [Classificacao] 
( NAME = N'Classificacao', FILENAME = N'c:\databases\Classificacao.ndf' , SIZE = 1024KB , MAXSIZE = 1048576KB , FILEGROWTH = 20%), 
 FILEGROUP [Local] 
( NAME = N'Local', FILENAME = N'c:\databases\Local.ndf' , SIZE = 1024KB , MAXSIZE = 1048576KB , FILEGROWTH = 20%), 
 FILEGROUP [Log_Interno] 
( NAME = N'Log_Interno', FILENAME = N'c:\databases\Log_Interno.ndf' , SIZE = 1024KB , MAXSIZE = 1048576KB , FILEGROWTH = 20%), 
 FILEGROUP [Reserva] 
( NAME = N'Reserva', FILENAME = N'c:\databases\Reserva.ndf' , SIZE = 1024KB , MAXSIZE = 1048576KB , FILEGROWTH = 20%), 
 FILEGROUP [Utilizador] 
( NAME = N'Utilizador', FILENAME = N'c:\databases\Utilizador.ndf' , SIZE = 1024KB , MAXSIZE = 1048576KB , FILEGROWTH = 20%)
 LOG ON 
( NAME = N'Projeto_Airbooking_Log_1', FILENAME = N'c:\databases\Projeto_Airbooking_Log_1.ldf' , SIZE = 2304KB , MAXSIZE = 409600KB , FILEGROWTH = 10%), 
( NAME = N'Projeto_Airbooking_Log_2', FILENAME = N'c:\databases\Projeto_Airbooking_Log_2.ldf' , SIZE = 1792KB , MAXSIZE = 409600KB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Projeto_Airbooking] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Projeto_Airbooking].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Projeto_Airbooking] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET ARITHABORT OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Projeto_Airbooking] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Projeto_Airbooking] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Projeto_Airbooking] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Projeto_Airbooking] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET RECOVERY FULL 
GO
ALTER DATABASE [Projeto_Airbooking] SET  MULTI_USER 
GO
ALTER DATABASE [Projeto_Airbooking] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Projeto_Airbooking] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Projeto_Airbooking] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Projeto_Airbooking] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Projeto_Airbooking] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Projeto_Airbooking] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Projeto_Airbooking', N'ON'
GO
ALTER DATABASE [Projeto_Airbooking] SET QUERY_STORE = OFF
GO
USE [Projeto_Airbooking]
GO
/****** Object:  User [app_user]    Script Date: 05/01/2023 19:52:57 ******/
CREATE USER [app_user] FOR LOGIN [projeto_aribooking_app_user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Administrador]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrador](
	[id_admin] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[data_nascimento] [date] NOT NULL,
	[nif] [varchar](9) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[genero] [varchar](9) NOT NULL,
	[contato_telefonico] [varchar](15) NOT NULL,
	[password] [varchar](256) NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_admin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Utilizador]
) ON [Utilizador]
GO
/****** Object:  Table [dbo].[Alojamento]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alojamento](
	[id_alojamento] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](80) NOT NULL,
	[descricao] [varchar](400) NOT NULL,
	[morada] [varchar](150) NOT NULL,
	[numero_maximo_pessoa] [int] NOT NULL,
	[numero_quartos] [int] NOT NULL,
	[codigo_postal_indicativo] [varchar](5) NULL,
	[id_anfitriao] [int] NOT NULL,
	[id_tipo_alojamento] [int] NOT NULL,
	[codigo_postal_cidade] [varchar](9) NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
	[geolocalizacao] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_alojamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Alojamento_Comodidade]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alojamento_Comodidade](
	[id_alojamento_comodidade] [int] IDENTITY(1,1) NOT NULL,
	[id_alojamento] [int] NOT NULL,
	[id_comodidade] [int] NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_alojamento_comodidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Anfitriao]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Anfitriao](
	[id_anfitriao] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[data_nascimento] [date] NOT NULL,
	[morada] [varchar](30) NOT NULL,
	[codigo_postal_indicativo] [varchar](5) NULL,
	[genero] [varchar](9) NOT NULL,
	[foto] [varchar](255) NULL,
	[contato_telefonico] [varchar](15) NOT NULL,
	[contato_emergencia] [varchar](15) NOT NULL,
	[superhost] [bit] NOT NULL,
	[email] [varchar](50) NOT NULL,
	[password] [varchar](256) NULL,
	[codigo_postal_cidade] [varchar](9) NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_anfitriao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Utilizador]
) ON [Utilizador]
GO
/****** Object:  Table [dbo].[Cidade]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cidade](
	[codigo_postal_cidade] [varchar](9) NOT NULL,
	[nome_cidade] [varchar](50) NOT NULL,
	[id_pais] [int] NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_postal_cidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Local]
) ON [Local]
GO
/****** Object:  Table [dbo].[Classificao]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classificao](
	[id_classificacao] [int] IDENTITY(1,1) NOT NULL,
	[limpeza] [float] NOT NULL,
	[comunicacao] [float] NOT NULL,
	[check_in] [float] NOT NULL,
	[localizacao] [float] NOT NULL,
	[qualidade_preco] [float] NOT NULL,
	[comentario] [varchar](255) NOT NULL,
	[id_cliente] [int] NOT NULL,
	[id_alojamento] [int] NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_classificacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Classificacao]
) ON [Classificacao]
GO
/****** Object:  Table [dbo].[Classificao_Anfitriao]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classificao_Anfitriao](
	[id_classificacao_anfitriao] [int] IDENTITY(1,1) NOT NULL,
	[comunicacao] [float] NOT NULL,
	[tempo_resposta] [float] NOT NULL,
	[comentario] [varchar](255) NOT NULL,
	[id_cliente] [int] NOT NULL,
	[id_anfitriao] [int] NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_classificacao_anfitriao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Classificacao]
) ON [Classificacao]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[data_nascimento] [date] NOT NULL,
	[foto] [varchar](255) NULL,
	[morada] [varchar](30) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[genero] [varchar](9) NOT NULL,
	[contato_telefonico] [varchar](15) NOT NULL,
	[contato_emergencia] [varchar](15) NOT NULL,
	[password] [varchar](256) NOT NULL,
	[codigo_postal_indicativo] [varchar](5) NULL,
	[codigo_postal_cidade] [varchar](9) NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Utilizador]
) ON [Utilizador]
GO
/****** Object:  Table [dbo].[Comodidade]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comodidade](
	[id_comodidade] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](80) NOT NULL,
	[id_tipo_comodidade] [int] NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_comodidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Foto_Alojamento]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Foto_Alojamento](
	[id_foto_alojamento] [int] IDENTITY(1,1) NOT NULL,
	[foto] [varchar](255) NOT NULL,
	[id_alojamento] [int] NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_foto_alojamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[id_log] [int] IDENTITY(1,1) NOT NULL,
	[id_numero] [int] NOT NULL,
	[id_nome] [varchar](30) NOT NULL,
	[nome_tabela] [varchar](50) NOT NULL,
	[comando_sql] [varchar](255) NOT NULL,
	[tipo_evento] [varchar](20) NOT NULL,
	[data_evento] [datetime] NOT NULL,
	[id_admin] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_log] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Log_Interno]
) ON [Log_Interno]
GO
/****** Object:  Table [dbo].[Metodo_Pagamento]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Metodo_Pagamento](
	[id_metodo_pagamento] [int] IDENTITY(1,1) NOT NULL,
	[tipo_pagamento] [varchar](10) NOT NULL,
	[nome_cartao] [varchar](100) NOT NULL,
	[numero_cartao] [varchar](16) NOT NULL,
	[cvc_codigo] [varchar](3) NOT NULL,
	[data_vencimento] [varchar](5) NOT NULL,
	[id_cliente] [int] NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_metodo_pagamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Reserva]
) ON [Reserva]
GO
/****** Object:  Table [dbo].[Pagamento]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagamento](
	[id_pagamento] [int] IDENTITY(1,1) NOT NULL,
	[preco] [money] NOT NULL,
	[estado_pagamento] [varchar](50) NOT NULL,
	[id_reserva] [int] NOT NULL,
	[id_metodo_pagamento] [int] NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pagamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Reserva]
) ON [Reserva]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[id_pais] [int] IDENTITY(1,1) NOT NULL,
	[nome_pais] [varchar](150) NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Local]
) ON [Local]
GO
/****** Object:  Table [dbo].[Preco_Epoca_Ano]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Preco_Epoca_Ano](
	[id_preco_epoca_ano] [int] IDENTITY(1,1) NOT NULL,
	[data_inicio] [date] NOT NULL,
	[data_fim] [date] NOT NULL,
	[preco] [float] NOT NULL,
	[id_alojamento] [int] NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_preco_epoca_ano] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reserva]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reserva](
	[id_reserva] [int] IDENTITY(1,1) NOT NULL,
	[check_in] [date] NOT NULL,
	[check_out] [date] NOT NULL,
	[numero_pessoas] [int] NOT NULL,
	[preco] [money] NOT NULL,
	[data_reserva] [datetime] NOT NULL,
	[status] [int] NOT NULL,
	[detalhes] [varchar](200) NOT NULL,
	[id_alojamento] [int] NOT NULL,
	[id_cliente] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_reserva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Reserva]
) ON [Reserva]
GO
/****** Object:  Table [dbo].[Tipo_Alojamento]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Alojamento](
	[id_tipo_alojamento] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](50) NOT NULL,
	[icon_tipo_alojamento] [varchar](255) NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tipo_alojamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_Comodidade]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Comodidade](
	[id_tipo_comodidade] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](30) NOT NULL,
	[icon_tipo_comodidade] [varchar](255) NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tipo_comodidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_Reserva]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Reserva](
	[id_tipo_reserva] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](20) NOT NULL,
	[id_reserva] [int] NOT NULL,
	[data_modificacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tipo_reserva] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Reserva]
) ON [Reserva]
GO
ALTER TABLE [dbo].[Administrador] ADD  CONSTRAINT [DF_Administrador]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Alojamento] ADD  CONSTRAINT [DF_Alojamento]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Alojamento_Comodidade] ADD  CONSTRAINT [DF_Alojamento_Comodidade]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Anfitriao] ADD  CONSTRAINT [DF_Anfitriao]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Cidade] ADD  CONSTRAINT [DF_Cidade]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Classificao] ADD  CONSTRAINT [DF_Classificao]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Classificao_Anfitriao] ADD  CONSTRAINT [DF_Classificao_Anfitriao]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Cliente] ADD  CONSTRAINT [DF_Cliente]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Comodidade] ADD  CONSTRAINT [DF_Comodidade]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Foto_Alojamento] ADD  CONSTRAINT [DF_Foto_Alojamento]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Logs] ADD  CONSTRAINT [DF_Logs]  DEFAULT (getdate()) FOR [data_evento]
GO
ALTER TABLE [dbo].[Metodo_Pagamento] ADD  CONSTRAINT [DF_Metodo_Pagamento]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Pagamento] ADD  CONSTRAINT [DF_Pagamento]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Pais] ADD  CONSTRAINT [DF_Pais]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Preco_Epoca_Ano] ADD  CONSTRAINT [DF_Preco_Epoca_Ano]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Reserva] ADD  CONSTRAINT [DF_Reserva]  DEFAULT (getdate()) FOR [data_reserva]
GO
ALTER TABLE [dbo].[Tipo_Alojamento] ADD  CONSTRAINT [DF_Tipo_Alojamento]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Tipo_Reserva] ADD  CONSTRAINT [DF_Tipo_Reserva]  DEFAULT (getdate()) FOR [data_modificacao]
GO
ALTER TABLE [dbo].[Alojamento]  WITH CHECK ADD FOREIGN KEY([codigo_postal_cidade])
REFERENCES [dbo].[Cidade] ([codigo_postal_cidade])
GO
ALTER TABLE [dbo].[Alojamento]  WITH CHECK ADD FOREIGN KEY([id_anfitriao])
REFERENCES [dbo].[Anfitriao] ([id_anfitriao])
GO
ALTER TABLE [dbo].[Alojamento]  WITH CHECK ADD FOREIGN KEY([id_tipo_alojamento])
REFERENCES [dbo].[Tipo_Alojamento] ([id_tipo_alojamento])
GO
ALTER TABLE [dbo].[Alojamento_Comodidade]  WITH CHECK ADD FOREIGN KEY([id_alojamento])
REFERENCES [dbo].[Alojamento] ([id_alojamento])
GO
ALTER TABLE [dbo].[Alojamento_Comodidade]  WITH CHECK ADD FOREIGN KEY([id_comodidade])
REFERENCES [dbo].[Comodidade] ([id_comodidade])
GO
ALTER TABLE [dbo].[Anfitriao]  WITH CHECK ADD FOREIGN KEY([codigo_postal_cidade])
REFERENCES [dbo].[Cidade] ([codigo_postal_cidade])
GO
ALTER TABLE [dbo].[Cidade]  WITH CHECK ADD FOREIGN KEY([id_pais])
REFERENCES [dbo].[Pais] ([id_pais])
GO
ALTER TABLE [dbo].[Classificao]  WITH CHECK ADD FOREIGN KEY([id_alojamento])
REFERENCES [dbo].[Alojamento] ([id_alojamento])
GO
ALTER TABLE [dbo].[Classificao]  WITH CHECK ADD FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Cliente] ([id_cliente])
GO
ALTER TABLE [dbo].[Classificao_Anfitriao]  WITH CHECK ADD FOREIGN KEY([id_anfitriao])
REFERENCES [dbo].[Anfitriao] ([id_anfitriao])
GO
ALTER TABLE [dbo].[Classificao_Anfitriao]  WITH CHECK ADD FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Cliente] ([id_cliente])
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD FOREIGN KEY([codigo_postal_cidade])
REFERENCES [dbo].[Cidade] ([codigo_postal_cidade])
GO
ALTER TABLE [dbo].[Comodidade]  WITH CHECK ADD FOREIGN KEY([id_tipo_comodidade])
REFERENCES [dbo].[Tipo_Comodidade] ([id_tipo_comodidade])
GO
ALTER TABLE [dbo].[Foto_Alojamento]  WITH CHECK ADD FOREIGN KEY([id_alojamento])
REFERENCES [dbo].[Alojamento] ([id_alojamento])
GO
ALTER TABLE [dbo].[Logs]  WITH CHECK ADD FOREIGN KEY([id_admin])
REFERENCES [dbo].[Administrador] ([id_admin])
GO
ALTER TABLE [dbo].[Metodo_Pagamento]  WITH CHECK ADD FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Cliente] ([id_cliente])
GO
ALTER TABLE [dbo].[Pagamento]  WITH CHECK ADD FOREIGN KEY([id_metodo_pagamento])
REFERENCES [dbo].[Metodo_Pagamento] ([id_metodo_pagamento])
GO
ALTER TABLE [dbo].[Pagamento]  WITH CHECK ADD FOREIGN KEY([id_reserva])
REFERENCES [dbo].[Reserva] ([id_reserva])
GO
ALTER TABLE [dbo].[Preco_Epoca_Ano]  WITH CHECK ADD FOREIGN KEY([id_alojamento])
REFERENCES [dbo].[Alojamento] ([id_alojamento])
GO
ALTER TABLE [dbo].[Reserva]  WITH CHECK ADD FOREIGN KEY([id_alojamento])
REFERENCES [dbo].[Alojamento] ([id_alojamento])
GO
ALTER TABLE [dbo].[Reserva]  WITH CHECK ADD FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Cliente] ([id_cliente])
GO
ALTER TABLE [dbo].[Tipo_Reserva]  WITH CHECK ADD FOREIGN KEY([id_reserva])
REFERENCES [dbo].[Reserva] ([id_reserva])
GO
ALTER TABLE [dbo].[Administrador]  WITH CHECK ADD CHECK  (([genero]='outro' OR [genero]='feminino' OR [genero]='masculino'))
GO
ALTER TABLE [dbo].[Anfitriao]  WITH CHECK ADD CHECK  (([genero]='outro' OR [genero]='feminino' OR [genero]='masculino'))
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD CHECK  (([genero]='outro' OR [genero]='feminino' OR [genero]='masculino'))
GO
ALTER TABLE [dbo].[Logs]  WITH CHECK ADD CHECK  (([tipo_evento]='removido' OR [tipo_evento]='atualizado' OR [tipo_evento]='adicionado'))
GO
/****** Object:  StoredProcedure [dbo].[adicionarCidadeEPais]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[adicionarCidadeEPais] @inserirPais VARCHAR(150), @postalCodeInsert VARCHAR(9), @cidade VARCHAR(50), @codigo_postal_cidade VARCHAR(9) OUTPUT AS
BEGIN

	DECLARE @nomePais VARCHAR(255);
	--DECLARE @inserirPais VARCHAR(255);
	DECLARE @idPais INT;
	--SELECT @inserirPais = 'Portugal'
	SELECT @nomePais = nome_pais FROM Pais WHERE nome_pais = @inserirPais

	IF @nomePais IS NULL
	BEGIN
		INSERT INTO Pais (nome_pais) VALUES(@inserirPais)
		SELECT @idPais = id_pais FROM Pais WHERE nome_pais = @inserirPais
	END
	ELSE 
		SELECT @idPais = id_pais FROM Pais WHERE nome_pais = @inserirPais

	--PRINT @idPais

	--DECLARE @postalCodeInsert INT
	--SELECT @postalCodeInsert = '9400'
	--DECLARE @cidade VARCHAR(80)
	--SELECT @cidade = 'Camara '
	DECLARE @postalCode VARCHAR(9)
	--DECLARE @codigo_postal_cidade VARCHAR(9)
	SELECT @postalCode = codigo_postal_cidade FROM cidade WHERE @postalCodeInsert = codigo_postal_cidade;


	IF @postalCode IS NULL
	BEGIN
		INSERT INTO cidade (codigo_postal_cidade, nome_cidade, id_pais) VALUES(@postalCodeInsert, @cidade, @idPais)
		SELECT @codigo_postal_cidade = codigo_postal_cidade FROM Cidade WHERE codigo_postal_cidade = @postalCodeInsert
	END
	ELSE 
		SELECT @codigo_postal_cidade = codigo_postal_cidade FROM Cidade WHERE codigo_postal_cidade = @postalCodeInsert

	--SELECT @codigo_postal_cidade = 10
	--PRINT @codigo_postal_cidade
END
GO
/****** Object:  StoredProcedure [dbo].[alojamentoComodidade]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[alojamentoComodidade]
as(SELECT Alojamento.nome as Alojamento, Tipo_Comodidade.descricao as Tipo_Comodidade, Comodidade.descricao as Comodidade
	FROM Alojamento, Tipo_Comodidade, Comodidade, Alojamento_Comodidade
	WHERE Alojamento.id_alojamento = Alojamento_Comodidade.id_alojamento
		AND Alojamento_Comodidade.id_comodidade = Comodidade.id_comodidade
		AND Comodidade.id_tipo_comodidade = Tipo_Comodidade.id_tipo_comodidade)
GO
/****** Object:  StoredProcedure [dbo].[alojamentoPorComodidade]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[alojamentoPorComodidade]
@comodidade VARCHAR(80)
as(SELECT Alojamento.nome as Alojamento, Tipo_Comodidade.descricao as Tipo_Comodidade, Comodidade.descricao as Comodidade
	FROM Alojamento, Tipo_Comodidade, Comodidade, Alojamento_Comodidade
	WHERE Alojamento.id_alojamento = Alojamento_Comodidade.id_alojamento
		AND Alojamento_Comodidade.id_comodidade = Comodidade.id_comodidade
		AND Comodidade.id_tipo_comodidade = Tipo_Comodidade.id_tipo_comodidade
		AND Comodidade.descricao = @comodidade)
GO
/****** Object:  StoredProcedure [dbo].[alojamentoTipo]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[alojamentoTipo]
@tipo VARCHAR(50)
as(SELECT Tipo_Alojamento.descricao, Alojamento.nome
	FROM Tipo_Alojamento, Alojamento
	WHERE Alojamento.id_tipo_alojamento = Tipo_Alojamento.id_tipo_alojamento
		AND Tipo_Alojamento.descricao = @tipo)
GO
/****** Object:  StoredProcedure [dbo].[inserirAnfitriao]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[inserirAnfitriao] @nome VARCHAR(100), @descricao VARCHAR(255), @morada VARCHAR(150), @geolocalizacao VARCHAR(50), @numero_maximo_pessoa INT, @numero_quartos INT, 
@codigo_postal_indicativo VARCHAR(5), @email_anfitriao VARCHAR(50), @tipo_alojamento VARCHAR(30), @codigo_postal_cidade VARCHAR(9),
@pais VARCHAR(150), @cidade VARCHAR(50) AS
BEGIN
	DECLARE @codigo_postal VARCHAR(9);
	IF @codigo_postal_cidade != 'dne' EXEC adicionarCidadeEPais @pais, @codigo_postal_cidade, @cidade, @codigo_postal OUTPUT;
	ELSE SET @codigo_postal = 'dne'
	DECLARE @id_afintriao INT;
	DECLARE @id_tipo_alojamento VARCHAR(50);
	SELECT @id_afintriao = id_anfitriao FROM Anfitriao WHERE email = @email_anfitriao
	SELECT @id_tipo_alojamento = id_tipo_alojamento FROM Tipo_Alojamento WHERE descricao = @tipo_alojamento
	IF @id_afintriao IS NOT NULL AND @id_tipo_alojamento IS NOT NULL
		BEGIN 
			INSERT INTO Alojamento (nome, descricao, morada, numero_maximo_pessoa, numero_quartos, codigo_postal_indicativo, id_anfitriao,
			id_tipo_alojamento, codigo_postal_cidade, geolocalizacao) VALUES (@nome, @descricao, @morada, @numero_maximo_pessoa, @numero_quartos,
			@codigo_postal_indicativo, @id_afintriao, @id_tipo_alojamento, @codigo_postal, @geolocalizacao)
		END
		
END	
GO
/****** Object:  StoredProcedure [dbo].[numeroAlojamento]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[numeroAlojamento]
as(SELECT COUNT(id_alojamento) FROM Alojamento)
GO
/****** Object:  StoredProcedure [dbo].[numeroReservaData]    Script Date: 05/01/2023 19:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[numeroReservaData]
@data DATE
as
(SELECT COUNT(Reserva.id_reserva) 
	FROM Reserva
	WHERE @data BETWEEN Reserva.check_in AND Reserva.check_out)
GO
USE [master]
GO
ALTER DATABASE [Projeto_Airbooking] SET  READ_WRITE 
GO
