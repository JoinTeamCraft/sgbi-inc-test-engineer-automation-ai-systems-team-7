Login With Invalid Credentials
    Wait Until Element Is Visible    ${EMAIL_INPUT}    20s
    Clear Element Text    ${EMAIL_INPUT}
    Input Text    ${EMAIL_INPUT}    ${INVALID_EMAIL}

    Press Keys    ${EMAIL_INPUT}    TAB

    Click Element    ${SUBMIT_BUTTON}

    Wait Until Element Is Visible    ${PASSWORD_INPUT}    30s
    Clear Element Text    ${PASSWORD_INPUT}
    Input Password    ${PASSWORD_INPUT}    ${INVALID_PASSWORD}

    Click Element    ${SUBMIT_BUTTON}
