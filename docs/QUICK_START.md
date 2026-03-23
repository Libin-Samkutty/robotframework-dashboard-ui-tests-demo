# Quick Start Guide

Get the dashboard automation tests running in 5 minutes.

## Prerequisites

- Python 3.8+
- Git

## Installation (1 minute)

```bash
# Clone or download the project
cd dashboard-ui-tests-demo

# Install dependencies
pip install -r requirements.txt

# Copy environment template
cp .env.example .env
```

## Configuration (1 minute)

Edit `.env` with your test environment details:

```bash
# Minimum required changes:
LOGIN_EMAIL=your_test_email@example.com
LOGIN_PASSWORD=your_test_password
API_TOKEN=your_api_token
```

## Running Tests (1 minute)

```bash
# Run all web tests
robot --argumentfile argfile.robot web/tests/

# Run specific suite
robot web/tests/login_suite/

# Run with production environment
robot --variable ENV:PROD web/tests/

# Run API tests
robot API/tests/

# Run chatbot tests
robot chatbot/tests/
```

## View Results (1 minute)

After tests complete, open the generated report:

```bash
open report.html
```

Or view detailed logs:

```bash
open log.html
```

## Learning the Project

1. **Understand Architecture**: Read `docs/POM_ARCHITECTURE.md`
2. **Add New Tests**: Follow `docs/ADDING_NEW_TESTS.md`
3. **Verify Compliance**: Check `docs/POM_CHECKLIST.md`

## Key Files to Know

- `argfile.robot` - Default test arguments
- `web/data/locators/` - UI element selectors
- `web/resources/pages/*/action.robot` - User actions
- `web/resources/pages/*/result.robot` - Assertions
- `web/tests/` - Test cases

## Common Commands

```bash
# Run Smoke tests only
robot --include Smoke web/tests/

# Run with verbose output
robot --loglevel DEBUG web/tests/

# Run specific test
robot -t "Verify That The User Can Login" web/tests/login_suite/login_page_test.robot

# Run with custom output directory
robot --outputdir custom_results web/tests/

# Combine multiple test runs
rebot --merge output*.xml
```

## Troubleshooting

Browser not found?
```bash
# Install ChromeDriver or geckodriver
# macOS:
brew install chromedriver

# Linux:
sudo apt-get install chromium-chromedriver

# Windows: Download from https://chromedriver.chromium.org/
```

Module not found?
```bash
# Re-install requirements
pip install --upgrade -r requirements.txt

# Or install specific library
pip install robotframework-seleniumlibrary==6.1.2
```

Tests not running?
```bash
# Check Python version (must be 3.8+)
python --version

# Check Robot Framework installation
robot --version

# Verify dependencies
pip list | grep -i robot
```

## Project Structure

```
dashboard-ui-tests-demo/
├── web/          Web dashboard tests
├── API/          REST API tests
├── chatbot/      Chatbot tests
├── docs/         Comprehensive documentation
├── argfile.robot Default arguments
└── .env.example  Configuration template
```

## Next Steps

1. Run the tests to verify setup
2. Read the architecture guide (docs/POM_ARCHITECTURE.md)
3. Add your own tests (docs/ADDING_NEW_TESTS.md)
4. Customize for your needs

## Support

- Architecture questions: See docs/POM_ARCHITECTURE.md
- Adding tests: See docs/ADDING_NEW_TESTS.md
- Compliance: See docs/POM_CHECKLIST.md
- Project overview: See PROJECT_SUMMARY.md

## What's Included

Tests:
- 3 login tests (positive + negative)
- 6 data-driven scenarios
- 4 dashboard tests
- 3 API smoke tests
- 3 API negative tests
- 3 chatbot tests

Patterns Demonstrated:
- Page Object Model
- BDD-style testing
- Data-driven testing
- Environment parameterization
- Error handling
- API testing with retry logic

## Ready to Go

Installation complete. Run your first test:

```bash
robot --argumentfile argfile.robot web/tests/login_suite/login_page_test.robot
```

Check the generated report.html for results.

Happy testing!
