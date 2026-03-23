*** Settings ***

Library    SeleniumLibrary

Resource    ../../../resources/common_resources.robot
Resource    ../../../resources/stage/smoke/smoke_suite_resource.robot
Resource    ../../../data/common_properties.robot

Suite Setup    Open Whatsapp Web And Scan The Link Manually
Suite Teardown    Close Browser

*** Test Cases ***

Verify Chatbot Onboarding Flow Works Correctly
    [Tags]    Smoke    Chatbot    Onboarding
    [Documentation]    Verify user can complete onboarding flow with chatbot

    Given Input Search Bar Is Visible On The Screen

    When User Starts The Demo Onboarding Flow    ${demo_smoke_keyword_1}    ${user_language}    ${user_gender}    ${user_age}

    Then Response From Bot    ${onboarding_complete_thanks}

Verify Chatbot Main Menu Is Accessible
    [Tags]    Smoke    Chatbot    Menu
    [Documentation]    Verify main menu loads and shows all options

    Given User Accesses The Main Menu

    Then Response From Bot    ${menu_option_1}
    And Response From Bot    ${menu_option_2}

Verify Chatbot Is Responsive To User Messages
    [Tags]    Smoke    Chatbot
    [Documentation]    Verify bot responds to simple user messages

    Given Input Search Bar Is Visible On The Screen

    When Verify Bot Is Responsive

    Then Wait Until Element Is Visible    ${whatsapp_response_container}    ${wait_timeout}
