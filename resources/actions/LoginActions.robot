*** Settings ***
Documentation            Ações da funcionalidade de Login - Authorization Actions

*** Variables ***
${INPUT_EMAIL}           id=email
${INPUT_PASS}            id=password

*** Keywords ***

Go To Login Page
    Go To            ${BASE_URL}
    Wait For Elements State        css=.login-form        visible        ${TIMEOUT}

Fill Credentials
    [Arguments]        ${user}

    Fill Text        ${INPUT_EMAIL}           ${user}[email]
    Fill Text        ${INPUT_PASS}        ${user}[password]

Submit Credentials
    Click            css=.submit-button >> text=Entrar

User Should Be Logged In
    [Arguments]                 ${user}

    ${element}                  Set Variable        css=a[href="/profile"]
    ${expected_fullname}        Set Variable        ${user}[name] ${user}[lastname]

    Wait For Elements State         ${element}        visible        ${TIMEOUT}
    Get Text                        ${element}        equal          ${expected_fullname}
    
Should Be Type Email
    Get Property        ${INPUT_EMAIL}        type        equal        email        #me da a propriedade do id=email onde o tipo é igual email

