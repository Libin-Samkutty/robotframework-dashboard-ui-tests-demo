*** Settings ***

Library    String
Library    Collections
Library    JSONLibrary
Library    OperatingSystem

Resource    ../common_resources.robot

*** Keywords ***

# ============================================================================
# API Utilities
# Helper functions for JSON, CSV, and data processing
# ============================================================================

Convert JSON String To Dictionary
    [Documentation]    Convert JSON string to Robot Framework dictionary
    [Arguments]        ${json_string}
    ${dictionary}=     Evaluate    json.loads("""${json_string}""")    json
    RETURN             ${dictionary}

Merge Two Dictionaries
    [Documentation]    Merge two dictionaries into one
    [Arguments]        ${dict1}    ${dict2}
    ${merged}=         Create Dictionary    &{dict1}    &{dict2}
    RETURN             ${merged}

Get Nested Dictionary Value
    [Documentation]    Get value from nested dictionary using dot notation (e.g. "user.address.city")
    [Arguments]        ${dictionary}    ${key_path}
    ${keys}=           Split String    ${key_path}    .
    ${value}=          Set Variable    ${dictionary}
    FOR    ${key}    IN    @{keys}
        ${value}=      Get From Dictionary    ${value}    ${key}
    END
    RETURN             ${value}

Create Payload From Template
    [Documentation]    Create API payload from dictionary template
    [Arguments]        ${template}    ${replacements}
    ${payload}=        Merge Two Dictionaries    ${template}    ${replacements}
    RETURN             ${payload}

Validate JSON Schema
    [Documentation]    Validate JSON response against expected structure
    [Arguments]        ${response_json}    @{required_keys}
    FOR    ${key}    IN    @{required_keys}
        Dictionary Should Contain Key    ${response_json}    ${key}
    END

Convert List To Query Parameters
    [Documentation]    Convert list of key-value pairs to query string
    [Arguments]        @{params}
    ${query_string}=    Create List
    FOR    ${param}    IN    @{params}
        Append To List    ${query_string}    ${param}
    END
    ${result}=         Catenate    SEPARATOR=&    @{query_string}
    RETURN             ${result}

Parse JSON Array Response
    [Documentation]    Parse JSON array response and return length
    [Arguments]        ${response_json}
    ${length}=         Get Length    ${response_json}
    RETURN             ${length}

Get Random Dictionary Entry
    [Documentation]    Get random entry from dictionary
    [Arguments]        ${dictionary}
    ${keys}=           Get Dictionary Keys    ${dictionary}
    ${random_key}=     Evaluate    random.choice(${keys})    random
    ${value}=          Get From Dictionary    ${dictionary}    ${random_key}
    RETURN             ${random_key}    ${value}

Filter Dictionary By Keys
    [Documentation]    Create new dictionary containing only specified keys
    [Arguments]        ${dictionary}    @{keys_to_keep}
    ${filtered}=       Create Dictionary
    FOR    ${key}    IN    @{keys_to_keep}
        ${value}=      Get From Dictionary    ${dictionary}    ${key}
        Set To Dictionary    ${filtered}    ${key}=${value}
    END
    RETURN             ${filtered}

Make GET Request With Retry
    [Documentation]    Make GET request to API with automatic retry on transient failures
    ...                Uses WAIT_UNTIL_KEYWORD_SUCCEEDS with configured retry settings
    ...                Useful for handling intermittent network issues or temporary service unavailability
    [Arguments]        ${endpoint}    ${expected_status}=200
    ${response}=    Wait Until Keyword Succeeds
    ...    ${api_retry_count}x
    ...    ${api_retry_delay}
    ...    Make GET Request To API    ${endpoint}    ${expected_status}
    RETURN    ${response}

Poll Until Response Body Contains
    [Documentation]    Poll an endpoint until response body contains expected value
    ...                Useful for async operations that take time to complete (e.g., job status checks)
    [Arguments]        ${endpoint}    ${key}    ${expected_value}    ${timeout}=30s    ${interval}=2s
    Wait Until Keyword Succeeds    ${timeout}    ${interval}
    ...    Response Value Should Equal    ${endpoint}    ${key}    ${expected_value}

Response Value Should Equal
    [Documentation]    Helper for polling: verify a specific key in response equals expected value
    [Arguments]        ${endpoint}    ${key}    ${expected_value}
    ${response}=    Make GET Request To API    ${endpoint}
    ${value}=       Get Nested Dictionary Value    ${response.json()}    ${key}
    Should Be Equal As Strings    ${value}    ${expected_value}
