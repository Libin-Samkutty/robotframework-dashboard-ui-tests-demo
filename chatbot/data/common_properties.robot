*** Variables ***

# ============================================================================
# Chatbot - Common Properties
# Configuration, timeouts, and test data for chatbot automation
# ============================================================================

# Browser & URL
${whatsapp_web_url}                         https://web.whatsapp.com
${browser}                                  Firefox

# Environment Settings
${country}                                  INDIA
${env}                                      STAGING

# Country Identifiers
${INDIA}                                    INDIA
${KENYA}                                    KENYA
${NIGERIA}                                  NIGERIA

# Environment Identifiers
${PROD}                                     PROD
${STAGE}                                    STAGE

# Contact Names (Sanitized)
${india_stage_contact_name}                 Demo App Staging
${kenya_stage_contact_name}                 Demo App Staging
${nigeria_stage_contact_name}               Demo App Staging

${india_prod_contact_name}                  Demo App Production
${kenya_prod_contact_name}                  Demo App Production
${nigeria_prod_contact_name}                Demo App Production

# Timeouts
${setup_timeout}                            60s
${wait_timeout}                             30s
${short_timeout}                            3s
${very_short_timeout}                       1s

# Special Characters & Keywords
${ENTER}                                    ENTER
${reset}                                    reset
${SELENIUM_LIBRARY}                         SeleniumLibrary

# Test Contact Information
${automation_user_contact}                  ${AUTOMATION_USER_CONTACT}

# User Preferences
${user_language}                            English
${user_gender}                              Man
${female_user_gender}                       Woman
${user_age}                                 22
