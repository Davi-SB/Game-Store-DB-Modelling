-- (dsb6) NÃO RODEI AINDA, PODE TER ERROS
-- (dsb6) adicionei umas restrições de atributos NOT NULL que não faz parte do escopo do projeto lógico, mas faz sentido pras tabelas do lógico. Fiz isso pq Robson fez isso tbm nos slides de SQL quando foi passar do lógico pro físico. Essas mudanças tão registradas no arquivo "rascunho.sql".

-- Tabela Usuario
CREATE TABLE Usuario (
    ID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL
);

-- Tabela Amigo
CREATE TABLE Amigo (
    Amigo1 INT NOT NULL,
    Amigo2 INT NOT NULL,
    PRIMARY KEY (Amigo1, Amigo2),
    FOREIGN KEY (Amigo1) REFERENCES Usuario(ID),
    FOREIGN KEY (Amigo2) REFERENCES Usuario(ID)
);

-- Tabela Conta
CREATE TABLE Conta (
    ID INT PRIMARY KEY,
    Senha VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Cartao VARCHAR(50),
    FOREIGN KEY (ID) REFERENCES Usuario(ID)
);

-- Tabela Cartao
CREATE TABLE Cartao (
    ID INT NOT NULL,
    Num VARCHAR(20) NOT NULL,
    Cod INT NOT NULL,
    DT_Exp DATE NOT NULL,
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
    Jogo_ID INT NOT NULL,
    Usuario_ID INT NOT NULL,
    Data DATE NOT NULL,
    Estrelas INT NOT NULL,
    Descricao TEXT,
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
    Jogo_ID INT NOT NULL,
    Dependente_ID INT NOT NULL,
    Dono_ID INT NOT NULL,
    PRIMARY KEY (Jogo_ID, Dependente_ID),
    FOREIGN KEY (Jogo_ID) REFERENCES Jogo(ID),
    FOREIGN KEY (Dependente_ID) REFERENCES Player(Usuario_ID),
    FOREIGN KEY (Dono_ID) REFERENCES Player(Usuario_ID)
);

-- Tabela Tem
CREATE TABLE Tem (
    Usuario_ID INT NOT NULL,
    Jogo_ID INT NOT NULL,
    PRIMARY KEY (Usuario_ID, Jogo_ID),
    FOREIGN KEY (Usuario_ID) REFERENCES Usuario(ID),
    FOREIGN KEY (Jogo_ID) REFERENCES Jogo(ID)
);

-- Tabela Conquistas
CREATE TABLE Conquistas (
    Usuario_ID INT NOT NULL,
    Jogo_ID INT NOT NULL,
    Conquista VARCHAR(100) NOT NULL,
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
    Usuario_ID INT NOT NULL,
    Jogo_ID INT NOT NULL,
    Empresa_ID INT NOT NULL,
    PRIMARY KEY (Usuario_ID, Jogo_ID),
    FOREIGN KEY (Usuario_ID) REFERENCES Usuario(ID),
    FOREIGN KEY (Jogo_ID) REFERENCES Jogo(ID),
    FOREIGN KEY (Empresa_ID) REFERENCES Empresa(ID)
);
