-- 1 Impedir exclusão de cliente se houver agendamento futuro
DELIMITER $$

CREATE TRIGGER ImpedirExclusaoClienteComAgendamentoFuturo
BEFORE DELETE ON Cliente
FOR EACH ROW
BEGIN
    DECLARE agendamentosFuturos INT;
    
    SELECT COUNT(*) INTO agendamentosFuturos
    FROM Agendamento
    WHERE IDCliente = OLD.IDCliente AND DataHora > NOW();
    
    IF agendamentosFuturos > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível excluir cliente com agendamentos futuros.';
    END IF;
END $$

DELIMITER ;

-- 2 Atualizar o status do agendamento após feedback
DELIMITER $$

CREATE TRIGGER AtualizarStatusAgendamentoApósFeedback
AFTER INSERT ON Feedback
FOR EACH ROW
BEGIN
    -- Atualiza o status do agendamento baseado no IDCliente relacionado ao feedback
    UPDATE Agendamento
    SET Status = 'Concluído'
    WHERE IDCliente = NEW.IDCliente
    AND Status != 'Concluído';  -- Evita atualizar agendamentos já concluídos
END $$

DELIMITER ;

-- 3 Impedir a inserção de agendamento para um cliente com mais de 5 agendamentos pendentes
DELIMITER $$

CREATE TRIGGER ImpedirAgendamentoExcessoPendentes
BEFORE INSERT ON Agendamento
FOR EACH ROW
BEGIN
    DECLARE quantidade INT;

    -- Conta o número de agendamentos pendentes do cliente
    SELECT COUNT(*) INTO quantidade
    FROM Agendamento
    WHERE IDCliente = NEW.IDCliente AND Status = 'Pendente';

    -- Se o cliente já tiver 5 agendamentos pendentes, impede a inserção
    IF quantidade >= 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente com limite de agendamentos pendentes atingido';
    END IF;
END $$

DELIMITER ;

-- 4 Atualizar o campo AvaliacaoMedia do Profissional após a inserção de Feedback
DELIMITER $$

CREATE TRIGGER AtualizarAvaliacaoMediaProfissional
AFTER INSERT ON Feedback
FOR EACH ROW
BEGIN
    DECLARE media FLOAT;

    -- Calcula a nova média de avaliação do profissional
    SELECT AVG(Nota) INTO media
    FROM Feedback
    WHERE IDProfissional = NEW.IDProfissional;

    -- Atualiza a média de avaliação do profissional
    UPDATE Profissional
    SET AvaliacaoMedia = media
    WHERE IDProfissional = NEW.IDProfissional;
END $$

DELIMITER ;

-- 5 Impedir a inserção de agendamento com serviço que tenha durabilidade superior a 120 minutos
DELIMITER $$

CREATE TRIGGER ImpedirServicoLongoAgendamento
BEFORE INSERT ON Agendamento
FOR EACH ROW
BEGIN
    -- Verifica se o serviço tem durabilidade superior a 120 minutos
    IF (SELECT Duracao FROM Servico WHERE IDServico = NEW.IDServico) > 120 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O serviço selecionado possui duração superior a 120 minutos';
    END IF;
END $$

DELIMITER ;

-- 6 Atualizar Status do Agendamento para Cancelado quando a DataHora do agendamento for modificada para uma data anterior à data atual
DELIMITER $$

CREATE TRIGGER CancelarAgendamentoDataPassada
BEFORE UPDATE ON Agendamento
FOR EACH ROW
BEGIN
    IF NEW.DataHora < NOW() THEN
        SET NEW.Status = 'Cancelado';
    END IF;
END $$

DELIMITER ;

-- 7 Impedir a inserção de Feedback com Nota inferior a 1 ou superior a 5
DELIMITER $$

CREATE TRIGGER ValidarNotaFeedback
BEFORE INSERT ON Feedback
FOR EACH ROW
BEGIN
    IF NEW.Nota < 1 OR NEW.Nota > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A nota do feedback deve ser entre 1 e 5';
    END IF;
END $$

DELIMITER ;

-- 8 Atualizar a quantidade de agendamentos de cada Profissional após a inserção de um novo Agendamento
DELIMITER $$

CREATE TRIGGER AtualizarQuantidadeAgendamentosProfissional
AFTER INSERT ON Agendamento
FOR EACH ROW
BEGIN
    UPDATE Profissional
    SET QuantidadeAgendamentos = QuantidadeAgendamentos + 1
    WHERE IDProfissional = NEW.IDProfissional;
END $$

DELIMITER ;

-- 9 Adicionar data de premiação na tabela FeedbackPremiado quando o feedback for superior a 4
DELIMITER $$

CREATE TRIGGER AdicionarPremiacaoFeedback
AFTER INSERT ON Feedback
FOR EACH ROW
BEGIN
    IF NEW.Nota > 4 THEN
        INSERT INTO FeedbackPremiado (IDFeedback, DataPremiacao)
        VALUES (NEW.IDFeedback, NOW());
    END IF;
END $$

DELIMITER ;

-- 10 Atualizar o preço de um Serviço para o valor anterior se o preço de um Serviço for alterado para um valor negativo
DELIMITER $$

CREATE TRIGGER ValidarPrecoServico
BEFORE UPDATE ON Servico
FOR EACH ROW
BEGIN
    IF NEW.Preco < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Preço do serviço não pode ser negativo';
    END IF;
END $$

DELIMITER ;









