*** Keywords ***

Open MoRent Website
    Open Browser    ${BASE_URL}    chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Wait Until Element Is Visible    ${SIGN_IN_BUTTON}    20s

Go To Login Page
    Click Element    ${SIGN_IN_BUTTON}
    Wait Until Element Is Visible    ${EMAIL_IDENTIFIER_FIELD}    20s

Login With Invalid Credentials
    Input Text    ${EMAIL_IDENTIFIER_FIELD}    ${INVALID_EMAIL}
    Press Keys    ${EMAIL_IDENTIFIER_FIELD}    TAB
    Click Element    ${CONTINUE_BTN}

    Wait Until Element Is Visible    ${PASSWORD_FIELD}    20s
    Input Password    ${PASSWORD_FIELD}    ${INVALID_PASSWORD}
    Click Element    ${CONTINUE_BTN}

    ${password_msg}=    Wait Until Keyword Succeeds    10s    500ms
    ...    Get Non Empty Field Validation Feedback    ${PASSWORD_FIELD}

    ${password_valid}=    Get Field Validity If Present    ${PASSWORD_FIELD}

    Log    Invalid password validation message='${password_msg}'

    Run Keyword And Continue On Failure    Should Be True    not ${password_valid}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${password_msg}


Verify Home Page Loaded Successfully
    [Documentation]    Validates that the MoRent home page loads without errors and main content is visible.

    Location Should Be                       ${BASE_URL}
    Title Should Be                          Morent
    Wait Until Element Is Visible            ${HOME_MAIN_CONTAINER}    ${DEFAULT_TIMEOUT}
    Page Should Not Contain Element          ${GENERIC_ERROR_TEXT}
    Wait Until Page Contains Element         ${RENTAL_CAR_BUTTON}
    Wait Until Element Is Visible            ${SIGN_IN_BUTTON}         ${DEFAULT_TIMEOUT}