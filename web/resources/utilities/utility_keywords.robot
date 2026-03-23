*** Settings ***

Library    SeleniumLibrary
Library    DateTime
Library    OperatingSystem
Library    JSONLibrary
Library    FakerLibrary

Resource    ../../data/common_properties.robot
Resource    ../../data/testdata/contents.robot

*** Keywords ***

# ============================================================================
# Utility Keywords
# Reusable helper functions for common operations
# ============================================================================

Get Timestamp For Screenshot
    [Documentation]    Return compact timestamp string for use in screenshot filenames
    ${timestamp}=      Get Current Date    result_format=%d%m%H%M%S
    RETURN             ${timestamp}

Wait For Element And Click
    [Documentation]    Wait for element to be visible, then click it
    [Arguments]        ${locator}    ${timeout}=${default_timeout}
    Wait Until Element Is Visible  ${locator}    ${timeout}
    Click Element                  ${locator}

Wait For Element And Type
    [Documentation]    Wait for element to be visible, clear it, then type text
    [Arguments]        ${locator}    ${text}    ${timeout}=${default_timeout}
    Wait Until Element Is Visible  ${locator}    ${timeout}
    Clear Element Text             ${locator}
    Input Text                     ${locator}    ${text}

Page Should Contain Element With Text
    [Documentation]    Verify page contains both element and specific text
    [Arguments]        ${locator}    ${text}
    Wait Until Page Contains Element    ${locator}
    Wait Until Page Contains            ${text}

Scroll To Element
    [Documentation]    Scroll page to make element visible
    [Arguments]        ${locator}
    Scroll Element Into View    ${locator}

Take Screenshot
    [Documentation]    Capture screenshot with timestamp in filename
    ${timestamp}=      Get Timestamp For Screenshot
    Capture Page Screenshot    screenshots/screenshot_${timestamp}.png

Close All Windows And Logs
    [Documentation]    Close all open browser windows
    Close All Browsers

Generate Random Test User Data
    [Documentation]    Generate realistic-looking random test user data using FakerLibrary
    ...                Demonstrates dynamic test data generation to avoid hardcoded values
    ...                Useful for tests that require unique emails or names across parallel runs
    ${random_email}=     FakerLibrary.Email
    ${random_name}=      FakerLibrary.Name
    ${random_company}=   FakerLibrary.Company
    RETURN               ${random_email}    ${random_name}    ${random_company}
