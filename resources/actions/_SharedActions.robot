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