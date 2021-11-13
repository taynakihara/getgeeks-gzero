*** Settings ***
Documentation           Modelo para utilizar templates Signup Required Test Suite    #casos de testes que fazem somente a validação de campos obrigatórios

Resource                ${EXECDIR}/resources/Base.robot

Suite Setup           Signup Without Fill Form    #Suite Setup faz com que o navegador seja aberto apenas uma única vez e executa todos os testes sem fechar o navegador
Test Teardown        End Session

*** Test Cases ***
Name is required
    Alert Span Should Be        Cadê o seu nome?

Lastname is required
    Alert Span Should Be        E o sobrenome?

Email is required
    Alert Span Should Be        O email é importante também!

Password is required
    Alert Span Should Be        Agora só falta a senha!

*** Keywords ***
Signup Without Fill Form

    Star Session
    Go To Signup Form
    Submit Signup Form