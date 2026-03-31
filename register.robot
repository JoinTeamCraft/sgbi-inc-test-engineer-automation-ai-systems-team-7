*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://morent-car.archisacademy.com/
${BROWSER}      chrome

${SIGN_IN_HDR}  xpath=//button[contains(text(), 'Sign in')]
${SIGN_UP_LNK}  xpath=//a[text()='Sign up']

${FIRST_NAME}   id=firstName-field
${LAST_NAME}    id=lastName-field
${EMAIL_FLD}    id=emailAddress-field
${PASS_FLD}     id=password-field

${CONT_BTN}     xpath=//button[contains(@class, 'cl-formButtonPrimary')]


*** Test Cases ***
Verify Clerk Registration Page And Fields
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    # ---- Click Sign In ----
    Wait Until Element Is Visible    ${SIGN_IN_HDR}    20s
    Click Element    ${SIGN_IN_HDR}

    # ---- Click Sign Up ----
    Wait Until Element Is Visible    ${SIGN_UP_LNK}    15s
    Click Element    ${SIGN_UP_LNK}

    # ---- Fill Registration Form ----
    Wait Until Element Is Visible    ${FIRST_NAME}    20s

    Input Text    ${FIRST_NAME}    Arun
    Input Text    ${LAST_NAME}     Mohan
    Input Text    ${EMAIL_FLD}     test@gmail.com
    Input Text    ${PASS_FLD}      12345678aA@

    # ---- Click Continue ----
    Click Element    ${CONT_BTN}

    Sleep    3s

    [Teardown]    Close Browser