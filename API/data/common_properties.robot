*** Variables ***

# ============================================================================
# API - Common Properties
# Base URLs, headers, and API configuration
# ============================================================================

# API Endpoints
${api_session_name}                         api_session
${api_base_url_staging}                     https://api-staging.yourdomain.com/v1
${api_base_url_prod}                        https://api.yourdomain.com/v1

# Authentication
${api_token}                                your-api-token

# Common Endpoints
${health_check_endpoint}                    /health
${version_endpoint}                         /version
${status_endpoint}                          /status

# Default Headers
${default_content_type}                     application/json
${default_accept}                           application/json

# Timeouts
${api_timeout}                              30s
${api_retry_count}                          3
${api_retry_delay}                          1s

# Response Codes
${success_200}                              200
${created_201}                              201
${bad_request_400}                          400
${unauthorized_401}                         401
${forbidden_403}                            403
${not_found_404}                            404
${server_error_500}                         500

# Environment Variables
${ENV}                                      staging
${COUNTRY}                                  India
