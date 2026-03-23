*** Variables ***

# ============================================================================
# Web Dashboard - Common Properties
# Global settings, browser configuration, and timeouts
# ============================================================================

# Browser Configuration
${BROWSER}                                  Chrome
# Options: Chrome, Firefox, Edge

${HEADLESS_CHROME}                          headlesschrome
${HEADLESS_FIREFOX}                         headlessfirefox

# Timeouts (in seconds)
${default_timeout}                          60s
${short_timeout}                            3s
${very_short_timeout}                       1s
${keyword_succeed_timeout}                  30s

# Environment & Country (Command-line Override)
${ENV}                                      STAGING
${COUNTRY}                                  INDIA

# Page Content Identifiers
${DASHBOARD_NAME}                           Dashboard
${DASHBOARD_TITLE}                          Dashboard
${SUMMARY}                                  Summary
${LOGIN_POPUP}                              Login

# Common Keywords
${CHROME}                                   Chrome
${FIREFOX}                                  Firefox
${EDGE}                                     Edge
${SAFARI}                                   Safari

${STAGING}                                  STAGING
${PROD}                                     PROD

${INDIA}                                    INDIA
${KENYA}                                    KENYA
${NIGERIA}                                  NIGERIA

# Error Messages
${YOU_HAVE_ENTERED_WRONG_COMMAND}           You have entered a wrong command

