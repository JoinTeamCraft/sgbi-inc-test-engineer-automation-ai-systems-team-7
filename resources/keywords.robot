*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Library           ../config/env_config.py
Library           ../python_lib/validators.py
Resource          locators.robot

*** Keywords ***
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
    Wait Until Element Is Visible    ${SIGN_IN_BUTTON}    20s
    Click Button    ${SIGN_IN_BUTTON}
    Sleep    2s
    ${handles}=    Get Window Handles
    ${handle_count}=    Get Length    ${handles}
    IF    ${handle_count} > 1
        Switch Window    NEW
    END
    Wait Until Element Is Visible    ${SIGN_UP_LINK}    20s
    Wait Until Keyword Succeeds    10s    1s    Click Element    ${SIGN_UP_LINK}
    Wait Until Element Is Visible    ${SIGN_UP_HEADING}    20s

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
    Wait Until Element Is Visible    ${HOME_READY_TEXT}    20s
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
    Wait Until Element Is Visible    ${SIGN_UP_SUBMIT_BUTTON}    10s
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
    Wait Until Element Is Visible    ${SIGN_UP_SUBMIT_BUTTON}    10s
    Sleep    3s
    ${post_submit_url}=    Assert Still On Registration Page

    ${password_msg}=    Get Field Validation Feedback    ${PASSWORD_INPUT}
    ${password_valid}=    Get Field Validity If Present    ${PASSWORD_INPUT}
    Log    Invalid password '${invalid_password}' => url='${post_submit_url}', checkValidity=${password_valid}, validation message='${password_msg}'
    Run Keyword And Continue On Failure    Should Not Be Empty    ${password_msg}
