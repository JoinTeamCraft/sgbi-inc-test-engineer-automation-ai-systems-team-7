*** Settings ***
Library     SeleniumLibrary
Resource    locators.robot
Resource    variables.robot

*** Keywords ***

Login With Valid Credentials
    # Enter Email
    Wait Until Element Is Visible    ${EMAIL_INPUT}    20s
    Clear Element Text                ${EMAIL_INPUT}
    Input Text                        ${EMAIL_INPUT}    ${VALID_EMAIL}
    Press Keys                        ${EMAIL_INPUT}    TAB

    # Submit Email
    Wait Until Element Is Visible    ${SUBMIT_BUTTON}    20s
    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}    20s
    Click Element                     ${SUBMIT_BUTTON}

    # Enter Password
    Wait Until Element Is Visible    ${PASSWORD_INPUT}    30s
    Clear Element Text                ${PASSWORD_INPUT}
    Input Password                    ${PASSWORD_INPUT}    ${VALID_PASSWORD}

    # Submit Login
    Wait Until Element Is Visible    ${SUBMIT_BUTTON}    20s
    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}    20s
    Click Element                     ${SUBMIT_BUTTON}

    # Handle OTP if present
    ${otp_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${OTP_INPUT}    10s

    IF    ${otp_visible}
        Log    OTP detected and submitting OTP code
        Clear Element Text    ${OTP_INPUT}
        Input Text            ${OTP_INPUT}    ${OTP_CODE}
        Press Keys            ${OTP_INPUT}    ENTER
        Log    OTP submitted successfully
    END
