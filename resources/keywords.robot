*** Keywords ***

Open MoRent Website
    Open Browser    https://morent-car.archisacademy.com/    chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    20s

Go To Login Page
    Click Element    ${LOGIN_BUTTON}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    20s

Login With Invalid Credentials
    Input Text    ${EMAIL_INPUT}    ${INVALID_EMAIL}
    Press Keys    ${EMAIL_INPUT}    TAB
    Click Element    ${SUBMIT_BUTTON}

    Wait Until Element Is Visible    ${PASSWORD_INPUT}    20s
    Input Password    ${PASSWORD_INPUT}    ${INVALID_PASSWORD}
    Click Element    ${SUBMIT_BUTTON}

    Log    Invalid login scenario verified successfully
