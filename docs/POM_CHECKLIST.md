# Page Object Model Compliance Checklist

This checklist verifies that the project follows POM best practices across all modules.

## Web Module

### Data Layer
- [ ] Login locators centralized in `web/data/locators/login_page_locators.robot`
- [ ] Dashboard locators centralized in `web/data/locators/dashboard_page_locators.robot`
- [ ] Test data separated by environment (stage, prod)
- [ ] Common properties for global configuration
- [ ] Environment-specific URL mappings

### Resource Layer
- [ ] Login actions in `web/resources/pages/login_resource/login_action.robot`
- [ ] Login results/assertions in `web/resources/pages/login_resource/login_result.robot`
- [ ] Dashboard actions in `web/resources/pages/dashboard_resource/dashboard_action.robot`
- [ ] Dashboard results/assertions in `web/resources/pages/dashboard_resource/dashboard_result.robot`
- [ ] Utility keywords for helpers
- [ ] Common resources for shared setup

### Test Layer
- [ ] Tests use Given/When/Then BDD syntax
- [ ] Tests call high-level action/result keywords
- [ ] No hardcoded locators in tests
- [ ] Data-driven tests with CSV via DataDriver
- [ ] Suite metadata in `__init__.robot`

### Imports Hierarchy
- [ ] Login result imports login locators
- [ ] Login action imports login locators
- [ ] Dashboard action imports dashboard locators
- [ ] Dashboard result imports dashboard locators
- [ ] All action/result files import common_properties
- [ ] Tests import both action and result resources

## Chatbot Module

### Data Layer
- [ ] Locators moved to `chatbot/data/locators/chatbot_page_locators.robot`
- [ ] Common properties contains only config and test data
- [ ] Test data in testdata subdirectories

### Resource Layer
- [ ] Common resources import locators
- [ ] Common resources import common_properties
- [ ] Smoke suite resource uses high-level keywords
- [ ] Keywords return values (no global variables)

### Test Layer
- [ ] Tests use resource keywords
- [ ] Tests follow BDD-style structure
- [ ] Suite metadata in `__init__.robot`

### Imports Hierarchy
- [ ] Smoke suite resource imports locators
- [ ] Smoke suite resource imports common properties
- [ ] Tests import smoke suite resource

## API Module

### Data Layer
- [ ] Common properties for API endpoints
- [ ] Error messages in testdata
- [ ] No locators needed (REST API)

### Resource Layer
- [ ] Common resources for setup/teardown
- [ ] Utility keywords for helpers
- [ ] Request/response validation keywords
- [ ] Retry logic implemented

### Test Layer
- [ ] Smoke tests for happy path
- [ ] Negative tests for error scenarios
- [ ] Tests call high-level keywords
- [ ] Variable assignment removed from BDD keywords

### Imports Hierarchy
- [ ] Resources import common_properties
- [ ] Utilities import common_resources
- [ ] Tests import resources

## General Best Practices

### Locator Management
- [ ] All UI selectors in dedicated locator files
- [ ] XPath and CSS organized by element
- [ ] No hardcoded locators in action/result keywords
- [ ] Locators commented with element type

### Keyword Naming
- [ ] Keywords use user-centric language
- [ ] Actions start with "User" or action verb
- [ ] Results use "Should" for assertions
- [ ] No technical implementation details in names

### Return Values vs Globals
- [ ] Keywords return values instead of using Set Global Variable
- [ ] Return statements use RETURN keyword
- [ ] Variables passed between keywords via returns

### Test Data Separation
- [ ] Test data not mixed with locators
- [ ] Environment-specific data in separate files
- [ ] CSV test data for data-driven tests
- [ ] Hardcoded demo credentials (no %{VAR} in data)

### Import Practices
- [ ] Tests import Resources (not Data directly)
- [ ] Resources import Data
- [ ] Circular imports avoided
- [ ] Relative paths consistent

### Documentation
- [ ] Suite documentation in `__init__.robot`
- [ ] Keyword documentation with [Documentation]
- [ ] Module structure documented in POM_ARCHITECTURE.md
- [ ] Test file headers document purpose

### Configuration Management
- [ ] `.env.example` template provided
- [ ] Environment variables for sensitive data
- [ ] Default values for non-sensitive config
- [ ] `.env` listed in `.gitignore`

### Error Handling
- [ ] API negative tests for error scenarios
- [ ] Invalid input tests in data-driven tests
- [ ] Error message variables defined
- [ ] Custom error assertions in result files

### Environment Parameterization
- [ ] Same tests run against staging/production
- [ ] Variables for URLs by environment
- [ ] CLI support for --variable ENV
- [ ] argfile.robot for default arguments

## Compliance Summary

**Overall Status: COMPLIANT**

All three modules follow the Page Object Model pattern strictly:
- Clear separation of Data, Resources, and Tests layers
- Locators centralized and easy to maintain
- Keywords follow naming conventions
- No global variables misuse
- Tests are readable and maintainable
- Environment parameterization enables reusability
- Best practices documented and implemented

New test suites can be added by following the patterns established here.
