% ===================================================================================================================
% Main
% ===================================================================================================================

% Predicado main que chama o initialController.
main :-
    iniciar_sistema.


% ===================================================================================================================
% Codigo de Produto
% ===================================================================================================================

% Define o contador como um fato dinâmico.
:- dynamic(contador_codigo/1).

% Predicado para obter o próximo código e incrementá-lo.
obter_e_incrementar_codigo(ProximoCodigo) :-
    retract(contador_codigo(CodigoAtual)),  
    ProximoCodigo is CodigoAtual,          
    NovoCodigo is CodigoAtual + 1,         
    asserta(contador_codigo(NovoCodigo)). 


% ===================================================================================================================
% Controllers
% ===================================================================================================================

initialController :-
    writeln('====================================='),
    writeln('         Menu de Visitante          '),
    writeln('====================================='), 
    writeln('  (01) Visualizar Produtos'), 
    writeln('  (02) Entrar como Cliente'), 
    writeln('  (03) Registrar como Cliente'), 
    writeln('  (04) Entrar como Administrador'), 
    writeln('  (05) Sair do Sistema'), 
    writeln('Digite a opção desejada: '), 
    read(Opcao),
    initialController_processar_opcao(Opcao).

initialController_processar_opcao(01) :-
    writeln('Visualizando produtos...'),
    imprimir_produtos_por_categoria(_), 
    initialController.

initialController_processar_opcao(02) :-
    % Coloque aqui a lógica para logar como cliente.
    writeln('Entrando como cliente...'),
    clienteController.

initialController_processar_opcao(03) :-
    % Coloque aqui a lógica para registrar um cliente.
    writeln('Entrando como cliente...'),
    clienteController.

initialController_processar_opcao(04) :-
    % Coloque aqui a lógica para logar como administrador.
    writeln('Entrando como administrador...'),
    admController.

initialController_processar_opcao(05) :-
    fechar_sistema.

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
    imprimir_produtos_por_categoria(_),
    clienteController.

processar_opcao_cliente(02) :-
    writeln('Digite a categoria desejada: '),
    read(Categoria),
    imprimir_produtos_por_categoria(Categoria),
    clienteController.

processar_opcao_cliente(03) :-
    % Lógica para adicionar ao carrinho
    writeln('Digite seu CPF'),
    read(CPF),
    writeln('Digite o codigo do produto'),
    read(Codigo),
    writeln('Digite a quantidade'),
    read(Quantidade_Carrinho),
    adicionar_carro(CPF, Codigo, Quantidade_Carrinho),
    clienteController.

processar_opcao_cliente(04) :-
    % Lógica para remover carrinho
    writeln('Digite o cpf'),
    read(CPF),
    writeln('Digite o codigo do produto'),
    read(Codigo),
    writeln('Digite a quantidade a ser retirada'),
    read(QuantidadeCarrinhoRetirada),
    atualizar_carro(CPF, Codigo, QuantidadeCarrinhoRetirada),
    clienteController.

processar_opcao_cliente(05) :-
    % Lógica para visualizar carrinho
    writeln('Digite seu CPF'),
    read(CPF),
    mostrarCarro(CPF),
    clienteController.

processar_opcao_cliente(06) :-teboo
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
    fechar_sistema.

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
    imprimir_produtos_por_categoria(_),
    admController.

admController_processar_opcao(02) :-
    ler_produto(Nome, Disponivel, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade),
    obter_e_incrementar_codigo(Codigo),
    criar_produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade),
    writeln('Produto adicionado com sucesso.'),
    admController.

admController_processar_opcao(03) :-
    writeln('Digite o código do produto a ser atualizado: '),
    read(Codigo),
    (verificar_produto(Codigo) ->
        ler_produto(Nome, Disponivel, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade),
        atualizar_produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade),
        writeln('Produto atualizado com sucesso.')
    ;   writeln('Produto não encontrado.')
    ),
    admController.

admController_processar_opcao(04) :-
    writeln('Digite o código do produto: '),
    read(Codigo),
    (verificar_produto(Codigo) ->
        imprimir_produto(Codigo)
    ;   writeln('Produto não encontrado.')
    ),
    admController.

admController_processar_opcao(05) :-
    writeln('Digite a categoria desejada: '),
    read(Categoria),
    imprimir_produtos_por_categoria(Categoria),
    admController.

admController_processar_opcao(06) :-
    writeln('Digite o código do produto: '),
    read(Codigo),
    (verificar_produto(Codigo) ->
        deletar_produto(Codigo),
        writeln('Produto removido com sucesso.')
    ;   writeln('Produto não encontrado.')
    ),
    admController.

admController_processar_opcao(07) :-
    writeln('Digite o CPF do cliente: '),
    read(CPF),
    (verificar_cliente(CPF) ->
        imprimir_cliente_por_cpf(CPF)
    ;   writeln('Cliente não encontrado.')
    ),
    admController.

admController_processar_opcao(08) :-
    writeln('Digite o CPF do cliente a ser atualizado: '),
    read(CPF),
    (verificar_cliente(CPF) ->
        ler_cliente(NomeCompleto, Sexo, DataNascimento, Email, Telefone, NomeUsuario, Senha),
        atualizar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha),
        writeln('Cliente atualizado com sucesso.')
    ;   writeln('Cliente não encontrado.')
    ),
    admController.

admController_processar_opcao(09) :-
    writeln('Digite o CPF do cliente: '),
    read(CPF),
    (verificar_cliente(CPF) ->
        deletar_cliente(CPF),
        writeln('Cliente removido com sucesso.')
    ;   writeln('Cliente não encontrado.')
    ),
    admController.

admController_processar_opcao(10) :-
    % Lógica para visualizar dashboard
    admController.

admController_processar_opcao(11) :-
    writeln('Saindo do modo administrador.'),
    initialController.

admController_processar_opcao(12) :-
    fechar_sistema.

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
    retract(produto(Codigo, _, _, _, _, _, _, _, _)),
    assertz(produto(Codigo, NovoDisponivel, NovoNome, NovaCategoria, NovoPrecoCompra, NovoPrecoVenda, NovaQuantidade, NovaFabricacao, NovaValidade)).

% Predicado para deletar um produto por código
deletar_produto(Codigo) :-
    retract(produto(Codigo, _, _, _, _, _, _, _, _)).

% Predicado para imprimir um produto
imprimir_produto(Codigo) :-
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


% ===================================================================================================================
% Cliente
% ===================================================================================================================

:- dynamic cliente/8.

% Predicado para criar um cliente
criar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha) :-
    assertz(cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha)).

% Predicado para deletar um cliente por CPF
deletar_cliente(CPF) :-
    retract(cliente(_, _, _, CPF, _, _, _, _)).

atualizar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha) :-
    retract(cliente(_, _, _, CPF, _, _, _, _)),
    assertz(cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha)).

imprimir_cliente_por_cpf(CPF) :-
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

% Predicado para iniciar o sistema
iniciar_sistema :-
    writeln('Iniciando o sistema...'),
    ler_produtos_csv('Produtos.csv'),
    ler_clientes_csv('Clientes.csv'),
    ler_codigo_csv('NextCodigo.csv'),
    initialController.

% Predicado para fechar o sistema
fechar_sistema :-
    writeln('Fechando o sistema...'),
    gravar_produtos_csv('Produtos.csv'),
    gravar_clientes_csv('Clientes.csv'),
    gravar_codigo_csv('NextCodigo.csv'), 
    halt.

% Predicado para verificar se um produto existe
verificar_produto(Codigo) :-
    produto(Codigo, _, _, _, _, _, _, _, _).

% Predicado para verificar se um cliente existe
verificar_cliente(CPF) :-
    cliente(_, _, _, CPF, _, _, _, _).

% Predicado para ler um produto
ler_produto(Nome, Disponivel, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade) :-
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
    writeln('Digite a data de fabricação do produto (DD-MM-AAAA): '),
    read(Fabricacao),
    writeln('Digite a data de validade do produto (DD-MM-AAAA): '),
    read(Validade),
    writeln('Digite a disponibilidade do produto (true/false): '),
    read(Disponivel).

% Predicado para ler um cliente
ler_cliente(NomeCompleto, Sexo, DataNascimento, Email, Telefone, NomeUsuario, Senha) :-
    writeln('Digite o nome completo do cliente: '),
    read(NomeCompleto),
    writeln('Digite o sexo do cliente: '),
    read(Sexo),
    writeln('Digite a data de nascimento do cliente (DD-MM-AAAA): '),
    read(DataNascimento),
    writeln('Digite o email do cliente: '),
    read(Email),
    writeln('Digite o telefone do cliente: '),
    read(Telefone),
    writeln('Digite o nome de usuário do cliente: '),
    read(NomeUsuario),
    writeln('Digite a senha do cliente: '),
    read(Senha).

%--------------------------------------------------------------------------------------------------------------------------------------------
% carrinho
%--------------------------------------------------------------------------------------------------------------------------------------------

:- dynamic carro/3.

adicionar_carro(CPF, Codigo, Quantidade_Carrinho):-
    assertz(carro(CPF, verificar_produto(Codigo), Quantidade_Carrinho)).

atualizar_carro(CPF, Codigo, QuantidadeCarrinhoRetirada):-
    quantidade_carrinho(CPF, Retorno),
    Quantidade_final is Retorno - QuantidadeCarrinhoRetirada,
    retract(carro(CPF, verificar_produto(Codigo), Quantidade_Carrinho)),
    assertz(carro(CPF, verificar_produto(Codigo), Quantidade_final)).

remover_produto_carro(nomeProduto)
    retract(carro(nomeProduto, _)).

tem_carrinho(CPF):-
    carro(CPF, _, _).

quantidade_carrinho(CPF, Retorno):-
    carro(CPF, _, Quantidade_Carrinho),
    Retorno = Quantidade_Carrinho.

mostrarCarro(CPF):-
    carro(CPF, verificar_produto(Codigo), Quantidade_Carrinho),
    imprimir_produto(Codigo),
    format('Quantidade no carrinho:    | ~w~n', [Quantidade_Carrinho]).
    

%--------------------------------------------------------------------------------------------------------------------------------------------
% historico
%--------------------------------------------------------------------------------------------------------------------------------------------



% ===================================================================================================================
% Persistência de Dados
% ===================================================================================================================

:- use_module(library(csv)).

% Predicado para ler os dados do arquivo CSV de produtos
ler_produtos_csv(NomeArquivoProdutos) :-
    (   csv_read_file(NomeArquivoProdutos, ProdutoRows, [])
    ->  writeln('Arquivo de produtos lido com sucesso.'),
        processar_linhas(ProdutoRows, produto)
    ;   writeln('Erro ao ler o arquivo de produtos.')
    ).

% Predicado para ler os dados do arquivo CSV de clientes
ler_clientes_csv(NomeArquivoClientes) :-
    (   csv_read_file(NomeArquivoClientes, ClienteRows, [])
    ->  writeln('Arquivo de clientes lido com sucesso.'),
        processar_linhas(ClienteRows, cliente)
    ;   writeln('Erro ao ler o arquivo de clientes.')
    ).

% Predicado para processar as linhas lidas do CSV
processar_linhas([], _).
processar_linhas([Row|Rest], Tipo) :-
    (   processar_linha(Row, Tipo)
    ->  processar_linhas(Rest, Tipo)
    ;   writeln('Erro ao processar a linha.'),
        writeln(Row)
    ).

% Predicado para processar uma linha de produtos e criar predicados
processar_linha(Row, produto) :-
    Row = row(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade),
    assertz(produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade)).

% Predicado para processar uma de clientes e criar predicados
processar_linha(Row, cliente) :-
    Row = row(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha),
    assertz(cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha)).

% Predicado para gravar produtos em um arquivo CSV
gravar_produtos_csv(NomeArquivo) :-
    findall(row(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade), 
        produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade), ProdutoRows),
    csv_write_file(NomeArquivo, ProdutoRows).

% Predicado para gravar clientes em um arquivo CSV
gravar_clientes_csv(NomeArquivo) :-
    findall(row(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha),
        cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha), ClienteRows),
    csv_write_file(NomeArquivo, ClienteRows).

% Predicado para inicializar o contador de código
ler_codigo_csv(NomeArquivo) :-
    (   csv_read_file(NomeArquivo, [row(Valor)], [])
    ->  writeln('Arquivo de codigo lido com sucesso.'),
        asserta(contador_codigo(Valor))
    ;   writeln('Erro ao ler o arquivo de codigo.')
    ).

% Predicado para salvar o valor do contador em um arquivo CSV
gravar_codigo_csv(NomeArquivo) :-
    contador_codigo(Valor),
    csv_write_file(NomeArquivo, [row(Valor)]).




% ===================================================================================================================
% Dashboard
% ===================================================================================================================


% Função para calcular a quantidade total de produtos em estoque
quantidade_total_estoque(Total) :-
    findall(Q, produto(_, _, _, _, _, _, Q, _, _), Quantidades),
    sum_list(Quantidades, Total).

% Função para listar produtos com estoque baixo (estoque < 10)
produtos_com_estoque_baixo(Produtos) :-
    findall(P, (produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade), Quantidade < 10), Produtos).

% Função para calcular a receita total gerada por todos os produtos
receita_total_por_produto(ReceitaTotal) :-
    findall(Receita, (produto(_, _, _, _, _, PrecoVenda, Quantidade, _, _), Receita is PrecoVenda * Quantidade), Receitas),
    sum_list(Receitas, ReceitaTotal).

% Função para calcular a receita total gerada por categoria
receita_total_por_categoria(Categoria, ReceitaTotal) :-
    findall(Receita, (produto(_, _, _, Categoria, _, PrecoVenda, Quantidade, _, _), Receita is PrecoVenda * Quantidade), Receitas),
    sum_list(Receitas, ReceitaTotal).

% Função para encontrar os produtos mais populares (com base na quantidade)
produtos_mais_populares(Produtos) :-
    findall([Quantidade, produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade)], produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade), ListaProdutos),
    sort(ListaProdutos, ListaOrdenada),
    reverse(ListaOrdenada, ListaReversa),
    take(5, ListaReversa, Produtos).

% Helper: Função para pegar os N primeiros itens de uma lista
take(0, _, []).
take(_, [], []).
take(N, [H|T], [H|Result]) :-
    N > 0,
    N1 is N-1,
    take(N1, T, Result).

% Função para calcular os clientes mais ativos
clientes_mais_ativos(Clientes) :-
    findall([Len, cliente(CPF, Nome, Historico)], (cliente(CPF, Nome, Historico), length(Historico, Len)), ListaClientes),
    sort(ListaClientes, ListaOrdenada),
    reverse(ListaOrdenada, ListaReversa),
    take(5, ListaReversa, Clientes).

% Função para calcular a media de compras por cliente
media_compras_por_cliente(Media) :-
    findall(Len, (cliente(_, _, Historico), length(Historico, Len)), ListaCompras),
    sum_list(ListaCompras, TotalCompras),
    length(ListaCompras, TotalClientes),
    (TotalClientes =:= 0 -> Media = 0 ; Media is TotalCompras / TotalClientes).