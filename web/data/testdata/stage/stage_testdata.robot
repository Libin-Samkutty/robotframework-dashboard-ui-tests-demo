*** Variables ***

# ============================================================================
# Staging Environment Test Data
# URLs and environment-specific settings for staging
# ============================================================================

# Environment URLs
${stage_url_india}                          https://staging.yourdomain.com/summary
${stage_url_eu}                             https://staging-eu.yourdomain.com/summary
${stage_url}                                https://staging.yourdomain.com

# Environment Identifier
${env}                                      # Variable for command-line assignment
${country}                                  # Variable for command-line assignment

# Test Location Data
${test_location_india}                      New Delhi
${test_location_eu}                         London
${test_location_default}                    Mumbai

# Test Timeouts (staging may have slower responses)
${api_response_timeout}                     15s
${page_load_timeout}                        30s
