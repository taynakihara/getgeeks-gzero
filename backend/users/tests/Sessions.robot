*** Settings ***

Documentation            Sessions route test suite

Library            RequestsLibrary
Resource           ${EXECDIR}/resources/Base.robot

*** Variables ***
&{incorrect_pass}            email=tay@getgeeks.com           password=tayna321
&{incorrect_email}           email=tay.getgeeks.com.br        password=tayna123
&{user_not_found}            email=tay@404.com                password=tayna123
&{empty_email}               email=${EMPTY}                   password=tayna123
&{without_email}                                              password=tayna123
&{empty_pass}                email=tay@getgeeks.com           password=${EMPTY}
&{without_pass}              email=tay@getgeeks.com

*** Test Cases ***

User session
    &{payload}        Create Dictionary        email=tay@getgeeks.com        password=tayna123
    
    ${response}        POST Session    ${payload}

    Status Should Be       200                        ${response}

    ${size}                Get Length                 ${response.json()}[token]
    ${expected_size}       Convert To Integer         140

    Should Be Equal        ${expected_size}           ${size}
    Should Be Equal        10d                        ${response.json()}[expires_in]

Should not get token
    [Template]                    Attempt POST session

    ${incorrect_pass}             401        Unauthorized
    ${incorrect_email}            400        Incorrect email
    ${user_not_found}             401        Unauthorized
    ${empty_email}                400        Required email
    ${without_email}              400        Required email
    ${empty_pass}                 400        Required pass
    ${without_pass}               400        Required pass

*** Keywords ***
Attempt POST session
    [Arguments]        ${payload}        ${status_code}        ${error_message}

    ${response}        POST Session      ${payload}

    Status Should Be       ${status_code}        ${response}
    Should Be Equal        ${error_message}      ${response.json()}[error]