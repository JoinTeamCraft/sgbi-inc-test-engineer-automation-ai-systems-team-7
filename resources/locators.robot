*** Settings ***
Documentation     Common locators for MoRent application

*** Variables ***
${SIGNIN_CONTAINER}             css=div[data-clerk-component*='SignIn']
${EMAIL_IDENTIFIER_FIELD}       css=#identifier-field
${CONTINUE_BTN}                 xpath=//button[@data-localization-key='formButtonPrimary']
${PASSWORD_FIELD}               css=#password-field
${OTP_INPUT_FIELD}              xpath=//input[@autocomplete='one-time-code']
${PROFILE_ICON}                 css=div[data-clerk-component$='UserButton']
${MANAGE_ACCOUNT}               xpath=//button[normalize-space()='Manage account']
${ACCOUNT_MODAL}                xpath=//div[@role='dialog' and not(@aria-hidden='true')]
${PROFILE_DETAIL}               xpath=//div[@role='dialog']//h1[normalize-space()='Profile details']
${MANAGE_YOUR_ACCOUNT}          xpath=//div[@role='dialog']//p[contains(.,'Manage your account')]
${SIDEBAR_PROFILE_OPTION}       xpath=//div[@role='dialog']//span[normalize-space()='Profile']
${SIDEBAR_SECURITY_OPTION}      xpath=//div[@role='dialog']//span[normalize-space()='Security']
${BASE_URL}                     https://morent-car.archisacademy.com/
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

${HOME_MAIN_CONTAINER}          css=main
${RENTAL_CAR_BUTTON}            xpath=//a[contains(normalize-space(),'Rental Car')]
${GENERIC_ERROR_TEXT}           xpath=//*[contains(text(),'404') or contains(text(),'500')]

${HEADER_SECTION}               css=header
${APP_LOGO}                     xpath=//a[contains(normalize-space(),'MORENT')]
${HEADER_LEFT}                  css=div[class^='_header-left']
${HEADER_RIGHT}                 css=div[class^='_header-right']
${SEARCH_INPUT}                 css=input[type*='search']
${SEARCH_RESULT}                xpath=//div[contains(@class,'ant-select-item-option-content')]
${FAVOURITE_ICON}               css=button[aria-label='Favorite Icon']
${NOTIFICATION_ICON}            css=button[aria-label='Notification Icon']

${SHOW_PASSWORD}                css=button.cl-formFieldInputShowPasswordButton

