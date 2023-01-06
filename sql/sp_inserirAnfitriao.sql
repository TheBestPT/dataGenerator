ALTER PROCEDURE inserirAnfitriao @nome VARCHAR(100), @descricao VARCHAR(255), @morada VARCHAR(150), @geolocalizacao VARCHAR(50), @numero_maximo_pessoa INT, @numero_quartos INT, 
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

GRANT EXECUTE ON inserirAnfitriao TO app_user

ALTER TABLE Alojamento ADD geolocalizacao VARCHAR(30) NOT NULL


SELECT * FROM Alojamento Order By id_anfitriao
SELECT * FROM Tipo_Alojamento
DELETE FROM Alojamento

DBCC CHECKIDENT ('[Alojamento]', RESEED, 0);
GO

SELECT * FROM Anfitriao