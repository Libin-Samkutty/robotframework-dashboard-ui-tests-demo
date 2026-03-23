*** Settings ***
Library     SeleniumLibrary
Library     DataDriver    file=../../data/testdata/login_credentials.csv    encoding=utf-8

Resource    ../../data/common_properties.robot
Resource    ../../resources/pages/login_resource/login_action.robot
Resource    ../../resources/pages/login_resource/login_result.robot
Resource    ../../resources/common_resources.robot
Resource    ../../resources/utilities/utility_keywords.robot

Test Template     Verify Login Behavior With Credentials
Test Teardown     Run Keyword If Test Failed    Take Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***
Verify Login Behavior With Credentials    ${email}    ${password}    ${expected_outcome}    ${test_tag}

*** Keywords ***

Verify Login Behavior With Credentials
    [Documentation]    Template keyword - receives row data from DataDriver CSV
    ...                Tests various login scenarios: valid credentials, invalid email, wrong password, empty fields
    [Arguments]        ${email}    ${password}    ${expected_outcome}    ${test_tag}
    [Tags]    DataDriven    Login    ${test_tag}
    [Setup]    Set Up Web Test Environment

    Given User Opens The Dashboard    ${ENV}    ${COUNTRY}
    And Login Page Should Load Successfully

    When User Enters Email For Login    ${email}
    And User Enters Password For Login    ${password}
    And User Clicks Submit Button

    IF    '${expected_outcome}' == 'dashboard'
        Then User Should Be On Dashboard After Login
    ELSE IF    '${expected_outcome}' == 'error'
        Then User Should See Login Error Message
    ELSE
        Fail    Unknown expected outcome: ${expected_outcome}
    END
