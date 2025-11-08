DELIMITER $$

CREATE PROCEDURE sp_extrato_conta (
    IN p_id_conta INT,
    IN p_data_inicio DATE,
    IN p_data_fim DATE
)
BEGIN
    DECLARE v_saldo_inicial DECIMAL(15,2);
    DECLARE v_total_credito DECIMAL(15,2);
    DECLARE v_total_debito DECIMAL(15,2);
    DECLARE v_saldo_final DECIMAL(15,2);

    -- Busca o saldo inicial da conta
    SELECT saldo_inicial INTO v_saldo_inicial
    FROM contas
    WHERE id_conta = p_id_conta;

    -- Calcula os créditos no período
    SELECT IFNULL(SUM(valor), 0) INTO v_total_credito
    FROM transacoes
    WHERE id_conta = p_id_conta
      AND tipo = 'CREDITO'
      AND data_transacao BETWEEN p_data_inicio AND p_data_fim;

    -- Calcula os débitos no período
    SELECT IFNULL(SUM(valor), 0) INTO v_total_debito
    FROM transacoes
    WHERE id_conta = p_id_conta
      AND tipo = 'DEBITO'
      AND data_transacao BETWEEN p_data_inicio AND p_data_fim;

    -- Calcula o saldo final
    SET v_saldo_final = v_saldo_inicial + (v_total_credito - v_total_debito);

    -- Exibe o saldo atual
    SELECT 
        p_id_conta AS Conta,
        v_saldo_inicial AS Saldo_Inicial,
        v_total_credito AS Total_Credito,
        v_total_debito AS Total_Debito,
        v_saldo_final AS Saldo_Final;

    -- Exibe as 10 últimas transações dentro do período
    SELECT 
        id_transacao, data_transacao, tipo, valor, descricao
    FROM transacoes
    WHERE id_conta = p_id_conta
      AND data_transacao BETWEEN p_data_inicio AND p_data_fim
    ORDER BY data_transacao DESC
    LIMIT 10;
END$$

DELIMITER ;
