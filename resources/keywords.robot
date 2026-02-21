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
    Input Text    ${EMAIL_INPUT}    doe+clerk_test@example.com
    Press Keys    ${EMAIL_INPUT}    TAB
    Sleep    2s
    Wait Until Element Is Visible    ${SUBMIT_BUTTON}    20s
    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}    20s
    Click Element                    ${SUBMIT_BUTTON}
    Wait Until Element Is Visible               ${PASSWORD_INPUT}    30s

    Wait Until Element Is Visible    ${PASSWORD_INPUT}
    Input Password    ${PASSWORD_INPUT}    morenttest@12345
    Wait Until Element Is Visible    ${SUBMIT_BUTTON}    20s
    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}    20s
    Click Element                    ${SUBMIT_BUTTON}
   
    ${otp_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${OTP_INPUT}    10s

    IF    ${otp_visible}
        Log    OTP detected
        Clear Element Text    ${OTP_INPUT}
        Input Text            ${OTP_INPUT}    424242
        Press Keys            ${OTP_INPUT}    ENTER
        
        # Wait for login success instead of OTP disappearing
        
        Log    OTP not shown
    END
    
