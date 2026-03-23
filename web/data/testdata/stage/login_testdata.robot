*** Variables ***

# ============================================================================
# Login Test Data - Staging
# Credentials loaded from environment variables for security
# ============================================================================

# User Credentials (staging demo account)
${login_email}                              demo@yourdomain.com
${login_password}                           DemoPassword123

# Alternative Test Credentials
${alternate_email}                          alternate.user@yourdomain.com
${alternate_password}                       DemoPassword123

# Invalid Test Credentials (for negative tests)
${invalid_email}                            invalid@example.com
${invalid_password}                         wrongpassword123

# Test User Display Names
${test_user_name}                           Test User
${test_user_role}                           Administrator

# User Preferences
${user_language}                            English
${user_timezone}                            UTC
