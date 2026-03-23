# Page Object Model Architecture

This project strictly follows the Page Object Model (POM) pattern for test automation. The architecture separates concerns into three main layers: Data, Resources, and Tests.

## Three-Layer Architecture

### Layer 1: Data (`*/data/`)
Contains all static test data, locators, and configuration.

**Sub-directories:**
- `locators/` - All UI element selectors (XPath, CSS)
- `testdata/` - Test data including CSV files and environment-specific data
- `common_properties.robot` - Global configuration variables

**Key Principle:** No code logic, only data definitions.

### Layer 2: Resources (`*/resources/`)
Contains reusable keywords organized by functionality.

**Sub-structure for UI testing:**
- `pages/*/action.robot` - Keywords that interact with UI (click, type, fill forms)
- `pages/*/result.robot` - Keywords that assert and verify state
- `utilities/` - Helper keywords for common operations
- `common_resources.robot` - Shared setup/teardown and cross-page keywords

**Key Principle:** Keywords are named as high-level actions (user-centric), not technical operations.

### Layer 3: Tests (`*/tests/`)
Contains test cases that use resources to execute scenarios.

**Structure:**
- `*_suite/` - Test suites organized by feature
- `*_test.robot` - Individual test files with BDD-style Given/When/Then
- `__init__.robot` - Suite metadata and documentation

**Key Principle:** Tests read like business requirements, not code.

## Module Structure

### Web Module

```
web/
├── data/
│   ├── locators/
│   │   ├── login_page_locators.robot
│   │   └── dashboard_page_locators.robot
│   ├── testdata/
│   │   ├── contents.robot
│   │   ├── stage/
│   │   │   ├── stage_testdata.robot
│   │   │   └── login_testdata.robot
│   │   └── prod/
│   │       └── prod_testdata.robot
│   └── common_properties.robot
├── resources/
│   ├── pages/
│   │   ├── login_resource/
│   │   │   ├── login_action.robot
│   │   │   └── login_result.robot
│   │   └── dashboard_resource/
│   │       ├── dashboard_action.robot
│   │       └── dashboard_result.robot
│   ├── utilities/
│   │   └── utility_keywords.robot
│   └── common_resources.robot
└── tests/
    ├── login_suite/
    │   ├── login_page_test.robot
    │   └── login_data_driven_test.robot
    └── dashboard_suite/
        └── dashboard_page_test.robot
```

### Chatbot Module

```
chatbot/
├── data/
│   ├── locators/
│   │   └── chatbot_page_locators.robot
│   ├── testdata/
│   │   └── stage/
│   │       └── stage_testdata.robot
│   └── common_properties.robot
├── resources/
│   ├── stage/
│   │   └── smoke/
│   │       └── smoke_suite_resource.robot
│   └── common_resources.robot
└── tests/
    └── stage/
        └── smoke/
            └── Verify_Smoke_Suite.robot
```

### API Module

```
API/
├── data/
│   ├── common_properties.robot
│   └── testdata/
│       └── common_error_messages.robot
├── resources/
│   ├── utilities/
│   │   └── utility_keywords.robot
│   └── common_resources.robot
└── tests/
    ├── smoke/
    │   └── Verify_Smoke_Scenarios.robot
    └── negative/
        └── Verify_Error_Responses.robot
```

## Best Practices Applied

### 1. Locator Centralization
All UI selectors are defined in dedicated locators files. Changes to UI only require updates in one location.

Example:
```robot
# web/data/locators/login_page_locators.robot
${email_field}                              //input[@name="email"]
${password_field}                           //input[@name="password"]
${submit_button}                            //button[@type="submit"]
```

### 2. Action/Result Separation
Actions (what the user does) are separate from results (what we verify).

Example:
```robot
# web/resources/pages/login_resource/login_action.robot
User Enters Email For Login
    [Arguments]    ${email}
    Wait Until Element Is Visible    ${email_field}    ${default_timeout}
    Input Text    ${email_field}    ${email}

# web/resources/pages/login_resource/login_result.robot
Email Field Should Be Visible
    [Documentation]    Verify email input field is visible
    Element Should Be Visible    ${email_field}
```

### 3. Return Values Over Globals
Keywords return data instead of using global variables.

Example:
```robot
# Good: Returns count
Count The Number Of Elements On The Page
    [Arguments]    ${locator}
    ${element_count}=    Get Element Count    ${locator}
    RETURN    ${element_count}

# Bad: Sets global variable
Count The Number Of Elements On The Page
    [Arguments]    ${locator}
    ${element_count}=    Get Element Count    ${locator}
    Set Global Variable    ${element_count}
```

### 4. Keyword Naming Convention
Keywords are named from the user's perspective, not implementation.

Example:
```robot
User Enters Valid Email For Login            # Good - what user does
Input Text Into Email Field                  # Bad - technical implementation
```

### 5. Test Data Separation
Test data is centralized by environment.

Example:
```robot
# web/data/testdata/stage/login_testdata.robot
${login_email}                              demo@yourdomain.com
${login_password}                           DemoPassword123
```

### 6. Three-Level Keyword Composition
Tests compose high-level keywords from mid-level keywords from low-level keywords.

Example:
```robot
# Level 3 (Test)
Given User Opens The Dashboard    ${ENV}    ${COUNTRY}

# Level 2 (Resource - action)
User Opens The Dashboard
    [Arguments]    ${env}    ${country}
    Open Browser    ${url}    ${BROWSER}
    Wait Until Page Contains    ${LOGIN_POPUP}    ${default_timeout}

# Level 1 (SeleniumLibrary - built-in)
Open Browser
```

### 7. Environment Parameterization
Same tests run against multiple environments through variables.

Example:
```robot
# Run against staging
robot --variable ENV:STAGING web/tests/

# Run against production
robot --variable ENV:PROD web/tests/

# Variables resolve to correct URLs
${stage_url_india}                          https://staging.yourdomain.com/summary
${prod_url_india}                           https://app.yourdomain.com/summary
```

### 8. Data-Driven Testing
Tests parameterized with CSV data through DataDriver library.

Example:
```robot
# web/data/testdata/login_credentials.csv
Test Case,${email},${password},${expected_outcome},${test_tag}
Valid admin login,admin@yourdomain.com,DemoPassword123,dashboard,Smoke
Invalid email,notanemail,anypassword,error,Regression
```

### 9. Suite Metadata
Each test suite has `__init__.robot` with documentation.

Example:
```robot
*** Settings ***
Documentation    Login functionality test suite
Metadata    Author    QA Team
Metadata    Version    1.0
```

### 10. Secrets Management
Sensitive credentials are kept in `.env.example` template, never committed with real values.

Example:
```
# .env.example
LOGIN_EMAIL=demo@yourdomain.com
API_TOKEN=your_api_token_here
```

## Import Hierarchy

Imports follow a consistent pattern to ensure variables and keywords are available:

```robot
# Tests import Resources (action/result)
Resource    ../../resources/pages/login_resource/login_action.robot
Resource    ../../resources/pages/login_resource/login_result.robot

# Resources import Data
Resource    ../../data/locators/login_page_locators.robot
Resource    ../../data/common_properties.robot

# Resources import other Resources
Resource    ../utilities/utility_keywords.robot
```

## Maintenance Guidelines

When adding new tests:

1. Create locators in `data/locators/*.robot`
2. Create action keywords in `resources/pages/*/action.robot`
3. Create result/assertion keywords in `resources/pages/*/result.robot`
4. Create test cases in `tests/*_suite/*_test.robot`
5. Use action/result keywords in tests with Given/When/Then syntax

When modifying UI:

1. Update only the locator file (`data/locators/*.robot`)
2. Action/result keywords automatically use updated locators
3. Tests are unaffected

This separation ensures changes are localized and tests remain stable.
