*** Settings ***

Library    SeleniumLibrary

Resource    ../../data/common_properties.robot
Resource    ../../resources/pages/login_resource/login_action.robot
Resource    ../../resources/pages/login_resource/login_result.robot
Resource    ../../resources/utilities/utility_keywords.robot

Test Teardown    Run Keyword If Test Failed    Take Screenshot
Suite Teardown   Close All Browsers

*** Test Cases ***

Verify That The User Can Login With Valid Credentials
    [Tags]    Smoke    Login    Regression
    [Documentation]    Verify user can successfully login with valid email and password

    Given User Opens The Dashboard    ${ENV}    ${COUNTRY}
    And Login Page Should Load Successfully

    When User Enters Valid Email For Login
    And User Enters Valid Password For Login
    And User Clicks Submit Button

    Then User Should Be On Dashboard After Login

Verify Login Page Loads Correctly
    [Tags]    Smoke    Login
    [Documentation]    Verify login page UI elements are displayed correctly

    Given User Opens The Dashboard

    Then Login Page Should Load Successfully
    And Email Field Should Be Visible
    And Password Field Should Be Visible
    And Forgot Password Link Should Be Visible

Verify User Cannot Login With Invalid Email
    [Tags]    Regression    Login
    [Documentation]    Verify login fails with invalid email address

    Given User Opens The Dashboard
    And User Enters Invalid Email For Login
    And User Enters Valid Password For Login

    When User Clicks Submit Button

    Then User Should See Invalid Credentials Error

Verify User Cannot Login With Invalid Password
    [Tags]    Regression    Login
    [Documentation]    Verify login fails with incorrect password

    Given User Opens The Dashboard
    And User Enters Valid Email For Login
    And User Enters Invalid Password For Login

    When User Clicks Submit Button

    Then User Should See Invalid Credentials Error
