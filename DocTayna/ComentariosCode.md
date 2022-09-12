                            Comentários que foram feitos no próprio código para facilitar meu aprendizado.
                            SÃO CITADAS SOMENTES AS PARTES QUE CONTÉM COMENTÁRIOS


# ARQUIVOS DA PASTA RESOURCES/ACTIONS:

# _SharedActions.robot: Aqui estão todas as KW que podem ser COMPARTILHADAS em mais de um cenário de teste:
*** Alerts Spans Should Be ***
    [Arguments]            ${expected_alerts}

    @{got_alerts}       Create List

    ${spans}            Get Elements        xpath=//span[@class="error"]    # essa KW pode encontrar mais de um elemento com o mesmo nome
    #Nesse caso, a KW Get Elements pega os 4 elementos e armazena na lista ${spans}.
    #Quando chamo a KW Get Elements, o robot traz o elemento dessa lista e eu quero o texto, por isso chamo a KW Get Text no FOR.
    #Não colocamos @ para spans pois essa KW (Get Elements) já faz, internamente, a tipagem e devolve a lista para variável.

    FOR    ${span}    IN     @{spans}    #comando: quero que o robot pegue um span por vez, em (IN) uma lista (pega na lista ${spans})

        ${text}                Get Text            ${span}    #Traz o texto de cada elemento. Pego o texto de cada elemento e armazeno na #variável ${text}
        Append To List         ${got_alerts}       ${text}    #Adiciona na lista ${got_alerts} o texto que o Get Text vai pegar de elemento por #elemento

    END

    Lists Should Be Equal        ${expected_alerts}        ${got_alerts}    #IMPORTAR A LIBRARY COLLECTIONS para utilizar essa KW.
    #comparo uma lista com a outra para saber se todos esses textos estão corretos.

# LoginActions.robot: Aqui contém as ações da funcionalidade de Login:
*** Should Be Type Email ***
    Get Property        ${INPUT_EMAIL}        type        equal        email        #me da a propriedade do id=email onde o tipo é igual email

-----------------------------------------------------------------------------------------------------------------------------------------------

# ARQUIVOS DA PASTA RESOURCES/FACTORIES:

# Base.robot: Este é o arquivo BASE do projeto de testes:
#organizar por ordem alfabética e por tipos de importação de bibliotecas;


# Database.robot: Aqui contém os dados necessários para comunicação com a nosso BD:
Library            DatabaseLibrary
Library            factories/Users.py

*** Keywords ***
*** Connect To Postgres ***
    Connect To Database        psycopg2
    ...                        kwnxsbsr    #usuario do BD
    ...                        kwnxsbsr    #Database
    ...                        HNf0zinAGu56jDwxFutIsyF2Y3PMTYOy    #senha do BD
    ...                        fanny.db.elephantsql.com        #endereço do servidor do BD
    ...                        5432        #porta padrão do postgresql

*** Reset Database ***
    Execute SQL String        DELETE from public.geeks;    #deleta a tabela de geeks
    Execute SQL String        DELETE from public.users;    #deleta a tabela de usuários criados durante os testes

*** Insert User ***
    [Arguments]        ${u}

    ${hashed_pass}            Get Hashed Pass    ${u}[password]    #guardamos a senha sem criptografia na variável hashed_pass, que é a senha criptografada
#dessa forma, antes de montar a query para inserir o usuário no BD, tenho um método que criptografa essa senha;
#em seguida insiro essa variável (${hashed_pass}) no insert após o email, conforme query abaixo:
    ${q}        Set Variable        INSERT INTO public.users (name, email, password_hash, is_geek) values ('${u}[name] ${u}[lastname]', '${u}[email]', '${hashed_pass}', false)

    Execute SQL String      ${q}
#para cadastrar um usuário direto no BD, é preciso que a senha seja criptografada;

*** Users Seed ***    #semear uma massa de teste
    ${user}        Factory User Login
    Insert User    ${user}

-----------------------------------------------------------------------------------------------------------------------------------------------

# ARQUIVOS DA PASTA TESTS:

# Login.robot: Aqui contém a execução dos testes de Login:
Resource        ${EXECDIR}/resources/Base.robot

Test Setup           Star Session
Test Teardown        End Session

*** User Login ***
    ${user}                     Factory User Login
    #Add User From Database      ${user} - NÃO PRECISO MAIS DESSA KW, POIS ADICIONEI NO DELOREAN O USERS SEED, que faz o insert do usuário no BD

    Go To Login Page
    Fill Credentials                ${user}
    Submit Credentials
    User Should Be Logged In        ${user}

*** Incorrect Pass ***
    [Tags]         inv_pass

    ${user}        Create Dictionary        email=taynakihara@heroku.com        password=senha123
#a senha está diferente da informada no factory_user_login, em Users.py;
    Go To Login Page
    Fill Credentials    ${user}    #nesse context, essa variável só tem 2 argumentos: email e password;
    Submit Credentials
    Modal Content Should Be        Usuário e/ou senha inválidos.

*** User Not Found ***
    [Tags]         user_404

    ${user}        Create Dictionary        email=taynakihara@404.net        password=tayna123
#a senha está diferente da informada no factory_user_login, em Users.py;
    Go To Login Page
    Fill Credentials    ${user}    #nesse context, essa variável só tem 2 argumentos: email e password;
    Submit Credentials
    Modal Content Should Be        Usuário e/ou senha inválidos.

*** Incorrect Email ***
    [Tags]         inv_email

    ${user}        Create Dictionary        email=taynakihara.com.net        password=tayna123
#a senha está diferente da informada no factory_user_login, em Users.py;
    Go To Login Page
    Fill Credentials    ${user}    #nesse context, essa variável só tem 2 argumentos: email e password;
    Submit Credentials
    Should Be Type Email

-----------------------------------------------------------------------------------------------------------------------------------------------

# Signup.robot: Aqui contém a execução dos testes referentes ao cadastro de usuário:
Resource                ${EXECDIR}/resources/Base.robot

Test Setup           Star Session
Test Teardown        End Session

*** Test Cases ***
*** Register a new user ***

    ${user}        Factory User        #pego a massa de testes...

    Set Suite Variable        ${user}        #deixo ela disponível a nível de SUITE, ou seja, outros casos de testes terão acesso a essa informação
    
    Go To Signup Form                        #a partir daqui faço o testes de cadastro do usuário...
    Fill Signup Form          ${user}
    Submit Signup Form
    User Should Be Registered

-----------------------------------------------------------------------------------------------------------------------------------------------

# ARQUIVOS RUN.SH: FAZEMOS AS ALTERAÇÕES DIRETO NESSE ARQUIVO E DEPOIS EXECUTAMOS ELE NO HYPER. LÁ CONTÉM O QUE SERÁ EXECUTADO.

robot -l NONE -o NONE -r NONE tasks/Delorean.robot      #aqui executa o comando para limpar o BD
robot -d ./logs tests/                                  #aqui define quais testes serão executados - ex: -i reqf para incluir cenários específicos

#extensão "sh" é de arquivos SHELL. Dentro desses arquivos posso simplificar a execução dos testes através de atalhos.

#PARA EXECUTAR, o comando é: chmod +x run.sh
#Esse comando faz com que esse arquivo (run.sh) se torne um executável. Isso é necessário apenas UMA vez.

#Depois é só executar, no hyper: ./run.sh

#OBS: Caso eu não esteja usando o GITBASH, salvar o arquivo com extensão .bat e inserir os comandos com a última barra invertida.
# EXEMPLO: 
#robot -l NONE -o NONE -r NONE tasks/Delorean.robot
#robot -d ./logs tests\Signup.robot

-----------------------------------------------------------------------------------------------------------------------------------------------

# ARQUIVOS DA PASTA FACTORIES/USERS.PY: AQUI CONTÉM NOSSA MASSA DE TESTES, PROGRAMADA EM PYTHON.

from faker import Faker         #aqui importamos os perfis fakers para utilizarmos no cadastro
fake = Faker()

import bcrypt   #importando o bcrypt        #aqui importamos o bcrypt que criptografa a senha para inserir no BD

def get_hashed_pass(password):      #criando um novo método que recebe o argumento PASSWORD (senha que quero criptografar). Aqui ele recebe a senha não criptogrfada
    hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt(8))
    return hashed
#crio uma variável para armazenar todo esse código. Variável "hashed";
#na sequencia, chamo o módulo bcrypt junto do método hashpw, que é o método que criptografa uma senha;
#em seguida passo a senho que quero criptografar "(password)" e acrescento o .encode('utf-8) para não dar ruim no código;
#depois informo o modelo de criptografia "bcrypt.gensalt(8)", onde o 8 é o padrão de criptografia que o dev usou no bcrypt para o nodejs javascript
#por último, no return, retornamos a senha criptografada

-----------------------------------------------------------------------------------------------------------------------------------------------

# ESSA É TODA MASSA DE DADOS UTILIZADAS NOS TESTES. DO ARQUIVO USERS.PY, QUE AGORA FOI SUBSTITUÍDA PELA def factory_user (target). ONDE FIZEMOS UMA REFATORAÇÃO NESSA MASSA E ATRIBUÍMOS CADA ARGUMENTO EM TODOS AS SUITES DE TESTES.

def factory_user():
    return {
        'name': fake.first_name(),
        'lastname': fake.last_name(),
        'email': fake.free_email(),
        'password': 'tayna123',
    }

def factory_wrong_email():

    first_name = fake.first_name()

    return {
        'name':first_name,
        'lastname': fake.last_name(),
        'email': first_name.lower() + '&gmail.com',
        'password': 'tayna123'
    }

def factory_user_login():
    return {
        'name':'Tayna',
        'lastname':'Kihara',
        'email': 'taynakihara@heroku.com',
        'password': 'tayna123'
    }
    
def factory_user_be_geek():
    return {
        'name': 'Kim',
        'lastname': 'Dotcom',
        'email': 'kim@dotcom.com',
        'password': 'pwd123',
        'geek_profile': {
            'whatsapp': '18981555555',
            'desc': 'Seu pc está lento? Posso resolver isso pra você. Seja formatando a máquina, reinstalando o sistema operacional Windows ou Linux, realizando a troca de algum hardware ou até mesmo eliminando malwares que estão afetando o desempenho do seu PC!',
            'printer_repair': 'Sim',
            'work': 'Remoto',
            'cost': '100'
        }
    }

-----------------------------------------------------------------------------------------------------------------------------------------------

# ESSA MASSA DE TESTE EXECUTA UM LOGIN PARA CADA CENÁRIO, OU SEJA, SE TIVER 5 CENÁRIOS DE PREENCHIMENTO DE CAMPOS NA MESMA TELA, O TESTE FARÁ LOGIN 5 VEZES. UMA PARA CADA CENÁRIO. ISSO FOI REFATORADO POSTERIORMENTE.

# CENÁRIO DE TESTE BeGeek.robot:

Short Description       #descrição curta
    [Tags]        short_desc

    ${user}        Factory User        short_desc

    Do Login              ${user}
    Go To Geek Form
    Fill Geek Form        ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be    A descrição deve ter no minimo 80 caracteres

Long Description        #descrição longa
    [Tags]        long_desc

    ${user}        Factory User        long_desc

    Do Login              ${user}
    Go To Geek Form
    Fill Geek Form        ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be    A descrição deve ter no máximo 255 caracteres

Empty Description       #campo descrição vazio
    [Tags]        empty_desc
    
    ${user}        Factory User        empty_desc

    Do Login                ${user}
    Go To Geek Form
    Fill Geek Form          ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be    Informe a descrição do seu trabalho

Empty WhatsApp          #campo whatsApp vazio
    [Tags]        empty_whats
    
    ${user}        Factory User        empty_whats

    Do Login                ${user}
    Go To Geek Form
    Fill Geek Form          ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be    O WhatsApp deve ter 11 digitos contando com o DDD

-----------------------------------------------------------------------------------------------------------------------------------------------

# COMENTÁRIOS IMPORTANTES REFERENTES AO CENÁRIO AttemptBeGeek:
# TRABALHANDO COM TEMPLATE, FAZENDO LOGIN APENAS UMA VEZ E EXECUTANDO VÁRIAS TENTATIVAS DE SE TORNAR UM GEEK.

*** Test Cases ***
Required Fill Be a Geek
    [Tags]            reqf_geek
    [Template]        Attempt Be a Geek        #faço o login apenas 1x e executo todos os cenários abaixo:

    whatsapp            ${EMPTY}                O Whatsapp deve ter 11 digitos contando com o DDD
    whatsapp            18                      O Whatsapp deve ter 11 digitos contando com o DDD
    whatsapp            999999999               O Whatsapp deve ter 11 digitos contando com o DDD
    desc                ${EMPTY}                Informe a descrição do seu trabalho
    desc                Formato seu PC!         A descrição deve ter no minimo 80 caracteres
    desc                ${long_desc}            A descrição deve ter no máximo 255 caracteres
    cost                abcde                   Valor hora deve ser numérico
    cost                1f2r3                   Valor hora deve ser numérico
    cost                */$%^                   Valor hora deve ser numérico
    cost                ${EMPTY}                Valor hora deve ser numérico

*** Keywords ***
Attempt Be a Geek
    [Arguments]        ${fields_dictionary}        ${input_field}        ${output_message}
    ${user}            Factory User        attempt_be_geek

    Set To Dictionary           ${user}[geek_profile]        ${fields_dictionary}        ${input_field}
    #essa KW seta o valor em um determinado dicionário, ou seja, vou mexer no dicionário geek_profile
    #vou alterar o campo (${field}) com o valor que vou passar no argumento ${input_field}
    #e a mensagem esperada, vou receber no argumento ${output_message}, na KW Alert Span Should Be

    Fill Geek Form              ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be        ${output_message}

    Take Screenshot            fullPage=True    #colocando essa KW aqui, o robot tira um print no final de cada um desses cenários de tentativa
    #dessa forma, eu não preciso mais do gancho "Test Teardown End Session", onde executa apenas a ação de tirar o print

Start Session For Attempt Be a Geek    #utilizar essa KW no gancho Test Setup, iniciando uma sessão para tentativa de se tornar um geek
    ${user}        Factory User        attempt_be_geek

    Start Session                #abre uma sessão do navegador
    Do Login                    ${user}
    Go To Geek Form

----------------------------------------------------------------------------------------------------------------------------------------------

# APÓS REFATORAÇÃO NO CÓDIGO. TESTE: AttemptBeGeek:
# INVÉS DE EXECUTAR APENAS 1 ÚNICO TESTE, ATRIBUIMOS NOMES AOS CENÁRIOS EXECUTADOS E NO RELATÓRIO PASSA A CONSTAR QUE 10 CASOS DE TESTES FORAM EXECUTADOS;
# PARA ABRIR O NAVEGADOR APENAS UMA VEZ, ATRIBUÍMOS "SUITE SETUP" INVÉS DE "TEST SETUP";


Resource            ${EXECDIR}/resources/Base.robot

Suite Setup            Start Session For Attempt Be a Geek          #abre o navegador apenas uma única vez
Test Template          Attempt Be a Geek                            #cada teste dentro do template é contabilizado

*** Variables ***
${long_desc}        Mojibake pode acontecer mesmo sem transferir informação de um computador para outro pois programas diferentes podem estar configurados para usar sistemas de codificação diferentes. As imagens a seguir mostram um problema comum nos laboratórios: um ambiente.

*** Test Cases ***
Whatsapp vazio                whatsapp            ${EMPTY}                O Whatsapp deve ter 11 digitos contando com o DDD
Whatsapp somente DDD          whatsapp            18                      O Whatsapp deve ter 11 digitos contando com o DDD
Whatsapp sem DDD              whatsapp            999999999               O Whatsapp deve ter 11 digitos contando com o DDD
Desc vazia                    desc                ${EMPTY}                Informe a descrição do seu trabalho
Desc curta                    desc                Formato seu PC!         A descrição deve ter no minimo 80 caracteres
Desc longa                    desc                ${long_desc}            A descrição deve ter no máximo 255 caracteres
Valor hora com letras         cost                abcde                   Valor hora deve ser numérico
Valor hora alfanumerico       cost                1f2r3                   Valor hora deve ser numérico
Valor hora chars especiais    cost                */$%^                   Valor hora deve ser numérico
Valor hora vazio              cost                ${EMPTY}                Valor hora deve ser numérico

# FORAM ATRIBUÍDOS NOMES PARA CADA CENÁRIO EXECUTADO DENTRO DO TEMPLATE.

-----------------------------------------------------------------------------------------------------------------------------------------------

# KW "Fill Geek Form", SE ENCONTRA NO ARQUIVO "BeGeekActions.robot".
# VÍDEO "26. TRABALHANDO COM IFs". MOSTRANDO A UTILIZAÇÃO DE IFs DENTRO DE ALGUNS CENÁRIOS ESPECÍFICOS:

Fill Geek Form
    [Arguments]        ${geek_profile}

    Reset Geek Form

    Fill Text            id=whatsapp        ${geek_profile}[whatsapp]
    Fill Text            id=desc            ${geek_profile}[desc]

    IF        '${geek_profile}[printer_repair]'    #se existir um valor nessa condiçao, ai eu executo o Select Options By
        Select Options By        id=printer_repair        text        ${geek_profile}[printer_repair]
    END        #caso não exista, eu pulo essa etapa/step;
    #Assim meu teste só seleciona uma das opções se estiverem com valores, de fato, válidos. Se estiver vazio (EMPTY), não seleciona nada.

    IF         '${geek_profile}[work]'            #mesmo comportamento do IF anterior, do cenário printer_repair
        Select Options By        id=work                  text        ${geek_profile}[work]
    END

    Fill Text            id=cost            ${geek_profile}[cost]

-----------------------------------------------------------------------------------------------------------------------------------------------

# ARQUIVO Base.robot:

    Set Viewport Size          1280    768        #define em qual resolução o navegador será executado

-----------------------------------------------------------------------------------------------------------------------------------------------

# ARQUIVO Base.robot:

End Session
    ${shot_name}            Screenshot Name
    Take Screenshot         fullPage=True        filename=${shot_name}

> implementação na KW End Session, para capturar screenshots em testes executados com o pabot.

-----------------------------------------------------------------------------------------------------------------------------------------------

# ARQUIVO backend/users/tests/Sessions.robot
# TESTES DE API

User Session
    ${payload}        Create Dictionary        email=tay@getgeeks.com        password=tayna123
    ${headers}        Create Dictionary        Content-Type=aplication/json

# Posso deixar sem o dicionário headers, e passar apenas json=${payload}, invés de data=${payload}, pois a biblioteca Requests tem um argumento chamado json que faz a conversão da informação diretamente para json. Com isso posso apagar headers=${headers}.

    ${response}        POST        ${API_USERS}/Sessions        data=${payload}*       headers=${headers}*
#o 1º argumento é a rota para onde deve ser enviada a requisição;
#o 2º argumento é a massa de teste (payload)
#o 3º argumento é o cabeçalho, que é ${headers}. No thunder client pego de "headers" o content-type
#Faço uma requisição e guardo esse resultado na variável ${response}.

    Status Should Be        200        ${response}        #Keyword da biblioteca Requests
#Valida se o Status code é 200 para a requisição que foi armazenada na ${response}

# CONTINUAÇÃO:
    Status Should Be        200        ${response}

    ${size}        Get Length        ${response.json()}[token]    #conta quantos caracteres contém no [token]
#criei a variável ${size} e mandei um get lenght para fazer essa contagem.

    ${expected_size}        Convert To Integer        140
#como o esperado é uma string e o retornado é um número inteiro, fazemos essa conversão
    Should Be Equal        ${expected_size}                   ${size}
#140 deve ser o tamanho do token retornado na requisição;

    Should Be Equal        10d                   ${response.json()}[expires_in]
#espero esse valor (10d) na resposta do json que é retornada no campo "expires_in"
#pego o nome desse campo no thunder client;

    Log To Console        ${size} --- apagar essa linha de código para pegar o log.
#colocar um log para pegar o json que ele retorna e entre colchetes o campo que quero pegar
#depois de pegar o log, pode tirar esse comando.


# COMO FICOU DEPOIS DE REFATORADO, ACRESCENTANDO O CENÁRIO INCORRECT PASS:

User Session
    ${payload}        Create Dictionary        email=tay@getgeeks.com        password=tayna123
    
    ${response}        POST        ${API_USERS}/sessions        json=${payload}        expected_status=any

    Status Should Be       200                        ${response}

    ${size}                Get Length                 ${response.json()}[token]
    ${expected_size}        Convert To Integer        140

    Should Be Equal        ${expected_size}           ${size}
    Should Be Equal        10d                        ${response.json()}[expires_in]

Incorrect Pass
    ${payload}        Create Dictionary        email=tay@getgeeks.com        password=tayna321
    
    ${response}        POST        ${API_USERS}/sessions        json=${payload}        expected_status=any  
#para a library RequestsLibrary, por padrão, se o status retornado for diferente de 200, o teste vai falhar. Adicionando esse argumento (expected_message=any), o robot ignora o erro, deixando de retornar FALHA nos testes.

    Status Should Be       401                         ${response}
    Should Be Equal        Unauthorized                ${response.json()}[error]

# TODOS OS CENÁRIOS DE TENTATIVAS DE LOGIN, TESTANDO APIs:

# User session
    ${payload}        Create Dictionary        email=tay@getgeeks.com        password=tayna123
    
    ${response}        POST Session    ${payload}

    Status Should Be       200                        ${response}

    ${size}                Get Length                 ${response.json()}[token]
    ${expected_size}       Convert To Integer         140

    Should Be Equal        ${expected_size}           ${size}
    Should Be Equal        10d                        ${response.json()}[expires_in]

# Incorrect pass
    ${payload}        Create Dictionary        email=tay@getgeeks.com        password=tayna321
    
    ${response}        POST Session    ${payload}

    Status Should Be       401                         ${response}
    Should Be Equal        Unauthorized                ${response.json()}[error]

# User not found
    ${payload}        Create Dictionary        email=tay@404.com        password=tayna321
   
    ${response}        POST Session    ${payload}

    Status Should Be       401                         ${response}
    Should Be Equal        Unauthorized                ${response.json()}[error]

# Incorrect email
    ${payload}        Create Dictionary        email=tay.com.br        password=tayna321
    
    ${response}        POST Session    ${payload}

    Status Should Be       400                         ${response}
    Should Be Equal        Incorrect email             ${response.json()}[error]

# Empty email
    ${payload}        Create Dictionary        email=${EMPTY}        password=tayna321
    
    ${response}        POST Session    ${payload}

    Status Should Be       400                         ${response}
    Should Be Equal        Required email              ${response.json()}[error]

# Without email
    ${payload}        Create Dictionary                password=tayna321
    
    ${response}        POST Session    ${payload}

    Status Should Be       400                         ${response}
    Should Be Equal        Required email              ${response.json()}[error]

# Empty pass
    ${payload}        Create Dictionary        email=tay@getgeeks.com        password=${EMPTY}
    
    ${response}        POST Session    ${payload}

    Status Should Be       400                         ${response}
    Should Be Equal        Required pass               ${response.json()}[error]

# Without pass
    ${payload}        Create Dictionary         email=tay@getgeeks.com
    
    ${response}        POST Session    ${payload}

    Status Should Be       400                         ${response}
    Should Be Equal        Required pass               ${response.json()}[error]

----------------------------------------------------------------------------------------------------------------------------------------------
# CENÁRIOS DE TENTATIVA DE SER TORNAR UM GEEK (BeGeek), QUE FORAM SUBSTITUÍDOS POR UM TEMPLATE NA SUITE AttemptBeGeek.robot:

# Short Description
    [Tags]        short_desc

    ${user}        Factory User        short_desc

    Do Login              ${user}
    Go To Geek Form
    Fill Geek Form        ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be        A descrição deve ter no minimo 80 caracteres

# Long Description
    [Tags]        long_desc

    ${user}        Factory User        long_desc

    Do Login              ${user}
    Go To Geek Form
    Fill Geek Form        ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be        A descrição deve ter no máximo 255 caracteres

# Empty Description
    [Tags]        empty_desc

    ${user}        Factory User        empty_desc

    Do Login              ${user}
    Go To Geek Form
    Fill Geek Form        ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be    Informe a descrição do seu trabalho


# Empty Whats
    [Tags]        empty_whats

    ${user}        Factory User        empty_whats

    Do Login              ${user}
    Go To Geek Form
    Fill Geek Form        ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be        O Whatsapp deve ter 11 digitos contando com o DDD

----------------------------------------------------------------------------------------------------------------------------------------------