*** Settings ***
Library    SeleniumLibrary
Library    ../config/env_config.py
Resource   locators.robot
Resource   variables.robot

*** Variables ***
${DEFAULT_TIMEOUT}    ${None}

*** Keywords ***

Open MoRent Website
    ${browser}=    Get Browser
    ${url}=        Get Base Url
    ${timeout}=    Get Default Timeout

    Set Suite Variable    ${DEFAULT_TIMEOUT}    ${timeout}

    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Set Selenium Timeout    ${timeout}

    Wait Until Element Is Visible    ${LOGIN_BUTTON}    ${DEFAULT_TIMEOUT}

Go To Login Page
    Click Element    ${LOGIN_BUTTON}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    ${DEFAULT_TIMEOUT}

Login With Valid Credentials
    Input Text        ${EMAIL_INPUT}      ${VALID_EMAIL}
    Click Element     ${SUBMIT_BUTTON}

    Wait Until Element Is Visible    ${PASSWORD_INPUT}    ${DEFAULT_TIMEOUT}
    Input Password    ${PASSWORD_INPUT}   ${VALID_PASSWORD}
    Click Element     ${SUBMIT_BUTTON}

Login With Invalid Credentials
    Input Text        ${EMAIL_INPUT}      invalid@example.com
    Click Element     ${SUBMIT_BUTTON}

    Wait Until Element Is Visible    ${PASSWORD_INPUT}    ${DEFAULT_TIMEOUT}
    Input Password    ${PASSWORD_INPUT}   wrongpassword
    Click Element     ${SUBMIT_BUTTON}

Verify Login Successful
    Wait Until Page Does Not Contain Element    ${LOGIN_ERROR_MESSAGE}    ${DEFAULT_TIMEOUT}

Verify Login Failed
    Wait Until Element Is Visible    ${LOGIN_ERROR_MESSAGE}    ${DEFAULT_TIMEOUT}
    Element Should Be Visible        ${LOGIN_ERROR_MESSAGE}

Get Non Empty Field Validation Feedback
    [Arguments]    ${locator}
    ${message}=    Get Element Attribute    ${locator}    validationMessage
    Should Not Be Empty    ${message}
    [Return]    ${message}
