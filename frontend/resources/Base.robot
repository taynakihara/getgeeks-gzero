*** Settings ***
Documentation            Arquivo BASE do projeto de testes

Library                 Browser
Library                 Collections

Library                factories/Users.py
Library                Utils.py

Resource               actions/_SharedActions.robot
Resource               actions/BeGeekActions.robot
Resource               actions/LoginActions.robot
Resource               actions/SignupActions.robot

Resource                Database.robot
Resource                Helpers.robot

*** Variables ***
${BASE_URL}            https://getgeeks-tayna.herokuapp.com
${TIMEOUT}             5

*** Keywords ***
Start Session
    New Browser                ${BROWSER}        headless=${HEADLESS}        slowMo=00:00:00
    New Page                   ${BASE_URL}
    Set Viewport Size          1280    768

After Test
    ${shot_name}            Screenshot Name
    Take Screenshot         fullPage=True        filename=${shot_name}
