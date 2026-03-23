*** Variables ***

# ============================================================================
# API - Common Error Messages
# Expected error responses for API validation
# ============================================================================

# 4xx Client Errors
${error_bad_request}                        Bad Request
${error_invalid_payload}                    Invalid request payload
${error_missing_required_field}             Missing required field
${error_unauthorized}                       Unauthorized
${error_invalid_credentials}                Invalid credentials
${error_invalid_token}                      Invalid or expired token
${error_forbidden}                          Forbidden
${error_access_denied}                      Access denied
${error_not_found}                          Not Found
${error_resource_not_found}                 Resource not found
${error_conflict}                           Conflict
${error_duplicate_entry}                    Duplicate entry
${error_rate_limit}                         Rate limit exceeded

# 5xx Server Errors
${error_server_error}                       Internal Server Error
${error_service_unavailable}                Service Unavailable
${error_maintenance_mode}                   Service under maintenance

# Generic Error Wrapper
${error_response_format}                    {"error": {"message": "", "code": ""}}
${error_timestamp_field}                    timestamp
${error_path_field}                         path
${error_trace_id_field}                     traceId

# Success Messages
${success_ok}                               OK
${success_created}                          Created
${success_operation_complete}               Operation completed successfully
${success_data_retrieved}                   Data retrieved successfully
