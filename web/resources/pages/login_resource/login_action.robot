*** Settings ***

Library    SeleniumLibrary

Resource    ../../../data/locators/login_page_locators.robot
Resource    ../../../data/common_properties.robot
Resource    ../../../data/testdata/stage/stage_testdata.robot
Resource    ../../../data/testdata/stage/login_testdata.robot
Resource    ../../../data/testdata/prod/prod_testdata.robot
Resource    ../../utilities/utility_keywords.robot

*** Keywords ***

User Opens The Dashboard
    [Documentation]    Open the Dashboard in specified environment
    [Arguments]        ${env}=STAGING    ${country}=INDIA
    IF    '${env}' == 'STAGING' and '${country}' == 'INDIA'
        ${url}    Set Variable    ${stage_url_india}
    ELSE IF    '${env}' == 'STAGING' and '${country}' == 'KENYA'
        ${url}    Set Variable    ${stage_url_eu}
    ELSE IF    '${env}' == 'PROD' and '${country}' == 'INDIA'
        ${url}    Set Variable    ${prod_url_india}
    ELSE IF    '${env}' == 'PROD' and '${country}' == 'KENYA'
        ${url}    Set Variable    ${prod_url_eu}
    ELSE
        Log To Console    Invalid environment or country specified
        Fail    Invalid environment: ${env}, country: ${country}
    END
    Open Browser    ${url}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains    ${LOGIN_POPUP}    ${default_timeout}

User Enters Valid Email For Login
    [Documentation]    Enter valid email in login form
    Wait Until Element Is Visible    ${email_field}    ${default_timeout}
    Input Text    ${email_field}    ${login_email}

User Enters Valid Password For Login
    [Documentation]    Enter valid password in login form
    Wait Until Element Is Visible    ${password_field}    ${default_timeout}
    Input Text    ${password_field}    ${login_password}

User Enters Invalid Email For Login
    [Documentation]    Enter invalid email for negative testing
    Wait Until Element Is Visible    ${email_field}    ${default_timeout}
    Input Text    ${email_field}    ${invalid_email}

User Enters Invalid Password For Login
    [Documentation]    Enter invalid password for negative testing
    Wait Until Element Is Visible    ${password_field}    ${default_timeout}
    Input Text    ${password_field}    ${invalid_password}

User Clicks Submit Button
    [Documentation]    Click the submit/login button
    Wait Until Element Is Visible    ${submit_button}    ${default_timeout}
    Click Element    ${submit_button}

User Clicks Forgot Password Link
    [Documentation]    Click forgot password link
    Wait Until Element Is Visible    ${forgot_password_link}    ${default_timeout}
    Click Element    ${forgot_password_link}

User Logs Out From The Application
    [Documentation]    Click logout and close browser
    Wait Until Page Contains Element    ${logout_button}    ${default_timeout}
    Click Element    ${logout_button}
    Close Browser

User Clears Email Field
    [Documentation]    Clear the email input field
    Wait Until Element Is Visible    ${email_field}    ${default_timeout}
    Clear Element Text    ${email_field}

User Clears Password Field
    [Documentation]    Clear the password input field
    Wait Until Element Is Visible    ${password_field}    ${default_timeout}
    Clear Element Text    ${password_field}

User Enters Email For Login
    [Documentation]    Enter email for login (parameterized for data-driven tests)
    [Arguments]        ${email}
    Wait Until Element Is Visible    ${email_field}    ${default_timeout}
    Clear Element Text    ${email_field}
    Input Text    ${email_field}    ${email}

User Enters Password For Login
    [Documentation]    Enter password for login (parameterized for data-driven tests)
    [Arguments]        ${password}
    Wait Until Element Is Visible    ${password_field}    ${default_timeout}
    Clear Element Text    ${password_field}
    Input Text    ${password_field}    ${password}
