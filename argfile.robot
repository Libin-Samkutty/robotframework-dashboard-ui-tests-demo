# argfile.robot - Default Robot Framework argument file
# Standard configuration for consistent test execution across local and CI environments
#
# Usage:
#   robot --argumentfile argfile.robot web/tests/
#   robot -A argfile.robot API/tests/
#   robot --argumentfile argfile.robot --include Smoke .

# Environment variables - can be overridden via command line
--variable    ENV:STAGING
--variable    COUNTRY:INDIA

# Test filtering
--include     Smoke

# Output configuration
--outputdir   reports
--loglevel    INFO
--timestampoutputs

# Do not generate individual reports here - use rebot to merge outputs
--report      NONE
