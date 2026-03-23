*** Settings ***
Library    RequestsLibrary
Library    Collections

Resource    ../../resources/common_resources.robot
Resource    ../../data/common_properties.robot
Resource    ../../data/testdata/common_error_messages.robot

Suite Setup    Create API Session With Staging Environment
Suite Teardown    Close API Session

*** Test Cases ***

Verify Unauthorized Request Returns 401 Unauthorized
    [Tags]    Negative    API    Auth    Security
    [Documentation]    Verify request with missing/invalid authentication token returns 401 Unauthorized

    Create Session    no_auth_session    ${api_base_url_staging}    verify=True
    ${response}=    GET On Session    no_auth_session    ${health_check_endpoint}    expected_status=401
    Response Should Have Status Code    ${response}    401
    Response Should Contain Key    ${response}    error

Verify Unknown Endpoint Returns 404 Not Found
    [Tags]    Negative    API    NotFound    Routing
    [Documentation]    Verify request to non-existent endpoint returns 404 Not Found

    ${response}=    Make GET Request To API    /nonexistent-endpoint-xyz    404
    Response Should Have Status Code    ${response}    404

Verify Malformed Request Returns 400 Bad Request
    [Tags]    Negative    API    Validation    BadRequest
    [Documentation]    Verify malformed POST payload with invalid structure returns 400 Bad Request

    ${payload}=    Create Dictionary    invalid_field=invalid_value
    ${response}=    Make POST Request To API    ${health_check_endpoint}    ${payload}    400
    Response Should Have Status Code    ${response}    400
    Response Should Contain Key    ${response}    error
    Store JSON Response And Status Code    ${response}
