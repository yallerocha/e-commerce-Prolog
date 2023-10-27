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
% Login e Cadastro
% ===================================================================================================================

clienteLoginController:-
	writeln('Login: '),
    read(LoginCliente),
	writeln('Senha: '),
    read(SenhaCliente),
	cliente_login(LoginCliente,SenhaCliente).

clienteCadastroController:-
	writeln('Nome (ex: Nome): '),
    read(NomeCadastroCliente),
	writeln('Sexo (ex: Masculino): '),
    read(SexoCadastroCliente),
	writeln('Data de nascimento (ex: 29-01-2003): '),
    read(user, Date),
	writeln('CPF (ex: 08515939410): '),
    read(user, CPFcadastroCliente),
	writeln('Email (ex: nome@gmail.com.br): '),
    read(user, EmailCadastroCliente),
	writeln('telefone (ex: 83999999999): '),
    read(TelefoneCadastroCliente),
	writeln('Nome de usuario: '),
    read(LoginCadastroCliente),
	writeln('Sua senha: '),
    read(SenhaCadastroCliente),
	criar_cliente(NomeCadastroCliente, SexoCadastroCliente, Date, CPFcadastroCliente,EmailCadastroCliente,TelefoneCadastroCliente,LoginCadastroCliente,SenhaCadastroCliente).

admLoginController:-
	writeln('Login: '),
	read(LoginAdm),
	writeln('Senha: '),
	read(SenhaAdm),
	adm_Login(LoginAdm,SenhaAdm).

cliente_login(LoginCliente,SenhaCliente):-
	cliente(_,_,_,CPF,_,_,LoginCliente,SenhaCliente),
    assertz(logado(CPF)),
	clienteController.

adm_Login('admin', 'admin'):-
	admController.


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
    imprimir_produtos_por_categoria_e_disponibilidade(_, true),
    initialController.

initialController_processar_opcao(02) :-
	writeln('Entrando como cliente...'),
    clienteLoginController.

initialController_processar_opcao(03) :-
    writeln('Registrar como cliente...'),
    clienteCadastroController.

initialController_processar_opcao(04) :-
    writeln('Entrando como administrador...'),
    admLoginController.

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
	writeln('  (07) Avaliar um Produto'),
	writeln('  (08) Ver avaliações de um Produto'),
    writeln('  (09) Atualizar Meu Cadastro'),
    writeln('  (10) Deletar Minha Conta'),
    writeln('  (11) Sair do Modo Cliente'),
    writeln('  (12) Sair do Sistema'),
    writeln('Digite a opção desejada: '),
    read(Opcao),
    processar_opcao_cliente(Opcao).

processar_opcao_cliente(01) :-
    writeln('Visualizando produtos...'),
    imprimir_produtos_por_categoria_e_disponibilidade(_, true),
    clienteController.

processar_opcao_cliente(02) :-
    writeln('Digite a categoria desejada: '),
    read(Categoria),
    imprimir_produtos_por_categoria_e_disponibilidade(Categoria, true),
    clienteController.

processar_opcao_cliente(03) :-
    % Lógica para adicionar ao carrinho
    logado(CPF),
    writeln('Digite o codigo do produto'),
    read(Codigo),
    writeln('Digite a quantidade'),
    read(Quantidade_Carrinho),
    verificar_produto(Codigo),
    adicionar_carrinho(CPF, Codigo, Quantidade_Carrinho),
    clienteController.

processar_opcao_cliente(04) :-
    % Lógica para remover do carrinho
    logado(CPF),
    writeln('Digite o codigo do produto'),
    read(Codigo),
    verificar_produto(Codigo),
    remover_carrinho(CPF, Codigo),
    clienteController.

processar_opcao_cliente(05) :-
    % Lógica para visualizar carrinho
    logado(CPF),
    mostrarcarrinho(CPF),
    clienteController.

processar_opcao_cliente(06) :-
    % Lógica para finalizar compra
    logado(CPF),
    writeln('Digite a data da compra (DD-MM-AAAA)'),
    read(DataCompra),
    tem_carrinho(CPF),
    finalizar_compra(CPF, DataCompra),
    clienteController.

processar_opcao_cliente(07) :-
    % Lógica para criar avaliação
    logado(CPF),
    writeln('Digite o codigo do Produto a ser avaliado:'),
    read(CodigoProduto),
	writeln('Digite a sua nota para este produto'),
    read(NotaAvaliacao),
	writeln('Digite a sua avaliação deste produto:'),
    read(user, TextAvaliacao),
    avalia_produto(CPF, CodigoProduto,TextAvaliacao,NotaAvaliacao),
    clienteController.

processar_opcao_cliente(08) :-
    writeln('Ver avaliacao de um produto, digite o codigo do produto:'),
    read(CodigoProduto),
    imprimir_avaliacao_produto(CodigoProduto),
    clienteController.

processar_opcao_cliente(09) :-
    % Lógica para atualizar cadastro
    clienteAtualizarCadastroController.

processar_opcao_cliente(10) :-
    % Lógica para deletar conta
	writeln('Digite seu CPF para deletar sua conta: '),
    read(CPF),
    logado(CPF) -> (
        deletar_cliente(CPF),
        writeln('Conta deletada com sucesso.'),
        initialController
    ) ; (
        writeln('Este CPF não é seu.'),
        clienteController
    ).

processar_opcao_cliente(11) :-
    retract(logado(_)),
    writeln('Saindo do modo cliente.'),
    initialController.

% Opção para sair do sistema
processar_opcao_cliente(12) :-
    fechar_sistema.

% Opção inválida
processar_opcao_cliente(_) :-
    writeln('Opção inválida. Tente novamente.'),
    clienteController.

clienteAtualizarCadastroController:-
	writeln('Digite o CPF a ser atualizado: '),
    read(CPF),
	(verificar_cliente(CPF) ->
        nl
    ;   writeln('Cliente não encontrado.')
    ),
	cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha),

	writeln('======================'),
    writeln('  (01) Atualizar Nome'),
    writeln('  (02) Atualizar Sexo'),
    writeln('  (03) Atualizar Data de nascimento'),
    writeln('  (04) Atualizar Email'),
    writeln('  (05) Atualizar Senha'),
	read(Opcao),
	(
        Opcao = 01 ->
            writeln('Nome (ex: Nome): '),
    		read(NomeUpdateCliente),
			atualizar_cliente(NomeUpdateCliente, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha),
			clienteController
        ;
        Opcao = 02 ->
            writeln('Sexo (ex: Masculino): '),
    		read(SexoUpdateCliente),
			atualizar_cliente(NomeCompleto, SexoUpdateCliente, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha),
			clienteController
        ;
        Opcao = 03 ->
            writeln('Data de nascimento (ex: 29-01-2003): '),
    		read(DataNascimentoUpdate),
			atualizar_cliente(NomeCompleto, Sexo, DataNascimentoUpdate, CPF, Email, Telefone, NomeUsuario, Senha),
			clienteController
        ;
		Opcao = 04 ->
            writeln('Email (ex: nome@gmail.com.br): '),
    		read(EmailUpdate),
			atualizar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, EmailUpdate, Telefone, NomeUsuario, Senha),
			clienteController
        ;
		Opcao = 05 ->
            writeln('senha (ex: Senha): '),
    		read(SenhaUpdate),
			atualizar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, SenhaUpdate),
			clienteController
        ;
        write('Opcao Invalida!'), nl,
		clienteAtualizarCadastroController
    ).

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
	writeln('  (08) Ver Avaliacoes de um produto'),
    writeln('  (09) Atualizar Cliente Completo'),
    writeln('  (10) Deletar Cliente por CPF'),
	writeln('  (11) Adicionar Categoria'),
    writeln('  (12) Remover Categoria e Produtos'),
    writeln('  (13) Visualizar Dashboard'),
    writeln('  (14) Sair do Modo Administrador'),
    writeln('  (15) Sair do Sistema'),
    writeln('Digite a opção desejada: '),
    read(Opcao),
    admController_processar_opcao(Opcao).

admController_processar_opcao(01) :-
    writeln('Visualizando produtos...'),
    imprimir_produtos_por_categoria_e_disponibilidade(_, _),
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
    imprimir_produtos_por_categoria_e_disponibilidade(Categoria, _),
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
    writeln('Ver avaliacao de um produto, digite o codigo do produto:'),
    read(CodigoProduto),
    imprimir_avaliacao_produto(CodigoProduto),
    admController.

admController_processar_opcao(09) :-
    writeln('Digite o CPF do cliente a ser atualizado: '),
    read(CPF),
    (verificar_cliente(CPF) ->
        ler_cliente(NomeCompleto, Sexo, DataNascimento, Email, Telefone, NomeUsuario, Senha),
        atualizar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha),
        writeln('Cliente atualizado com sucesso.')
    ;   writeln('Cliente não encontrado.')
    ),
    admController.

admController_processar_opcao(10) :-
    writeln('Digite o CPF do cliente: '),
    read(CPF),
    (verificar_cliente(CPF) ->
        deletar_cliente(CPF),
        writeln('Cliente removido com sucesso.')
    ;   writeln('Cliente não encontrado.')
    ),
    admController.

admController_processar_opcao(11) :-
    writeln('Digite a categoria a ser adicionada: '),
    read(Categoria),
    (
        categoria(Categoria) ->
        writeln('Categoria já existe na base de dados.')
    ;
        criar_categoria(Categoria),
        writeln('Categoria adicionada com sucesso.')
    ),
    admController.

admController_processar_opcao(12) :-
    writeln('Digite a categoria a ser removida: '),
    read(Categoria),
    (categoria(Categoria) ->
        deletar_categoria(Categoria),
        writeln('Categoria removida com sucesso.')
    ;   writeln('Categoria não encontrada.')
    ),
    admController.

admController_processar_opcao(13) :-
    repeat,
    writeln('Escolha o tipo de dashboard:'),
    writeln('  (1) Quantidade total de produtos em estoque'),
    writeln('  (2) Produtos com estoque baixo'),
    writeln('  (3) Receita total gerada por todos os produtos'),
    writeln('  (4) Receita total por categoria'),
    writeln('  (5) Produtos mais populares'),
    writeln('  (6) Clientes mais ativos'),
    writeln('  (7) Média de compras por cliente'),
    writeln('  (0) Voltar ao Menu de Administrador'),
    read(OpcaoDashboard),
    (OpcaoDashboard =:= 0 -> !, admController ; exibir_dashboard(OpcaoDashboard), !),
    fail.

% Funções para exibir os dashboards correspondentes

exibir_dashboard(1) :-
    quantidade_total_estoque(TotalEstoque),
    format('Quantidade total de produtos em estoque: ~w~n', [TotalEstoque]),
    nl,
    admController_processar_opcao(13).

exibir_dashboard(2) :-
    produtos_com_estoque_baixo(ProdutosBaixo),
    format('Produtos com estoque baixo: ~w~n', [ProdutosBaixo]),
    nl,
    admController_processar_opcao(13).

exibir_dashboard(3) :-
    receita_total_por_produto(ReceitaTotal),
    format('Receita total gerada por todos os produtos: ~w~n', [ReceitaTotal]),
    nl,
    admController_processar_opcao(13).

exibir_dashboard(4) :-
    writeln('Digite a categoria desejada: '),
    read(Categoria),
    receita_total_por_categoria(Categoria, ReceitaTotal),
    format('Receita total gerada pela categoria ~w: ~w~n', [Categoria, ReceitaTotal]),
    nl,
    admController_processar_opcao(13).

exibir_dashboard(5) :-
    produtos_mais_populares(ProdutosPopulares),
    format('Produtos mais populares: ~w~n', [ProdutosPopulares]),
    nl,
    admController_processar_opcao(13).

exibir_dashboard(6) :-
    clientes_mais_ativos(ClientesAtivos),
    format('Clientes mais ativos: ~w~n', [ClientesAtivos]),
    nl,
    admController_processar_opcao(13).

exibir_dashboard(7) :-
    media_compras_por_cliente(MediaCompras),
    format('Média de compras por cliente: ~w~n', [MediaCompras]),
    nl,
    admController_processar_opcao(13).

exibir_dashboard(_) :-
    writeln('Opção de dashboard inválida. Tente novamente.'),
    nl,
    admController_processar_opcao(13).

admController_processar_opcao(14) :-
    writeln('Saindo do modo administrador.'),
    initialController.

admController_processar_opcao(15) :-
    fechar_sistema.

admController_processar_opcao(_) :-
    writeln('Opção inválida. Tente novamente.'),
    admController.

% ===================================================================================================================
% Categoria
% ===================================================================================================================

:- dynamic categoria/1.

% Predicado para criar uma categoria
criar_categoria(Categoria) :-
    assertz(categoria(Categoria)).

% Predicado para deletar uma categoria (isso também apaga os produtos da categoria)
deletar_categoria(Categoria) :-
    retract(categoria(Categoria)),
    deletar_produtos_por_categoria(Categoria).

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

% predicado para deletar produtos por categoria
deletar_produtos_por_categoria(Categoria) :-
    retractall(produto(_, _, _, Categoria, _, _, _, _, _)).

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
imprimir_produtos_por_categoria_e_disponibilidade(Categoria, Disponivel) :-
    findall((Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade),
            produto(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade), Produtos),
    imprimir_lista_produtos(Produtos).


% ===================================================================================================================
% Cliente
% ===================================================================================================================

:- dynamic cliente/8.

% Predicado para criar um cliente
criar_cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha) :-
    assertz(cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha)),
	writeln("Cliente Cadastrado com sucesso!"),
	clienteController.

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
    ler_carrinhos_csv('Carrinhos.csv'),
    ler_categorias_csv('Categorias.csv'),
    ler_avaliacoes_csv('Avaliacoes.csv'),
    initialController.

% Predicado para fechar o sistema
fechar_sistema :-
    writeln('Fechando o sistema...'),
    gravar_produtos_csv('Produtos.csv'),
    gravar_clientes_csv('Clientes.csv'),
    gravar_codigo_csv('NextCodigo.csv'),
    gravar_carrinhos_csv('Carrinhos.csv'),
    gravar_categorias_csv('Categorias.csv'),
    gravar_avaliacoes_csv('Avaliacoes.csv'),
    halt.

% Predicado para verificar se um produto existe
verificar_produto(Codigo) :-
    produto(Codigo, _, _, _, _, _, _, _, _).

% Predicado para verificar se um cliente existe
verificar_cliente(CPF) :-
    cliente(_, _, _, CPF, _, _, _, _).

% Predica para ler um produto
ler_produto(Nome, Disponivel, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade) :-
    writeln('Digite o nome do produto: '),
    read(Nome),
    verificar_categoria(Categoria),
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

verificar_categoria(Categoria) :-
    writeln('Digite a categoria do produto: '),
    read(Categoria),
    (categoria(Categoria)
    -> true
    ; writeln('Categoria inválida. Tente novamente!'),
      admController
    ).

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
% Avaliação
%--------------------------------------------------------------------------------------------------------------------------------------------

:- dynamic avaliacao/4.

avalia_produto(CPF,CodigoProduto,TextAvaliacao,NotaAvaliacao):-
	assertz(avaliacao(CPF,CodigoProduto,TextAvaliacao,NotaAvaliacao)),
	writeln("Produto Avaliado com sucesso!").

imprimir_avaliacao_produto(CodigoProduto) :-
    avaliacao(CPF,CodigoProduto,TextAvaliacao,NotaAvaliacao),
    format('Avaliacao'),
    format('========================================~n'),
    format('CPF:        | ~w~n', [CPF]),
    format('----------------------------------------~n'),
    format('codigo:      | ~w~n', [CodigoProduto]),
    format('----------------------------------------~n'),
    format('NOTA:  | ~w~n', [NotaAvaliacao]),
    format('----------------------------------------~n'),
    format('Avaliacao:   | ~w~n', [TextAvaliacao]),
    format('========================================~n'),
    fail.

% Predicado para imprimir uma lista de produtos
imprimir_lista_produtos([]).
imprimir_lista_produtos([(Codigo, Disponivel, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade) | Resto]) :-
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
    imprimir_lista_produtos(Resto).

%--------------------------------------------------------------------------------------------------------------------------------------------
% Carrinho
%--------------------------------------------------------------------------------------------------------------------------------------------

:- dynamic carrinho/3.

adicionar_carrinho(CPF, Codigo, Quantidade_Carrinho):-
    assertz(carrinho(CPF, Codigo, Quantidade_Carrinho)).

remover_carrinho(CPF, Codigo):-
    retract(carrinho(CPF, Codigo, _)).

tem_carrinho(CPF):-
    carrinho(CPF, _, _).

quantidade_carrinho(CPF, Retorno):-
    carrinho(CPF, _, Quantidade_Carrinho),
    Retorno = Quantidade_Carrinho.

mostrarcarrinho(CPF):-
    carrinho(CPF, Codigo, Quantidade_Carrinho),
    imprimir_produtos_carrinho(Codigo, Quantidade_Carrinho).


imprimir_produtos_carrinho(Codigo, Quantidade_Carrinho) :-
    produto(Codigo, Disponivel, Nome, Categoria, _, PrecoVenda, Quantidade, Fabricacao, Validade),
    format('Seu Carrinho de Compras~n'),
    format('========================================~n'),
    format('Nome:        | ~w~n', [Nome]),
    format('----------------------------------------~n'),
    format('Código:      | ~w~n', [Codigo]),
    format('----------------------------------------~n'),
    format('Disponível:  | ~w~n', [Disponivel]),
    format('----------------------------------------~n'),
    format('Categoria:   | ~w~n', [Categoria]),
    format('----------------------------------------~n'),
    format('Preço: | R$~w~n', [PrecoVenda]),
    format('----------------------------------------~n'),
    format('Estoque:  | ~w~n', [Quantidade]),
    format('----------------------------------------~n'),
    format('Fabricação:  | ~w~n', [Fabricacao]),
    format('----------------------------------------~n'),
    format('Validade:    | ~w~n', [Validade]),
    format('----------------------------------------~n'),
    format('Quantidade no Carrinho:    | ~w~n', [Quantidade_Carrinho]),
    format('========================================~n'),
    fail.


%--------------------------------------------------------------------------------------------------------------------------------------------
% Histórico de compras
%--------------------------------------------------------------------------------------------------------------------------------------------

:- dynamic historico/2.

finalizar_compra(CPF, DataCompra):-
   assertz(historico(CPF, DataCompra)),
   imprimir_historico(CPF, DataCompra).

imprimir_historico(CPF, DataCompra) :-
    carrinho(CPF, Codigo, Quantidade_Carrinho),
    produto(Codigo, _, Nome, Categoria, PrecoCompra, PrecoVenda, Quantidade, Fabricacao, Validade),
    format('Seu Comprovante de Compra~n'),
    format('========================================~n'),
    format('Nome:        | ~w~n', [Nome]),
    format('----------------------------------------~n'),
    format('Código:      | ~w~n', [Codigo]),
    format('----------------------------------------~n'),
    format('Categoria:   | ~w~n', [Categoria]),
    format('----------------------------------------~n'),
    format('Preço: | R$~w~n', [PrecoVenda]),
    format('----------------------------------------~n'),
    format('Data:  | ~w~n', [DataCompra]),
    format('----------------------------------------~n'),
    format('Fabricação:  | ~w~n', [Fabricacao]),
    format('----------------------------------------~n'),
    format('Validade:    | ~w~n', [Validade]),
    format('----------------------------------------~n'),
    format('Quantidade no Comprada:    | ~w~n', [Quantidade_Carrinho]),
    format('----------------------------------------~n'),
	NovaQuantidade is Quantidade - Quantidade_Carrinho,
	(NovaQuantidade > 0 -> NovaDisponibilidade = true; NovaDisponibilidade = false),
	atualizar_produto(Codigo, NovaDisponibilidade, Nome, Categoria, PrecoCompra, PrecoVenda, NovaQuantidade, Fabricacao, Validade),
    remover_carrinho(CPF, Codigo),
    fail.

% ===================================================================================================================
% Persistência de Dados
% ===================================================================================================================

:- use_module(library(csv)).

% Predicado para ler os dados do arquivo CSV de produtos
ler_produtos_csv(NomeArquivoProdutos) :-
    (   csv_read_file(NomeArquivoProdutos, ProdutoRows, [])
    ->  processar_linhas(ProdutoRows, produto)
    ;   writeln('Erro ao ler o arquivo de produtos.')
    ).

% Predicado para ler os dados do arquivo CSV de clientes
ler_clientes_csv(NomeArquivoClientes) :-
    (   csv_read_file(NomeArquivoClientes, ClienteRows, [])
    ->  processar_linhas(ClienteRows, cliente)
    ;   writeln('Erro ao ler o arquivo de clientes.')
    ).

% Predicado para inicializar o contador de código
ler_codigo_csv(NomeArquivo) :-
    (   csv_read_file(NomeArquivo, [row(Valor)], [])
    ->  asserta(contador_codigo(Valor))
    ;   writeln('Erro ao ler o arquivo de codigo.')
    ).

% Predicado para ler os dados do arquivo CSV de carrinhos
ler_carrinhos_csv(NomeArquivoCarrinhos) :-
    (   csv_read_file(NomeArquivoCarrinhos, CarrinhoRows, [])
    ->  processar_linhas(CarrinhoRows, carrinho)
    ;   writeln('Erro ao ler o arquivo de carrinhos.')
    ).

% Predicado para ler as categorias de produtos do arquivo CSV
ler_categorias_csv(NomeArquivoCategorias) :-
    (   csv_read_file(NomeArquivoCategorias, CategoriaRows, [])
    ->  processar_linhas(CategoriaRows, categoria)
    ;   writeln('Erro ao ler o arquivo de categorias.')
    ).

% Predicado para ler as avaliacoes de produtos do arquivo CSV
ler_avaliacoes_csv(NomeArquivoAvaliacoes) :-
    (   csv_read_file(NomeArquivoAvaliacoes, AvaliacaoRows, [])
    ->  processar_linhas(AvaliacaoRows, avaliacao)
    ;   writeln('Erro ao ler o arquivo de avaliacoes.')
    ).

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

% Predicado para salvar o valor do contador em um arquivo CSV
gravar_codigo_csv(NomeArquivo) :-
    contador_codigo(Valor),
    csv_write_file(NomeArquivo, [row(Valor)]).

% Predicado para salvar os carrinhos de compra em um arquivo CSV
gravar_carrinhos_csv(NomeArquivo) :-
    findall(row(CPF, Codigo, Quantidade_Carrinho),
        carrinho(CPF, Codigo, Quantidade_Carrinho), CarrinhoRows),
    csv_write_file(NomeArquivo, CarrinhoRows).

% Predicado para salvar as categorias de produto em um arquivo CSV
gravar_categorias_csv(NomeArquivo) :-
    findall(row(Categoria),
        categoria(Categoria), CategoriaRows),
    csv_write_file(NomeArquivo, CategoriaRows).

% Predicado para salvar as avaliacoes de produto em um arquivo CSV
gravar_avaliacoes_csv(NomeArquivo) :-
    findall(row(CPF,CodigoProduto,TextAvaliacao,NotaAvaliacao),
        avaliacao(CPF,CodigoProduto,TextAvaliacao,NotaAvaliacao), AvaliacaoRows),
    csv_write_file(NomeArquivo, AvaliacaoRows).

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

% Predicado para processar uma linha de clientes e criar predicados
processar_linha(Row, cliente) :-
    Row = row(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha),
    assertz(cliente(NomeCompleto, Sexo, DataNascimento, CPF, Email, Telefone, NomeUsuario, Senha)).

% Predicado para processar uma linha de carrinhos e criar predicados
processar_linha(Row, carrinho) :-
    Row = row(CPF, Codigo, Quantidade_Carrinho),
    assertz(carrinho(CPF, Codigo, Quantidade_Carrinho)).

% Predicado para processar uma linha de categorias e criar predicados
processar_linha(Row, categoria) :-
    Row = row(Categoria),
    assertz(categoria(Categoria)).

% Predicado para processar linha de avaliacao e criar predicados
processar_linha(Row, avaliacao) :-
    Row = row(CPF,CodigoProduto,TextAvaliacao,NotaAvaliacao),
    assertz(avaliacao(CPF,CodigoProduto,TextAvaliacao,NotaAvaliacao)).


% ===================================================================================================================
% Dashboard
% ===================================================================================================================

% Função para calcular a quantidade total de produtos em estoque
quantidade_total_estoque(Total) :-
    findall(Quantidade, produto(_, _, _, _, _, _, Quantidade, _, _), Quantidades),
    sum_list(Quantidades, Total).

% Função para listar produtos com estoque baixo (estoque < 10)
produtos_com_estoque_baixo(Produtos) :-
    findall(Nome, (produto(_, _, Nome, _, _, _, Quantidade, _, _), Quantidade < 10), Produtos).

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
    findall([Quantidade, Nome], (produto(_, _, Nome, _, _, _, Quantidade, _, _)), ListaProdutos),
    sort(2, @>=, ListaProdutos, ListaOrdenada),
    take(5, ListaOrdenada, Produtos).

% Helper: Função para pegar os N primeiros itens de uma lista
take(0, _, []).
take(_, [], []).
take(N, [H|T], [H|Result]) :-
    N > 0,
    N1 is N-1,
    take(N1, T, Result).

% Função para calcular os clientes mais ativos
clientes_mais_ativos(Clientes) :-
    findall([Len, Nome], (cliente(Nome, _, _, _, _, _, _, _), historico_compras(Nome, Historico), length(Historico, Len)), ListaClientes),
    sort(2, @>=, ListaClientes, ListaOrdenada),
    take(5, ListaOrdenada, Clientes).

% Função para calcular a media de compras por cliente
media_compras_por_cliente(Media) :-
    findall(Compras, (cliente(_, _, _, _, _, _, _, _), historico_compras(_, Historico), length(Historico, Compras)), ListaCompras),
    length(ListaCompras, TotalClientes),
    sum_list(ListaCompras, TotalCompras),
    (TotalClientes = 0 -> Media is 0; Media is TotalCompras / TotalClientes).

% Função para obter o histórico de compras de um cliente
historico_compras(Cliente, Historico) :-
    findall(Produto, carrinho(Cliente, Produto, _), Historico).
