*** Settings ***
Documentation           Signup test suite - Suite de testes para cadastro de usuários

Resource                ${EXECDIR}/resources/Base.robot
#Resource                ${EXECDIR}/resources/actions/SignupActions.robot

Test Setup           Star Session
Test Teardown        End Session

*** Test Cases ***
Register a new user

    ${user}        Factory User        #pego a massa de testes...

    Set Suite Variable        ${user}        #deixo ela disponível a nível de SUITE, ou seja, outros casos de testes terão acesso a essa informação
    
    Go To Signup Form                        #a partir daqui faço o testes de cadastro do usuário...
    Fill Signup Form          ${user}
    Submit Signup Form
    User Should Be Registered

Duplicate user                            #e esse teste depende da execução do primeiro teste (Register a new user)
    [Tags]        dup_email

    ${user}                     Factory User

    Add User From Database      ${user}

    Go To Signup Form
    Fill Signup Form            ${user}
    Submit Signup Form
    Modal Content Should Be        Já temos um usuário com o e-mail informado.

Wrong Email
    [Tags]        attempt_signup        #"tentativa de cadastro"

    ${user}                    Factory Wrong Email

    Go To Signup Form
    Fill Signup Form           ${user}
    Submit Signup Form
    Alert Span Should Be            O email está estranho

Required Fields
    [Tags]        attempt_signup            reqf
#    [Template]    Signup Submit Without Form

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

#Signup Submit Without Form
#    [Arguments]            ${expected_alert}
#
#    Go To Signup Form
#    Submit Signup Form
#    Alert Span Should Be    ${expected_alert}