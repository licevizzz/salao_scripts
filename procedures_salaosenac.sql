-- 1 Procedure para Inserir Novo Agendamento
DELIMITER $$

CREATE PROCEDURE InserirAgendamento(IN p_DataHora DATETIME, IN p_Status VARCHAR(20), IN p_IDCliente INT, IN p_IDProfissional INT, IN p_IDServico INT)
BEGIN
    INSERT INTO Agendamento (DataHora, Status, IDCliente, IDProfissional, IDServico)
    VALUES (p_DataHora, p_Status, p_IDCliente, p_IDProfissional, p_IDServico);
END $$

DELIMITER ;

-- 2 Procedure para Alterar Status de Agendamento
DELIMITER $$

CREATE PROCEDURE AlterarStatusAgendamento(IN p_IDAgendamento INT, IN p_Status VARCHAR(20))
BEGIN
    UPDATE Agendamento
    SET Status = p_Status
    WHERE IDAgendamento = p_IDAgendamento;
END $$

DELIMITER ;

-- 3 Procedure para Calcular Valor Total de Agendamento
DELIMITER $$

CREATE PROCEDURE CalcularValorAgendamento(IN p_IDAgendamento INT, OUT p_ValorTotal DECIMAL(10, 2))
BEGIN
    DECLARE preco DECIMAL(10, 2);
    DECLARE duracao INT;

    SELECT s.Preco, s.Duracao
    INTO preco, duracao
    FROM Servico s
    JOIN Agendamento a ON s.IDServico = a.IDServico
    WHERE a.IDAgendamento = p_IDAgendamento;

    SET p_ValorTotal = preco * (duracao / 60); -- Exemplo: Preço por hora
END $$

DELIMITER ;

-- 4 
DELIMITER $$

CREATE PROCEDURE CancelarAgendamento(IN p_IDAgendamento INT)
BEGIN
    UPDATE Agendamento
    SET Status = 'Cancelado'
    WHERE IDAgendamento = p_IDAgendamento;
END $$

DELIMITER ;

-- 5 Função/procedure para Calcular a Média de Avaliação de um Profissional
DELIMITER $$

CREATE PROCEDURE CalcularMediaAvaliacaoProfissional(IN p_IDProfissional INT, OUT p_Media DECIMAL(3, 2))
BEGIN
    -- Calculando a média de avaliações diretamente e atribuindo ao parâmetro de saída
    SELECT AVG(f.Nota)
    INTO p_Media
    FROM Feedback f
    WHERE f.IDProfissional = p_IDProfissional;

    -- Se não houver avaliações, a média será 0
    IF p_Media IS NULL THEN
        SET p_Media = 0;
    END IF;
END $$

DELIMITER ;

-- 6 Função para Retornar o Total de Feedbacks de um Cliente
DELIMITER $$

CREATE PROCEDURE ContarAgendamentosProfissional(IN p_IDProfissional INT, OUT p_QuantidadeAgendamentos INT)
BEGIN
    -- Calculando a quantidade de agendamentos diretamente e atribuindo ao parâmetro de saída
    SELECT COUNT(a.IDAgendamento)
    INTO p_QuantidadeAgendamentos
    FROM Agendamento a
    WHERE a.IDProfissional = p_IDProfissional;

    -- Se não houver agendamentos, a quantidade será 0
    IF p_QuantidadeAgendamentos IS NULL THEN
        SET p_QuantidadeAgendamentos = 0;
    END IF;
END $$

DELIMITER ;

-- 7 Procedure para Premiar um Feedback
DELIMITER $$

CREATE PROCEDURE PremiarFeedback(IN p_IDFeedback INT, IN p_DataPremiacao DATE)
BEGIN
    DECLARE p_IDCliente INT;

    -- Obter o ID do cliente do feedback
    SELECT IDCliente INTO p_IDCliente
    FROM Feedback
    WHERE IDFeedback = p_IDFeedback;

    -- Inserir na tabela de feedback premiado
    INSERT INTO FeedbackPremiado (IDFeedback, DataPremiacao, IDCliente)
    VALUES (p_IDFeedback, p_DataPremiacao, p_IDCliente);
END $$

DELIMITER ;

-- 8 Procedure para Listar Profissionais Disponíveis
DELIMITER $$

CREATE PROCEDURE ListarProfissionaisDisponiveis()
BEGIN
    SELECT p.Nome, p.HorarioDisponivel
    FROM Profissional p
    WHERE p.HorarioDisponivel = 'Sim';
END $$

DELIMITER ;

-- 9 Função para Retornar o Total de Serviços Realizados por um cliente
DELIMITER $$

CREATE PROCEDURE ContarAgendamentosCliente(IN p_IDCliente INT, OUT p_QuantidadeAgendamentos INT)
BEGIN
    -- Conta o número de agendamentos feitos por um cliente
    SELECT COUNT(a.IDAgendamento)
    INTO p_QuantidadeAgendamentos
    FROM Agendamento a
    WHERE a.IDCliente = p_IDCliente;

    -- Caso não haja agendamentos, a quantidade será 0
    IF p_QuantidadeAgendamentos IS NULL THEN
        SET p_QuantidadeAgendamentos = 0;
    END IF;
END $$

DELIMITER ;

-- 10 Procedure para Gerar Relatório de Feedbacks Positivos
DELIMITER $$

CREATE PROCEDURE RelatorioFeedbacksPositivos()
BEGIN
    SELECT c.Nome AS Cliente, f.Nota, f.Comentario
    FROM Feedback f
    JOIN Cliente c ON f.IDCliente = c.IDCliente
    WHERE f.Nota >= 4;
END $$

DELIMITER ;



-- Para executar procedures e funções
-- CALL NomeDaProcedure(parâmetros);
-- CALL InserirAgendamento('2024-12-15 14:00:00', 'Confirmado', 1, 2, 3);
-- SELECT CalcularMediaAvaliacaoProfissional(2);







