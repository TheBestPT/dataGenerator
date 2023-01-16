SELECT * FROM Administrador
SELECT * FROM Alojamento
SELECT * FROM Alojamento_Comodidade
SELECT * FROM Anfitriao
SELECT * FROM Cidade
SELECT * FROM Classificacao
SELECT * FROM Classificacao_Anfitriao
SELECT * FROM Cliente
SELECT * FROM Comodidade
SELECT * FROM Foto_Alojamento
SELECT * FROM Logs
SELECT * FROM Metodo_Pagamento
SELECT * FROM Pagamento
SELECT * FROM Pais
SELECT * FROM Preco_Epoca_Ano
SELECT * FROM Reserva
SELECT * FROM Tipo_Alojamento
SELECT * FROM Tipo_Comodidade
SELECT * FROM Tipo_Reserva


SELECT * FROM Alojamento
SELECT * FROM Tipo_Alojamento

ALTER TABLE Alojamento ADD Classificacao INT DEFAULT 0; 
ALTER TABLE Anfitriao ADD Classificacao INT DEFAULT 0;

SELECT * FROM Alojamento



SELECT * FROM Reserva WHERE preco < 0
SELECT * FROM Reserva

SELECT * FROM Pais Order By nome_pais


CREATE TRIGGER tr_updateMediaClassificacoesAlojamento
ON Classificacao
AFTER INSERT
AS
BEGIN
UPDATE Alojamento SET Classificacao = (SELECT AVG(limpeza+comunicacao+check_in+localizacao+qualidade_preco)/5.0 
FROM Classificacao,Alojamento WHERE Classificacao.id_alojamento = Alojamento.id_alojamento) WHERE Alojamento.id_alojamento = (SELECT id_alojamento FROM inserted)
END

alter TRIGGER tr_updateMediaClassificacoesAnfitriao
ON Classificacao_Anfitriao
AFTER INSERT
AS
BEGIN
UPDATE Anfitriao SET Classificacao = (SELECT AVG(comunicacao+tempo_resposta)/2.0
FROM Classificacao_Anfitriao,Anfitriao WHERE Classificacao_Anfitriao.id_anfitriao = Anfitriao.id_anfitriao) WHERE Anfitriao.id_anfitriao = (SELECT id_anfitriao FROM inserted)
END


CREATE PROCEDURE sp_alojamentoComodidade
as(SELECT Alojamento.nome as Alojamento, Tipo_Comodidade.descricao as Tipo_Comodidade, Comodidade.descricao as Comodidade
	FROM Alojamento, Tipo_Comodidade, Comodidade, Alojamento_Comodidade
	WHERE Alojamento.id_alojamento = Alojamento_Comodidade.id_alojamento
		AND Alojamento_Comodidade.id_comodidade = Comodidade.id_comodidade
		AND Comodidade.id_tipo_comodidade = Tipo_Comodidade.id_tipo_comodidade)


CREATE PROCEDURE sp_alojamentoPorComodidade
@comodidade VARCHAR(80)
as(SELECT Alojamento.nome as Alojamento, Tipo_Comodidade.descricao as Tipo_Comodidade, Comodidade.descricao as Comodidade
	FROM Alojamento, Tipo_Comodidade, Comodidade, Alojamento_Comodidade
	WHERE Alojamento.id_alojamento = Alojamento_Comodidade.id_alojamento
		AND Alojamento_Comodidade.id_comodidade = Comodidade.id_comodidade
		AND Comodidade.id_tipo_comodidade = Tipo_Comodidade.id_tipo_comodidade
		AND Comodidade.descricao = @comodidade)

CREATE PROCEDURE sp_alojamentoTipo
@tipo VARCHAR(50)
as(SELECT Tipo_Alojamento.descricao, Alojamento.nome
	FROM Tipo_Alojamento, Alojamento
	WHERE Alojamento.id_tipo_alojamento = Tipo_Alojamento.id_tipo_alojamento
		AND Tipo_Alojamento.descricao = @tipo)

CREATE PROCEDURE sp_mediaPrecoPorData
@data DATE
as(SELECT AVG(Preco_Epoca_Ano.preco) as Media
	FROM Preco_Epoca_Ano
	WHERE @data BETWEEN Preco_Epoca_Ano.data_inicio AND Preco_Epoca_Ano.data_fim)


CREATE PROCEDURE sp_mediaPrecoPorDataELocalizacao
@data DATE,
@localizacao VARCHAR(50)
as(SELECT AVG(Preco_Epoca_Ano.preco) as Media, Cidade.nome_cidade as Cidade
	FROM Preco_Epoca_Ano, Alojamento, Cidade
	WHERE @data BETWEEN Preco_Epoca_Ano.data_inicio AND Preco_Epoca_Ano.data_fim
		AND Preco_Epoca_Ano.id_alojamento = Alojamento.id_alojamento
		AND Alojamento.codigo_postal_cidade = Cidade.codigo_postal_cidade
		AND Cidade.nome_cidade = @localizacao
	GROUP BY Cidade.nome_cidade
)

CREATE PROCEDURE sp_numeroAlojamento
as(SELECT COUNT(id_alojamento) AS NumeroAlojamentos FROM Alojamento)

CREATE PROCEDURE sp_numeroReservaPorData
@data DATE
as
(SELECT COUNT(Reserva.id_reserva) AS NumeroReservas
	FROM Reserva
	WHERE @data BETWEEN Reserva.check_in AND Reserva.check_out)

CREATE TRIGGER tr_novaReserva
ON Reserva
AFTER INSERT
AS
PRINT 'Nova reserva registada';
SELECT * FROM inserted
GO


CREATE TRIGGER tr_novoAlojamento
ON Alojamento
AFTER INSERT
AS
PRINT 'Novo alojamento registado';
SELECT * FROM inserted

CREATE TRIGGER tr_novoAnfitriao
ON Anfitriao
AFTER INSERT
AS
PRINT 'Novo anfitriao registado';
SELECT * FROM inserted
GO


CREATE TRIGGER tr_updateReserva
ON Pagamento
AFTER INSERT
AS
UPDATE Reserva SET status = 'Confirmado' WHERE id_reserva = (SELECT id_reserva FROM inserted);
PRINT 'Status da Reserva atualizado!'
GO

CREATE TRIGGER tr_verificacaoClassificacao
ON Classificacao
AFTER INSERT
AS
IF NOT EXISTS (SELECT Reserva.id_reserva FROM Reserva WHERE Reserva.id_cliente = (SELECT id_cliente FROM inserted) AND Reserva.id_alojamento = (SELECT id_alojamento FROM inserted))
	BEGIN
		PRINT 'Nao tem nenhuma reserva neste alojamento, a sua classificacao nao foi registada!'
		ROLLBACK
	END
GO


CREATE TRIGGER tr_verificacaoClassificacaoAnfitriao
ON Classificacao_Anfitriao
AFTER INSERT
AS
IF NOT EXISTS(SELECT Reserva.id_reserva FROM Reserva, Alojamento WHERE Reserva.id_cliente = (SELECT id_cliente FROM inserted) AND Reserva.id_alojamento = Alojamento.id_alojamento AND Alojamento.id_anfitriao = (SELECT id_anfitriao FROM inserted))
	BEGIN
		PRINT 'Nao tem nenhuma reserva com este anfitriao, a sua classificacao nao foi registada!';
		ROLLBACK
	END


ALTER TABLE Alojamento ADD Classificacao FLOAT DEFAULT 0
ALTER TABLE Anfitriao ADD Classificacao FLOAT DEFAULT 0

-- DROP COLUMN 
alter table Alojamento drop constraint DF__Alojament__Class__4D5F7D71;
alter table Alojamento drop column Classificacao;

alter table Anfitriao drop constraint DF__Anfitriao__Class__4E53A1AA;
alter table Anfitriao drop column Classificacao;

SELECT * FROM Anfitriao

DECLARE @preco FLOAT; EXEC sp_trackPrecoByDate '5-22-2023', '9-20-2023', 1, @preco OUTPUT; DECLARE @tipo_reserva INT; SELECT @tipo_reserva = id_tipo_reserva FROM tipo_reserva WHERE descricao = 'Trabalho'; INSERT INTO reserva (check_in, check_out, numero_pessoas, preco, status, detalhes, id_alojamento, id_cliente, id_tipo_reserva) VALUES('5-22-2023', '9-20-2023', '1', @preco, 1, 'Reserva confirmada', 1, 1, @tipo_reserva); DECLARE @id_reserva INT; SET @id_reserva = IDENT_CURRENT('Reserva'); INSERT INTO pagamento (preco, estado_pagamento, id_reserva, id_metodo_pagamento) VALUES(@preco, 'Pago', @id_reserva, @id_reserva)

UPDATE Anfitriao SET Classificacao = 0
UPDATE Alojamento SET Classificacao = 0

SELECT * FROM Tipo_Reserva




ALTER PROCEDURE sp_selectARowOfLogs @id_log INT  as 
BEGIN
	DECLARE @id INT;
	DECLARE @id_nome VARCHAR(30)
	DECLARE @table VARCHAR(30)
	DECLARE @event VARCHAR(20)
	SELECT @event = tipo_evento FROM Logs WHERE id_log = @id_log
	IF @event = 'removido'
	BEGIN
		PRINT 'Não é possível ver um item apagado.'
		SELECT comando_sql FROM Logs WHERE id_log = @id_log
		RETURN
	END
	SELECT @id = id_numero, @id_nome = id_nome, @table = nome_tabela FROM Logs WHERE id_log = @id_log
	IF @id IS NULL AND @id_nome IS NULL
	BEGIN
		PRINT 'Log não existente'
		RETURN
	END
	declare @sql as varchar(max)
	set @sql = 'SELECT * FROM ' + @table + ' WHERE '+ @id_nome +' = '+ CAST(@id AS VARCHAR)
	exec (@sql)
END

SELECT * FROM Logs WHERE id_log = 1

EXEC sp_selectARowOfLogs 1

ALTER PROCEDURE sp_verificarDatasAlojamento @id_alojamento INT, @data_inicio DATE, @data_fim DATE, @existeData BIT OUTPUT, 
@data_ocupada_inicio DATE OUTPUT, 
@data_ocupada_fim DATE OUTPUT, @id_reserva_output INT OUTPUT AS
BEGIN
	IF NOT EXISTS (SELECT TOP 1 * FROM Reserva WHERE id_alojamento = @id_alojamento AND ((@data_inicio BETWEEN check_in AND check_out) 
	OR (@data_fim BETWEEN
	check_in AND check_out)))
	BEGIN
		SELECT @existeData = 0
		PRINT 'Não existe reserva nestas datas!'
	END
	ELSE
	BEGIN
		PRINT 'Já existe reserva nestas datas.'
		SELECT TOP 1 @data_ocupada_inicio = check_in, @data_ocupada_fim = check_out, @id_reserva_output = id_reserva FROM Reserva WHERE id_alojamento = @id_alojamento AND ((@data_inicio BETWEEN check_in AND check_out) 
		OR (@data_fim BETWEEN
		check_in AND check_out))
		SELECT @existeData = 1
	END	
END

DECLARE @data_inicio DATE
DECLARE @data_fim DATE
SELECT @data_inicio = '2023-05-26'
SELECT @data_fim = '2023-11-01'
DECLARE @id_alojamento INT
SELECT @id_alojamento = 1


--SELECT * FROM Reserva

--SELECT TOP 1 * FROM Reserva WHERE id_alojamento = @id_alojamento AND ((@data_inicio BETWEEN check_in AND check_out) 
--	OR (@data_fim BETWEEN
--	check_in AND check_out))

--INSERT INTO Reserva (check_in, check_out, numero_pessoas, preco, status, detalhes, id_alojamento, id_cliente, id_tipo_reserva) VALUES(
--'2023-05-25', '2023-06-01', 1, 300, 1, '', 1, 2, 2)

--SELECT * FROM Reserva


DECLARE @existeData BIT;
DECLARE @data_ocupada_inicio DATE
DECLARE @data_ocupada_fim DATE
EXEC sp_verificarDatasAlojamento @id_alojamento, @data_inicio,
@data_fim, @existeData OUTPUT, @data_ocupada_inicio OUTPUT, @data_ocupada_fim OUTPUT

PRINT CAST(@data_ocupada_inicio AS VARCHAR)
PRINT CAST(@data_ocupada_fim AS VARCHAR)


ALTER TRIGGER tr_verificacaoDeDatas
ON Reserva
AFTER INSERT
AS
BEGIN
	DECLARE @data_inicio DATE
	DECLARE @data_fim DATE
	DECLARE @id_alojamento INT
	DECLARE @id_reserva INT
	SELECT @data_inicio = check_in, @data_fim = check_out, @id_alojamento = id_alojamento, @id_reserva = id_reserva FROM inserted
	DECLARE @existeData BIT;
	DECLARE @data_ocupada_inicio DATE
	DECLARE @data_ocupada_fim DATE
	DECLARE @id_reserva_output INT
	EXEC sp_verificarDatasAlojamento @id_alojamento, @data_inicio,
	@data_fim, @existeData OUTPUT, @data_ocupada_inicio OUTPUT, @data_ocupada_fim OUTPUT, @id_reserva_output OUTPUT
	IF @existeData = 1 AND @id_reserva_output != @id_reserva
	BEGIN
		PRINT 'Já existe reserva nesta data'
		ROLLBACK
	END
END

