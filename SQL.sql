-- Iniciar transação
START TRANSACTION;

-- Remover chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 0;

-- Para a tabela Livros_Autores
DROP TABLE IF EXISTS Livros_Autores;

-- Para a tabela Empréstimos_Clientes
DROP TABLE IF EXISTS Empréstimos_Clientes;

-- Para a tabela Livros
DROP TABLE IF EXISTS Livros;

-- Para a tabela Autores
DROP TABLE IF EXISTS Autores;

-- Para a tabela Editoras
DROP TABLE IF EXISTS Editoras;

-- Para a tabela Empréstimos
DROP TABLE IF EXISTS Empréstimos;

-- Para a tabela Clientes
DROP TABLE IF EXISTS Clientes;
DROP VIEW IF EXISTS LivrosDisponiveis;
-- Para as stored procedures
DROP PROCEDURE IF EXISTS NovoEmprestimo;
DROP PROCEDURE IF EXISTS LivrosEmprestados;
DROP PROCEDURE IF EXISTS CalcularMultas;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Livros (
    ID INT PRIMARY KEY,
    Titulo VARCHAR(100),
    ISBN VARCHAR(13),
    AnoPublicacao YEAR
);

CREATE TABLE Autores (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    DataNascimento DATE,
    Nacionalidade VARCHAR(50)
);

CREATE TABLE Editoras (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Endereco VARCHAR(200)
);

CREATE TABLE Empréstimos (
    ID INT PRIMARY KEY,
    LivroID INT,
    ClienteID INT,
    DataEmprestimo DATE,
    DataDevolucao DATE,
    Status VARCHAR(20),
    FOREIGN KEY (LivroID) REFERENCES Livros(ID),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);


CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Endereco VARCHAR(200)
);

-- Criar relacionamentos
CREATE TABLE Livros_Autores (
    LivroID INT,
    AutorID INT,
    FOREIGN KEY (LivroID) REFERENCES Livros(ID),
    FOREIGN KEY (AutorID) REFERENCES Autores(ID)
);

CREATE TABLE Empréstimos_Clientes (
    EmprestimoID INT,
    ClienteID INT,
    FOREIGN KEY (EmprestimoID) REFERENCES Empréstimos(ID),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);


INSERT INTO Livros (ID, Titulo, ISBN, AnoPublicacao) VALUES
(1, 'Dom Quixote', '9780199536823', 1605),
(2, 'Ulisses', '9780393345091', 1922),
(3, 'Cem Anos de Solidão', '9780060883287', 1967),
(4, '1984', '9780451524935', 1949),
(5, 'A Máquina do Tempo', '9780141439976', 1895),
(6, 'O Senhor dos Anéis', '9780261102385', 1954),
(7, 'Harry Potter e a Pedra Filosofal', '9780747532743', 1997),
(8, 'Crime e Castigo', '9780143107637', 1866),
(9, 'O Pequeno Príncipe', '9780156012195', 1943),
(10, 'O Grande Gatsby', '9780141182636', 1925),
(11, 'O Apanhador no Campo de Centeio', '9780316769174', 1951),
(12, 'O Hobbit', '9780007458424', 1937),
(13, 'Moby Dick', '9781853260087', 1851),
(14, 'Orgulho e Preconceito', '9780141439518', 1813),
(15, 'Guerra e Paz', '9780140447934', 1869),
(16, 'Anna Karenina', '9780143035008', 1877),
(17, 'A Revolução dos Bichos', '9780451526342', 1945),
(18, 'O Sol é para Todos', '9780446310789', 1960),
(19, 'O Nome da Rosa', '9780544173406', 1980),
(20, 'O Retrato de Dorian Gray', '9780486278070', 1890);

INSERT INTO Autores (ID, Nome, DataNascimento, Nacionalidade) VALUES
(1, 'Miguel de Cervantes', '1547-09-29', 'Espanha'),
(2, 'James Joyce', '1882-02-02', 'Irlanda'),
(3, 'Gabriel García Márquez', '1927-03-06', 'Colômbia'),
(4, 'George Orwell', '1903-06-25', 'Reino Unido'),
(5, 'H.G. Wells', '1866-09-21', 'Reino Unido'),
(6, 'J.R.R. Tolkien', '1892-01-03', 'Reino Unido'),
(7, 'J.K. Rowling', '1965-07-31', 'Reino Unido'),
(8, 'Fiódor Dostoiévski', '1821-11-11', 'Rússia'),
(9, 'Antoine de Saint-Exupéry', '1900-06-29', 'França'),
(10, 'F. Scott Fitzgerald', '1896-09-24', 'Estados Unidos'),
(11, 'J.D. Salinger', '1919-01-01', 'Estados Unidos'),
(12, 'J.R.R. Tolkien', '1892-01-03', 'Reino Unido'),
(13, 'Herman Melville', '1819-08-01', 'Estados Unidos'),
(14, 'Jane Austen', '1775-12-16', 'Reino Unido'),
(15, 'Liev Tolstói', '1828-09-09', 'Rússia'),
(16, 'Fiódor Dostoiévski', '1821-11-11', 'Rússia'),
(17, 'George Orwell', '1903-06-25', 'Reino Unido'),
(18, 'Harper Lee', '1926-04-28', 'Estados Unidos'),
(19, 'Umberto Eco', '1932-01-05', 'Itália'),
(20, 'Oscar Wilde', '1854-10-16', 'Irlanda');

INSERT INTO Editoras (ID, Nome, Endereco) VALUES
(1, 'Editora ABC', 'Rua A, 123, CidadeX'),
(2, 'Editora XYZ', 'Avenida B, 456, CidadeY'),
(3, 'Editora 123', 'Praça C, 789, CidadeZ'),
(4, 'Editora QWE', 'Rua D, 101, CidadeW'),
(5, 'Editora RST', 'Avenida E, 202, CidadeV'),
(6, 'Editora DEF', 'Praça F, 303, CidadeU'),
(7, 'Editora GHI', 'Rua G, 404, CidadeT'),
(8, 'Editora 456', 'Avenida H, 505, CidadeS'),
(9, 'Editora 789', 'Praça I, 606, CidadeR'),
(10, 'Editora JK', 'Rua J, 707, CidadeQ'),
(11, 'Editora LMN', 'Avenida K, 808, CidadeP'),
(12, 'Editora OPQ', 'Praça L, 909, CidadeO'),
(13, 'Editora STU', 'Rua M, 111, CidadeN'),
(14, 'Editora VWX', 'Avenida N, 222, CidadeM'),
(15, 'Editora YZ', 'Praça O, 333, CidadeL'),
(16, 'Editora 123', 'Rua P, 444, CidadeK'),
(17, 'Editora XYZ', 'Avenida Q, 555, CidadeJ'),
(18, 'Editora ABC', 'Praça R, 666, CidadeI'),
(19, 'Editora DEF', 'Rua S, 777, CidadeH'),
(20, 'Editora GHI', 'Avenida T, 888, CidadeG');

INSERT INTO Clientes (ID, Nome, Endereco) VALUES
(1, 'Cliente A', 'Rua A, 123, CidadeX'),
(2, 'Cliente B', 'Avenida B, 456, CidadeY'),
(3, 'Cliente C', 'Praça C, 789, CidadeZ'),
(4, 'Cliente D', 'Rua D, 101, CidadeW'),
(5, 'Cliente E', 'Avenida E, 202, CidadeV'),
(6, 'Cliente F', 'Praça F, 303, CidadeU'),
(7, 'Cliente G', 'Rua G, 404, CidadeT'),
(8, 'Cliente H', 'Avenida H, 505, CidadeS'),
(9, 'Cliente I', 'Praça I, 606, CidadeR'),
(10, 'Cliente J', 'Rua J, 707, CidadeQ'),
(11, 'Cliente K', 'Avenida K, 808, CidadeP'),
(12, 'Cliente L', 'Praça L, 909, CidadeO'),
(13, 'Cliente M', 'Rua M, 111, CidadeN'),
(14, 'Cliente N', 'Avenida N, 222, CidadeM'),
(15, 'Cliente O', 'Praça O, 333, CidadeL'),
(16, 'Cliente P', 'Rua P, 444, CidadeK'),
(17, 'Cliente Q', 'Avenida Q, 555, CidadeJ'),
(18, 'Cliente R', 'Praça R, 666, CidadeI'),
(19, 'Cliente S', 'Rua S, 777, CidadeH'),
(20, 'Cliente T', 'Avenida T, 888, CidadeG');


DELIMITER $$
CREATE PROCEDURE NovoEmprestimo(IN livroID INT, IN clienteID INT)
BEGIN
  -- Coloque a lógica para verificar disponibilidade do livro e atualizar o estoque aqui
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE LivrosEmprestados(IN clienteID INT)
BEGIN
  -- Coloque a lógica para recuperar a lista de livros emprestados por um cliente específico aqui
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE CalcularMultas()
BEGIN
  -- Coloque a lógica para calcular multas para empréstimos atrasados aqui
END $$
DELIMITER ;

-- Criar visões
CREATE VIEW LivrosDisponiveis AS 
SELECT Livros.* 
FROM Livros 
LEFT JOIN Empréstimos ON Livros.ID = Empréstimos.LivroID 
WHERE Empréstimos.LivroID IS NULL OR Empréstimos.Status = 'devolvido';


CREATE VIEW EmpréstimosAtuais AS 
SELECT Empréstimos.ID AS EmprestimoID, 
       LivroID, 
       ClienteID, 
       DataEmprestimo, 
       DataDevolucao, 
       Status, 
       Livros.Titulo, 
       Clientes.Nome AS ClienteNome
FROM Empréstimos 
JOIN Livros ON Empréstimos.LivroID = Livros.ID 
JOIN Clientes ON Empréstimos.ClienteID = Clientes.ID;



-- Commit da transação
COMMIT;
