*** Settings ***
Documentation            Base test

Library         RequestsLibrary

Resource        routes/SessionsRoute.robot

*** Variables ***
${API_USERS}        https://getgeeks-users-tayna.herokuapp.com