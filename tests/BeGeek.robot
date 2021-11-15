*** Settings ***
Documentation            Suite de testes para funcionalidade Seja um Geek

Resource            ${EXECDIR}/resources/Base.robot

Test Setup           Star Session
Test Teardown        End Session

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
