create database escola_musica;

use escola_musica;

-- 1. CRIAÇÃO DAS TABELAS --

create table orquestra (
id_orquestra int primary key NOT NULL,
nome_orquestra VARCHAR(100) NOT NULL,
cidade VARCHAR(30) NOT NULL,
pais VARCHAR(30) NOT NULL,
data_criacao DATE NOT NULL
);

create table sinfonia (
id_sinfonia int primary key NOT NULL,
nome_sinfonia varchar(100) NOT NULL,
compositor varchar(30) NOT NULL,
data_criacao DATE NOT NULL
);

create table musico (
id_musico int primary key NOT NULL,
nome_musico varchar(30) NOT NULL,
identidade int NOT NULL,
nacionalidade varchar(30) NOT NULL,
data_nasc DATE NOT NULL,
id_orquestra INT not null,
FOREIGN KEY (id_orquestra) REFERENCES orquestra (id_orquestra)
);

create table instrumento (
id_instrumento int primary key NOT NULL,
nome_instrumento varchar(30) NOT NULL
);

create table funcao (
id_funcao INT PRIMARY KEY NOT NULL,
nome_funcao varchar(50) NOT NULL
);

create table apresentacao (
id_apresentacao int primary key not null,
data_apresentacao date not null,
id_orquestra int not null,
id_sinfonia int not null,
foreign key (id_orquestra) references orquestra (id_orquestra),
foreign key (id_sinfonia) references sinfonia (id_sinfonia)
);

create table musico_Funcao_apresentacao (
    id_musico INT NOT NULL,
    id_funcao INT NOT NULL,
    id_instrumento INT NOT NULL,
    id_apresentacao INT NOT NULL,
    PRIMARY KEY (id_musico, id_funcao, id_instrumento, id_apresentacao),
    FOREIGN KEY (id_musico) REFERENCES musico (id_musico),
    FOREIGN KEY (id_funcao) REFERENCES funcao (id_funcao),
    FOREIGN KEY (id_instrumento) REFERENCES instrumento (id_instrumento),
    FOREIGN KEY (id_apresentacao) REFERENCES apresentacao (id_apresentacao)
);

-- 2. SCRIPTS DE ALTERAÇÃO --

ALTER TABLE musico 
MODIFY COLUMN identidade VARCHAR(20) NOT NULL;

ALTER TABLE orquestra
MODIFY COLUMN cidade varchar(40) not null;

ALTER TABLE sinfonia
ADD COLUMN continente varchar(30);

ALTER TABLE musico
ADD COLUMN genero ENUM('M', 'F') NOT NULL;

ALTER TABLE musico
ADD COLUMN cidade_nasc varchar(40);

ALTER TABLE sinfonia
ADD COLUMN pais_sinfonia varchar(40);

ALTER TABLE musico
ADD COLUMN id_instrumento varchar(50);

ALTER TABLE musico
ADD COLUMN continente varchar(30);

ALTER TABLE orquestra
ADD COLUMN continente varchar(30);

ALTER TABLE sinfonia
DROP COLUMN continente; -- todas as sinfonias registradas são europeias

-- 3. SCRIPT DE DELETAÇÃO --

SET SQL_SAFE_UPDATES = 0;

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM musico_funcao_apresentacao;
DELETE FROM apresentacao;
DELETE FROM sinfonia;
DELETE FROM funcao;
DELETE FROM instrumento;
DELETE FROM musico;
DELETE FROM orquestra;

DROP TABLE IF EXISTS musico_Funcao_apresentacao;

DROP TABLE IF EXISTS apresentacao;

DROP TABLE IF EXISTS funcao;

DROP TABLE IF EXISTS instrumento;

DROP TABLE IF EXISTS sinfonia;

DROP TABLE IF EXISTS orquestra;

DROP TABLE IF EXISTS musico;

DROP VIEW IF EXISTS view_musicos_brasileiros;
DROP VIEW IF EXISTS view_musicos_estrangeiros;
DROP VIEW IF EXISTS view_musicos_sul_americanos;
DROP VIEW IF EXISTS view_musicos_nao_sul_americanos;
DROP VIEW IF EXISTS view_musicos_homens;
DROP VIEW IF EXISTS view_musicos_mulheres;
DROP VIEW IF EXISTS view_musico_instrumento;
DROP VIEW IF EXISTS view_musico_orquestra;
DROP VIEW IF EXISTS view_musico_mais_jovem;
DROP VIEW IF EXISTS view_musico_mais_velho;
DROP VIEW IF EXISTS view_orquestras_europeias;
DROP VIEW IF EXISTS view_orquestras_nao_europeias;

SET FOREIGN_KEY_CHECKS = 1;

-- 4. INSERÇÃO DE DADOS --

-- (id_orquestra, nome_orquestra, cidade, pais, data_criacao, continente)
INSERT INTO orquestra VALUES
(1, 'Filarmônica de Viena', 'Viena', 'Áustria', '1842-03-28', 'Europa'),
(2, 'Orquestra de Paris', 'Paris', 'França', '1967-11-01', 'Europa'),
(3, 'Orquestra Sinfônica de Chicago', 'Chicago', 'EUA', '1891-10-16', 'América do Norte'),
(4, 'Orquestra Filarmônica de Berlim', 'Berlim', 'Alemanha', '1882-05-01', 'Europa'),
(5, 'Orquestra Sinfônica Brasileira', 'Rio de Janeiro', 'Brasil', '1940-07-11', 'América do Sul'),
(6, 'Orquestra Filarmônica de Tóquio', 'Tóquio', 'Japão', '1911-04-01', 'Ásia'),
(7, 'Orquestra Gulbenkian', 'Lisboa', 'Portugal', '1962-01-01', 'Europa'),
(8, 'Orquestra Sinfônica de Londres', 'Londres', 'Reino Unido', '1904-06-09', 'Europa'),
(9, 'Orquestra Nacional Russa', 'Moscou', 'Rússia', '1990-01-01', 'Europa'),
(10, 'Orquestra Sinfônica de Sydney', 'Sydney', 'Austrália', '1932-06-30', 'Oceania');

-- (id_sinfonia, nome_sinfonia, compositor, data_criacao, pais_sinfonia, continente)
INSERT INTO sinfonia VALUES
(11, 'Sinfonia Nº5', 'Beethoven', '1808-12-22', 'Alemanha', 'Europa'),
(12, 'Sinfonia Nº9', 'Beethoven', '1824-05-07', 'Alemanha', 'Europa'),
(13, 'Sinfonia Fantástica', 'Berlioz', '1830-12-05', 'França', 'Europa'),
(14, 'Sinfonia Nº40', 'Mozart', '1788-07-25', 'Áustria', 'Europa'),
(15, 'Nova Mundo', 'Dvořák', '1893-12-15', 'Tchéquia', 'Europa'),
(16, 'Sinfonia Alpina', 'Richard Strauss', '1915-10-28', 'Alemanha', 'Europa'),
(17, 'Pastoral', 'Beethoven', '1808-12-22', 'Alemanha', 'Europa'),
(18, 'Sinfonia Nº6', 'Tchaikovsky', '1893-10-28', 'Rússia', 'Europa'),
(19, 'Sinfonia Leningrado', 'Shostakovich', '1942-03-05', 'Rússia', 'Europa'),
(20, 'Sinfonia Nº1', 'Mahler', '1889-11-20', 'Áustria', 'Europa');

-- (id_instrumento, nome)
INSERT INTO instrumento VALUES
(21, 'Violino'),
(22, 'Viola'),
(23, 'Violoncelo'),
(24, 'Contrabaixo'),
(25, 'Flauta'),
(26, 'Guitarra'),
(27, 'Clarinete'),
(28, 'Piano'),
(29, 'Trompete'),
(30, 'Violão');

-- (id_funcao, nome)
INSERT INTO funcao VALUES
(31, 'Violinista'),
(32, 'Violista'),
(33, 'Violoncelista'),
(34, 'Contrabaixista'),
(35, 'Flautista'),
(36, 'Guitarrista'),
(37, 'Clarinetista'),
(38, 'Pianista'),
(39, 'Trompetista'),
(40, 'Violonista');

-- (id_musico, nome, identidade, nacionalidade, data_nasc, genero, cidade_nasc, id_instrumento, continente)
INSERT INTO musico VALUES
(41, 'João Silva', '123.456.789-10', 'Brasileira', '1985-07-10', 1, 'M', 'São Paulo', 21, 'América do Sul'),
(42, 'Anna Müller', '263.509.430-42', 'Alemã', '1982-09-15', 2, 'F', 'Berlim', 22, 'Europa'),
(43, 'Yuki Tanaka', '804.317.020-53', 'Japonesa', '1990-11-20', 3, 'F', 'Tóquio', 23, 'Ásia'),
(44, 'Marie Dubois', '148.222.580-01', 'Francesa', '1987-03-12', 4, 'F', 'Paris', 24, 'Europa'),
(45, 'Liam Smith', '395.748.670-37', 'Britânica', '1992-08-25', 5, 'M', 'Londres', 25, 'Europa'),
(46, 'Carlos Mendes', '573.960.090-70', 'Brasileira', '1984-01-30', 6, 'M', 'Rio de Janeiro', 26, 'América do Sul'),
(47, 'Lucas Costa', '607.431.110-08', 'Brasileira', '1991-12-05', 7, 'M', 'Recife', 27, 'América do Sul'),
(48, 'Fernanda Palacios', '725.168.800-39', 'Argentina', '1993-03-22', 8, 'F', 'Buenos Aires', 28, 'América do Sul'),
(49, 'Pedro Oliveira', '991.620.340-82', 'Brasileira', '1988-09-14', 9, 'M', 'Porto Alegre', 29, 'América do Sul'),
(50, 'Juliana Ribeiro', '313.208.750-66', 'Brasileira', '1995-06-08', 10, 'F', 'Salvador', 30, 'América do Sul');

-- (id_apresentacao, data_apresentacao, id_orquestra, id_sinfonia)
INSERT INTO apresentacao VALUES
(51, '2025-05-15', 1, 11),
(52, '2025-06-20', 2, 12),
(53, '2025-07-18', 3, 13),
(54, '2025-08-10', 4, 14),
(55, '2025-09-05', 5, 15),
(56, '2025-09-22', 6, 16),
(57, '2025-10-17', 7, 17),
(58, '2025-11-12', 8, 18),
(59, '2025-12-23', 9, 19),
(60, '2025-12-31', 10, 20);

-- Inserts para tabela 'musico_funcao_apresentacao' (id_musico, id_funcao, id_apresentacao)
INSERT INTO musico_funcao_apresentacao VALUES
(41, 31, 21, 51),  -- João Silva, Violinista, Violino, Apresentação 1
(42, 32, 22, 52),  -- Anna Müller, Violista, Viola, Apresentação 2
(43, 33, 23, 53),  -- Yuki Tanaka, Violoncelista, Violoncelo, Apresentação 3
(44, 34, 24, 54),  -- Marie Dubois, Contrabaixista, Contrabaixo, Apresentação 4
(45, 35, 25, 55),  -- Liam Smith, Flautista, Flauta, Apresentação 5
(46, 36, 26, 56),  -- Carlos Mendes, Guitarrista, Guitarra, Apresentação 6
(47, 37, 27, 57),  -- Lucas Costa, Clarinetista, Clarinetista, Apresentação 7
(48, 38, 28, 58),  -- Fernanda Souza, Pianista, Pianista,Apresentação 8
(49, 39, 29, 59),  -- Pedro Oliveira, Trompetista, Trompete, Apresentação 9
(50, 40, 30, 60); -- Juliana Ribeiro, Violonista, Violão, Apresentação 10

-- 5. PERGUNTAS/CONSULTAS/RELATÓRIOS --

-- 1. músicos brasileiros --
SELECT nome_musico
FROM musico
WHERE nacionalidade = 'Brasileira';

-- 2. músicos estrangeiros --
SELECT nome_musico
FROM musico
WHERE nacionalidade != 'Brasileira';

-- 3. músicos sul-americanos --
SELECT nome_musico, nacionalidade, continente
FROM musico
WHERE continente = 'América do Sul';

-- 4. músicos não sul-americanos --
SELECT nome_musico, nacionalidade, continente
FROM musico
WHERE continente != 'América do Sul';


-- 5. músico e seu instrumento --
SELECT musico.nome_musico, nome_instrumento
FROM musico
JOIN instrumento ON musico.id_instrumento = instrumento.id_instrumento;

-- 6. músico e sua orquestra --
SELECT musico.nome_musico, orquestra.nome_orquestra
FROM musico
JOIN orquestra ON musico.id_orquestra = orquestra.id_orquestra;

-- 7. músico mais jovem --
SELECT nome_musico, TIMESTAMPDIFF(YEAR, data_nasc, CURDATE()) AS idade
FROM musico
WHERE data_nasc = (
    SELECT MAX(data_nasc)
    FROM musico
);

-- 8. músico mais velho --
SELECT nome_musico, TIMESTAMPDIFF(YEAR, data_nasc, CURDATE()) AS idade
FROM musico
WHERE data_nasc = (
    SELECT MIN(data_nasc)
    FROM musico
);

-- 9. sinfonia mais nova --
SELECT nome_sinfonia, compositor, data_criacao
FROM sinfonia
WHERE data_criacao = (
    SELECT MAX(data_criacao)
    FROM sinfonia
);

-- 10. sinfonia mais antiga --
SELECT nome_sinfonia, compositor, data_criacao
FROM sinfonia
WHERE data_criacao = (
    SELECT MIN(data_criacao)
    FROM sinfonia
);

-- 11. orquestras europeias --
SELECT nome_orquestra, continente
FROM orquestra
WHERE continente = 'Europa';

-- 12. orquestras não europeias --
SELECT nome_orquestra, continente
FROM orquestra
WHERE continente != 'Europa';

-- 13. músico com a apresentação com data mais próxima --
SELECT musico.nome_musico, apresentacao.data_apresentacao
FROM musico
JOIN musico_funcao_apresentacao mf ON musico.id_musico = mf.id_musico
JOIN apresentacao ON mf.id_apresentacao = apresentacao.id_apresentacao
WHERE apresentacao.data_apresentacao = (
    SELECT MIN(data_apresentacao)
    FROM apresentacao
    WHERE data_apresentacao >= CURDATE()
);

-- 14. músico com a apresentação com data mais distante --
SELECT musico.nome_musico, a.data_apresentacao 
FROM musico 
JOIN musico_funcao_apresentacao mf ON musico.id_musico = mf.id_musico 
JOIN apresentacao a ON mf.id_apresentacao = a.id_apresentacao 
WHERE a.data_apresentacao = (
    SELECT MAX(data_apresentacao)
    FROM apresentacao
    WHERE data_apresentacao >= CURDATE()
);

-- 15. músicos homens --
SELECT nome_musico, genero
FROM musico
WHERE genero = 'M';

-- 16. músicas mulheres --
SELECT nome_musico, genero
FROM musico
WHERE genero = 'F';

-- 17. músicos com identidade iniciada em número par --
SELECT nome_musico, identidade
FROM musico
WHERE CAST(LEFT(identidade, 1) AS UNSIGNED) % 2 = 0;

-- 18. músicos com identidade iniciada em número ímpar --
SELECT nome_musico, identidade
FROM musico
WHERE CAST(LEFT(identidade, 1) AS UNSIGNED) % 2 != 0;

-- 19. orquestra mais antiga --
SELECT nome_orquestra, data_criacao
FROM orquestra
WHERE data_criacao = (SELECT MIN(data_criacao) FROM orquestra);

-- 20. orquestra mais nova --
SELECT nome_orquestra, data_criacao
FROM orquestra
WHERE data_criacao = (SELECT MAX(data_criacao) FROM orquestra);

-- 21. músicos que tocaram sinfonias de Beethoven--
SELECT musico.nome_musico
FROM musico
JOIN musico_funcao_apresentacao mf ON musico.id_musico = mf.id_musico
JOIN apresentacao a ON mf.id_apresentacao = a.id_apresentacao
WHERE a.id_sinfonia IN (
    SELECT id_sinfonia
    FROM sinfonia
    WHERE compositor = 'Beethoven'
);

-- 22. orquestra que toca sinfonia mais antiga --
SELECT orquestra.nome_orquestra, sinfonia.nome_sinfonia
FROM orquestra
JOIN apresentacao a ON orquestra.id_orquestra = a.id_orquestra
JOIN sinfonia ON a.id_sinfonia = sinfonia.id_sinfonia
WHERE sinfonia.data_criacao = (
    SELECT MIN(data_criacao)
    FROM sinfonia
);

-- 23. orquestra que toca sinfonia mais nova --
SELECT orquestra.nome_orquestra, sinfonia.nome_sinfonia
FROM orquestra
JOIN apresentacao a ON orquestra.id_orquestra = a.id_orquestra
JOIN sinfonia ON a.id_sinfonia = sinfonia.id_sinfonia
WHERE sinfonia.data_criacao = (
    SELECT MAX(data_criacao)
    FROM sinfonia
);

-- 6. VIEWS --

-- 1. view para músicos brasileiros
CREATE VIEW view_musicos_brasileiros AS
SELECT nome_musico
FROM musico
WHERE nacionalidade = 'Brasileira';

-- 2. view para músicos estrangeiros
CREATE VIEW view_musicos_estrangeiros AS
SELECT nome_musico, nacionalidade
FROM musico
WHERE nacionalidade != 'Brasileira';

-- 3. view para músicos sul-americanos
CREATE VIEW view_musicos_sul_americanos AS
SELECT nome_musico, nacionalidade, continente
FROM musico
WHERE continente = 'América do Sul';

-- 4. view para músicos não sul-americanos
CREATE VIEW view_musicos_nao_sul_americanos AS
SELECT nome_musico, nacionalidade, continente
FROM musico
WHERE continente != 'América do Sul';

-- 5. view para músicos homens
CREATE VIEW view_musicos_homens AS
SELECT nome_musico, genero
FROM musico
WHERE genero = 'M';

-- 6. view para músicas mulheres
CREATE VIEW view_musicos_mulheres AS
SELECT nome_musico, genero
FROM musico
WHERE genero = 'F';

-- 7. view para músicos e seus instrumentos
CREATE VIEW view_musico_instrumento AS
SELECT musico.nome_musico, instrumento.nome_instrumento
FROM musico
JOIN instrumento ON musico.id_instrumento = instrumento.id_instrumento;

-- 8. view para músicos e suas orquestras
CREATE VIEW view_musico_orquestra AS
SELECT musico.nome_musico, orquestra.nome_orquestra
FROM musico
JOIN orquestra ON musico.id_orquestra = orquestra.id_orquestra;

-- 9. view pro músico mais jovem
CREATE VIEW view_musico_mais_jovem AS
SELECT nome_musico, data_nasc, TIMESTAMPDIFF(YEAR, data_nasc, CURDATE()) AS idade
FROM musico
WHERE data_nasc = (
    SELECT MAX(data_nasc)
    FROM musico
);

-- 10. view pro músico mais velho
CREATE VIEW view_musico_mais_velho AS
SELECT nome_musico, data_nasc, TIMESTAMPDIFF(YEAR, data_nasc, CURDATE()) AS idade
FROM musico
WHERE data_nasc = (
    SELECT MIN(data_nasc)
    FROM musico
);

-- 11. view para orquestras europeias
CREATE VIEW view_orquestras_europeias AS
SELECT nome_orquestra, continente
FROM orquestra
WHERE continente = 'Europa';

-- 12. view para orquestras não europeias
CREATE VIEW view_orquestras_nao_europeias AS
SELECT nome_orquestra, continente
FROM orquestra
WHERE continente != 'Europa';

-- 7. TESTANDO AS VIEWS --

SELECT * FROM view_musicos_brasileiros;

SELECT * FROM view_musicos_estrangeiros;

SELECT * FROM view_musicos_sul_americanos;

SELECT * FROM view_musicos_nao_sul_americanos;

SELECT * FROM view_musicos_homens;

SELECT * FROM view_musicos_mulheres;

SELECT * FROM view_musico_instrumento;

SELECT * FROM view_musico_orquestra;

SELECT * FROM view_musico_mais_jovem;

SELECT * FROM view_musico_mais_velho;

SELECT * FROM view_orquestras_europeias;

SELECT * FROM view_orquestras_nao_europeias
