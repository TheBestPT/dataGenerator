USE [Projeto_Airbooking]
GO
/****** Object:  StoredProcedure [dbo].[adicionarCidadeEPais]    Script Date: 03/01/2023 19:14:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[adicionarCidadeEPais] @inserirPais VARCHAR(150), @postalCodeInsert VARCHAR(9), @cidade VARCHAR(50), @codigo_postal_cidade VARCHAR(9) OUTPUT AS
BEGIN

	DECLARE @nomePais VARCHAR(255);
	--DECLARE @inserirPais VARCHAR(255);
	DECLARE @idPais INT;
	--SELECT @inserirPais = 'Portugal'
	SELECT @nomePais = nome_pais FROM Pais WHERE nome_pais LIKE @inserirPais

	IF @nomePais IS NULL
	BEGIN
		INSERT INTO Pais (nome_pais) VALUES(@inserirPais)
		SELECT @idPais = id_pais FROM Pais WHERE nome_pais LIKE @inserirPais
	END
	ELSE 
		SELECT @idPais = id_pais FROM Pais WHERE nome_pais LIKE @inserirPais

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