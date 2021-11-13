*** Settings ***
Documentation            Shared Actions - Ações que podem ser compartilhadas em mais de um step


*** Keywords ***
Modal Content Should Be
    [Arguments]            ${expected_text}
    ${title}              Set Variable            css=.swal2-title
    ${content}            Set Variable            css=.swal2-html-container

    Wait For Elements State        ${title}                visible        ${TIMEOUT}
    Get Text                       ${title}                equal          Oops...

    Wait For Elements State        ${content}              visible        ${TIMEOUT}
    Get Text                       ${content}              equal          ${expected_text}

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