*** Settings ***
Library     SeleniumLibrary
Resource    locators.robot

*** Keywords ***

Open MoRent Website
    Open Browser    https://morent-car.archisacademy.com/    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${LOGIN_BUTTON}

Go To Login Page
    Click Element    ${LOGIN_BUTTON}
    Wait Until Element Is Visible    ${EMAIL_INPUT}

Login With Valid Credentials
    # Step 1: Enter Email
    Input Text    ${EMAIL_INPUT}    doe+clerk_test@example.com
    Click Element    ${SUBMIT_BUTTON}

    # Step 2: Enter Password
    Wait Until Element Is Visible    ${PASSWORD_INPUT}
    Input Password    ${PASSWORD_INPUT}    morenttest@12345
    Click Element    ${SUBMIT_BUTTON}

Verify Successful Login
    Wait Until Element Is Visible    ${LOGOUT_BUTTON}
