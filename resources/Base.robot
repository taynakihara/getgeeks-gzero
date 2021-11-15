*** Settings ***
Documentation            Arquivo BASE do projeto de testes

Library                 Browser
Library                 Collections

Library                 factories/Users.py

Resource                actions/_SharedActions.robot
Resource                actions/BeGeekActions.robot
Resource                actions/LoginActions.robot
Resource                actions/SignupActions.robot

Resource                Database.robot
Resource                Helpers.robot

*** Variables ***
${BASE_URL}            https://getgeeks-tayna.herokuapp.com
${TIMEOUT}             5

*** Keywords ***
Star Session
    New Browser        chromium        headless=False        slowMo=00:00:00.1
    New Page           ${BASE_URL}

End Session
    Take Screenshot        fullPage=True
