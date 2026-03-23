*** Variables ***

# ============================================================================
# Login Page Locators
# XPath and CSS selectors for login page elements
# ============================================================================

# Form Fields
${email_field}                              //input[@name="email"]
${password_field}                           //input[@name="password"]

# Buttons
${submit_button}                            //button[@type="submit"]
${forgot_password_link}                     //a[contains(text(), 'Forgot password')]

# Navigation & Logout
${logout_button}                            //span[contains(text(), 'Logout')]
${user_menu}                                //div[@data-testid='user-menu']

# Page Identifiers
${dashboard_landing_page}                   //span[contains(text(), 'Dashboard')]
${login_page_title}                         //h1[contains(text(), 'Login')]

# Error Messages
${error_message_invalid_credentials}        //div[contains(text(), 'Invalid email or password')]
${error_message_required_field}             //span[contains(text(), 'This field is required')]

# Loading Indicators
${loading_spinner}                          //div[@class='spinner']
${loading_overlay}                          //div[@data-testid='loading-overlay']
