### User Story - Cadastro de clientes

BDD (Behavior Driven Development)

> Sendo um visitante que deseja contratar serviços de TI (ATOR)
> Posso fazer o meu cadastro (FUNCIONALIDADE QUE VAI SER DESENVOLVIDA)
> Para que eu possa buscar por prestadores de serviços (Geeks) (VALOR DE NEGÓCIO AGREGADO)

##### Cenário: Cadastro de clientes

Dado que acesso a página de cadastro (pré condição)
Quando faço o meu cadastro com o nome completo, e-mail e senha (ação)
Então vejo a mensagem de boas vindas: (resultado)
     "Agora você faz parte da Getgeeks. Tenha uma ótima experiência."

##### Cenário: E-mail duplicado

Dado que acesso a página de cadastro
Porem o meu e-mail já foi cadastrado
Quando faço o meu cadastro com o nome completo, e-mail e senha
Então vejo a mensagem de alerta:
    "Oops! Já temos um usuário com o e-mail informado."

##### Cenário: Email com formato incorreto

Dado que acesso a página de cadastro
Quando faço o meu cadastro com um email incorreto
Então vejo a mensagem de alerta "O email está estranho"

##### Cenário: Campos obrigatórios

Dado que acesso a página de cadastro
Quando submeto o cadastro sem preencher o formulário
Então devo ver uma mensagem informando que todos os campos são obrigatórios

##### Cenário: Senha muito curta

Dado que acesso a página de cadastro
Quando submeto o cadastro com uma senha com menos de 6 dígitos
Então vejo a mensagem de alerta "Informe uma senha com pelo menos 6 caracteres"

> o BDD deve ser escrito em primeira pessoa (EU), junto com o analista.
> no momento do planejamento, escrita dos critérios de aceite, a automação não é o meu foco.
> utilizar o método PascalCase, onde a primeira letra de cada palavra é maiuscula e é tudo junto
    > para definir nome de arquivos
> camelCase, onde começa com minuscula e todas as outras iniciais começam com maiuscula;
> snake_case, onde cada palavra é separada por underline
> CTRL + Alt + F = identa tudo automaticamente;
> 4:22