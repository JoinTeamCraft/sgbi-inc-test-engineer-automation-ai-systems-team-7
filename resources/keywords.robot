*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          locators.robot

*** Keywords ***
Open MoRent Home Page
    [Documentation]    Opens the MoRent homepage and waits until main content is visible.
    Open Browser    ${BASE_URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${HOME_READY_TEXT}    20s

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
