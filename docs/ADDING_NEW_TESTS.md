# Adding New Tests Following POM

Step-by-step guide for adding new test suites while maintaining Page Object Model integrity.

## Adding Web UI Tests

### Step 1: Create Locator File

Create `web/data/locators/feature_page_locators.robot`:

```robot
*** Variables ***

# Feature Page Locators
${feature_button}                           //button[@id='feature-btn']
${feature_input}                            //input[@name='feature-input']
${feature_result}                           //div[@data-testid='result']
```

### Step 2: Create Action Keywords

Create `web/resources/pages/feature_resource/feature_action.robot`:

```robot
*** Settings ***
Library    SeleniumLibrary
Resource    ../../../data/locators/feature_page_locators.robot
Resource    ../../../data/common_properties.robot
Resource    ../../utilities/utility_keywords.robot

*** Keywords ***

User Clicks Feature Button
    [Documentation]    Click the feature button
    Wait Until Element Is Visible    ${feature_button}    ${default_timeout}
    Click Element    ${feature_button}

User Enters Feature Input
    [Documentation]    Enter text in feature input field
    [Arguments]    ${text}
    Wait Until Element Is Visible    ${feature_input}    ${default_timeout}
    Input Text    ${feature_input}    ${text}
```

### Step 3: Create Result Keywords

Create `web/resources/pages/feature_resource/feature_result.robot`:

```robot
*** Settings ***
Library    SeleniumLibrary
Resource    ../../../data/locators/feature_page_locators.robot
Resource    ../../../data/common_properties.robot

*** Keywords ***

Feature Result Should Be Visible
    [Documentation]    Verify feature result is displayed
    Element Should Be Visible    ${feature_result}

Feature Result Should Contain
    [Documentation]    Verify result contains expected text
    [Arguments]    ${expected_text}
    Wait Until Page Contains    ${expected_text}    ${default_timeout}
```

### Step 4: Create Test File

Create `web/tests/feature_suite/feature_test.robot`:

```robot
*** Settings ***
Library    SeleniumLibrary

Resource    ../../data/common_properties.robot
Resource    ../../resources/pages/feature_resource/feature_action.robot
Resource    ../../resources/pages/feature_resource/feature_result.robot
Resource    ../../resources/common_resources.robot
Resource    ../../resources/utilities/utility_keywords.robot

Test Teardown    Run Keyword If Test Failed    Take Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***

Verify Feature Works
    [Tags]    Smoke    Feature
    [Documentation]    Verify feature basic functionality
    [Setup]    Set Up Web Test Environment

    Given User Opens The Dashboard    ${ENV}    ${COUNTRY}
    And Login Page Should Load Successfully
    And User Enters Valid Email For Login
    And User Enters Valid Password For Login
    And User Clicks Submit Button

    When User Clicks Feature Button
    And User Enters Feature Input    test value

    Then Feature Result Should Be Visible
    And Feature Result Should Contain    test value
```

### Step 5: Create Suite Metadata

Create `web/tests/feature_suite/__init__.robot`:

```robot
*** Settings ***
Documentation    Feature test suite
Metadata    Author    QA Team
Metadata    Version    1.0
Metadata    Purpose    Test feature functionality
```

### Step 6: Add Test Data (if needed)

Update `web/data/testdata/stage/stage_testdata.robot` to include feature-specific data:

```robot
${feature_test_value}                       test data value
```

## Adding API Tests

### Step 1: Create Resource Keywords

Update `API/resources/common_resources.robot` or create new utilities:

```robot
*** Keywords ***

Get Feature Endpoint
    [Documentation]    Make GET request to feature endpoint
    [Arguments]    ${feature_id}
    ${response}=    Make GET Request To API    /features/${feature_id}
    RETURN    ${response}

Feature Response Should Contain
    [Documentation]    Verify feature response has required fields
    [Arguments]    ${response}    @{required_fields}
    FOR    ${field}    IN    @{required_fields}
        Dictionary Should Contain Key    ${response.json()}    ${field}
    END
```

### Step 2: Create Test File

Create `API/tests/feature/Verify_Feature_Scenarios.robot`:

```robot
*** Settings ***
Library    RequestsLibrary
Library    Collections

Resource    ../../resources/common_resources.robot
Resource    ../../data/common_properties.robot

Suite Setup    Create API Session With Staging Environment
Suite Teardown    Close API Session

*** Test Cases ***

Verify Get Feature Returns 200
    [Tags]    Smoke    API    Feature
    [Documentation]    Verify feature endpoint is responsive

    ${response}=    Get Feature Endpoint    feature-123
    Response Should Have Status Code    ${response}    200
    Feature Response Should Contain    ${response}    id    name    description
```

## Adding Data-Driven Tests

### Step 1: Create CSV File

Create `web/data/testdata/feature_scenarios.csv`:

```
Test Case,${input},${expected_result}
Valid input,test value,success
Empty input,,error
Special chars,!@#$%,processing
```

### Step 2: Create Template Keyword

In appropriate resource file:

```robot
Verify Feature With Input
    [Documentation]    Template keyword for feature data-driven tests
    [Arguments]    ${input}    ${expected_result}
    [Tags]    DataDriven    Feature
    [Setup]    Set Up Web Test Environment

    User Opens The Dashboard    ${ENV}    ${COUNTRY}
    User Enters Feature Input    ${input}
    User Clicks Feature Button

    IF    '${expected_result}' == 'success'
        Feature Result Should Be Visible
    ELSE
        Feature Error Should Be Visible
    END
```

### Step 3: Create Test File with DataDriver

Create `web/tests/feature_suite/feature_data_driven_test.robot`:

```robot
*** Settings ***
Library    SeleniumLibrary
Library    DataDriver    file=../../data/testdata/feature_scenarios.csv

Resource    ../../data/common_properties.robot
Resource    ../../resources/pages/feature_resource/feature_action.robot
Resource    ../../resources/pages/feature_resource/feature_result.robot
Resource    ../../resources/common_resources.robot

Test Template    Verify Feature With Input
Test Teardown    Run Keyword If Test Failed    Take Screenshot
Suite Teardown    Close All Browsers

*** Test Cases ***
Verify Feature With Input    ${input}    ${expected_result}
```

## Best Practices Checklist

When adding new tests, verify:

### Locators
- [ ] All UI selectors in dedicated locator file
- [ ] Locators organized by element type (buttons, inputs, messages)
- [ ] No hardcoded XPath/CSS in action/result keywords
- [ ] Meaningful locator variable names

### Keywords
- [ ] Action keywords use "User [action]" pattern
- [ ] Result keywords use "Should [assertion]" pattern
- [ ] Keywords have [Documentation]
- [ ] Keywords return values (not Set Global Variable)
- [ ] Reusable keywords in common_resources.robot

### Tests
- [ ] BDD-style Given/When/Then syntax
- [ ] No hardcoded locators or test data
- [ ] Meaningful test names describing business requirement
- [ ] Tags for categorization (Smoke, Regression, etc.)
- [ ] [Documentation] explaining test purpose
- [ ] [Setup] for test initialization
- [ ] Test Teardown for cleanup

### Data
- [ ] Test data in testdata/*.robot (not in resources)
- [ ] Environment-specific data in stage/prod directories
- [ ] CSV files for data-driven tests
- [ ] No hardcoded credentials

### Imports
- [ ] Tests import Resources (action/result)
- [ ] Resources import Data (locators/properties)
- [ ] Resources import other Resources
- [ ] No circular imports
- [ ] Consistent relative paths

### Documentation
- [ ] `__init__.robot` in test suite directory
- [ ] All keywords documented
- [ ] Test purpose in [Documentation]
- [ ] Complex logic has inline comments

## Running New Tests

Once created, run the new tests:

```bash
# Run specific test suite
robot --variable ENV:STAGING web/tests/feature_suite/feature_test.robot

# Run with data-driven tests
robot --variable ENV:STAGING web/tests/feature_suite/feature_data_driven_test.robot

# Run all web tests
robot --argumentfile argfile.robot web/tests/

# Run with specific tags
robot --include Smoke web/tests/
```

## Common Mistakes to Avoid

1. **Locators in keywords** - Never hardcode selectors in action/result keywords
2. **Global variables** - Use RETURN instead of Set Global Variable
3. **Mixed concerns** - Keep data, resources, and tests separate
4. **Hardcoded test data** - Use testdata files or CSV
5. **Missing documentation** - Always add [Documentation] to keywords and tests
6. **Circular imports** - Test imports Resource; Resource imports Data
7. **Unclear keyword names** - Use "User Clicks Button" not "Click"
8. **Ignoring environments** - Use parameterization for staging/production

## Extending Existing Features

When adding tests to existing features:

1. Add locators to existing locator file (if needed)
2. Add action keywords to existing action file
3. Add result keywords to existing result file
4. Create new test file in same suite

Never modify test files to add logic; always use keywords for reusability.
