*** Settings ***
Library    SeleniumLibrary

Resource    ../../data/common_properties.robot
Resource    ../../resources/pages/login_resource/login_action.robot
Resource    ../../resources/pages/login_resource/login_result.robot
Resource    ../../resources/pages/dashboard_resource/dashboard_action.robot
Resource    ../../resources/pages/dashboard_resource/dashboard_result.robot
Resource    ../../resources/common_resources.robot
Resource    ../../resources/utilities/utility_keywords.robot

Test Teardown    Run Keyword If Test Failed    Take Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***

Verify Dashboard Loads After Successful Login
    [Tags]    Smoke    Dashboard    Regression
    [Documentation]    Verify the dashboard main area and title render after successful login
    [Setup]    Set Up Web Test Environment

    Given User Opens The Dashboard    ${ENV}    ${COUNTRY}
    And Login Page Should Load Successfully
    And User Enters Valid Email For Login
    And User Enters Valid Password For Login
    And User Clicks Submit Button

    Then Dashboard Page Should Load Successfully

Verify All Dashboard Widgets Are Visible
    [Tags]    Smoke    Dashboard    Widgets
    [Documentation]    Verify all four KPI widgets (active users, messages, response time, satisfaction) are displayed
    [Setup]    Set Up Web Test Environment

    Given User Opens The Dashboard    ${ENV}    ${COUNTRY}
    And User Enters Valid Email For Login
    And User Enters Valid Password For Login
    And User Clicks Submit Button

    Then All Dashboard Widgets Should Be Visible
    And Dashboard Chart Should Be Rendered

Verify Dashboard Sidebar Navigation Is Accessible
    [Tags]    Regression    Dashboard    Navigation
    [Documentation]    Verify sidebar navigation renders and can be collapsed/expanded
    [Setup]    Set Up Web Test Environment

    Given User Opens The Dashboard    ${ENV}    ${COUNTRY}
    And User Enters Valid Email For Login
    And User Enters Valid Password For Login
    And User Clicks Submit Button
    And Sidebar Navigation Should Be Visible

    When User Toggles The Sidebar

    Then Sidebar Navigation Should Be Visible

Verify User Can Log Out From Dashboard
    [Tags]    Smoke    Dashboard    Auth
    [Documentation]    Verify logout from dashboard menu redirects back to login page
    [Setup]    Set Up Web Test Environment

    Given User Opens The Dashboard    ${ENV}    ${COUNTRY}
    And User Enters Valid Email For Login
    And User Enters Valid Password For Login
    And User Clicks Submit Button
    And Dashboard Page Should Load Successfully

    When User Logs Out From Dashboard

    Then User Should Be Returned To Login Page After Logout
