*** Variables ***

# ============================================================================
# Production Environment Test Data
# URLs and environment-specific settings for production
# ============================================================================

# Environment URLs
${prod_url_india}                           https://app.yourdomain.com/summary
${prod_url_eu}                              https://app-eu.yourdomain.com/summary
${prod_url}                                 https://app.yourdomain.com

# Production Environment Identifier
${prod_env}                                 PROD

# Test Location Data (Production)
${prod_location_india}                      Mumbai Production
${prod_location_eu}                         London Production
${prod_location_default}                    Delhi Production

# Production Timeouts (should be faster, but set conservatively)
${prod_api_response_timeout}                10s
${prod_page_load_timeout}                   20s

# Production-Only Features
${maintenance_mode_enabled}                 False
${feature_flags_enabled}                    True
