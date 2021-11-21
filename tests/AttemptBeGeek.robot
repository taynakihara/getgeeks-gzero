*** Settings ***
Documentation            Suite de testes para tentativas de ser um Geek - Attempt Be a Geek

Resource            ${EXECDIR}/resources/Base.robot

Test Setup            Start Session For Attempt Be a Geek

*** Variables ***
${long_desc}        Mojibake pode acontecer mesmo sem transferir informação de um computador para outro pois programas diferentes podem estar configurados para usar sistemas de codificação diferentes. As imagens a seguir mostram um problema comum nos laboratórios: um ambiente.

*** Test Cases ***
Required Fill Be a Geek
    [Tags]            reqf_geek
    [Template]        Attempt Be a Geek

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

    Fill Geek Form              ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be        ${output_message}

    Take Screenshot            fullPage=True

Start Session For Attempt Be a Geek
    ${user}        Factory User        attempt_be_geek

    Start Session
    Do Login                    ${user}
    Go To Geek Form