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
