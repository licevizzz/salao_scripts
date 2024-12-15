CREATE DATABASE salao_senac;
USE salao_senac;

CREATE TABLE Cliente (
    IDCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100),
    DataNascimento DATE,
    Endereco VARCHAR(255)
);

CREATE TABLE Profissional (
    IDProfissional INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Especialidade VARCHAR(50),
    HorarioDisponivel VARCHAR(50),
    AvaliacaoMedia DECIMAL(3,2)
);

CREATE TABLE Servico (
    IDServico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(255),
    Duracao INT,
    Preco DECIMAL(10,2)
);

CREATE TABLE Agendamento (
    IDAgendamento INT AUTO_INCREMENT PRIMARY KEY,
    DataHora DATETIME NOT NULL,
    Status VARCHAR(20),
    IDCliente INT,
    IDProfissional INT,
    IDServico INT,
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente),
    FOREIGN KEY (IDProfissional) REFERENCES Profissional(IDProfissional),
    FOREIGN KEY (IDServico) REFERENCES Servico(IDServico)
);

CREATE TABLE Feedback (
    IDFeedback INT AUTO_INCREMENT PRIMARY KEY,
    IDCliente INT,
    IDProfissional INT,
    Comentario TEXT,
    Nota INT CHECK (Nota >= 0 AND Nota <= 10),
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente),
    FOREIGN KEY (IDProfissional) REFERENCES Profissional(IDProfissional)
);

CREATE TABLE FeedbackPremiado (
    IDPremiacao INT AUTO_INCREMENT PRIMARY KEY,
    IDFeedback INT,
    DataPremiacao DATE,
    FOREIGN KEY (IDFeedback) REFERENCES Feedback(IDFeedback)
);

CREATE TABLE tb_match (
    IDMatch INT AUTO_INCREMENT PRIMARY KEY,
    IDCliente INT NOT NULL,
    IDProfissional INT NOT NULL,
    DataHoraMatch DATETIME NOT NULL,
    Status VARCHAR(50),
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente),
    FOREIGN KEY (IDProfissional) REFERENCES Profissional(IDProfissional)
);



