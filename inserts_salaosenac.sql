INSERT INTO Cliente (IDCliente, Nome, Telefone, Email, Endereco, DataNascimento)
VALUES 
(1, 'Ana Silva', '11987654321', 'ana@email.com', 'Rua A, 123', '1990-01-15'),
(2, 'Carlos Souza', '11912345678', 'carlos@email.com', 'Rua B, 456', '1992-03-20'),
(3, 'Mariana Costa', '11999988877', 'mariana@email.com', 'Rua C, 789', '1995-07-10'),
(4, 'João Pedro', '11944445555', 'joao@email.com', 'Rua D, 321', '1998-10-05'),
(5, 'Fernanda Lima', '11966667777', 'fernanda@email.com', 'Rua E, 654', '2000-02-25'),
(6, 'Lucas Pereira', '11955554444', 'lucas@email.com', 'Rua F, 987', '1993-12-12'),
(7, 'Bruna Rocha', '11922223333', 'bruna@email.com', 'Rua G, 456', '1997-08-18'),
(8, 'Paulo Ribeiro', '11988889999', 'paulo@email.com', 'Rua H, 567', '1991-06-30'),
(9, 'Juliana Mendes', '11933332222', 'juliana@email.com', 'Rua I, 678', '1989-04-01'),
(10, 'Ricardo Alves', '11977778888', 'ricardo@email.com', 'Rua J, 789', '1996-05-15');


INSERT INTO Profissional (IDProfissional, Nome, Especialidade, HorarioDisponivel, AvaliacaoMedia)
VALUES 
(1, 'Beatriz Santos', 'Cabelereira', '08:00-16:00', 4.5),
(2, 'Eduardo Ferreira', 'Manicure', '09:00-17:00', 4.8),
(3, 'Carla Ramos', 'Esteticista', '10:00-18:00', 4.7),
(4, 'André Neves', 'Barbeiro', '11:00-19:00', 4.6),
(5, 'Patrícia Gomes', 'Maquiadora', '08:00-14:00', 4.9),
(6, 'Rodrigo Silva', 'Cabelereiro', '12:00-20:00', 4.4),
(7, 'Natália Costa', 'Manicure', '13:00-21:00', 4.3),
(8, 'Marcelo Cruz', 'Barbeiro', '07:00-15:00', 4.7),
(9, 'Sabrina Souza', 'Maquiadora', '10:00-16:00', 4.6),
(10, 'Fernanda Andrade', 'Esteticista', '14:00-22:00', 4.8);


INSERT INTO Servico (IDServico, Nome, Descricao, Duracao, Preco)
VALUES 
(1, 'Corte de Cabelo', 'Corte masculino e feminino', '00:30', 30.00),
(2, 'Manicure', 'Esmaltação simples', '01:00', 25.00),
(3, 'Pedicure', 'Cuidado e esmaltação dos pés', '01:00', 30.00),
(4, 'Limpeza de Pele', 'Tratamento facial completo', '01:30', 80.00),
(5, 'Maquiagem', 'Maquiagem profissional', '01:00', 120.00),
(6, 'Barba', 'Barbear tradicional', '00:45', 40.00),
(7, 'Escova', 'Escova modeladora', '01:00', 50.00),
(8, 'Tratamento Capilar', 'Hidratação profunda', '01:30', 70.00),
(9, 'Sobrancelha', 'Design e limpeza de sobrancelhas', '00:45', 35.00),
(10, 'Massagem Relaxante', 'Massagem de corpo inteiro', '01:30', 100.00);

DESCRIBE Servico;
ALTER TABLE Servico MODIFY Duracao TIME;


INSERT INTO Agendamento (IDAgendamento, IDCliente, IDProfissional, IDServico, DataHora, Status)
VALUES 
(1, 1, 1, 1, '2024-06-01 10:00:00', 'Confirmado'),
(2, 2, 2, 2, '2024-06-02 11:00:00', 'Pendente'),
(3, 3, 3, 4, '2024-06-03 12:00:00', 'Confirmado'),
(4, 4, 4, 6, '2024-06-04 13:00:00', 'Cancelado'),
(5, 5, 5, 5, '2024-06-05 14:00:00', 'Confirmado'),
(6, 6, 6, 8, '2024-06-06 15:00:00', 'Pendente'),
(7, 7, 7, 7, '2024-06-07 16:00:00', 'Confirmado'),
(8, 8, 8, 3, '2024-06-08 17:00:00', 'Confirmado'),
(9, 9, 9, 9, '2024-06-09 18:00:00', 'Pendente'),
(10, 10, 10, 10, '2024-06-10 19:00:00', 'Confirmado');


INSERT INTO Feedback (IDFeedback, IDCliente, IDProfissional, Comentario, Nota)
VALUES 
(1, 1, 1, 'Ótimo atendimento!', 5),
(2, 2, 2, 'Muito bom!', 4),
(3, 3, 3, 'Adorei o serviço!', 5),
(4, 4, 4, 'Poderia ser melhor.', 3),
(5, 5, 5, 'Excelente!', 5),
(6, 6, 6, 'Bom atendimento.', 4),
(7, 7, 7, 'Fiquei muito satisfeito.', 5),
(8, 8, 8, 'Serviço rápido e eficiente.', 4),
(9, 9, 9, 'Recomendo!', 5),
(10, 10, 10, 'Muito atenciosos.', 5);


INSERT INTO FeedbackPremiado (IDPremiacao, DataPremiacao, IDFeedback) 
VALUES
(1, '2024-06-01', 1),
(2, '2024-06-05', 2),
(3, '2024-06-10', 3),
(4, '2024-06-15', 4);



