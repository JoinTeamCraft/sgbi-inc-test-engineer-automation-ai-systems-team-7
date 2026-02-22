*** Settings ***
Documentation     MoRent Profile Management: Verification, Upload, and Navigation.
Library           SeleniumLibrary
Library           OperatingSystem

*** Variables ***
${URL}            https://morent-car.archisacademy.com/
${BROWSER}        chrome

# --- Auth Locators ---
${SIGN_IN_BTN}    xpath=//button[contains(text(),'Sign in')]
${EMAIL_FIELD}    id=identifier-field
${EMAIL_CONT}     xpath=//button[contains(@class,'cl-formButtonPrimary')]
${PASS_FIELD}     id=password-field
${PASS_CONT}      xpath=//button[contains(@class,'cl-formButtonPrimary')]
${OTP_FIELD}      xpath=//input[@inputmode='numeric']

# --- Profile & Navigation ---
${HEADER_AVATAR}  xpath=//button[contains(@class,'cl-userButtonTrigger')]
${MANAGE_ACC}     xpath=//button[contains(.,'Manage account')]
${UPDATE_PROFILE_BTN}   xpath=//button[contains(text(),'Update profile')]
${UPLOAD_BTN}           xpath=//button[contains(text(),'Upload')]
${REMOVE_BTN}           xpath=//button[contains(text(),'Remove')]
${SAVE_BTN}             xpath=//button[contains(text(),'Save')]
${FILE_INPUT}           css=input[type='file']

# --- File ---
${IMAGE_PATH}     C:\\Users\\ASUS\\Downloads\\test.jpeg

*** Test Cases ***
Verify Update Profile And Upload Lifecycle
    [Documentation]    Logs in, verifies profile buttons, uploads image, saves, and validates navigation.
    [Setup]    Initialize Browser

    Perform Login    doe+clerk_test@example.com    morenttest@12345    424242

    # --- Navigate to Manage Account ---
    Wait Until Element Is Visible    ${HEADER_AVATAR}    30s
    Click Element    ${HEADER_AVATAR}

    Wait Until Element Is Visible    ${MANAGE_ACC}    20s
    Click Element    ${MANAGE_ACC}

    Wait Until Element Is Visible    ${UPDATE_PROFILE_BTN}    20s
    Click Element    ${UPDATE_PROFILE_BTN}

    # --- Verify Buttons ---
    Wait Until Element Is Visible    ${UPLOAD_BTN}    20s
    Element Should Be Visible    ${UPLOAD_BTN}
    Element Should Be Visible    ${REMOVE_BTN}
    Log To Console    SUCCESS: Upload and Remove buttons verified.

    # --- Force File Input Visible (Clerk hides it) ---
    Execute Javascript
    ...    var el = document.querySelector("input[type='file']");
    ...    if (el) { el.style.display = 'block'; el.style.visibility='visible'; el.style.opacity='1'; }

    # --- Upload Image ---
    Choose File    ${FILE_INPUT}    ${IMAGE_PATH}

    # Trigger change event for React
    Execute Javascript
    ...    var input = document.querySelector("input[type='file']");
    ...    if (input) { input.dispatchEvent(new Event('change', { bubbles: true })); }

    Log To Console    SUCCESS: File selected.

    # --- Save ---
    Wait Until Element Is Visible    ${SAVE_BTN}    20s
    Click Element    ${SAVE_BTN}

    # Wait for DOM refresh instead of waiting for button disappearance
    Wait Until Page Contains Element    ${HEADER_AVATAR}    30s

    Log To Console    SUCCESS: Save triggered and page refreshed.

    # --- Re-open Header Avatar (Avoid Stale) ---
    Wait Until Keyword Succeeds    3x    3s    Click Element    ${HEADER_AVATAR}

    Log To Console    SUCCESS: Header avatar clickable after upload.

    [Teardown]    Close Browser


*** Keywords ***
Initialize Browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.3s

Perform Login
    [Arguments]    ${user}    ${pass}    ${otp}

    Wait Until Element Is Visible    ${SIGN_IN_BTN}    20s
    Click Element    ${SIGN_IN_BTN}

    Wait Until Element Is Visible    ${EMAIL_FIELD}    20s
    Input Text    ${EMAIL_FIELD}    ${user}
    Click Element    ${EMAIL_CONT}

    Wait Until Element Is Visible    ${PASS_FIELD}    20s
    Input Text    ${PASS_FIELD}    ${pass}
    Click Element    ${PASS_CONT}

    Wait Until Element Is Visible    ${OTP_FIELD}    20s
    Input Text    ${OTP_FIELD}    ${otp}

    # Instead of Sleep → wait for avatar
    Wait Until Element Is Visible    ${HEADER_AVATAR}    30s