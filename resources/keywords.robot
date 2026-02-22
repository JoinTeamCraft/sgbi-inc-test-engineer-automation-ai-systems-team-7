*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Library           ../config/env_config.py
Resource          locators.robot
Resource          test_data.robot


*** Keywords ***
Open Browser To MoRent
    Open Browser    ${BASE_URL}     ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    10s

Login With Valid Credentials
    ${EMAIL}=       Get Test Email
    ${PASSWORD}=    Get Test Password

    Wait Until Element Is Visible    ${SIGN_IN_BUTTON}    10s
    Click Element    ${SIGN_IN_BUTTON}

    Wait Until Element Is Visible    ${EMAIL_IDENTIFIER_FIELD}    10s
    Clear Element Text    ${EMAIL_IDENTIFIER_FIELD}
    Input Text    ${EMAIL_IDENTIFIER_FIELD}    ${EMAIL}
    Click Element    ${CONTINUE_BTN}

    Wait Until Element Is Visible    ${PASSWORD_FIELD}    10s
    Clear Element Text    ${PASSWORD_FIELD}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Element    ${CONTINUE_BTN}

    Run Keyword And Ignore Error    Handle OTP If Present

Handle OTP If Present
    ${OTP_CODE}=    Get Otp Code
    ${status}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    xpath=//input[@autocomplete='one-time-code']    5s

    Run Keyword If    ${status}
    ...    Input Text    xpath=//input[@autocomplete='one-time-code']    ${OTP_CODE}


Verify Login Successful
    Wait Until Element Is Visible    ${PROFILE_ICON}    10s

Open Profile Dropdown
    Verify Login Successful
    Click Element    ${PROFILE_ICON}

Click Manage Account
    Click Element    ${MANAGE_ACCOUNT}

Verify Manage Account Modal Is Open
    Wait Until Element Is Visible    ${ACCOUNT_MODAL}    10s

    # Validate modal content
    Element Should Be Visible      ${PROFILE_DETAIL}
    Element Should Be Visible      ${MANAGE_YOUR_ACCOUNT}

    #Validate sidebar visibility
    Element Should Be Visible      ${SIDEBAR_PROFILE_OPTION}
    Element Should Be Visible      ${SIDEBAR_SECURITY_OPTION}


