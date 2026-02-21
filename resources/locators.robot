*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
${SIGN_IN_BUTTON}               css=button[component='SignInButton']
${EMAIL_IDENTIFIER_FIELD}       css=#identifier-field
${EMAIL_CONTINUE_BTN}           xpath=//span[@class='cl-internal-2iusy0']
${PASSWORD_FIELD}               css=#password-field
${PASSWORD_CONTINUE_BTN}        xpath=//span[@class='cl-internal-2iusy0']
${PROFILE_ICON}                 css=div[data-clerk-component$='UserButton']
${MANAGE_ACCOUNT}               xpath=//button[normalize-space()='Manage account']
${ACCOUNT_MODAL}                css=div[role='dialog']
${PROFILE_DETAIL}               xpath=//h1[normalize-space()='Profile details']
${MANAGE_YOUR_ACCOUNT}          xpath=//p[@class='cl-internal-lzddlw']
${SIDEBAR_PROFILE_OPTION}       xpath=//span[contains(.,'Profile')]
${SIDEBAR_SECURITY_OPTION}      xpath=//span[contains(.,'Security')]