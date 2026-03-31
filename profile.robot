*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}            https://morent-car.archisacademy.com/
${BROWSER}        chrome

${SIGN_IN_BTN}    xpath=//button[contains(text(),'Sign in')]

${EMAIL_FIELD}    id=identifier-field
${EMAIL_CONT}     xpath=//button[contains(@class,'cl-formButtonPrimary')]

${PASS_FIELD}     id=password-field
${PASS_CONT}      xpath=//button[contains(@class,'cl-formButtonPrimary')]

${OTP_FIELD}      xpath=//input[@inputmode='numeric']

# Account Navigation
${AVATAR_IMG}     xpath=//img[contains(@class,'cl-userButtonAvatarImage')]
${MANAGE_ACC}     xpath=//button[contains(.,'Manage account')]

# Profile Verification
${PROFILE_AVATAR}    css=img.cl-userPreviewAvatarImage
${PROFILE_NAME}      xpath=//span[contains(@class,'cl-userPreviewMainIdentifierText')]
${PROFILE_EMAIL}     xpath=//p[contains(text(),'doe+clerk_test@example.com')]
${EMAIL_STATUS}      xpath=//*[contains(text(),'Primary') or contains(text(),'Unverified')]
${UPDATE_PROFILE}    xpath=//*[contains(text(),'Update profile')]
${EXPECTED_ALT}      test morent's logo


*** Test Cases ***
Login And Verify Account Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    # ---- Click Sign In ----
    Wait Until Element Is Visible    ${SIGN_IN_BTN}    20s
    Click Element    ${SIGN_IN_BTN}

    # ---- Enter Email ----
    Wait Until Element Is Visible    ${EMAIL_FIELD}    20s
    Input Text    ${EMAIL_FIELD}    doe+clerk_test@example.com
    Click Element    ${EMAIL_CONT}

    # ---- Enter Password ----
    Wait Until Element Is Visible    ${PASS_FIELD}    20s
    Input Text    ${PASS_FIELD}    morenttest@12345
    Click Element    ${PASS_CONT}

    # ---- Enter OTP ----
    Wait Until Element Is Visible    ${OTP_FIELD}    20s
    Input Text    ${OTP_FIELD}    424242

    Sleep    3s

    # ---- Click Avatar ----
    Wait Until Element Is Visible    ${AVATAR_IMG}    20s
    Click Element    ${AVATAR_IMG}

    # ---- Click Manage Account ----
    Wait Until Element Is Visible    ${MANAGE_ACC}    10s
    Click Element    ${MANAGE_ACC}

    # ---- Verify Profile Avatar ----
    Wait Until Page Contains Element    ${PROFILE_AVATAR}    timeout=15s
    Element Should Be Visible           ${PROFILE_AVATAR}
    Element Attribute Value Should Be   ${PROFILE_AVATAR}    alt    ${EXPECTED_ALT}

    # ---- Verify Profile Name ----
    Element Should Be Visible    ${PROFILE_NAME}

    # ---- Verify Email ----
    Element Should Be Visible    ${PROFILE_EMAIL}

    # ---- Verify Email Status ----
    Element Should Be Visible    ${EMAIL_STATUS}

    # ---- Verify Update Profile Option ----
    Element Should Be Visible    ${UPDATE_PROFILE}

    Close Browser