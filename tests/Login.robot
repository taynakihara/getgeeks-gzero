*** Settings ***
Documentation            Authotization Test Suite - Login Actions

Resource        ${EXECDIR}/resources/Base.robot

Test Setup           Star Session
Test Teardown        End Session

*** Test Cases ***

User Login
    ${user}                     Factory User Login
    #Add User From Database      ${user} - NÃO PRECISO MAIS DESSA KW, POIS ADICIONEI NO DELOREAN O USERS SEED, que faz o insert do usuário no BD

    Go To Login Page
    Fill Credentials                ${user}
    Submit Credentials
    User Should Be Logged In        ${user}

Incorrect Pass
    [Tags]         i_pass

    ${user}        Create Dictionary        email=taynakihara@heroku.com        password=senha123
#a senha está diferente da informada no factory_user_login, em Users.py;
    Go To Login Page
    Fill Credentials    ${user}    #nesse context, essa variável só tem 2 argumentos: email e password;
    Submit Credentials
    Modal Content Should Be        Usuário e/ou senha inválidos.

User Not Found
    [Tags]         user_404

    ${user}        Create Dictionary        email=taynakihara@404.net        password=tayna123
#a senha está diferente da informada no factory_user_login, em Users.py;
    Go To Login Page
    Fill Credentials    ${user}    #nesse context, essa variável só tem 2 argumentos: email e password;
    Submit Credentials
    Modal Content Should Be        Usuário e/ou senha inválidos.

Incorrect Email
    [Tags]         i_email

    ${user}        Create Dictionary        email=taynakihara.com.net        password=tayna123
#a senha está diferente da informada no factory_user_login, em Users.py;
    Go To Login Page
    Fill Credentials    ${user}    #nesse context, essa variável só tem 2 argumentos: email e password;
    Submit Credentials
    Should Be Type Email    