*** Settings ***
Documentation        Arquivo Temporário - EXPLICAÇÃO DO FOR

Library        Collections    #importar biblioteca para poder utilizar a KW "Append To List"

*** Test Cases ***
Trabalhando com Listas

    @{avengers}        Create List        Tony Stark        Kamalakhan        Steve Rogers

    Append To List    ${avengers}        Hulk
    Append To List    ${avengers}        Bruce Banner
    #Essa KW adiciona os itens informados, dentro da minha lista

    FOR     ${a}    IN    @{avengers}        #pega minha lista de vingadores, percorre um a um e adiciona essas na variável ${a}, até acabar todos os itens da minha lista

        Log To Console        ${a}            #pede pra imprimir o valor de ${a}. Onde agora se encontram todos os itens da lista. E toda vez que eu adicionar um item na lista, ele já imprime em tela essa lista com esse novo item.

    END

    @{avengers2}        Create List        Tony Stark    Miss Marvel    Steve Rogers    Hulk    Scot Lang

    Lists Should Be Equal        ${avengers}        ${avengers2}    #faço a comparação da lista ${avengers} com a lista ${avengers2}

    #IMPORTANTE: Só ultilizo @ para criar uma lista ou para percorrer através do loop do FOR.

#    Log To Console    ${avengers}    #essa KW imprime no terminal o valor de um item da lista. Ou seja, vai imprimir os nomes acima no terminal
    #Sempre que eu tenho um conjunto de dados separados por vírgula, dentro de colchetes, indica que é uma lista
    #no terminal é só executar robot -d ./logs tests/Temp.robot (normal).
    #Para imprimir um valor específico, colocar a posição que esse item se encontra, entre colchetes: ${avengers}[1]
    #Para imprimir mais de um valor, separadamente, colocar: 
        # Log To Console    ${avengers}[0]
        # Log To Console    ${avengers}[1]
        # Log To Console    ${avengers}[2]
        #E por ai vai. Sempre o primeiro inicia-se pela posição ZERO.
    
