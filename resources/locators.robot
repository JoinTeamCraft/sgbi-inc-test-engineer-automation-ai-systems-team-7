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

${FULL_NAME_INPUT}              id=fullName-field
${FIRST_NAME_INPUT}             id=firstName-field
${LAST_NAME_INPUT}              id=lastName-field
${EMAIL_INPUT}                  id=emailAddress-field
${PASSWORD_INPUT}               id=password-field
${CONFIRM_PASSWORD_INPUT}       id=confirmPassword-field
