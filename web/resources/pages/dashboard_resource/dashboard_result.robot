*** Settings ***
Library    SeleniumLibrary

Resource    ../../../data/locators/dashboard_page_locators.robot
Resource    ../../../data/common_properties.robot
Resource    ../../../data/testdata/contents.robot

*** Keywords ***

Dashboard Page Should Load Successfully
    [Documentation]    Verify the dashboard main area is visible and page title is displayed
    Wait Until Element Is Visible    ${dashboard_main_area}    ${default_timeout}
    Wait Until Page Contains    ${DASHBOARD_TITLE}    ${default_timeout}

All Dashboard Widgets Should Be Visible
    [Documentation]    Verify all four core KPI widgets are rendered on the page
    Element Should Be Visible    ${widget_active_users}
    Element Should Be Visible    ${widget_messages_sent}
    Element Should Be Visible    ${widget_response_time}
    Element Should Be Visible    ${widget_user_satisfaction}

Sidebar Navigation Should Be Visible
    [Documentation]    Verify sidebar navigation is visible with core navigation items
    Element Should Be Visible    ${sidebar_nav}
    Element Should Be Visible    ${dashboard_nav_item}
    Element Should Be Visible    ${conversations_nav_item}

Dashboard Chart Should Be Rendered
    [Documentation]    Verify dashboard chart canvas element is present and visible
    Wait Until Element Is Visible    ${conversation_dashboard_canvas_element}    ${default_timeout}

User Should Be Returned To Login Page After Logout
    [Documentation]    Confirm that logout redirects back to the login page
    Wait Until Page Contains    ${LOGIN_POPUP}    ${default_timeout}
