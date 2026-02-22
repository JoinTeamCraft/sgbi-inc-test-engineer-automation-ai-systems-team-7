*** Settings ***
Library    SeleniumLibrary
Resource   locators.robot
Resource   variables.robot

*** Keywords ***

Open MoRent Website
    Open Browser    https://morent-car.archisacademy.com/    chrome
Open MoRent Home Page
    [Documentation]    Opens the MoRent homepage and waits until main content is visible.
    ${base_url}=    Set Variable    ${BASE_URL}
    ${browser}=    Set Variable    chrome
    ${timeout}=    Set Variable    10s
    ${browser_lower}=    Evaluate    str("""${browser}""").lower()
    IF    '${browser_lower}' == 'chrome'
        ${open_status}    ${open_msg}=    Run Keyword And Ignore Error    Open Chrome Browser Less Detectable    ${base_url}
        IF    '${open_status}' == 'FAIL'
            Open Browser    ${base_url}    ${browser}
        END
    ELSE
        Open Browser    ${base_url}    ${browser}
    END
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    20s

Go To Login Page
    Click Element    ${LOGIN_BUTTON}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    20s

Login With Valid Credentials
    Wait Until Element Is Visible    ${EMAIL_INPUT}    20s
    Clear Element Text    ${EMAIL_INPUT}
    Input Text    ${EMAIL_INPUT}    ${VALID_EMAIL}
    Press Keys    ${EMAIL_INPUT}    TAB

    Wait Until Element Is Visible    ${SUBMIT_BUTTON}    20s
    Click Element    ${SUBMIT_BUTTON}

    Wait Until Element Is Visible    ${PASSWORD_INPUT}    30s
    Clear Element Text    ${PASSWORD_INPUT}
    Input Password    ${PASSWORD_INPUT}    ${VALID_PASSWORD}

    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}    20s
    Click Element    ${SUBMIT_BUTTON}

    # OTP Handling (Optional)
    ${otp_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${OTP_INPUT}    10s

    IF    ${otp_visible}
        Clear Element Text    ${OTP_INPUT}
        Input Text    ${OTP_INPUT}    ${OTP_CODE}
        Press Keys    ${OTP_INPUT}    ENTER
    END

Verify User Is Logged In
    Wait Until Element Is Visible    ${SIGNOUT_BUTTON}       20s
    Element Should Be Visible       ${SIGNOUT_BUTTON}

    Log    User login verified successfully 
    Wait Until Element Is Visible    ${HOME_READY_TEXT}    ${timeout}

Open Chrome Browser Less Detectable
    [Arguments]    ${base_url}
    [Documentation]    Starts Chrome with options that reduce basic automation fingerprinting.
    ${chrome_options}=    Evaluate    __import__('selenium.webdriver').webdriver.ChromeOptions()
    Call Method    ${chrome_options}    add_argument    --disable-blink-features=AutomationControlled
    Call Method    ${chrome_options}    add_argument    --disable-infobars
    Call Method    ${chrome_options}    add_argument    --no-default-browser-check
    Call Method    ${chrome_options}    add_argument    --no-first-run
    ${exclude_switches}=    Create List    enable-automation
    Call Method    ${chrome_options}    add_experimental_option    excludeSwitches    ${exclude_switches}
    Call Method    ${chrome_options}    add_experimental_option    useAutomationExtension    ${False}
    Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${base_url}
    Run Keyword And Ignore Error    Execute Javascript    Object.defineProperty(navigator, 'webdriver', {get: () => undefined})

Go To Sign Up Page
    [Documentation]    Navigates from homepage to the registration form.
    Wait Until Element Is Visible    ${SIGN_IN_BUTTON}    10s
    Click Button    ${SIGN_IN_BUTTON}
    ${handles}=    Get Window Handles
    ${handle_count}=    Get Length    ${handles}
    IF    ${handle_count} > 1
        Switch Window    NEW
    END
    Wait Until Element Is Visible    ${SIGN_UP_LINK}    10s
    Click Element    ${SIGN_UP_LINK}
    Wait Until Element Is Visible    ${SIGN_UP_HEADING}    10s

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

Submit Registration Form Handling Human Check
    [Documentation]    Submits registration; if Cloudflare challenge appears, wait for manual completion.
    Click Sign Up Submit
    Sleep    1s
    ${still_on_signup}=    Run Keyword And Return Status    Assert Still On Registration Page
    IF    ${still_on_signup}
        ${human_check_present}=    Run Keyword And Return Status    Page Should Contain Element    ${HUMAN_VERIFY_TEXT}
        IF    ${human_check_present}
            Log To Console    Cloudflare human verification is shown. Complete it and click Continue manually.
            Wait Until Keyword Succeeds    1m    1s    Registration Should Move Past Sign Up
            RETURN
        END
    END

Registration Should Move Past Sign Up
    ${current_url}=    Get Location
    Should Not Contain    ${current_url}    ${SIGN_UP_URL_FRAGMENT}

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
    ${post_submit_url}=    Assert Still On Registration Page

    ${password_msg}=    Wait Until Keyword Succeeds    10s    500ms    Get Non Empty Field Validation Feedback    ${PASSWORD_INPUT}
    ${password_valid}=    Get Field Validity If Present    ${PASSWORD_INPUT}
    Log    Invalid password '${invalid_password}' => url='${post_submit_url}', checkValidity=${password_valid}, validation message='${password_msg}'
    Run Keyword And Continue On Failure    Should Be True    not ${password_valid}
    Run Keyword And Continue On Failure    Should Not Be Empty    ${password_msg}

Build Repeatable Registration Email
    [Arguments]    ${base_email}=morent+clerk_test@example.com
    [Documentation]    Uses a fixed registration email.
    RETURN    ${base_email}

Fill Valid Registration Details
    [Arguments]    ${email}
    Fill Registration Identity Fields    ${email}
    Fill Registration Password Fields    ValidPass123!

Assert No Visible Registration Errors
    [Documentation]    Verifies no visible validation/error indicators are shown after submit.
    ${visible_errors}=    Execute Javascript
    ...    const selectors = '[role="alert"],[class*="error"],[id*="error"],.cl-formFieldErrorText,.cl-alertText,[data-localization-key*="error"],[data-localization-key*="invalid"]';
    ...    const errWords = /(error|invalid|required|incorrect|must|too short|too weak|already exists|already in use)/i;
    ...    const visible = (el) => {
    ...      const style = window.getComputedStyle(el);
    ...      return style && style.display !== 'none' && style.visibility !== 'hidden' && el.getClientRects().length > 0;
    ...    };
    ...    return Array.from(document.querySelectorAll(selectors))
    ...      .filter(visible)
    ...      .map(el => (el.innerText || '').trim())
    ...      .filter(t => t && errWords.test(t))
    ...      .join(' | ');
    Should Be Empty    ${visible_errors}

Wait For Registration Success Indicator
    [Documentation]    Accepts either OTP/verification screen signal or navigation away from sign-up.
    Wait Until Keyword Succeeds    10s    1s    Registration Success Indicator Should Be Visible

Registration Success Indicator Should Be Visible
    ${current_url}=    Get Location
    ${moved_from_signup}=    Evaluate    'sign-up' not in """${current_url}"""
    IF    ${moved_from_signup}
        RETURN
    END
    Page Should Contain Element    ${OTP_SUCCESS_INDICATOR}

Pause For Manual OTP Completion
    [Documentation]    Manual step: complete OTP while test waits for verification flow to finish.
    Log To Console    Complete OTP verification manually in the browser. Waiting for redirect...
    Wait Until Keyword Succeeds    45s    1s    OTP Flow Should Be Completed

OTP Flow Should Be Completed
    ${current_url}=    Get Location
    ${otp_complete}=    Evaluate    'verify' not in """${current_url}""" and 'verification' not in """${current_url}""" and 'sign-up' not in """${current_url}"""
    Should Be True    ${otp_complete}

Verify Redirected To Login Or Home Page
    [Documentation]    Verifies final URL lands on expected destination after successful registration.
    Wait Until Keyword Succeeds    30s    1s    Redirect Should Be Login Or Home

Redirect Should Be Login Or Home
    ${current_url}=    Get Location
    ${is_home}=    Evaluate    'morent-car.archisacademy.com' in """${current_url}""" and 'sign-up' not in """${current_url}""" and 'verify' not in """${current_url}"""
    ${is_login}=    Evaluate    'sign-in' in """${current_url}""" or 'login' in """${current_url}"""
    Should Be True    ${is_home} or ${is_login}
