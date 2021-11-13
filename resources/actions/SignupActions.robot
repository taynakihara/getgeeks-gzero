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

Alert Span Should Be
    [Arguments]            ${expected_alert}

    Wait For Elements State        css=span[class=error] >> text=${expected_alert}        visible        ${TIMEOUT}

Alerts Spans Should Be
    [Arguments]            ${expected_alerts}

    @{got_alerts}       Create List

    ${spans}            Get Elements        xpath=//span[@class="error"]    #essa KW pode encontrar mais de um elemento com o mesmo nome
    #Nesse caso, a KW Get Elements pega os 4 elementos e armazena na lista ${spans}.
    #Quando chamo a KW Get Elements, o robot traz o elemento dessa lista e eu quero o texto, por isso chamo a KW Get Text no FOR.
    #Não colocamos @ para spans pois essa KW (Get Elements) já faz, internamente, a tipagem e devolve a lista para variável.
    FOR    ${span}    IN     @{spans}    #comando: quero que o robot pegue um span por vez, em (IN) uma lista (pega na lista ${spans})

        ${text}                Get Text            ${span}    #Traz o texto de cada elemento. Pego o texto de cada elemento e armazeno na variável ${text}
        Append To List         ${got_alerts}       ${text}    #Adiciona na lista ${got_alerts} o texto que o Get Text vai pegar de elemento por elemento

    END

    Lists Should Be Equal        ${expected_alerts}        ${got_alerts}    #IMPORTAR A LIBRARY COLLECTIONS para utilizar essa KW.
    #comparo uma lista com a outra para saber se todos esses textos estão corretos.