*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
${SIGN_IN_BUTTON}               css=button[component='SignInButton']
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
${SIGN_UP_LINK}                 xpath=//*[normalize-space()='Sign up']
${SIGN_UP_HEADING}              xpath=//*[contains(.,'Create your account')]
${SIGN_UP_SUBMIT_BUTTON}        xpath=//button[normalize-space()='Continue']
${SIGN_UP_URL_FRAGMENT}         sign-up

${FULL_NAME_INPUT}              id=fullName-field
${FIRST_NAME_INPUT}             id=firstName-field
${LAST_NAME_INPUT}              id=lastName-field
${EMAIL_INPUT}                  id=emailAddress-field
${PASSWORD_INPUT}               id=password-field
${CONFIRM_PASSWORD_INPUT}       id=confirmPassword-field

${HOME_MAIN_CONTAINER}          css=main
${HOME_HERO_TITLE}              css=section[class*='_hero-section_5hshi_30']
${RENTAL_CAR_BUTTON}            xpath=//a[contains(normalize-space(),'Rental Car')]
${GENERIC_ERROR_TEXT}           xpath=//*[contains(text(),'404') or contains(text(),'500')]