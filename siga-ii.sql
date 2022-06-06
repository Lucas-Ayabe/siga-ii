DROP DATABASE IF EXISTS SigaII;
CREATE DATABASE SigaII;
GO
USE SigaII;
GO
DROP TABLE IF EXISTS aluno
GO
CREATE TABLE aluno (
	ra BIGINT,
	nome VARCHAR(255),
	PRIMARY KEY (ra)
)
GO
-- Se é P1, P2, P3, P4, ...
DROP TABLE IF EXISTS avaliacao
GO
CREATE TABLE avaliacao (
	codigo INT,
	tipo VARCHAR(255),
	PRIMARY KEY (codigo)
)
GO
DROP TABLE IF EXISTS matricula
GO
CREATE TABLE matricula (
	ra_aluno BIGINT NOT NULL,
	codigo_disciplina VARCHAR(255) NOT NULL,
	FOREIGN KEY (ra_aluno) REFERENCES aluno(ra),
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
)
GO
DROP TABLE IF EXISTS disciplina
GO
CREATE TABLE disciplina (
	codigo VARCHAR(255),
	nome VARCHAR(255),
	sigla VARCHAR(10),
	turno VARCHAR(255),
	num_aulas INT,
	PRIMARY KEY (codigo)
)
GO
DROP TABLE IF EXISTS notas
GO
CREATE TABLE notas (
	ra_aluno BIGINT,
	codigo_disciplina VARCHAR(255),
	codigo_avaliacao INT,
	nota DECIMAL,
	FOREIGN KEY (ra_aluno) REFERENCES aluno(ra),
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
	FOREIGN KEY (codigo_avaliacao) REFERENCES avaliacao(codigo)
)
GO
DROP TABLE IF EXISTS faltas
GO
CREATE TABLE faltas (
	ra_aluno BIGINT,
	codigo_disciplina VARCHAR(255),
	data DATE,
	presenca INT,
	FOREIGN KEY (ra_aluno) REFERENCES aluno(ra),
	FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
);
GO
INSERT INTO disciplina VALUES
('4203-010', 'Arquitetura e Organização de Computadores', 'AOC', 'tarde', 80),
('4203-020', 'Arquitetura e Organização de Computadores', 'AOC', 'noite', 80),
('4208-010', 'Laboratório de Hardware', 'LBH', 'tarde', 80),
('4226-004', 'Banco de Dados', 'BD', 'tarde', 80),
('4233-005', 'Laboratorio de Banco de Dados', 'LBD', 'tarde', 80),
('5005-220', 'Métodos Para a Produção do Conhecimento', 'MPC', 'manha', 40);
GO
INSERT INTO avaliacao VALUES
(1,'P1'),
(2,'P2'),
(3,'P3'),
(4,'PE'),
(5,'EX'),
(6,'T');
GO
INSERT INTO aluno VALUES
(1110482012001, 'Marielle'),
(1110482012002, 'Milton'),
(1110482012003, 'Marje'),
(1110482012004, 'Emlyn'),
(1110482012005, 'Fee'),
(1110482012006, 'Charles'),
(1110482012007, 'Octavius'),
(1110482012008, 'Nicki'),
(1110482012009, 'Gael'),
(1110482012010, 'Naoma'),
(1110482012011, 'Jorgan'),
(1110482012012, 'Deane'),
(1110482012013, 'Ricki'),
(1110482012014, 'Pebrook'),
(1110482012015, 'Domenico'),
(1110482012016, 'Martainn'),
(1110482012017, 'Nester'),
(1110482012018, 'Brantley'),
(1110482012019, 'Kimberlyn'),
(1110482012020, 'Bay');
GO
INSERT INTO matricula VALUES
(1110482012001, '5005-220'),
(1110482012001, '4203-010'),
(1110482012002, '4203-010'),
(1110482012003, '4203-010'),
(1110482012004, '4203-010'),
(1110482012005, '4203-010'),
(1110482012006, '4203-010'),
(1110482012007, '4203-010'),
(1110482012008, '4203-010'),
(1110482012009, '4203-010'),
(1110482012010, '4203-010'),
(1110482012011, '4203-010'),
(1110482012012, '4203-010'),
(1110482012013, '4203-010'),
(1110482012014, '4203-010'),
(1110482012015, '4203-010'),
(1110482012016, '4203-010'),
(1110482012017, '4203-010'),
(1110482012018, '4203-010'),
(1110482012019, '4203-010'),
(1110482012020, '4203-010')
GO
DROP FUNCTION IF EXISTS quantidade_de_faltas_para_texto;
GO
CREATE FUNCTION quantidade_de_faltas_para_texto(@quantidade_de_faltas INT, @quantidade_de_aulas INT)
RETURNS VARCHAR(4) AS
BEGIN
	RETURN CONCAT(
		REPLICATE('F', @quantidade_de_faltas),
		REPLICATE('P', @quantidade_de_aulas - @quantidade_de_faltas)
	);
END
GO
DROP FUNCTION IF EXISTS calcular_quadro_de_faltas_do_aluno;
GO
CREATE FUNCTION calcular_quadro_de_faltas_do_aluno(@ra_do_aluno BIGINT, @codigo_da_disciplina VARCHAR(255))
RETURNS @quadro_de_faltas TABLE (
	RA_Aluno BIGINT,
	Nome_Aluno VARCHAR(255),
	Data1 VARCHAR(4) NULL,
	Data2 VARCHAR(4) NULL,
	Data3 VARCHAR(4) NULL,
	Data4 VARCHAR(4) NULL,
	Data5 VARCHAR(4) NULL,
	Data6 VARCHAR(4) NULL,
	Data7 VARCHAR(4) NULL,
	Data8 VARCHAR(4) NULL,
	Data9 VARCHAR(4) NULL,
	Data10 VARCHAR(4) NULL,
	Data11 VARCHAR(4) NULL,
	Data12 VARCHAR(4) NULL,
	Data13 VARCHAR(4) NULL,
	Data14 VARCHAR(4) NULL,
	Data15 VARCHAR(4) NULL,
	Data16 VARCHAR(4) NULL,
	Data17 VARCHAR(4) NULL,
	Data18 VARCHAR(4) NULL,
	Data19 VARCHAR(4) NULL,
	Data20 VARCHAR(4) NULL,
	Total_Faltas INT
)
AS
BEGIN
	DECLARE @nome_do_aluno VARCHAR(255) = (SELECT nome FROM aluno WHERE ra = @ra_do_aluno);
	DECLARE @total_de_faltas INT = (SELECT SUM(presenca) FROM faltas WHERE ra_aluno = @ra_do_aluno)
	DECLARE @aulas INT = (SELECT num_aulas FROM disciplina WHERE codigo = @codigo_da_disciplina)
	
	DECLARE @primeira_data    DATE = (SELECT TOP 1 data FROM faltas WHERE ra_aluno = @ra_do_aluno)
	DECLARE @faltas_da_aula_1  INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 0 * 7,  @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_2  INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 1 * 7,  @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_3  INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 2 * 7,  @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_4  INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 3 * 7,  @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_5  INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 4 * 7,  @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_6  INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 5 * 7,  @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_7  INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 6 * 7,  @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_8  INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 7 * 7,  @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_9  INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 8 * 7,  @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_10 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 9 * 7,  @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_11 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 10 * 7, @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_12 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 11 * 7, @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_13 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 12 * 7, @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_14 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 13 * 7, @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_15 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 14 * 7, @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_16 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 15 * 7, @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_17 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 16 * 7, @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_18 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 17 * 7, @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_19 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 18 * 7, @primeira_data) AND ra_aluno = @ra_do_aluno);
	DECLARE @faltas_da_aula_20 INT = (SELECT presenca FROM faltas WHERE data = DATEADD(DAY, 19 * 7, @primeira_data) AND ra_aluno = @ra_do_aluno);

	INSERT INTO @quadro_de_faltas(RA_Aluno, Nome_Aluno, Total_Faltas) VALUES
	(@ra_do_aluno, @nome_do_aluno, @total_de_faltas);
	
	UPDATE @quadro_de_faltas
	SET
		Data1  = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_1, @aulas),
		Data2  = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_2, @aulas),
		Data3  = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_3, @aulas),
		Data4  = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_4, @aulas),
		Data5  = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_5, @aulas),
		Data6  = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_6, @aulas),
		Data7  = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_7, @aulas),
		Data8  = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_8, @aulas),
		Data9  = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_9, @aulas),
		Data10 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_10, @aulas),
		Data11 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_11, @aulas),
		Data12 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_12, @aulas),
		Data13 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_13, @aulas),
		Data14 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_14, @aulas),
		Data15 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_15, @aulas),
		Data16 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_16, @aulas),
		Data17 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_17, @aulas),
		Data18 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_18, @aulas),
		Data19 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_19, @aulas),
		Data20 = dbo.quantidade_de_faltas_para_texto(@faltas_da_aula_20, @aulas)
	WHERE RA_Aluno = @ra_do_aluno
	
	RETURN
END
GO
DROP FUNCTION IF EXISTS calcular_quadro_de_faltas_da_disciplina;
GO
CREATE FUNCTION calcular_quadro_de_faltas_da_disciplina(@codigo_da_disciplina VARCHAR(255))
RETURNS @quadro_de_faltas TABLE (
	RA_Aluno BIGINT,
	Nome_Aluno VARCHAR(255),
	Data1 VARCHAR(4) NULL,
	Data2 VARCHAR(4) NULL,
	Data3 VARCHAR(4) NULL,
	Data4 VARCHAR(4) NULL,
	Data5 VARCHAR(4) NULL,
	Data6 VARCHAR(4) NULL,
	Data7 VARCHAR(4) NULL,
	Data8 VARCHAR(4) NULL,
	Data9 VARCHAR(4) NULL,
	Data10 VARCHAR(4) NULL,
	Data11 VARCHAR(4) NULL,
	Data12 VARCHAR(4) NULL,
	Data13 VARCHAR(4) NULL,
	Data14 VARCHAR(4) NULL,
	Data15 VARCHAR(4) NULL,
	Data16 VARCHAR(4) NULL,
	Data17 VARCHAR(4) NULL,
	Data18 VARCHAR(4) NULL,
	Data19 VARCHAR(4) NULL,
	Data20 VARCHAR(4) NULL,
	Total_Faltas INT
)
AS
BEGIN
	DECLARE @ra BIGINT
	DECLARE cursor_faltas CURSOR FOR
	SELECT ra_aluno FROM faltas WHERE codigo_disciplina = @codigo_da_disciplina
	GROUP BY ra_aluno

	OPEN cursor_faltas
	FETCH NEXT FROM cursor_faltas INTO @ra

	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO @quadro_de_faltas
		SELECT * FROM dbo.calcular_quadro_de_faltas_do_aluno(@ra, @codigo_da_disciplina)

		FETCH NEXT FROM cursor_faltas INTO @ra
	END

	CLOSE cursor_faltas;
	DEALLOCATE cursor_faltas;
	
	RETURN
END
GO