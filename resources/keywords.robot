*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          locators.robot

*** Variables ***
${BASE_URL}       https://morent-car.archisacademy.com/
${BROWSER}        chrome
${TEST_EMAIL}     doe+clerk_test@example.com
${TEST_PASSWORD}  morenttest@12345
${OTP_CODE}       424242


*** Keywords ***
Open Browser To MoRent
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    10s

Login With Valid Credentials
    Wait Until Element Is Visible    ${SIGN_IN_BUTTON}    10s
    Click Element    ${SIGN_IN_BUTTON}

    Wait Until Element Is Visible    ${EMAIL_IDENTIFIER_FIELD}    10s
    Input Text    ${EMAIL_IDENTIFIER_FIELD}    ${TEST_EMAIL}
    Click Element    ${EMAIL_CONTINUE_BTN}

    Wait Until Element Is Visible    ${PASSWORD_FIELD}    10s
    Input Text    ${PASSWORD_FIELD}    ${TEST_PASSWORD}
    Click Element    ${PASSWORD_CONTINUE_BTN}

    Run Keyword And Ignore Error    Handle OTP If Present

Handle OTP If Present
    Wait Until Element Is Visible    xpath=//h1[text()='Check your email']    5s
    Input Text    xpath=//input[@autocomplete='one-time-code']    ${OTP_CODE}


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
    Page Should Contain Element      ${PROFILE_DETAIL}
    Page Should Contain Element      ${MANAGE_YOUR_ACCOUNT}

    # Validate sidebar visibility
    Page Should Contain Element      ${SIDEBAR_PROFILE_OPTION}
    Page Should Contain Element      ${SIDEBAR_SECURITY_OPTION}

