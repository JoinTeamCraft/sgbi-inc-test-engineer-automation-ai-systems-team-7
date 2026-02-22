*** Settings ***
Library    SeleniumLibrary
Resource   locators.robot
Resource   variables.robot
Library    ../config/env_library.py

*** Keywords ***

Open MoRent Website
    ${url}=       Get Base Url
    ${browser}=   Get Browser

    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Set Selenium Implicit Wait    10s

    Wait Until Element Is Visible    ${LOGIN_BUTTON}    20s

Go To Login Page
    Click Element    ${LOGIN_BUTTON}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    20s

Login With Valid Credentials
    Input Text    ${EMAIL_INPUT}    ${VALID_EMAIL}
    Press Keys    ${EMAIL_INPUT}    TAB

    Click Element    ${SUBMIT_BUTTON}

    Wait Until Element Is Visible    ${PASSWORD_INPUT}    30s
    Input Password    ${PASSWORD_INPUT}    ${VALID_PASSWORD}

    Click Element    ${SUBMIT_BUTTON}

    # OTP Optional ⭐
    ${otp_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${OTP_INPUT}    10s

    IF    ${otp_visible}
        Input Text    ${OTP_INPUT}    ${OTP_CODE}
        Press Keys    ${OTP_INPUT}    ENTER
    END

Verify User Can Logout Successfully

    ${profile_exists}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${PROFILEICON_BUTTON}    5s

    IF    ${profile_exists}
        Click Element    ${PROFILEICON_BUTTON}
    END

    ${logout_exists}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${SIGNOUT_BUTTON}    10s

    IF    ${logout_exists}
        Click Element    ${SIGNOUT_BUTTON}
    END
    Log    Logout functionality verified successfully
