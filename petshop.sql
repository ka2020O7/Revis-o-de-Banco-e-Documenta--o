CREATE DATABASE petshop_db;
USE petshop_db;


CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE pet (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    especie ENUM('Cão', 'Gato', 'Pássaro', 'Outros') NOT NULL,
    porte ENUM('Pequeno', 'Médio', 'Grande') NOT NULL,
    nascimento DATE,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE
);

CREATE TABLE servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
    preco DECIMAL(8,2) NOT NULL CHECK (preco >= 0),
    duracao_min INT NOT NULL CHECK (duracao_min > 0),
    INDEX idx_servico_preco (preco)
);


CREATE TABLE agendamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT NOT NULL,
    servico_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    status ENUM('agendado', 'concluido', 'cancelado') DEFAULT 'agendado',
    observacoes TEXT,
    FOREIGN KEY (pet_id) REFERENCES pet(id) ON DELETE CASCADE,
    FOREIGN KEY (servico_id) REFERENCES servico(id) ON DELETE RESTRICT
);