% ===================================================================================================================
% Main
% ===================================================================================================================

% Predicado main que chama o initialController.
main :-
    criar_produto(80, true, 'Maçã Verde', 'Frutas', 5.99, 7.99, 100, '2023-01-10', '2023-02-10'),
    criar_produto(81, true, 'Notebook', 'Eletrônicos', 1299.99, 1599.99, 10, '2023-03-15', '2024-03-15'),
    criar_produto(82, true, 'Camiseta', 'Vestuário', 15.99, 29.99, 50, '2023-04-20', '2024-04-20'),

    criar_cliente('Maria Silva', 'Feminino', '1990-05-15', '12345678900', 'maria@email.com', '123456789', 'maria_silva', 'senha123'),
    criar_cliente('João Santos', 'Masculino', '1985-02-20', '98765432100', 'joao@email.com', '987654321', 'joao_santos', 'senha456'),
    criar_cliente('Ana Souza', 'Feminino', '1995-10-10', '55555555500', 'ana@email.com', '555555555', 'ana_souza', 'senha789'),
    
    initialController.

% ===================================================================================================================
% Codigo de Produto
% ===================================================================================================================

% Defina o contador como um fato dinâmico.
:- dynamic(contador_codigo/1).

% Predicado para inicializar o contador de código com 1.
inicializar_contador_codigo :-
    asserta(contador_codigo(1)).

% Predicado para obter o próximo código e incrementá-lo.
obter_e_incrementar_codigo(ProximoCodigo) :-
    retract(contador_codigo(CodigoAtual)),  
    ProximoCodigo is CodigoAtual,          
    NovoCodigo is CodigoAtual + 1,         
    asserta(contador_codigo(NovoCodigo)). 

:- inicializar_contador_codigo.

% ===================================================================================================================
% Controllers
% ===================================================================================================================

initialController :-
    writeln('====================================='),
    writeln('         Menu de Visitante          '),
    writeln('====================================='), 
    writeln('  (01) Entrar como Cliente'), 
    writeln('  (02) Registrar como Cliente'), 
    writeln('  (03) Entrar como Administrador'), 
    writeln('  (04) Visualizar Produtos'), 
    writeln('  (05) Sair do Sistema'), 
    writeln('Digite a opção desejada: '), 
    read(Opcao),
    initialController_processar_opcao(Opcao).

initialController_processar_opcao(01) :-
    % Coloque aqui a lógica para logar como cliente.
    writeln('Entrando como cliente...'),
    clienteController.

initialController_processar_opcao(02) :-
    % Coloque aqui a lógica para registrar um cliente.
    writeln('Entrando como cliente...'),
    clienteController.

initialController_processar_opcao(03) :-
    % Coloque aqui a lógica para logar como administrador.
    writeln('Entrando como administrador...'),
    admController.

initialController_processar_opcao(04) :-
    writeln('Visualizando produtos...'),
    imprimir_produtos, 
    initialController.

initialController_processar_opcao(05) :-
    writeln('Saindo do sistema.').

initialController_processar_opcao(_) :-
    writeln('Opção inválida. Tente novamente.'),
    initialController. 

% Predicado para buscar um produto por nome
clienteController :-
    writeln('====================================='), 
    writeln('        Menu de Cliente             '), 
    writeln('====================================='), 
    writeln('  (01) Visualizar Produtos'), 
    writeln('  (02) Visualizar Produtos por Categoria'), 
    writeln('  (03) Adicionar ao Carrinho'), 
    writeln('  (04) Remover do Carrinho'), 
    writeln('  (05) Visualizar Carrinho'), 
    writeln('  (06) Finalizar Compra'), 
    writeln('  (07) Atualizar Meu Cadastro'), 
    writeln('  (08) Deletar Minha Conta'), 
    writeln('  (09) Sair do Modo Cliente'), 
    writeln('  (10) Sair do Sistema'), 
    writeln('Digite a opção desejada: '), 
    read(Opcao),
    processar_opcao_cliente(Opcao).

processar_opcao_cliente(01) :-
    writeln('Visualizando produtos...'),
    imprimir_produtos,
    clienteController.

processar_opcao_cliente(02) :-
    writeln('Digite a categoria desejada: '),
    read(Categoria),
    imprimir_produtos_por_categoria(Categoria),
    clienteController.

processar_opcao_cliente(03) :-
    % Lógica para adicionar ao carrinho
    clienteController.

processar_opcao_cliente(04) :-
    % Lógica para remover do carrinho
    clienteController.

processar_opcao_cliente(05) :-
    % Lógica para visualizar carrinho
    clienteController.

processar_opcao_cliente(06) :-
    % Lógica para finalizar compra
    clienteController.

processar_opcao_cliente(07) :-
    % Lógica para atualizar cadastro
    clienteController.

processar_opcao_cliente(08) :-
    % Lógica para deletar conta
    clienteController.

processar_opcao_cliente(09) :-
    writeln('Saindo do modo cliente.'),
    initialController.

% Opção para sair do sistema
processar_opcao_cliente(10) :-
    writeln('Saindo do sistema.').

% Opção inválida
processar_opcao_cliente(_) :-
    writeln('Opção inválida. Tente novamente.'),
    clienteController.

% Predicado para controlar as ações do administrador
admController :-
    writeln('====================================='), 
    writeln('     Menu de Administrador           '),
    writeln('====================================='), 
    writeln('  (01) Visualizar Produtos'), 
    writeln('  (02) Adicionar Novo Produto'), 
    writeln('  (03) Atualizar Produto por Completo'), 
    writeln('  (04) Visualizar Produto por Código'), 
    writeln('  (05) Visualizar Produtos por Categoria'), 
    writeln('  (06) Remover Produto por Código'),
    writeln('  (07) Ler Cliente por CPF'), 
    writeln('  (08) Atualizar Cliente Completo'),
    writeln('  (09) Deletar Cliente por CPF'),
    writeln('  (10) Visualizar Dashboard'), 
    writeln('  (11) Sair do Modo Administrador'), 
    writeln('  (12) Sair do Sistema'), 
    writeln('Digite a opção desejada: '),
    read(Opcao),
    admController_processar_opcao(Opcao).

admController_processar_opcao(01) :-
    writeln('Visualizando produtos...'),
    imprimir_produtos,
    admController.

admController_processar_opcao(02) :-
    ler_produto_e_adicionar,
    writeln('Produto adicionado com sucesso.'),
    admController.

admController_processar_opcao(03) :-
    ler_produto_e_atualizar,
    writeln('Produto atualizado com sucesso.'),
    admController.

admController_processar_opcao(04) :-
    writeln('Digite o código do produto: '),
    read(Codigo),
    imprimir_produto(Codigo),
    admController.

admController_processar_opcao(05) :-
    writeln('Digite a categoria desejada: '),
    read(Categoria),
    imprimir_produtos_por_categoria(Categoria),
    admController.

admController_processar_opcao(06) :-
    writeln('Digite o código do produto: '),
    read(Codigo),
    deletar_produto(Codigo),
    admController.

admController_processar_opcao(07) :-
    writeln('Digite o CPF do cliente: '),
    read(CPF),
    imprimir_cliente_por_cpf(CPF),
    admController.

admController_processar_opcao(08) :-
    ler_cliente_e_atualizar,
    writeln('Cliente atualizado com sucesso.'),
    admController.

admController_processar_opcao(09) :-
    writeln('Digite o CPF do cliente: '),
    read(CPF),
    deletar_cliente(CPF),
    admController.

admController_processar_opcao(10) :-
    % Lógica para visualizar dashboard
    admController.

admController_processar_opcao(11) :-
    writeln('Saindo do modo administrador.'),
    initialController.

admController_processar_opcao(12) :-
    writeln('Saindo do sistema.').

admController_processar_opcao(_) :-
    writeln('Opção inválida. Tente novamente.'),
    admController.

% ===================================================================================================================
% Produto
% ===================================================================================================================

:- dynamic produto/9.

% Predicado para criar um produto
criar_produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade) :-
    assertz(produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade)).

% Predicado para atualizar um produto
atualizar_produto(Codigo, NovoDisponivel, NovoNome, NovaCategoria, NovoPrecoCompra, NovoPrecoVenda, NovaQuantidade, NovaFabricacao, NovaValidade) :-
    verificar_produto(Codigo),
    retract(produto(Codigo, _, _, _, _, _, _, _, _)),
    assertz(produto(Codigo, NovoDisponivel, NovoNome, NovaCategoria, NovoPrecoCompra, NovoPrecoVenda, NovaQuantidade, NovaFabricacao, NovaValidade)).

% Predicado para deletar um produto por código
deletar_produto(Codigo) :-
    verificar_produto(Codigo),
    retract(produto(Codigo, _, _, _, _, _, _, _, _)),
    writeln('Produto com código '), writeln(Codigo), writeln(' removido com sucesso.'), nl.

% Predicado para imprimir um produto
imprimir_produto(Codigo) :-
    verificar_produto(Codigo),
    produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade),
    format('========================================~n'),
    format('Nome:        | ~w~n', [Nome]),
    format('----------------------------------------~n'),
    format('Código:      | ~w~n', [Codigo]),
    format('----------------------------------------~n'),
    format('Disponível:  | ~w~n', [Disponivel]),
    format('----------------------------------------~n'),
    format('Categoria:   | ~w~n', [Categoria]),
    format('----------------------------------------~n'),
    format('Preço Compra:| R$~w~n', [PrecoCompra]),
    format('----------------------------------------~n'),
    format('Preço Venda: | R$~w~n', [PrecoVenda]),
    format('----------------------------------------~n'),
    format('Quantidade:  | ~w~n', [Quantidade]),
    format('----------------------------------------~n'),
    format('Fabricação:  | ~w~n', [Fabricacao]),
    format('----------------------------------------~n'),
    format('Validade:    | ~w~n', [Validade]),
    format('========================================~n').

% Predicado para imprimir todos os produtos do sistema
imprimir_produtos :-
    produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade),
    format('========================================~n'),
    format('Nome:        | ~w~n', [Nome]),
    format('----------------------------------------~n'),
    format('Código:      | ~w~n', [Codigo]),
    format('----------------------------------------~n'),
    format('Disponível:  | ~w~n', [Disponivel]),
    format('----------------------------------------~n'),
    format('Categoria:   | ~w~n', [Categoria]),
    format('----------------------------------------~n'),
    format('Preço Compra:| R$~w~n', [PrecoCompra]),
    format('----------------------------------------~n'),
    format('Preço Venda: | R$~w~n', [PrecoVenda]),
    format('----------------------------------------~n'),
    format('Quantidade:  | ~w~n', [Quantidade]),
    format('----------------------------------------~n'),
    format('Fabricação:  | ~w~n', [Fabricacao]),
    format('----------------------------------------~n'),
    format('Validade:    | ~w~n', [Validade]),
    format('========================================~n'),
    fail.

% Predicado para imprimir produtos de uma determinada categoria
imprimir_produtos_por_categoria(Categoria) :-
    produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade),
    format('========================================~n'),
    format('Nome:        | ~w~n', [Nome]),
    format('----------------------------------------~n'),
    format('Código:      | ~w~n', [Codigo]),
    format('----------------------------------------~n'),
    format('Disponível:  | ~w~n', [Disponivel]),
    format('----------------------------------------~n'),
    format('Categoria:   | ~w~n', [Categoria]),
    format('----------------------------------------~n'),
    format('Preço Compra:| R$~w~n', [PrecoCompra]),
    format('----------------------------------------~n'),
    format('Preço Venda: | R$~w~n', [PrecoVenda]),
    format('----------------------------------------~n'),
    format('Quantidade:  | ~w~n', [Quantidade]),
    format('----------------------------------------~n'),
    format('Fabricação:  | ~w~n', [Fabricacao]),
    format('----------------------------------------~n'),
    format('Validade:    | ~w~n', [Validade]),
    format('========================================~n'),
    fail.

verificar_produto(Codigo) :-
    (produto(Codigo, _, _, _, _, _, _, _, _) -> true ; writeln('O produto não existe')).

% ===================================================================================================================
% Cliente
% ===================================================================================================================

:- dynamic cliente/8.

% Predicado para criar um cliente
criar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha) :-
    assertz(cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha)).

% Predicado para deletar um cliente por CPF
deletar_cliente(CPF) :-
    verificar_cliente(CPF),
    retract(cliente(_, _, _, CPF, _, _, _, _)),
    writeln('Cliente com CPF '), writeln(CPF), writeln(' removido com sucesso.'), nl.

atualizar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha) :-
    verificar_cliente(CPF),
    retract(cliente(_, _, _, CPF, _, _, _, _)),
    assertz(cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha)).

% Predicado para verificar se um cliente existe
verificar_cliente(CPF) :-
    (cliente(_, _, _, CPF, _, _, _, _) -> true ; writeln('O cliente não existe')).

imprimir_cliente_por_cpf(CPF) :-
    verificar_cliente(CPF),
    cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha),
    format('========================================~n'),
    format('Nome Completo: | ~w~n', [NomeCompleto]),
    format('----------------------------------------~n'),
    format('Sexo:          | ~w~n', [Sexo]),
    format('----------------------------------------~n'),
    format('Data Nasc.:    | ~w~n', [DataNascimento]),
    format('----------------------------------------~n'),
    format('CPF:           | ~w~n', [CPF]),
    format('----------------------------------------~n'),
    format('Email:         | ~w~n', [Email]),
    format('----------------------------------------~n'),
    format('Telefone:      | ~w~n', [Telefone]),
    format('----------------------------------------~n'),
    format('Nome Usuário:  | ~w~n', [NomeUsuario]),
    format('----------------------------------------~n'),
    format('Senha:         | ~w~n', [Senha]),
    format('========================================~n').

% ===================================================================================================================
% Auxiliares
% ===================================================================================================================

ler_produto_e_adicionar :-
    obter_e_incrementar_codigo(Codigo),
    Disponivel = true,
    writeln('Digite o nome do produto: '),
    read(Nome),
    writeln('Digite a categoria do produto: '),
    read(Categoria),
    writeln('Digite o preço de compra do produto: '),
    read(PrecoCompra),
    writeln('Digite o preço de venda do produto: '),
    read(PrecoVenda),
    writeln('Digite a quantidade inicial em estoque: '),
    read(Quantidade),
    writeln('Digite a data de fabricação do produto: '),
    read(Fabricacao),
    writeln('Digite a data de validade do produto: '),
    read(Validade),
    criar_produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade).

ler_produto_e_atualizar :-
    writeln('Digite o código do produto a ser atualizado: '),
    read(Codigo),
    verificar_produto(Codigo),
    writeln('Digite o novo nome do produto: '),
    read(Nome),
    writeln('Digite a nova categoria do produto: '),
    read(Categoria),
    writeln('Digite o novo preço de compra do produto: '),
    read(PrecoCompra),
    writeln('Digite o novo preço de venda do produto: '),
    read(PrecoVenda),
    writeln('Digite a nova quantidade inicial em estoque: '),
    read(Quantidade),
    writeln('Digite a nova data de fabricação do produto: '),
    read(Fabricacao),
    writeln('Digite a nova data de validade do produto: '),
    read(Validade),
    atualizar_produto(Codigo, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade).

ler_cliente_e_adicionar :-
    writeln('Digite o nome completo do cliente: '),
    read(NomeCompleto),
    writeln('Digite o sexo do cliente: '),
    read(Sexo),
    writeln('Digite a data de nascimento do cliente: '),
    read(DataNascimento),
    writeln('Digite o CPF do cliente: '),
    read(CPF),
    writeln('Digite o email do cliente: '),
    read(Email),
    writeln('Digite o telefone do cliente: '),
    read(Telefone),
    writeln('Digite o nome de usuário do cliente: '),
    read(NomeUsuario),
    writeln('Digite a senha do cliente: '),
    read(Senha),
    criar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha).

ler_cliente_e_atualizar :-
    writeln('Digite o CPF do cliente: '),
    read(CPF),
    verificar_cliente(CPF),
    writeln('Digite o nome completo do cliente: '),
    read(NomeCompleto),
    writeln('Digite o sexo do cliente: '),
    read(Sexo),
    writeln('Digite a data de nascimento do cliente: '),
    read(DataNascimento),
    writeln('Digite o email do cliente: '),
    read(Email),
    writeln('Digite o telefone do cliente: '),
    read(Telefone),
    writeln('Digite o nome de usuário do cliente: '),
    read(NomeUsuario),
    writeln('Digite a senha do cliente: '),
    read(Senha),
    atualizar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha).