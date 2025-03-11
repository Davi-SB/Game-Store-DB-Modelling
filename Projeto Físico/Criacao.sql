-- (dsb6) adicionei umas restrições de atributos NOT NULL que não fazem parte do escopo 
-- do projeto lógico, mas fazem sentido pras tabelas do lógico. Fiz isso pq Robson fez 
-- isso tbm nos slides de SQL quando foi passar do lógico pro físico. Essas mudanças 
-- tão registradas no arquivo "rascunho.sql".

-- Tabela Usuario
CREATE TABLE Usuario (
    ID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL
);

-- Tabela Amigo
CREATE TABLE Amigo (
    Amigo1 INT,
    Amigo2 INT,
    PRIMARY KEY (Amigo1, Amigo2),
    FOREIGN KEY (Amigo1) REFERENCES Usuario(ID),
    FOREIGN KEY (Amigo2) REFERENCES Usuario(ID)
);

-- Tabela Conta
CREATE TABLE Conta (
    ID INT PRIMARY KEY,
    Senha VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    FOREIGN KEY (ID) REFERENCES Usuario(ID)
);

-- Tabela Cartao
CREATE TABLE Cartao (
    ID INT,
    Num VARCHAR(20),
    Cod INT,
    DT_Exp DATE,
    PRIMARY KEY (ID, Num, Cod, DT_Exp),
    FOREIGN KEY (ID) REFERENCES Conta(ID)
);

-- Tabela Jogo
CREATE TABLE Jogo (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DT_Lancamento DATE NOT NULL,
    Preco DECIMAL(10,2) NOT NULL
);

-- Tabela Comentario
CREATE TABLE Comentario (
    Jogo_ID INT,
    Usuario_ID INT,
    Data DATE,
    Estrelas INT NOT NULL CHECK (Estrelas BETWEEN 0 AND 5),
    Descricao VARCHAR(100),
    PRIMARY KEY (Jogo_ID, Usuario_ID, Data),
    FOREIGN KEY (Jogo_ID) REFERENCES Jogo(ID),
    FOREIGN KEY (Usuario_ID) REFERENCES Usuario(ID)
);

-- Tabela Player
CREATE TABLE Player (
    Usuario_ID INT PRIMARY KEY,
    FOREIGN KEY (Usuario_ID) REFERENCES Usuario(ID)
);

-- Tabela Compartilha
CREATE TABLE Compartilha (
    Jogo_ID INT,
    Dependente_ID INT,
    Dono_ID INT NOT NULL,
    PRIMARY KEY (Jogo_ID, Dependente_ID),
    FOREIGN KEY (Jogo_ID) REFERENCES Jogo(ID),
    FOREIGN KEY (Dependente_ID) REFERENCES Player(Usuario_ID),
    FOREIGN KEY (Dono_ID) REFERENCES Player(Usuario_ID)
);

-- Tabela Tem
CREATE TABLE Tem (
    Usuario_ID INT,
    Jogo_ID INT,
    PRIMARY KEY (Usuario_ID, Jogo_ID),
    FOREIGN KEY (Jogo_ID) REFERENCES Jogo(ID),
    FOREIGN KEY (Usuario_ID) REFERENCES Usuario(ID)
);

-- Tabela Conquistas
CREATE TABLE Conquistas (
    Usuario_ID INT,
    Jogo_ID INT,
    Conquista VARCHAR(100),
    PRIMARY KEY (Usuario_ID, Jogo_ID, Conquista),
    FOREIGN KEY (Usuario_ID, Jogo_ID) REFERENCES Tem(Usuario_ID, Jogo_ID)
);

-- Tabela Dev
CREATE TABLE Dev (
    Usuario_ID INT PRIMARY KEY,
    FOREIGN KEY (Usuario_ID) REFERENCES Usuario(ID)
);

-- Tabela Empresa
CREATE TABLE Empresa (
    ID INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela Desenvolve
CREATE TABLE Desenvolve (
    Usuario_ID INT,
    Jogo_ID INT,
    Empresa_ID INT,
    Funcao VARCHAR(100),
    PRIMARY KEY (Usuario_ID, Jogo_ID, Funcao),
    FOREIGN KEY (Usuario_ID) REFERENCES Usuario(ID),
    FOREIGN KEY (Jogo_ID) REFERENCES Jogo(ID),
    FOREIGN KEY (Empresa_ID) REFERENCES Empresa(ID)
);
