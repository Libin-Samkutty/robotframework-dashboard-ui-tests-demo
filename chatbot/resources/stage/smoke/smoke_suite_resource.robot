*** Settings ***

Library    SeleniumLibrary    run_on_failure=NOTHING
Library    DateTime

Resource    ../../common_resources.robot
Resource    ../../../data/locators/chatbot_page_locators.robot
Resource    ../../../data/common_properties.robot
Resource    ../../../data/testdata/stage/stage_testdata.robot

*** Keywords ***

# ============================================================================
# Chatbot Smoke Test Keywords
# High-level flow keywords for smoke testing
# ============================================================================

User Starts The Demo Onboarding Flow
    [Documentation]    Start the onboarding process
    [Arguments]        ${keyword_to_be_sent}    ${users_language}    ${users_gender}    ${users_age}
    User Resets The Account On The Chatbot
    User Resets The Account On The Chatbot
    Send Message To Bot    ${keyword_to_be_sent}
    Response From Bot    ${users_language}
    Click Element With Text    ${users_language}
    Response From Bot    ${welcome_message}
    Response From Bot    ${users_gender}
    Click Element With Text    ${users_gender}
    Send Message To Bot    ${users_age}
    Response From Bot    ${onboarding_complete_thanks}

User Accesses The Main Menu
    [Documentation]    Navigate to and verify main menu
    Send Message To Bot    ${demo_smoke_keyword_2}
    Response From Bot    ${main_menu_message}
    Response From Bot    ${menu_option_1}
    Response From Bot    ${menu_option_2}

User Sends The Demo Sandbox Passphrase
    [Documentation]    Send sandbox passphrase to enable demo features
    Send Message To Bot    ${demo_sandbox_passphrase}
    Response From Bot    ${bot_says_thank_you}

User Navigates To A Conversation Flow
    [Documentation]    Navigate to a demo conversation
    Send Message To Bot    ${demo_smoke_keyword_3}
    Response From Bot    ${welcome_message}

User Completes A Simple Conversation
    [Documentation]    Complete a full conversation flow
    Send Message To Bot    ${demo_smoke_keyword_1}
    Response From Bot    ${welcome_message_eng}
    Send Message To Bot    ${bot_response_yes}
    Response From Bot    ${bot_says_processing}
    Response From Bot    ${bot_says_complete}

Verify Bot Is Responsive
    [Documentation]    Check that bot responds to messages
    Send Message To Bot    ${test_user_input}
    # Bot should respond with something (not validation, just check it responds)
    Wait Until Element Is Visible    //div[@role='application']//span    ${wait_timeout}

User Selects Language
    [Documentation]    Select language preference
    [Arguments]        ${language}
    Click Element With Text    ${language}
    Response From Bot    ${bot_says_thank_you}
