*** Settings ***

Library    SeleniumLibrary    run_on_failure=NOTHING
Library    String

Resource    ../data/common_properties.robot
Resource    ../data/locators/chatbot_page_locators.robot
Resource    ../data/testdata/stage/stage_testdata.robot

*** Keywords ***

# ============================================================================
# Chatbot Common Keywords
# Core WhatsApp Web interaction keywords
# ============================================================================

Open Whatsapp Web And Scan The Link Manually
    [Documentation]    Open WhatsApp Web and wait for manual QR scan
    Open Browser       ${whatsapp_web_url}    ${browser}
    Maximize Browser Window
    User Searches For The Environment In The Whatsapp Search Bar
    User Clicks On The Environment In The Whatsapp Contact Results List

User Waits For Few Seconds
    [Documentation]    Wait for specified number of seconds
    [Arguments]        ${wait_timeout_seconds}
    Sleep              ${wait_timeout_seconds}

User Searches For The Environment In The Whatsapp Search Bar
    [Documentation]    Search for bot contact in WhatsApp
    Wait Until Element Is Visible    ${whatsapp_search_contact_bar}    ${setup_timeout}
    User Waits For Few Seconds    ${short_timeout}
    IF    '${country}' == '${INDIA}'
        Press Keys    ${whatsapp_search_contact_bar}    ${india_stage_contact_name}
    ELSE IF    '${country}' == '${KENYA}'
        Press Keys    ${whatsapp_search_contact_bar}    ${kenya_stage_contact_name}
    ELSE
        Log To Console    Country not configured
    END
    User Waits For Few Seconds    ${short_timeout}

User Clicks On The Environment In The Whatsapp Contact Results List
    [Documentation]    Click on bot contact from search results
    Wait Until Element Is Visible    //div[@role='row']//span[@title='${india_stage_contact_name}']    ${setup_timeout}
    Click Element    //div[@role='row']//span[@title='${india_stage_contact_name}']
    User Waits For Few Seconds    ${very_short_timeout}
    Input Search Bar Is Visible On The Screen

Input Search Bar Is Visible On The Screen
    [Documentation]    Verify message input bar is visible and ready
    Wait Until Element Is Visible    ${whatsapp_message_input_box}    ${setup_timeout}
    Wait Until Element Is Enabled    ${whatsapp_message_input_box}
    User Waits For Few Seconds    ${very_short_timeout}

User Resets The Account On The Chatbot
    [Documentation]    Send reset command to bot
    Press Keys    ${whatsapp_message_input_box}    ${reset} ${automation_user_contact}
    Press Keys    ${whatsapp_message_input_box}    ${ENTER}
    User Waits For Few Seconds    ${short_timeout}

Send Message To Bot
    [Documentation]    Send a message to the chatbot
    [Arguments]        ${message_from_user}
    User Waits For Few Seconds    ${very_short_timeout}
    Press Keys    ${whatsapp_message_input_box}    ${message_from_user}
    Press Keys    ${whatsapp_message_input_box}    ${ENTER}
    User Waits For Few Seconds    ${short_timeout}

Response From Bot
    [Documentation]    Wait for and verify bot response text
    [Arguments]        ${response_from_bot}
    ${current_count}=    Count The Number Of Elements On The Page    //div[@role='application']//span[contains(text(),'${response_from_bot}')]
    ${next_index}=       Evaluate    ${current_count}+1
    Wait Until Element Is Visible    (//div[@role='application']//span[contains(text(),'${response_from_bot}')])[${next_index}]    ${wait_timeout}

Count The Number Of Elements On The Page
    [Documentation]    Count matching elements on page and return the count
    [Arguments]        ${locator_of_element}
    Set Library Search Order    ${SELENIUM_LIBRARY}
    ${element_count}=    Get Element Count    ${locator_of_element}
    ${element_count}=    Convert To Integer    ${element_count}
    RETURN               ${element_count}

Click Element With Text
    [Documentation]    Find and click element by text
    [Arguments]        ${element_text}
    Wait Until Element Is Visible    //*[text()='${element_text}']    ${wait_timeout}
    ${count}=          Count The Number Of Elements On The Page    //*[text()='${element_text}']
    Click Element      (//*[text()='${element_text}'])[${count}]

Clear Chat History
    [Documentation]    Clear all messages in current chat
    Click Element    ${whatsapp_three_dot_menu}
    Wait Until Element Is Visible    ${whatsapp_clear_messages_button}    ${wait_timeout}
    Click Element    ${whatsapp_clear_messages_button}
    User Waits For Few Seconds    ${short_timeout}
