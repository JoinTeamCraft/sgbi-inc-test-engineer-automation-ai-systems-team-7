*** Settings ***
Documentation     Common locators for MoRent application

*** Variables ***
${HOME_READY_TEXT}              xpath=//*[contains(.,'The Best Platform for Car Rental')]
${SIGN_IN_BUTTON}               xpath=//button[normalize-space()='Sign in']
${SIGN_UP_LINK}                 xpath=//*[normalize-space()='Sign up']
${SIGN_UP_HEADING}              xpath=//*[contains(.,'Create your account')]
${SIGN_UP_SUBMIT_BUTTON}        xpath=//button[normalize-space()='Continue']
${SIGN_UP_URL_FRAGMENT}         sign-up
${VERIFY_URL_FRAGMENT}          verify
${LOGIN_URL_FRAGMENT}           sign-in
${OTP_SUCCESS_INDICATOR}        css=input[autocomplete='one-time-code']
${HUMAN_VERIFY_TEXT}            xpath=//*[contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'verify you are human')]

${FULL_NAME_INPUT}              id=fullName-field
${FIRST_NAME_INPUT}             id=firstName-field
${LAST_NAME_INPUT}              id=lastName-field
${SIGNUP_EMAIL_INPUT}           id=emailAddress-field
${SIGNUP_PASSWORD_INPUT}        id=password-field
${SIGNUP_CONFIRM_PASSWORD_INPUT}    id=confirmPassword-field

${LOGIN_BUTTON}            xpath=//button[normalize-space()='Sign in']
${EMAIL_INPUT}             id=identifier-field
${PASSWORD_INPUT}          xpath=//input[@type='password']
${SUBMIT_BUTTON}           css=button.cl-formButtonPrimary
${OTP_INPUT}               xpath=//input[@autocomplete='one-time-code']
${LOGIN_ERROR_MESSAGE}     xpath=//div[contains(@class,'error') or contains(@class,'cl-formFieldErrorText')]
${SIGNOUT_BUTTON}          xpath=//div[contains(@class,'profile')]//button[contains(.,'sign Out') or contains(.,'Logout')]


${PROFILE_ICON}               xpath=//button[contains(@class,'cl-userButtonTrigger')]
${MANAGE_ACCOUNT_BUTTON}      xpath=//button[normalize-space()='Manage account']

${CLERK_IFRAME}               xpath=//iframe[contains(@src,'accounts')]

${UPDATE_PROFILE_BUTTON}      xpath=//button[normalize-space()='Update profile']
${UPLOAD_BUTTON}              xpath=//button[normalize-space()='Upload']
${REMOVE_BUTTON}              xpath=//button[normalize-space()='Remove']
${SAVE_BUTTON}                xpath=//button[normalize-space()='Save']

${PROFILE_IMAGE}              xpath=//img[contains(@class,'cl-avatarImage')]
${HEADER_AVATAR}              xpath=//img[contains(@class,'cl-userButtonAvatar')]
${UPLOAD_BUTTON}              xpath=//button[normalize-space()='Upload']
${FILE_INPUT}                 xpath=//input[@type='file']
${HEADER_PROFILE_AVATAR}      css=img.cl-userButtonAvatarImage
${PROFILE_MODAL_CLOSE}    xpath=//svg[@aria-hidden='true']/ancestor::button
