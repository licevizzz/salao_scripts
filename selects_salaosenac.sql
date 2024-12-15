-- 1 Retorna todos os dados da tabela Cliente. Mostra todas as colunas para cada cliente registrado no banco.
SELECT * 
FROM Cliente;

-- 2 Retorna o nome e e-mail de todos os clientes, ordenados de forma crescente (alfabética) pelo nome do cliente.
SELECT Nome, Email 
FROM Cliente
ORDER BY Nome ASC;

-- 3 Retorna o nome e e-mail de todos os clientes, ordenados de forma crescente (alfabética) pelo nome do cliente.
SELECT a.IDAgendamento, c.Nome AS Cliente, p.Nome AS Profissional, s.Nome AS Servico, a.DataHora
FROM Agendamento a
JOIN Cliente c ON a.IDCliente = c.IDCliente
JOIN Profissional p ON a.IDProfissional = p.IDProfissional
JOIN Servico s ON a.IDServico = s.IDServico;

-- 4 Retorna o ID, data/hora e status de todos os agendamentos com status 'Confirmado'.
SELECT IDAgendamento, DataHora, Status
FROM Agendamento
WHERE Status = 'Confirmado';

-- 5 Retorna o nome de cada profissional e o total de agendamentos realizados por cada um. Ordena os profissionais pelo total de agendamentos de forma decrescente (profissional com mais agendamentos aparece primeiro).
SELECT p.Nome AS Profissional, COUNT(a.IDAgendamento) AS TotalAgendamentos
FROM Profissional p
JOIN Agendamento a ON p.IDProfissional = a.IDProfissional
GROUP BY p.Nome
ORDER BY TotalAgendamentos DESC;

-- 6 Retorna os serviços que têm duração superior a 30 minutos, mostrando o ID, nome, descrição e duração de cada um.
SELECT IDServico, Nome, Descricao, Duracao
FROM Servico
WHERE Duracao > 30;

-- 7 Retorna as informações sobre feedbacks premiados, incluindo o ID da premiação, data da premiação, nome do cliente, nota e comentário do feedback. Utiliza JOIN nas tabelas FeedbackPremiado, Feedback e Cliente.
SELECT fp.IDPremiacao, fp.DataPremiacao, c.Nome AS Cliente, f.Nota, f.Comentario
FROM FeedbackPremiado fp
JOIN Feedback f ON fp.IDFeedback = f.IDFeedback
JOIN Cliente c ON f.IDCliente = c.IDCliente;

-- 8 Retorna as informações sobre feedbacks premiados, incluindo o ID da premiação, data da premiação, nome do cliente, nota e comentário do feedback. Utiliza JOIN nas tabelas FeedbackPremiado, Feedback e Cliente.
SELECT Nome, AvaliacaoMedia
FROM Profissional
WHERE AvaliacaoMedia > 4.0
ORDER BY AvaliacaoMedia DESC;

-- 9 Retorna o nome de clientes que enviaram mais de um feedback, contando a quantidade de feedbacks de cada cliente. O filtro HAVING garante que apenas clientes com mais de um feedback sejam retornados.
SELECT c.Nome AS Cliente, COUNT(f.IDFeedback) AS TotalFeedbacks
FROM Cliente c
JOIN Feedback f ON c.IDCliente = f.IDCliente
GROUP BY c.Nome
HAVING COUNT(f.IDFeedback) > 1;

-- 10 Retorna o nome dos clientes que realizaram agendamentos para serviços com preço superior a 50. Usa um subselect para filtrar os serviços com preço maior que 50.
SELECT DISTINCT c.Nome AS Cliente
FROM Cliente c
JOIN Agendamento a ON c.IDCliente = a.IDCliente
WHERE a.IDServico IN (
    SELECT IDServico 
    FROM Servico 
    WHERE Preco > 50
);

-- 11 Insere feedbacks para clientes e profissionais de agendamentos confirmados, com nota 5 e comentário "Ótimo atendimento!".
INSERT INTO Feedback (IDCliente, IDProfissional, Nota, Comentario)
SELECT a.IDCliente, a.IDProfissional, 5, 'Ótimo atendimento!'
FROM Agendamento a
WHERE a.Status = 'Confirmado';

-- 12 Insere novos agendamentos com status "Pendente" para 5 clientes, escolhendo profissionais com horário disponível e serviços com preço inferior a 60 reais. 
INSERT INTO Agendamento (DataHora, Status, IDCliente, IDProfissional, IDServico)
SELECT NOW(), 'Pendente', c.IDCliente, p.IDProfissional, s.IDServico
FROM Cliente c, Profissional p, Servico s
WHERE p.HorarioDisponivel = 'Sim' AND s.Preco < 60
LIMIT 5;

-- 13 Insere 5 registros na tabela tb_match para profissionais e clientes que estão disponíveis para agendamentos, com status "Ativo".
INSERT INTO tb_match (DataHoraMatch, Status, IDProfissional, IDCliente)
SELECT NOW(), 'Ativo', p.IDProfissional, c.IDCliente
FROM Profissional p
JOIN Cliente c ON p.HorarioDisponivel = 'Sim'
LIMIT 5;

-- 14 Insere 3 novos agendamentos com status "Pendente" para clientes, profissionais disponíveis e serviços com duração inferior a 45 minutos.
INSERT INTO Agendamento (DataHora, Status, IDCliente, IDProfissional, IDServico)
SELECT NOW(), 'Pendente', c.IDCliente, p.IDProfissional, s.IDServico
FROM Cliente c
JOIN Profissional p ON p.HorarioDisponivel = 'Sim'
JOIN Servico s ON s.Duracao < 45
LIMIT 3;

-- 15 Insere feedbacks para clientes que receberam serviços com duração superior a 20 minutos, atribuindo nota 4 e comentário "Serviço demorado, mas bem feito!".
INSERT INTO Feedback (IDCliente, IDProfissional, Nota, Comentario)
SELECT c.IDCliente, a.IDProfissional, 4, 'Serviço demorado, mas bem feito!'
FROM Agendamento a
JOIN Servico s ON a.IDServico = s.IDServico
JOIN Cliente c ON a.IDCliente = c.IDCliente
WHERE s.Duracao > 20;

-- 16  Insere novos serviços com desconto de 15%, copiando os serviços com preço superior a 70, alterando o nome para indicar que são promoções e aplicando o desconto de 15% no preço.
INSERT INTO Servico (Nome, Descricao, Duracao, Preco)
SELECT CONCAT(Nome, ' - Desconto'), Descricao, Duracao, Preco * 0.85
FROM Servico
WHERE Preco > 70;

-- 17 Retorna os clientes que realizaram mais de um agendamento com serviços que têm preço superior a 50. Usa subselect para filtrar os serviços e HAVING para contar os agendamentos.
SELECT c.Nome AS Cliente, COUNT(a.IDAgendamento) AS TotalAgendamentos
FROM Cliente c
JOIN Agendamento a ON c.IDCliente = a.IDCliente
WHERE a.IDServico IN (
    SELECT IDServico
    FROM Servico
    WHERE Preco > 50
)
GROUP BY c.IDCliente
HAVING COUNT(a.IDAgendamento) > 1;

-- 18  Retorna o nome do profissional e do serviço realizado para os serviços com a maior duração disponível.
SELECT p.Nome AS Profissional, s.Nome AS Servico, s.Duracao
FROM Profissional p
JOIN Agendamento a ON p.IDProfissional = a.IDProfissional
JOIN Servico s ON a.IDServico = s.IDServico
WHERE s.Duracao = (SELECT MAX(Duracao) FROM Servico);

-- 19 Retorna o nome dos serviços e o total de agendamentos realizados para cada serviço, ordenando os serviços pelos que mais tiveram agendamentos.
SELECT s.Nome AS Servico, COUNT(a.IDAgendamento) AS TotalAgendamentos
FROM Servico s
JOIN Agendamento a ON s.IDServico = a.IDServico
GROUP BY s.IDServico
ORDER BY TotalAgendamentos DESC;

-- 20  Retorna os nomes dos clientes que não enviaram nenhum feedback, usando um subselect para encontrar clientes que não estão na tabela Feedback.
SELECT c.Nome AS Cliente
FROM Cliente c
WHERE c.IDCliente NOT IN (
    SELECT DISTINCT f.IDCliente
    FROM Feedback f
);
































