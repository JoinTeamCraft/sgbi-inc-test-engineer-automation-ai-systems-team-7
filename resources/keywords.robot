*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Library           ../config/env_config.py
Library           ../python_lib/validators.py
Resource          locators.robot
Resource          test_data.robot


*** Keywords ***
Open Browser To MoRent
    Open Browser    ${BASE_URL}     ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}

Login With Valid Credentials
    ${EMAIL}=       Set Variable    %{TEST_EMAIL}
    ${PASSWORD}=    Set Variable    %{TEST_PASSWORD}

    Wait Until Element Is Visible    ${SIGN_IN_BUTTON}    ${DEFAULT_TIMEOUT}
    Click Element    ${SIGN_IN_BUTTON}

    Wait Until Element Is Visible    ${EMAIL_IDENTIFIER_FIELD}    ${DEFAULT_TIMEOUT}
    Clear Element Text    ${EMAIL_IDENTIFIER_FIELD}
    Input Text    ${EMAIL_IDENTIFIER_FIELD}    ${EMAIL}
    Click Element    ${CONTINUE_BTN}

    Wait Until Element Is Visible    ${PASSWORD_FIELD}    ${DEFAULT_TIMEOUT}
    Clear Element Text    ${PASSWORD_FIELD}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Element    ${CONTINUE_BTN}

    Run Keyword And Ignore Error    Handle OTP If Present

Handle OTP If Present
    ${OTP_CODE}=    Set Variable    %{OTP_CODE}
    ${status}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${OTP_INPUT_FIELD}    ${DEFAULT_TIMEOUT}

    Run Keyword If    ${status}
    ...    Input Text    ${OTP_INPUT_FIELD}    ${OTP_CODE}


Verify Login Successful
    Wait Until Element Is Visible    ${PROFILE_ICON}    ${DEFAULT_TIMEOUT}

Open Profile Dropdown
    Verify Login Successful
    Click Element    ${PROFILE_ICON}

Click Manage Account
    Click Element    ${MANAGE_ACCOUNT}

Verify Manage Account Modal Is Open
    Wait Until Element Is Visible    ${ACCOUNT_MODAL}    ${DEFAULT_TIMEOUT}

    # Validate modal content
    Element Should Be Visible      ${PROFILE_DETAIL}
    Element Should Be Visible      ${MANAGE_YOUR_ACCOUNT}

    #Validate sidebar visibility
    Element Should Be Visible      ${SIDEBAR_PROFILE_OPTION}
    Element Should Be Visible      ${SIDEBAR_SECURITY_OPTION}

Open MoRent Home Page
    [Documentation]    Opens the MoRent homepage and waits until main content is visible.
    ${base_url}=    Get Base Url
    ${browser}=    Get Browser
    ${timeout}=    Get Default Timeout
    Open Browser    ${base_url}    ${browser}
    Maximize Browser Window
    Wait Until Element Is Visible    ${HOME_READY_TEXT}    ${timeout}

Go To Sign Up Page
    [Documentation]    Navigates from homepage to the registration form.
    Wait Until Element Is Visible    ${SIGN_IN_BUTTON}    ${DEFAULT_TIMEOUT}
    Click Button    ${SIGN_IN_BUTTON}
    Sleep    2s
    ${handles}=    Get Window Handles
    ${handle_count}=    Get Length    ${handles}
    IF    ${handle_count} > 1
        Switch Window    NEW
    END
    Wait Until Element Is Visible    ${SIGN_UP_LINK}    ${DEFAULT_TIMEOUT}
    Wait Until Keyword Succeeds    ${DEFAULT_TIMEOUT}    1s    Click Element    ${SIGN_UP_LINK}
    Wait Until Element Is Visible    ${SIGN_UP_HEADING}    ${DEFAULT_TIMEOUT}

Clear Field If Present
    [Arguments]    ${locator}
    ${is_present}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
    IF    ${is_present}
        Clear Element Text    ${locator}
    END

Field Should Be Empty If Present
    [Arguments]    ${locator}
    ${is_present}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
    IF    ${is_present}
        Textfield Value Should Be    ${locator}    ${EMPTY}
    END

Click Sign Up Submit
    Click Button    ${SIGN_UP_SUBMIT_BUTTON}

Get Validation Message If Present
    [Arguments]    ${locator}
    ${is_present}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
    IF    ${is_present}
        ${element}=    Get WebElement    ${locator}
        ${message}=    Execute Javascript    return arguments[0].validationMessage;    ARGUMENTS    ${element}
        RETURN    ${message}
    END
    RETURN    ${EMPTY}

Field Is Required If Present
    [Arguments]    ${locator}
    ${is_present}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
    IF    ${is_present}
        ${element}=    Get WebElement    ${locator}
        ${required}=    Execute Javascript    return arguments[0].required;    ARGUMENTS    ${element}
        RETURN    ${required}
    END
    RETURN    ${FALSE}

Open Sign Up Page Fresh
    [Documentation]    Opens home page then navigates to sign-up page for isolated scenario checks.
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${HOME_READY_TEXT}    ${DEFAULT_TIMEOUT}
    Go To Sign Up Page

Fill Registration Identity Fields
    [Arguments]    ${email}
    ${full_name_present}=    Run Keyword And Return Status    Page Should Contain Element    ${FULL_NAME_INPUT}
    IF    ${full_name_present}
        Input Text    ${FULL_NAME_INPUT}    Test User
    ELSE
        Input Text    ${FIRST_NAME_INPUT}    Test
        Input Text    ${LAST_NAME_INPUT}    User
    END
    Input Text    ${EMAIL_INPUT}    ${email}

Fill Registration Password Fields
    [Arguments]    ${password}
    Input Text    ${PASSWORD_INPUT}    ${password}
    ${confirm_password_present}=    Run Keyword And Return Status    Page Should Contain Element    ${CONFIRM_PASSWORD_INPUT}
    IF    ${confirm_password_present}
        Input Text    ${CONFIRM_PASSWORD_INPUT}    ${password}
    END

Get Field Validity If Present
    [Arguments]    ${locator}
    ${is_present}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
    IF    ${is_present}
        ${element}=    Get WebElement    ${locator}
        ${valid}=    Execute Javascript    return arguments[0].checkValidity();    ARGUMENTS    ${element}
        RETURN    ${valid}
    END
    RETURN    ${TRUE}

Get Custom Validation Message If Present
    [Arguments]    ${locator}
    ${is_present}=    Run Keyword And Return Status    Page Should Contain Element    ${locator}
    IF    ${is_present}
        ${element}=    Get WebElement    ${locator}
        ${message}=    Execute Javascript
        ...    const el = arguments[0];
        ...    const describedBy = (el.getAttribute('aria-describedby') || '').split(/\s+/).filter(Boolean);
        ...    const describedText = describedBy
        ...      .map(id => {
        ...          const node = document.getElementById(id);
        ...          return node ? node.innerText.trim() : '';
        ...      })
        ...      .filter(Boolean)
        ...      .join(' ');
        ...    if (describedText) { return describedText; }
        ...    const container = el.closest('form, [role="dialog"], body') || document.body;
        ...    const selectors = '[role=\"alert\"],[aria-live],.error,.field-error,[class*=\"error\"],[class*=\"invalid\"],[id*=\"error\"]';
        ...    const text = Array.from(container.querySelectorAll(selectors))
        ...      .map(n => (n.innerText || '').trim())
        ...      .filter(Boolean)
        ...      .join(' | ');
        ...    return text;
        ...    ARGUMENTS
        ...    ${element}
        RETURN    ${message}
    END
    RETURN    ${EMPTY}

Get Field Validation Feedback
    [Arguments]    ${locator}
    [Documentation]    Returns native message first, then custom message when native is empty.
    ${native_msg}=    Get Validation Message If Present    ${locator}
    IF    '${native_msg}' != '${EMPTY}'
        RETURN    ${native_msg}
    END
    ${custom_msg}=    Get Custom Validation Message If Present    ${locator}
    RETURN    ${custom_msg}

Get Non Empty Field Validation Feedback
    [Arguments]    ${locator}
    ${message}=    Get Field Validation Feedback    ${locator}
    Should Not Be Empty    ${message}
    RETURN    ${message}

Assert Still On Registration Page
    ${post_submit_url}=    Get Location
    Should Contain    ${post_submit_url}    ${SIGN_UP_URL_FRAGMENT}
    RETURN    ${post_submit_url}

Validate Invalid Email Scenario
    [Arguments]    ${invalid_email}
    Open Sign Up Page Fresh
    Fill Registration Identity Fields    ${invalid_email}
    Fill Registration Password Fields    ValidPass123!

    Click Sign Up Submit
    Wait Until Element Is Visible    ${SIGN_UP_SUBMIT_BUTTON}    ${DEFAULT_TIMEOUT}
    ${post_submit_url}=    Assert Still On Registration Page

    ${email_msg}=    Get Field Validation Feedback    ${EMAIL_INPUT}
    ${email_valid}=    Get Field Validity If Present    ${EMAIL_INPUT}
    Log    Invalid email '${invalid_email}' => url='${post_submit_url}', checkValidity=${email_valid}, validation message='${email_msg}'
    Run Keyword And Continue On Failure    Should Be True    not ${email_valid}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${email_msg}

Validate Invalid Password Scenario
    [Arguments]    ${invalid_password}
    Open Sign Up Page Fresh
    ${valid_email}=    Build Unique Email    test.user.password.check
    Fill Registration Identity Fields    ${valid_email}
    Fill Registration Password Fields    ${invalid_password}

    Click Sign Up Submit
    Wait Until Element Is Visible    ${SIGN_UP_SUBMIT_BUTTON}    ${DEFAULT_TIMEOUT}
    ${post_submit_url}=    Assert Still On Registration Page

    ${password_msg}=    Wait Until Keyword Succeeds    10s    500ms    Get Non Empty Field Validation Feedback    ${PASSWORD_INPUT}
    ${password_valid}=    Get Field Validity If Present    ${PASSWORD_INPUT}
    Log    Invalid password '${invalid_password}' => url='${post_submit_url}', checkValidity=${password_valid}, validation message='${password_msg}'
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
