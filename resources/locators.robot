*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
${BASE_URL}                     https://morent-car.archisacademy.com/
${HOME_READY_TEXT}              xpath=//*[contains(.,'The Best Platform for Car Rental')]
${SIGN_IN_BUTTON}               xpath=//button[normalize-space()='Sign in']
${SIGN_UP_LINK}                 xpath=//*[normalize-space()='Sign up']
${SIGN_UP_HEADING}              xpath=//*[contains(.,'Create your account')]
${SIGN_UP_SUBMIT_BUTTON}        xpath=//button[normalize-space()='Continue']
${SIGN_UP_URL_FRAGMENT}         sign-up
${VERIFY_URL_FRAGMENT}          verify
${LOGIN_URL_FRAGMENT}           sign-in
${OTP_SUCCESS_INDICATOR}        xpath=//*[contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'verify') or contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'verification') or contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'code')]
${HUMAN_VERIFY_TEXT}            xpath=//*[contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'verify you are human')]

${FULL_NAME_INPUT}              id=fullName-field
${FIRST_NAME_INPUT}             id=firstName-field
${LAST_NAME_INPUT}              id=lastName-field
${EMAIL_INPUT}                  id=emailAddress-field
${PASSWORD_INPUT}               id=password-field
${CONFIRM_PASSWORD_INPUT}       id=confirmPassword-field
