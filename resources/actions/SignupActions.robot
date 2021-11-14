*** Settings ***
Documentation            Ações da funcionalidade de Cadastro - Signup Actions

*** Keywords ***
Go To Signup Form
    Go To                          ${BASE_URL}/signup
    Wait For Elements State        css=.signup-form        visible        ${TIMEOUT}

Fill Signup Form
    [Arguments]            ${user}

    Fill Text              id=name              ${user}[name]
    Fill Text              id=lastname          ${user}[lastname]
    Fill Text              id=email             ${user}[email]
    Fill Text              id=password          ${user}[password]

Submit Signup Form
    Click                css=button >> text=Cadastrar

User Should Be Registered
    ${expected_message}            Set Variable        css=p >> text=Agora você faz parte da Getgeeks. Tenha uma ótima experiência.

    Wait For Elements State        ${expected_message}        visible        ${TIMEOUT}

