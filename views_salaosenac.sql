-- 1 Exibe os agendamentos confirmados, com os detalhes do cliente, profissional e serviço.
CREATE VIEW vw_Agendamentos_Confirmados AS
SELECT a.IDAgendamento, c.Nome AS Cliente, p.Nome AS Profissional, s.Nome AS Servico, a.DataHora, a.Status
FROM Agendamento a
JOIN Cliente c ON a.IDCliente = c.IDCliente
JOIN Profissional p ON a.IDProfissional = p.IDProfissional
JOIN Servico s ON a.IDServico = s.IDServico
WHERE a.Status = 'Confirmado';

-- 2 Exibe todos os clientes que realizaram agendamentos, com o total de agendamentos feitos.
CREATE VIEW vw_Clientes_Agendamentos AS
SELECT c.Nome AS Cliente, COUNT(a.IDAgendamento) AS Total_Agendamentos
FROM Cliente c
JOIN Agendamento a ON c.IDCliente = a.IDCliente
GROUP BY c.IDCliente;

-- 3 Exibe os profissionais e o total de agendamentos realizados por cada um.
CREATE VIEW vw_Profissionais_Agendamentos AS
SELECT p.Nome AS Profissional, COUNT(a.IDAgendamento) AS Total_Agendamentos
FROM Profissional p
JOIN Agendamento a ON p.IDProfissional = a.IDProfissional
GROUP BY p.IDProfissional;

-- 4 Exibe os serviços mais populares com base no número de agendamentos.
CREATE VIEW vw_Servicos_Populares AS
SELECT s.Nome AS Servico, COUNT(a.IDAgendamento) AS Total_Agendamentos
FROM Servico s
JOIN Agendamento a ON s.IDServico = a.IDServico
GROUP BY s.IDServico
ORDER BY Total_Agendamentos DESC;

-- 5 Exibe os feedbacks enviados pelos clientes, com as notas e comentários.
CREATE VIEW vw_Feedbacks_Clientes AS
SELECT f.IDFeedback, c.Nome AS Cliente, f.Nota, f.Comentario
FROM Feedback f
JOIN Cliente c ON f.IDCliente = c.IDCliente;

-- 6 Exibe profissionais que têm avaliação média acima de 4.0.
CREATE VIEW vw_Profissionais_Avaliacao_Alta AS
SELECT p.Nome AS Profissional, p.AvaliacaoMedia
FROM Profissional p
WHERE p.AvaliacaoMedia > 4.0
ORDER BY p.AvaliacaoMedia DESC;

-- 7 Exibe os feedbacks premiados, com os dados do cliente e a nota atribuída.
CREATE VIEW vw_Feedback_Premiado AS
SELECT fp.IDPremiacao, fp.DataPremiacao, c.Nome AS Cliente, f.Nota, f.Comentario
FROM FeedbackPremiado fp
JOIN Feedback f ON fp.IDFeedback = f.IDFeedback
JOIN Cliente c ON f.IDCliente = c.IDCliente;

-- 8 Exibe os clientes que não enviaram nenhum feedback.
CREATE VIEW vw_Clientes_Sem_Feedback AS
SELECT c.Nome AS Cliente
FROM Cliente c
WHERE c.IDCliente NOT IN (
    SELECT DISTINCT f.IDCliente
    FROM Feedback f
);

-- 9 Exibe os profissionais que têm horário disponível para agendamento.
CREATE VIEW vw_Profissionais_Disponiveis AS
SELECT p.Nome AS Profissional, p.HorarioDisponivel
FROM Profissional p
WHERE p.HorarioDisponivel = 'Sim';

-- 10 Exibe todos os agendamentos com status "Pendente".
CREATE VIEW vw_Agendamentos_Pendentes AS
SELECT a.IDAgendamento, c.Nome AS Cliente, p.Nome AS Profissional, s.Nome AS Servico, a.DataHora
FROM Agendamento a
JOIN Cliente c ON a.IDCliente = c.IDCliente
JOIN Profissional p ON a.IDProfissional = p.IDProfissional
JOIN Servico s ON a.IDServico = s.IDServico
WHERE a.Status = 'Pendente';





