*** Settings ***

Library    SeleniumLibrary

Resource    ../../../data/locators/login_page_locators.robot
Resource    ../../../data/common_properties.robot
Resource    ../../../data/testdata/contents.robot

*** Keywords ***

User Should See Login Popup
    [Documentation]    Verify login popup is displayed
    Wait Until Page Contains    ${LOGIN_POPUP}    ${default_timeout}
    Element Should Be Visible    ${login_page_title}

User Should Be On Dashboard After Login
    [Documentation]    Verify user is logged in and on dashboard
    Wait Until Page Contains    ${DASHBOARD_TITLE}    ${default_timeout}
    Wait Until Page Contains    ${SUMMARY}    ${default_timeout}
    Element Should Be Visible    ${dashboard_landing_page}

User Should See Invalid Credentials Error
    [Documentation]    Verify error message for invalid credentials
    Wait Until Page Contains    ${ERROR_INVALID_CREDENTIALS}    ${default_timeout}
    Element Should Be Visible    ${error_message_invalid_credentials}

User Should See Required Field Error
    [Documentation]    Verify error message for required fields
    Element Should Be Visible    ${error_message_required_field}

User Should See Login Button
    [Documentation]    Verify submit button is visible
    Element Should Be Visible    ${submit_button}

Email Field Should Be Visible
    [Documentation]    Verify email input field is visible
    Element Should Be Visible    ${email_field}

Password Field Should Be Visible
    [Documentation]    Verify password input field is visible
    Element Should Be Visible    ${password_field}

Forgot Password Link Should Be Visible
    [Documentation]    Verify forgot password link is visible
    Element Should Be Visible    ${forgot_password_link}

Login Page Should Load Successfully
    [Documentation]    Verify entire login page loads correctly
    Email Field Should Be Visible
    Password Field Should Be Visible
    User Should See Login Button
    Forgot Password Link Should Be Visible

User Should Be Logged Out
    [Documentation]    Verify user is logged out (back on login page)
    Wait Until Page Contains    ${LOGIN_POPUP}    ${default_timeout}
    Element Should Not Be Visible    ${dashboard_landing_page}

User Should See Login Error Message
    [Documentation]    Verify any login error message is displayed (invalid credentials or required field)
    TRY
        User Should See Invalid Credentials Error
    EXCEPT
        User Should See Required Field Error
    END
