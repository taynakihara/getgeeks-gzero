*** Settings ***
Documentation            Suite de testes para tentativas de ser um Geek - Attempt Be a Geek

Resource            ${EXECDIR}/resources/Base.robot

Test Setup            Start Session For Attempt Be a Geek

*** Variables ***
${long_desc}        Mojibake pode acontecer mesmo sem transferir informação de um computador para outro pois programas diferentes podem estar configurados para usar sistemas de codificação diferentes. As imagens a seguir mostram um problema comum nos laboratórios: um ambiente.

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