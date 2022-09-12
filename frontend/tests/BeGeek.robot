*** Settings ***
Documentation            Suite de testes para funcionalidade Seja um Geek

Resource            ${EXECDIR}/resources/Base.robot

Test Setup            Start Session
Test Teardown         After Test

*** Test Cases ***
Be a Geek
    [Tags]        be_geek        smoke

    ${user}        Factory User        be_geek

    Do Login            ${user}
    Go To Geek Form
    Fill Geek Form      ${user}[geek_profile]
    Submit Geek Form
    Geek Form Should Be Success
