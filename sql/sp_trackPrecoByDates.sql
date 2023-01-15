SELECT * FROM Preco_Epoca_Ano WHERE '2023-12-20' between data_inicio and data_fim AND '2023-12-25' between data_inicio AND data_fim AND id_alojamento = 2 

SELECT * FROM Preco_Epoca_Ano

SELECT * FROM Alojamento

ALTER PROCEDURE sp_trackPrecoByDate @data_inicio DATE, @data_fim DATE, @id_alojamento INT, @preco FLOAT OUTPUT AS 
BEGIN
	--test date 11-23-2023 12-21-2023
	SELECT @preco = preco FROM Preco_Epoca_Ano WHERE @data_inicio between 
	data_inicio and data_fim AND @data_fim between data_inicio AND data_fim AND id_alojamento = @id_alojamento;
	SELECT @preco = DATEDIFF(day, @data_inicio, @data_fim) * @preco;
	IF @preco IS NULL
	BEGIN
		DECLARE @date1 DATE;
		DECLARE @days1 INT;
		SELECT @preco = preco, @date1 = data_fim FROM Preco_Epoca_Ano WHERE @data_inicio between 
	data_inicio and data_fim AND id_alojamento = @id_alojamento;
		SELECT @days1 = DATEDIFF(day, @data_inicio, @date1);
		DECLARE @days2 INT;
		DECLARE @preco2 FLOAT;
		DECLARE @date2 DATE;
		SELECT @preco2 = preco, @date2 = data_inicio FROM Preco_Epoca_Ano WHERE @data_fim between 
	data_inicio and data_fim AND id_alojamento = @id_alojamento;
		SELECT @days2 = DATEDIFF(day, @date2, @data_fim);
		SELECT @preco = @preco * @days1 + @preco2 * @days2
	END
END


DECLARE @res FLOAT;
EXEC sp_trackPrecoByDate '1-4-2024', '1-5-2024', 13, @res output
PRINT @res

DECLARE @res FLOAT;
--EXEC sp_trackPrecoByDate '8-1-2023', '9-1-2023', 10, @res output
EXEC sp_trackPrecoByDate '2023-1-8', '2023-1-9', 10, @res output
PRINT @res


SELECT * FROM Reserva

SELECT * FROM Reserva WHERE id_reserva = 10
SELECT * FROM Alojamento WHERE id_alojamento = 10
SELECT * FROM Preco_Epoca_Ano WHERE id_alojamento = 10

PRINT DATEDIFF(day, '2023-02-11', '2023-06-13')

SELECT * FROM Metodo_Pagamento

DELETE FROM Reserva
DBCC CHECKIDENT ('[Reserva]', RESEED, 0);
GO


SELECT * FROM Reserva
SELECT * FROM Pagamento

DELETE FROM Pagamento
DBCC CHECKIDENT ('[Pagamento]', RESEED, 0);
GO


SELECT * FROM Cliente

SELECT * FROM Administrador


INSERT INTO Logs (id_numero, id_nome, nome_tabela, comando_sql, tipo_evento, id_admin) VALUES(1, 'id_foto_alojamento', 
'Foto_Alojamento', 'DECLARE @id_anfitriao INT; DECLARE @id_alojamento INT; SELECT @id_anfitriao = id_anfitriao  FROM Anfitriao WHERE email = ''adriananielsen@shitmail.me''; SELECT @id_alojamento = id_alojamento FROM Alojamento WHERE id_alojamento = @id_anfitriao; INSERT INTO Foto_Alojamento (foto, id_alojamento) VALUES (''./fotos/adriananielsen_shitmail_mefoto_alojamento_amsterdam_noord-holland1054_netherlands.jpg'', @id_alojamento);',
'inserted', 1)

INSERT INTO Logs (id_numero, id_nome, nome_tabela, comando_sql, tipo_evento, id_admin) VALUES(1, 'id_foto_alojamento', 
'Foto_Alojamento', '',
'', 1)

SELECT * FROM Logs

DELETE FROM Logs
DBCC CHECKIDENT ('[Logs]', RESEED, 0);
GO

SELECT
name, definition 
FROM
    sys.check_constraints
WHERE
    name = 'FK__Foto_Aloj__id_al__534D60F1'



EXEC inserirAnfitriao 'Amsterdam, North Holland, Netherlands', 'Cozy private room with a double bed in Oud-West, Amsterdam. Typical 
Dutch local neighborhood quiet but with live. All sorts of facilities: supermarkets, stores, cafés 1 min walking. Great location: 5min to the center, 7min Leidseplein (restaurants, bars, shops, etc.), the marvelous famous FoodHallen (restaurants), Waterkant (bar), Kade West (café).', 
'Amsterdam, North Holland, Netherlands', '52.36667871194905, 4.865594943841575', 2, 1,
'dne', 'tamiahobbs@fromvermont.com', 'quarto privado', 'dne', 'Netherlands', 'Amsterdam'

SELECT * FROM Cidade WHERE codigo_postal_cidade = 'dne'


SELECT * FROM Alojamento
INSERT INTO Foto_Alojamento (foto, id_alojamento) VALUES ('./fotos/adriananielsen_shitmail_mefoto_alojamento_amsterdam_noord-holland1054_netherlands.jpg', 1);


ALTER PROCEDURE sp_clearIdenity AS 
BEGIN 
	exec sp_MSforeachtable @command1 = 'DBCC CHECKIDENT(''?'', RESEED, 0)'
END


SELECT * FROM Tipo_Comodidade

SELECT * FROM Comodidade


DELETE FROM Comodidade
DBCC CHECKIDENT ('[Comodidade]', RESEED, 0);
GO

DELETE FROM Alojamento_Comodidade
DBCC CHECKIDENT ('[Alojamento_Comodidade]', RESEED, 0);
GO

SELECT * FROM Alojamento_Comodidade