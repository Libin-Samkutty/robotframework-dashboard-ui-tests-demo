*** Settings ***
Library    SeleniumLibrary

Resource    ../../../data/locators/dashboard_page_locators.robot
Resource    ../../../data/common_properties.robot
Resource    ../login_resource/login_action.robot
Resource    ../../utilities/utility_keywords.robot

*** Keywords ***

User Navigates To Dashboard
    [Documentation]    Click Dashboard in sidebar navigation and wait for main area to load
    Wait For Element And Click    ${dashboard_nav_item}
    Wait Until Element Is Visible    ${dashboard_main_area}    ${default_timeout}

User Toggles The Sidebar
    [Documentation]    Click the sidebar collapse/expand toggle button
    Wait For Element And Click    ${sidebar_toggle}

User Navigates To Conversations Section
    [Documentation]    Click Conversations navigation item
    Wait For Element And Click    ${conversations_nav_item}

User Navigates To Analytics Section
    [Documentation]    Click Analytics navigation item
    Wait For Element And Click    ${analytics_nav_item}

User Navigates To Settings Section
    [Documentation]    Click Settings navigation item
    Wait For Element And Click    ${settings_nav_item}

User Logs Out From Dashboard
    [Documentation]    Click user menu button and then logout menu item
    Wait For Element And Click    ${user_menu_button}
    Wait For Element And Click    ${logout_menu_item}
