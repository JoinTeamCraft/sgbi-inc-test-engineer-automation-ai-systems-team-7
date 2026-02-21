*** Settings ***
Documentation     Validates mandatory field checks on the registration form.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Setup        Open MoRent Home Page
Test Teardown     Close Browser

*** Test Cases ***
Registration Form Should Show Mandatory Field Validation
    [Documentation]    Verifies form is not submitted and mandatory fields show validation messages.
    [Tags]    auth    signup    validation
    Go To Sign Up Page

    Field Should Be Empty If Present    ${FULL_NAME_INPUT}
    Field Should Be Empty If Present    ${FIRST_NAME_INPUT}
    Field Should Be Empty If Present    ${LAST_NAME_INPUT}
    Field Should Be Empty If Present    ${EMAIL_INPUT}
    Field Should Be Empty If Present    ${PASSWORD_INPUT}
    Field Should Be Empty If Present    ${CONFIRM_PASSWORD_INPUT}

    Click Sign Up Submit
    Wait Until Element Is Visible    ${SIGN_UP_SUBMIT_BUTTON}    10s
    ${current_url}=    Get Location
    Should Contain    ${current_url}    sign-up

    ${email_required}=    Field Is Required If Present    ${EMAIL_INPUT}
    Should Be True    ${email_required}
    ${email_msg}=    Get Validation Message If Present    ${EMAIL_INPUT}
    Should Not Be Empty    ${email_msg}

    ${password_required}=    Field Is Required If Present    ${PASSWORD_INPUT}
    Should Be True    ${password_required}
    ${password_msg}=    Get Validation Message If Present    ${PASSWORD_INPUT}
    Should Not Be Empty    ${password_msg}

    ${full_name_present}=    Run Keyword And Return Status    Page Should Contain Element    ${FULL_NAME_INPUT}
    IF    ${full_name_present}
        ${full_name_required}=    Field Is Required If Present    ${FULL_NAME_INPUT}
        Should Be True    ${full_name_required}
        ${full_name_msg}=    Get Validation Message If Present    ${FULL_NAME_INPUT}
        Should Not Be Empty    ${full_name_msg}
    END

    ${confirm_password_present}=    Run Keyword And Return Status    Page Should Contain Element    ${CONFIRM_PASSWORD_INPUT}
    IF    ${confirm_password_present}
        ${confirm_password_required}=    Field Is Required If Present    ${CONFIRM_PASSWORD_INPUT}
        Should Be True    ${confirm_password_required}
        ${confirm_password_msg}=    Get Validation Message If Present    ${CONFIRM_PASSWORD_INPUT}
        Should Not Be Empty    ${confirm_password_msg}
    END
