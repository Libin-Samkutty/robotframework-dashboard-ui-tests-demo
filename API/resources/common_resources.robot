*** Settings ***

Library    RequestsLibrary
Library    String
Library    OperatingSystem
Library    Collections

Resource    ../data/common_properties.robot
Resource    ../data/testdata/common_error_messages.robot

*** Keywords ***

# ============================================================================
# API Common Keywords
# Setup, request, and response validation keywords
# ============================================================================

Create API Session With Staging Environment
    [Documentation]    Create RequestsLibrary session for staging API
    Create Session    ${api_session_name}    ${api_base_url_staging}    verify=True    max_retries=0

Create API Session With Production Environment
    [Documentation]    Create RequestsLibrary session for production API
    Create Session    ${api_session_name}    ${api_base_url_prod}    verify=True    max_retries=0

Create Request Headers For API
    [Documentation]    Create standard request headers with authentication
    ${headers}=        Create Dictionary
    ...                Content-Type=${default_content_type}
    ...                Accept=${default_accept}
    ...                Authorization=Bearer ${api_token}
    RETURN             ${headers}

Make GET Request To API
    [Documentation]    Make GET request to API endpoint
    [Arguments]        ${endpoint}    ${expected_status}=200
    ${headers}=        Create Request Headers For API
    ${response}=       GET On Session    ${api_session_name}    ${endpoint}    headers=${headers}    expected_status=${expected_status}
    RETURN             ${response}

Make POST Request To API
    [Documentation]    Make POST request to API endpoint
    [Arguments]        ${endpoint}    ${payload}    ${expected_status}=201
    ${headers}=        Create Request Headers For API
    ${response}=       POST On Session    ${api_session_name}    ${endpoint}    json=${payload}    headers=${headers}    expected_status=${expected_status}
    RETURN             ${response}

Response Should Have Status Code
    [Documentation]    Verify response has expected status code
    [Arguments]        ${response}    ${expected_status}
    Should Be Equal    ${response.status_code}    ${expected_status}

Response Should Contain Key
    [Documentation]    Verify response JSON contains expected key
    [Arguments]        ${response}    ${key}
    Dictionary Should Contain Key    ${response.json()}    ${key}

Response Should Contain Keys
    [Documentation]    Verify response JSON contains all expected keys
    [Arguments]        ${response}    @{keys}
    FOR    ${key}    IN    @{keys}
        Dictionary Should Contain Key    ${response.json()}    ${key}
    END

Get Response Value By Key
    [Documentation]    Extract value from response JSON by key
    [Arguments]        ${response}    ${key}
    ${value}=          Get From Dictionary    ${response.json()}    ${key}
    RETURN             ${value}

Response Should Have Timestamp Field
    [Documentation]    Verify response contains timestamp
    [Arguments]        ${response}
    Response Should Contain Key    ${response}    ${error_timestamp_field}

Store JSON Response And Status Code
    [Documentation]    Store response and status code for later use
    [Arguments]        ${response}
    Set Test Variable    ${api_response}    ${response}
    Set Test Variable    ${api_status_code}    ${response.status_code}
    Set Test Variable    ${api_response_json}    ${response.json()}

Close API Session
    [Documentation]    Close the API session
    Delete All Sessions
