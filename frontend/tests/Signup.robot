*** Settings ***
Documentation           Signup test suite - Suite de testes para cadastro de usuários

Resource                ${EXECDIR}/resources/Base.robot

Test Setup           Start Session
Test Teardown        After Test

*** Test Cases ***
Register a new user
    [Tags]        smoke
    ${user}        Factory User        faker

    Set Suite Variable        ${user}
    
    Go To Signup Form
    Fill Signup Form          ${user}
    Submit Signup Form
    User Should Be Registered

Duplicate user
    [Tags]        dup_email

    ${user}                     Factory User        faker

    Add User From Database      ${user}

    Go To Signup Form
    Fill Signup Form            ${user}
    Submit Signup Form
    Modal Content Should Be        Já temos um usuário com o e-mail informado.

Wrong Email
    [Tags]        attempt_signup

    ${user}                    Factory User         wrong_email

    Go To Signup Form
    Fill Signup Form           ${user}
    Submit Signup Form
    Alert Span Should Be            O email está estranho

Required Fields
    [Tags]        attempt_signup            reqf

    @{expected_alerts}         Create List    
    ...                        Cadê o seu nome?
    ...                        E o sobrenome?
    ...                        O email é importante também!
    ...                        Agora só falta a senha!

    Go To Signup Form
    Submit Signup Form
    Alerts Spans Should Be        ${expected_alerts}

Short Password
    [Tags]        attempt_signup        short_pass
    [Template]    Signup With Short Pass

    1
    12
    123
    1234
    12345
    a
    a2
    ab3
    ab3c
    a23bc
    -1
    acb#1

*** Keywords ***
Signup With Short Pass
    [Arguments]            ${short_pass}

    ${user}        Create Dictionary
    ...            name=tayna                    lastname=kihara
    ...            email=tayna@hotmail.com       password=${short_pass}

    Go To Signup Form
    Fill Signup Form                ${user}
    Submit Signup Form
    Alert Span Should Be            Informe uma senha com pelo menos 6 caracteres
