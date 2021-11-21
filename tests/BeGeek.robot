*** Settings ***
Documentation            Suite de testes para funcionalidade Seja um Geek

Resource            ${EXECDIR}/resources/Base.robot

Test Setup            Star Session
Test Teardown         End Session

*** Test Cases ***
Be a Geek
    [Tags]        be_geek

    ${user}        Factory User        be_geek

    Do Login            ${user}
    Go To Geek Form
    Fill Geek Form      ${user}[geek_profile]
    Submit Geek Form
    Geek Form Should Be Success

Short Description
    [Tags]        short_desc

    ${user}        Factory User        short_desc

    Do Login              ${user}
    Go To Geek Form
    Fill Geek Form        ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be    A descrição deve ter no minimo 80 caracteres

Long Description
    [Tags]        long_desc

    ${user}        Factory User        long_desc

    Do Login              ${user}
    Go To Geek Form
    Fill Geek Form        ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be    A descrição deve ter no máximo 255 caracteres

Empty Description
    [Tags]        empty_desc
    
    ${user}        Factory User        empty_desc

    Do Login                ${user}
    Go To Geek Form
    Fill Geek Form          ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be    Informe a descrição do seu trabalho

Empty WhatsApp
    [Tags]        empty_whats
    
    ${user}        Factory User        empty_whats

    Do Login                ${user}
    Go To Geek Form
    Fill Geek Form          ${user}[geek_profile]
    Submit Geek Form
    Alert Span Should Be    O WhatsApp deve ter 11 digitos contando com o DDD

Required Fill Be a Geek
    [Tags]            reqf_geek
    [Template]        Correct Fill    ${whats}        ${desc}        ${cost}

    ${EMPTY}
    18
    1899999999

    ${EMPTY}

    ${EMPTY}
    12fr
    1f2r
    asdcf
    */$%
    50%
    asc@


*** Keywords ***
Correct Fill
    [Arguments]        ${whats}        ${desc}        ${cost}

    ${user}        Create Dictionary
    ...            email=kim@dotcom.com        password=pwd123
    ...            whatsapp=${whats}           desc=${desc}
    ...            printer_repair=Não          work=Remoto
    ...            cost=${cost}

    Do Login                    ${user}
    Go To Geek Form
    Fill Geek Form              ${user}
    Submit Geek Form
    Alert Span Should Be        O Whatsapp deve ter 11 digitos contando com o DDD
    Alert Span Should Be        Informe a descrição do seu trabalho
    Alert Span Should Be        Valor hora deve ser numérico



# O Whatsapp deve ter 11 digitos contando com o DDD
# Informe a descrição do seu trabalho
# Valor hora deve ser numérico
