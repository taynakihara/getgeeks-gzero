*** Settings ***
Documentation            Authotization Test Suite - Login Actions

Resource        ${EXECDIR}/resources/Base.robot

Test Setup           Start Session
Test Teardown        End Session

*** Test Cases ***

User Login
    [Tags]            smoke
    ${user}                     Factory User        login

    Go To Login Page
    Fill Credentials                ${user}
    Submit Credentials
    User Should Be Logged In        ${user}

Incorrect Pass
    [Tags]         inv_pass

    ${user}        Create Dictionary        email=taynakihara@heroku.com        password=senha123

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Modal Content Should Be        Usuário e/ou senha inválidos.

User Not Found
    [Tags]         user_404

    ${user}        Create Dictionary        email=taynakihara@404.net        password=tayna123

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Modal Content Should Be        Usuário e/ou senha inválidos.

Incorrect Email
    [Tags]         inv_email

    ${user}        Create Dictionary        email=taynakihara.com.net        password=tayna123

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Should Be Type Email

Required Email
    [Tags]        req_email

    ${user}        Create Dictionary        email=${EMPTY}            password=tayna123

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Alert Span Should Be    E-mail obrigatório

Required Password
    [Tags]        req_pass

    ${user}        Create Dictionary        email=taynakihara@heroku.com            password=${EMPTY}

    Go To Login Page
    Fill Credentials    ${user}
    Submit Credentials
    Alert Span Should Be    Senha obrigatória

Required Fields
    [Tags]        req_fields

    ${expected_alerts}        Create List
    ...                       E-mail obrigatório
    ...                       Senha obrigatória

    Go To Login Page
    Submit Credentials
    Alerts Spans Should Be    ${expected_alerts}