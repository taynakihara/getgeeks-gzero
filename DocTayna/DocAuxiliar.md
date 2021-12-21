# VERSIONANDO CÓDIGO NO GIT SUBINDO(PUSH) NO GITHUB:

>> PASSO A PASSO:
# git status
vai exibir o que e onde foram realizadas alterações;

# git add .
vai adicionar todas essas alterações para que seja feito o commit. Estas aparecerão em vermelho.

# git status
dar um git status para verificar se foram adicionadas. Estas aparecerão em verde.

# git commit -m "Informar um nome para o commit (ex: o que foi alterado no código)"
realiza o commit das alterações

# git push -u origin main
sobe as alterações commitadas para o github

---------------------------------------------------------------------------------------------------------------------------------------------

# PARA EXECUTAR OS TESTES COM O PABOT E SALVAR OS SCREENSHOTS CORRETAMENTE. AJUSTES DE ESTRUTURA DE ARQUIVOS/PROCESSOS/TAREFAS.

# 1. COMANDO PARA DELETAR UM ARQUIVO/PASTA:
No prompt de comando digitar: rm -rf ./logs/browser
> Esse comando apaga a pasta BROWSER que vai estar dentro da pasta LOGS; Para garantir que não terei resquícios de execuções anteriores;
NOTA: Sem o pabot, o robot resolve isso naturalmente, porém, quando fazemos na mão, é importante deletar antes de começar a reestruturar as evidências.

# 2. COMANDO PARA CRIAR UMA PASTA BROWSER DENTRO DA PASTA LOGS, NOVAMENTE:
No prompt digitar: mkdir ./logs/browser

# 3. COMANDO PARA CRIAR A PASTA DE SCREENSHOT DENTRO DA PASTA BROWSER:
No prompt digitar: mkdir ./logs/browser/screenshot

# 4. COPIAR CADA UM DESSES COMANDOS, NESSA ORDEM, E COLAR NO RUN.SH.

# 5. COMANDO PARA BUSCAR OS SCREENSHOTS DENTRO DA PASTA "SCREENSHOT" - NÃO COPIAR ESSE COMANDO PARA O RUN.SH:
No prompt digitar: find ./logs/pabot_results -type f -name "*.png"
> Ou seja, "busque (find) pra mim, dentro de ./logs/pabot_results todos os arquivos que têm a extensão .png", independente da quantidade de imagens e das pastas;

# 6. COMANDO PARA COPIAR TODO CONTEÚDO QUE VIRÁ NA LISTA DE EVIDÊNCIAS, APÓS BUSCAR POR TODOS OS ARQUIVOS .png, COM SEU CAMINHO COMPLETO:
No prompt digitar: cp $(find ./logs/pabot_results -type f -name "*.png") ./logs/browser/screenshot
> Faço a cópia desses arquivos para a pasta ./logs/browser/screenshot, automaticamente.
# COPIAR MAIS ESSE COMANDO PARA O RUN.SH
Esses comandos, em ordem, fazem com que as evidências sejam reorganizadas na estrutura padrão para que o relatório do robot consiga exibir as imagens. PORÉM, na exibição do relatório, ele se confunde no momento da atribuição de cada imagem ao seu devido cenário executado.

# 7. FAZER O SEGUINTE PASSO A PASSO:
    1- Criar, dentro de resources, um arquivo com nome "Utils.py";
    2- Importar o "faker" para dentro desse arquivo;
    3- Definir um método, dentro de "Utils.py" (verificar direto no arquivo o código inserido);
    4- o método "sha1", gera um hash alfanumérico, e usamos esse recurso para dar um nome para os screenshots;
    5- No "Base.robot", importar essa biblioteca: Library       Utils.py    #Não precisa do ${EXECDIR}, porque estão na mesma estrutura.
    6- Alterar a KW que contém o Take Schreenshot:

    End Session
        ${shot_name}            Screenshot Name
        Take Screenshot         fullPage=True        filename=${shot_name}

---------------------------------------------------------------------------------------------------------------------------------------------

# SOBRE A CRIAÇÃO DO ARQUIVO README PARA DOCUMENTAR O CÓDIGO:

#Seria um plus adicionar um readme com informações sobre o proposito do projeto, setup, como executar, etc 

#Complementaria o readme com informações sobre o setup do projeto e informações sobre como executá-lo

#Seria um plus adicionar um readme no projeto contendo informações sobre seu propósito, setup, informações para executar o projeto, etc

#Adicionaria um readme contendo infos sobre o projeto como: Proposito, Setup, informações sobre a execução, cenários cobertos, etc

#Seria um plus se o readme fosse incrementado com informações de: Propósito do projeto, Dependencias necessarias para rodar os testes e como instalá-las, Instruções gerais de execução (Adicionando a informação de que os testes podem ser executados via .bat ou .sh, por exemplo)
- Dependencias do projeto(Libs, coisas que precisamos instalar pra executar o projeto na maquina)

---------------------------------------------------------------------------------------------------------------------------------------------
# SMOKE TEST - TESTE DE FUMAÇA.

É o conceito de: o primeiro teste a ser executado, se este falhar, nem executa/cria os próximos cenários.
Testes de fumaça são importantes para garantir a continuidade do negócio, garantir que a empresa funcione.
** A GRANDE SACADA DOS TESTES DE FUMAÇA É GANHAR TEMPO NA EXECUÇÃO. OU SEJA, EXECUTOU ESSES TESTES, E NÃO "SAIU FUMAÇA", CONTINUA COM OS PRÓXIMOS TESTES.
O sinal de fumaça tem que acontecer no teste principal para que assim eu possa executar os próximos cenários.

# EXEMPLO: 
1- em Signup.robot tem um smoke test, que seria "Register a new user". Ou seja, se não conseguir executar este cenário, não consigo logar na pltaforma, não consigo me tornar um prestador de serviços, etc.

# IMPORTANTE:
É importante identificar quais são os cenários de "fumaça" e executá-los primeiro. Dessa forma, se estes falharem, já reportamos o bug para o dev e nem executamos os cenários posteriores. Após a correção do dev, executar novamente os cenários "smoke", e se dessa vez estiver tudo OK, seguir com os próximos testes. IMPORTANTE PARA O PROCESSO NO DIA A DIA.

---------------------------------------------------------------------------------------------------------------------------------------------

# VÍDEO "25. RESETANDO O FORMULÁRIO HTML" - MÓDULO PRO.
# Isso faz com que eu resete o formulário apagando tudo que está escrito naquele momento:

- Acessar a página da getgeeks e preencher o formulário, sem submeter; - OU QUALQUER OUTRA PÁGINA QUE FOR UTILIZAR;
- Abrir a ferramenta do desenvolvedor (F12);
- Procura pelo nome da classe do formulário (form class="be-geek-form") - QUE É UMA PROPRIEDADE RELEVANTE PARA ENCONTRAR O ELEMENTO;
    - PODEMOS TAMBÉM BUSCAR POR UM OUTRO SELETOR PARA ENCONTRAR O ELEMENTO;
- Copia o nome da classe (be-geek-form);

# 1:
- Na aba Console, executar o comando de JS:
	- document.getElementsByClassName("be-geek-form") + ENTER;
	- nesse caso específico, trouxe o resultado em HTMLCollection (tipo um array), dessa forma ainda não estou tendo acesso direto ao formulário mas sim a coleção de elementos em HTML;
ENTÃO EXECUTAR:
# 2:
- Então executar o mesmo comando acrescentando a posição zero [0]:
	- document.getElementsByClassName("be-geek-form")[0] > ENTER
	- dessa forma ele pega o próprio elemento;
EM SEGUIDA EXECUTAR:
# 3:
- acrescentar ao comando o reset:
	- document.getElementsByClassName("be-geek-form")[0].reset(); > ENTER
    - Isso faz com que ele reset o formulário, ou seja, apaga todo INPUT que já foi feito dentro daquela página;
    - FEITO ISSO, COPIAR O CÓDIGO DE RESET (document.getElementsByClassName("be-geek-form")[0].reset();)
NO VS CODE FAZER O SEGUINTE:
# 4:
- Abrir o arquivo: resources/actions/GeekActions.robot
    - Criar uma nova KW com o nome "Reset Geek Form"
    - Dentro dessa KW, colocar assim:
        - Execute Javascript        document.getElementsByClassName("be-geek-form")[0].reset();
    - O robot consegue executar comandos em JS através dessa KW - Execute Javascript
    - Depois é só colar essa KW (Reset Geek Form) dentro da KW "Fill Geek Form", no início de tudo, antes de preencher qualquer campo;

- ASSIM, O ROBOT VAI RESETAR O FORMULÁRIO SEMPRE QUE FOR EXECUTAR UM NOVO CENÁRIO; TENDO QUE TODOS ESSES TESTES SÃO FEITOS DENTRO DE UMA ÚNICA SESSÃO. OU SEJA, O LOGIN É FEITO APENAS UMA VEZ E VÁRIOS CENÁRIOS SÃO EXECUTADOS SEM PRECISAR LOGAR NOVAMENTE - ÚTIL PARA TESTES DE TEMPLATE;

---------------------------------------------------------------------------------------------------------------------------------------------

