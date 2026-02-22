*** Settings ***
Library    SeleniumLibrary
Resource   locators.robot
Resource   variables.robot

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
    Wait Until Element Is Visible    ${EMAIL_INPUT}    20s
    Clear Element Text    ${EMAIL_INPUT}
    Input Text    ${EMAIL_INPUT}    ${VALID_EMAIL}
    Press Keys    ${EMAIL_INPUT}    TAB

    Wait Until Element Is Visible    ${SUBMIT_BUTTON}    20s
    Click Element    ${SUBMIT_BUTTON}

    Wait Until Element Is Visible    ${PASSWORD_INPUT}    30s
    Clear Element Text    ${PASSWORD_INPUT}
    Input Password    ${PASSWORD_INPUT}    ${VALID_PASSWORD}

    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}    20s
    Click Element    ${SUBMIT_BUTTON}

    # OTP Handling (Optional)
    ${otp_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${OTP_INPUT}    10s

    IF    ${otp_visible}
        Clear Element Text    ${OTP_INPUT}
        Input Text    ${OTP_INPUT}    ${OTP_CODE}
        Press Keys    ${OTP_INPUT}    ENTER
    END

Verify User Is Logged In
    Wait Until Element Is Visible    ${LOGOUT_BUTTON}     30s
    Element Should Be Visible    ${LOGOUT_BUTTON}
    Log    User login verified successfully
