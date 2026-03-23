*** Settings ***

Library    RequestsLibrary
Library    Collections

Resource    ../../resources/common_resources.robot
Resource    ../../data/common_properties.robot

Suite Setup    Run Keyword If    '${ENV}' == 'STAGING'    Create API Session With Staging Environment    ELSE    Create API Session With Production Environment
Suite Teardown    Close API Session

*** Test Cases ***

Verify API Health Check Endpoint Returns 200
    [Tags]    Smoke    API    HealthCheck
    [Documentation]    Verify API health check endpoint is responsive

    ${response}=    Make GET Request To API    ${health_check_endpoint}
    Response Should Have Status Code    ${response}    200
    Store JSON Response And Status Code    ${response}

Verify API Version Endpoint Returns Valid Response
    [Tags]    Smoke    API    Version
    [Documentation]    Verify API version endpoint returns version information

    ${response}=    Make GET Request To API    ${version_endpoint}
    Response Should Have Status Code    ${response}    200
    Response Should Contain Key    ${response}    version
    Store JSON Response And Status Code    ${response}

Verify API Status Endpoint Is Accessible
    [Tags]    Smoke    API    Status
    [Documentation]    Verify API status endpoint is accessible and returns status

    ${response}=    Make GET Request To API    ${status_endpoint}
    Response Should Have Status Code    ${response}    200
