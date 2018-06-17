CREATE DATABASE escola;
GO

USE escola;
GO

CREATE TABLE tb_aluno(
id INT IDENTITY,
nome VARCHAR(50),
matricula VARCHAR(3)
);
GO

INSERT INTO tb_aluno VALUES ('Jose marcondes', '001'),
('Maria bonita', '002'),
('Tim armstrong', '003')
GO

CREATE TRIGGER tgrVerificaMatricula ON tb_aluno
AFTER INSERT
AS
	BEGIN
		IF(EXISTS(SELECT matricula FROM tb_aluno
			GROUP BY matricula
			HAVING COUNT(*) > 1))
		BEGIN
			RAISERROR('MATRICULA JA EXISTE!',15,0)
			ROLLBACK
		END
	END
GO


CREATE TRIGGER tgr_validarRegistro
ON tb_aluno
AFTER INSERT
AS
	BEGIN
		DECLARE @nome varchar(50);
		DECLARE @matricula varchar(50);
		SELECT @nome=i.nome FROM inserted i;
		SELECT @matricula=i.matricula FROM inserted i;
		
		DECLARE @ErrorSeverity INT,@ErrorState INT

		IF(LEN(@nome)< '3')
			BEGIN
				RAISERROR('NOME DEVE CONTER MAIS QUE 3 CARACTERES',@ErrorSeverity,@ErrorState);
				ROLLBACK
			END
		IF(LEN(@matricula)< '3' OR LEN(@matricula)> '3')
			BEGIN
				RAISERROR('MATRICULA DEVE CONTER APENAS 3 CARACTERES',@ErrorSeverity,@ErrorState);
				ROLLBACK
			END
	
	
	END
GO

---verifica se matricula contem 3 caracteres
INSERT INTO tb_aluno VALUES ('Machado de assis', '40');


---verifica se nome contem 3 caracteres
INSERT INTO tb_aluno VALUES ('Jr', '111');

--verifica se nome e matricula contem 3 caracteres
INSERT INTO tb_aluno VALUES ('Dr', '88');

--verifica se matricula já existe
INSERT INTO tb_aluno VALUES ('Jose marcondes','002')

