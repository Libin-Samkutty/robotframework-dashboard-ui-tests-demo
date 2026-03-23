# Dashboard UI Tests Demo

Robot Framework test automation framework for web dashboards, chatbots, and REST APIs. Includes smoke tests, architecture patterns, Docker containerization, and GitHub Actions CI/CD.

## Contents

1. [Project Overview](#project-overview)
2. [Tech Stack](#tech-stack)
3. [Prerequisites](#prerequisites)
4. [Quick Start](#quick-start)
5. [Project Structure](#project-structure)
6. [Architecture & Design Patterns](#architecture--design-patterns)
7. [Best Practices Demonstrated](#best-practices-demonstrated)
8. [Running Tests](#running-tests)
9. [Docker Setup](#docker-setup)
10. [CI/CD Integration](#cicd-integration)
11. [Merging Reports](#merging-reports)
12. [Adding New Tests](#adding-new-tests)
13. [Reports](#reports)

---

## Project Overview

Covers three test domains:

- **Web Dashboard** — UI testing via SeleniumLibrary (Chrome/Firefox)
- **Chatbot** — WhatsApp bot flows (onboarding, menu, conversation)
- **REST API** — Endpoint validation and health checks

Implements Page Object Model with parameterized environments (staging/production), reusable keywords, timestamped HTML reports, Docker containerization, and GitHub Actions CI/CD.

---

## Tech Stack

| Component | Technology |
|---|---|
| Test Framework | Robot Framework 7.1+ |
| Web Automation | SeleniumLibrary |
| API Testing | RequestsLibrary |
| Chatbot Testing | SeleniumLibrary (WhatsApp Web) |
| Output Management | Robot Framework's built-in reporting |
| Containerization | Docker & Docker Compose |
| CI/CD | GitHub Actions |

---

## Prerequisites

- Python 3.12+
- Chrome or Firefox
- ChromeDriver or GeckoDriver
- Docker and Docker Compose (optional)

---

## Quick Start

### 1. Clone Repository

```bash
git clone https://github.com/your-org/dashboard-ui-tests-demo.git
cd dashboard-ui-tests-demo
```

### 2. Configure Environment

```bash
cp .env.example .env
```

Edit `.env` with credentials and URLs:

```bash
LOGIN_EMAIL=test@yourdomain.com
LOGIN_PASSWORD=your_secure_password
BASE_URL_STAGING=https://staging.yourdomain.com
BASE_URL_PROD=https://app.yourdomain.com
AUTOMATION_USER_CONTACT=+1234567890
API_TOKEN=your_api_token_here
BROWSER=Chrome
ENV=STAGING
COUNTRY=INDIA
```

### 3. Install Dependencies

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install --upgrade pip
pip install -r requirements.txt
```

### 4. Run Tests

**Web (Login) Tests:**
```bash
robot web/tests/login_suite/
```

**Chatbot Tests:**
```bash
robot chatbot/tests/stage/smoke/
```

**API Tests:**
```bash
robot API/tests/smoke/
```

**All Tests:**
```bash
robot .
```

Reports are generated in `reports/` directory with timestamp.

---

## Project Structure

```
dashboard-ui-tests-demo/
│
├── README.md                          # This file
├── requirements.txt                   # Python dependencies (with comments)
├── .env.example                       # Environment variables template
├── .gitignore                         # Git ignore configuration
├── argfile.robot                      # Robot Framework argument file
├── NameOutputDir.py                   # Helper: generates timestamped output dirs
├── Dockerfile                         # Container image for test execution
├── docker-compose.yml                 # Docker Compose configuration
│
├── .github/
│   └── workflows/
│       └── run-tests.yml              # GitHub Actions CI/CD pipeline (includes rebot merge job)
│
├── web/                               # Web Dashboard Tests
│   ├── data/
│   │   ├── common_properties.robot    # Browser settings, timeouts, variables
│   │   ├── locators/
│   │   │   ├── login_page_locators.robot       # Login UI element locators
│   │   │   └── dashboard_page_locators.robot   # Dashboard UI element locators
│   │   └── testdata/
│   │       ├── contents.robot                  # UI text constants
│   │       ├── login_credentials.csv           # Data-driven test data
│   │       ├── stage/
│   │       │   ├── stage_testdata.robot        # Staging URL & test data
│   │       │   └── login_testdata.robot        # Login credentials (from env)
│   │       └── prod/
│   │           └── prod_testdata.robot         # Production URL & test data
│   │
│   ├── resources/
│   │   ├── common_resources.robot              # Shared browser setup keywords
│   │   ├── utilities/
│   │   │   └── utility_keywords.robot          # Date/time/Faker/helper functions
│   │   └── pages/
│   │       ├── login_resource/
│   │       │   ├── login_action.robot          # Login interaction keywords
│   │       │   └── login_result.robot          # Login assertion keywords
│   │       └── dashboard_resource/
│   │           ├── dashboard_action.robot      # Dashboard interaction keywords
│   │           └── dashboard_result.robot      # Dashboard assertion keywords
│   │
│   └── tests/
│       ├── __init__.robot
│       ├── login_suite/
│       │   ├── __init__.robot
│       │   ├── login_page_test.robot           # Smoke test: valid login
│       │   └── login_data_driven_test.robot    # Data-driven login tests
│       └── dashboard_suite/
│           ├── __init__.robot
│           └── dashboard_page_test.robot       # Dashboard UI tests
│
├── chatbot/                           # WhatsApp Chatbot Tests
│   ├── data/
│   │   ├── common_properties.robot    # WhatsApp locators & variables
│   │   └── testdata/
│   │       └── stage/
│   │           └── stage_testdata.robot        # Generic bot responses & keywords
│   │
│   ├── resources/
│   │   ├── common_resources.robot     # Core WhatsApp keywords (send, receive)
│   │   └── stage/
│   │       └── smoke/
│   │           └── smoke_suite_resource.robot  # Onboarding & menu flow keywords
│   │
│   └── tests/
│       ├── __init__.robot
│       └── stage/
│           ├── __init__.robot
│           └── smoke/
│               ├── __init__.robot
│               └── Verify_Smoke_Suite.robot    # Chatbot smoke tests
│
└── API/                               # REST API Tests
    ├── data/
    │   ├── common_properties.robot    # Base URL, timeouts, auth headers
    │   └── testdata/
    │       └── common_error_messages.robot     # Expected error messages
    │
    ├── resources/
    │   ├── common_resources.robot     # RequestsLibrary session & request helpers
    │   └── utilities/
    │       └── utility_keywords.robot          # JSON/retry/polling helpers
    │
    └── tests/
        ├── __init__.robot
        ├── smoke/
        │   ├── __init__.robot
        │   └── Verify_Smoke_Scenarios.robot    # API smoke tests
        └── negative/
            ├── __init__.robot
            └── Verify_Error_Responses.robot    # API negative tests (401, 404, 400)
```

### Directory Structure

- **`data/`** — Test data, variables, and locators
  - `common_properties.robot` — Global settings, browser config, timeouts
  - `locators/` — XPath/CSS selectors
  - `testdata/` — Test data organized by environment

- **`resources/`** — Reusable keywords
  - `pages/` — Page Object Model (locators, actions, assertions)
  - `utilities/` — Helper functions
  - `common_resources.robot` — Shared keywords

- **`tests/`** — Test cases by feature
  - Call keywords from `resources/`
  - Reference data from `data/`

---

## Architecture & Design Patterns

### 1. Page Object Model (POM)

Separates test logic from UI element locators and interaction details.

**Structure:**
- **Locators** — Element selectors (XPath, CSS)
- **Actions** — User interactions (click, type, login)
- **Results** — Assertions and validations

**Example:**

```robot
# web/data/locators/login_page_locators.robot
${email_field}         //input[@name="email"]
${password_field}      //input[@name="password"]
${submit_button}       //button[@type="submit"]

# web/resources/pages/login_resource/login_action.robot
User enters email
    [Arguments]    ${email}
    Wait Until Element Is Visible    ${email_field}    ${default_timeout}
    Input Text    ${email_field}    ${email}

# web/resources/pages/login_resource/login_result.robot
Login should be successful
    Wait Until Page Contains    ${DASHBOARD_TITLE}    ${default_timeout}
```

### 2. Three-Layer Architecture

Tests → Resources → Data

Hierarchy enables localized changes, keyword reuse, and readable test syntax.

### 3. Environment Parameterization

Pass environment variables to execute tests against staging or production:

```bash
robot -v ENV:STAGING web/tests/
robot -v ENV:PROD web/tests/
```

Environment data in `.env` and `testdata/{stage,prod}/` directories.

### 4. BDD-style Syntax

Test cases follow Given/When/Then pattern:

```robot
*** Test Cases ***
Verify User Can Login Successfully
    Given User opens the application
    And User should see the login popup
    When User enters valid credentials
    And User clicks submit
    Then User should be on the dashboard

*** Keywords ***
User opens the application
    Open Browser    ${BASE_URL}    ${BROWSER}
```

### 5. Timestamped Output Directories

`NameOutputDir.py` creates timestamped report paths: `reports/YYYY-MM-DD/HH-MM-SS/`

Invoke with:
```bash
robot --outputdir `python NameOutputDir.py` web/tests/
```

---

## Best Practices Demonstrated

Implemented patterns:

| Practice | Location | Purpose |
|---|---|---|
| **Page Object Model** | `web/data/locators/`, `web/resources/pages/` | Separates locators, actions, and assertions |
| **BDD-style Testing** | All `tests/` files | Given/When/Then syntax for readability |
| **Data-driven Tests** | `web/tests/login_suite/login_data_driven_test.robot` | Uses DataDriver CSV for multiple test scenarios |
| **Dynamic Test Data** | `web/resources/utilities/utility_keywords.robot` | FakerLibrary generates unique test data |
| **Environment Parameterization** | `common_properties.robot`, CLI `--variable` | Same tests run against staging/production |
| **Retry Logic** | `API/resources/utilities/utility_keywords.robot` | `Wait Until Keyword Succeeds` for resilience |
| **Structured Arguments** | `argfile.robot` | Single config file for consistent invocation |
| **Suite Metadata** | `__init__.robot` files | Documentation and metadata at suite level |
| **Separation of Concerns** | `data/`, `resources/`, `tests/` | Three-layer architecture for maintainability |
| **Error Handling** | `API/tests/negative/` | Tests for 401, 404, 400 error scenarios |
| **Report Merging** | `.github/workflows/run-tests.yml` | `rebot` combines multiple test runs |
| **Secrets Management** | `.env.example`, `%{VAR}` syntax | No hardcoded credentials in code |
| **Return Values** | `chatbot/resources/common_resources.robot` | Keywords return data instead of using globals |
| **Locator Centralization** | `data/locators/` | All XPath/CSS in one place |
| **Scalable Structure** | All modules | Easy to add new test suites by following patterns |

---

## Running Tests

### Using Argument File

Execute tests with `argfile.robot` for standardized configuration:

```bash
# Run all web tests with argument file
robot --argumentfile argfile.robot web/tests/

# Override variables from argument file
robot --argumentfile argfile.robot --variable ENV:PROD web/tests/

# Run dashboard tests specifically
robot --argumentfile argfile.robot web/tests/dashboard_suite/
```

### Run by Module

```bash
# Web dashboard tests
robot web/tests/

# Chatbot tests
robot chatbot/tests/

# API tests (both smoke and negative)
robot API/tests/
```

### Run by Tag

```bash
robot --include Smoke .
robot --exclude Slow .
robot --variable ENV:STAGING web/tests/
robot --include Dashboard web/tests/
```

### Data-driven Tests

Run parameterized login tests with multiple credentials:

```bash
# Data-driven login tests from CSV
robot web/tests/login_suite/login_data_driven_test.robot
```

### Run Specific Test

```bash
robot web/tests/login_suite/login_page_test.robot::Verify\ Dashboard\ Loads\ After\ Successful\ Login
```

### Parallel Execution

```bash
pip install robotframework-pabot
pabot -n 4 .
```

### Full Example with Output Directory

```bash
robot \
  --argumentfile argfile.robot \
  --variable ENV:STAGING \
  --variable COUNTRY:INDIA \
  --outputdir `python NameOutputDir.py` \
  .
```

---

## Docker Setup

### Build Image

```bash
docker build -t dashboard-ui-tests-demo .
```

### Run Tests in Container

```bash
docker run \
  --env-file .env \
  -v $(pwd)/reports:/app/reports \
  dashboard-ui-tests-demo
```

### Using Docker Compose

```bash
# Copy .env.example to .env and fill in values
cp .env.example .env

# Run tests
docker-compose up

# Run specific module
docker-compose run tests robot web/tests/
```

docker-compose.yml loads `.env`, mounts `reports/` volume, includes Firefox and Python 3.12 with dependencies.

---

## CI/CD Integration

### GitHub Actions

Workflow configuration in `.github/workflows/run-tests.yml`:

1. Triggers on push to `main` and pull requests
2. Matrix strategy for STAGING and PROD environments
3. Steps: checkout, Python 3.12 setup, dependency install, test execution, artifact upload

**Workflow File:**

```yaml
name: Run Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        env: [STAGING, PROD]
    steps:
      - uses: actions/checkout@v4
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.12'
      - name: Install dependencies
        run: pip install -r requirements.txt
      - name: Run tests
        env:
          LOGIN_EMAIL: ${{ secrets.LOGIN_EMAIL }}
          LOGIN_PASSWORD: ${{ secrets.LOGIN_PASSWORD }}
          BASE_URL_STAGING: ${{ secrets.BASE_URL_STAGING }}
          BASE_URL_PROD: ${{ secrets.BASE_URL_PROD }}
        run: |
          python -m robot --variable ENV:${{ matrix.env }} .
      - name: Upload reports
        uses: actions/upload-artifact@v3
        with:
          name: test-reports-${{ matrix.env }}
          path: reports/
```

**Add secrets in GitHub:**
Settings → Secrets & Variables → Actions → Add:
- `LOGIN_EMAIL`
- `LOGIN_PASSWORD`
- `BASE_URL_STAGING`
- `BASE_URL_PROD`

---

## Merging Reports

Combine test output files from multiple environments using `rebot`:

### Local Report Merging

```bash
# Run tests for both environments separately
robot --outputdir reports/staging --variable ENV:STAGING .
robot --outputdir reports/prod --variable ENV:PROD .

# Merge reports using rebot
rebot \
  --outputdir reports/merged \
  --name "Dashboard UI Tests - All Environments" \
  reports/staging/output.xml \
  reports/prod/output.xml
```

### GitHub Actions Automatic Merging

CI/CD workflow includes `merge-reports` job that:
1. Runs tests against STAGING and PROD
2. Collects `output.xml` artifacts
3. Merges with `rebot`
4. Uploads merged artifact

Provides combined statistics and unified HTML report across environments.

---

## Adding New Tests

1. Create test file in `tests/` with Given/When/Then structure
2. Create action keywords in `resources/pages/{feature}/` (user interactions)
3. Create result keywords in same directory (assertions)
4. Add locators to `data/locators/`
5. Execute tests

Follow existing dashboard_suite structure as template.

---

## Reports

### HTML Reports

View generated reports:

```bash
open reports/*/*/report.html         # macOS
xdg-open reports/*/*/report.html     # Linux
start reports/\*\*/report.html       # Windows
```

Output files: `report.html` (summary), `log.html` (debug), `output.xml` (machine-readable)

### Custom Report Location

```bash
robot --outputdir custom/path/ web/tests/
```

---

## Contributing

Follow POM pattern. Use descriptive keyword names. Add tags to test cases. Keep test data in `data/` directory.

Before PR submission:
```bash
robot .
grep -r "password\|token\|secret" web/ chatbot/ API/
```

---

## Troubleshooting

**Tests Timeout:** Increase timeout in `common_properties.robot` (default 60s)

**Element Not Found:** Verify locator in DevTools, update `web/data/locators/`, check page load time

**Browser Crashes:** Update chromedriver/geckodriver or run headless mode

**Docker Build Fails:** Verify Dockerfile permissions and Docker daemon state

---

## Support

File GitHub issues for bugs and feature requests.

---

## License

MIT License — See LICENSE file for details.

---

## References

- [Robot Framework Documentation](https://robotframework.org/)
- [SeleniumLibrary Documentation](https://robotframework.org/SeleniumLibrary/)
- [RequestsLibrary Documentation](https://github.com/MarketSquare/robotframework-requests)
