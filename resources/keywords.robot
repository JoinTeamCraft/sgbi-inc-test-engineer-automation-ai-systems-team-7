*** Settings ***
Library     SeleniumLibrary
Resource    locators.robot

*** Keywords ***

Open MoRent Website
    Open Browser    https://morent-car.archisacademy.com/    chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    20s

Go To Login Page
    Click Element    ${LOGIN_BUTTON}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    20s

Login With Valid Credentials
    Click Element    ${EMAIL_INPUT}
    Press Keys       ${EMAIL_INPUT}  doe+clerk_test@example.com
    Press Keys    ${EMAIL_INPUT}    TAB
    Sleep    2s
    Wait Until Element Is Visible    ${SUBMIT_BUTTON}    20s
    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}    20s
    Click Element                    ${SUBMIT_BUTTON}
    Wait Until Page Does Not Contain Element    ${EMAIL_INPUT}    20s
    Wait Until Element Is Visible               ${PASSWORD_INPUT}    30s

    Wait Until Element Is Visible    ${PASSWORD_INPUT}
    Input Password    ${PASSWORD_INPUT}    morenttest@12345
    Wait Until Element Is Visible    ${SUBMIT_BUTTON}    20s
    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}    20s
    Click Element                    ${SUBMIT_BUTTON}

Verify Successful Login
    Wait Until Element Is Visible    ${LOGOUT_BUTTON}    20s
