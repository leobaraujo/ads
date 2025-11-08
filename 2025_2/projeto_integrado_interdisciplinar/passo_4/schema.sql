CREATE TABLE contas (
    id_conta INT PRIMARY KEY,
    nome_cliente VARCHAR(100),
    saldo_inicial DECIMAL(15,2) DEFAULT 0
);

CREATE TABLE transacoes (
    id_transacao INT PRIMARY KEY AUTO_INCREMENT,
    id_conta INT,
    data_transacao DATE,
    tipo VARCHAR(10), -- 'CREDITO' ou 'DEBITO'
    valor DECIMAL(15,2),
    descricao VARCHAR(255),
    FOREIGN KEY (id_conta) REFERENCES contas(id_conta)
);
