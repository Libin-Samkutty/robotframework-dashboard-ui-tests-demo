*** Variables ***

# ============================================================================
# Dashboard Page Locators
# XPath and CSS selectors for dashboard page elements
# ============================================================================

# Main Layout & Navigation
${dashboard_main_area}                      //div[@data-testid='dashboard']
${sidebar_nav}                              //nav[@data-testid='sidebar']
${sidebar_toggle}                           //button[@data-testid='sidebar-toggle']

# Navigation Menu Items
${dashboard_nav_item}                       //nav//a[contains(text(), 'Dashboard')]
${conversations_nav_item}                   //nav//a[contains(text(), 'Conversations')]
${analytics_nav_item}                       //nav//a[contains(text(), 'Analytics')]
${settings_nav_item}                        //nav//a[contains(text(), 'Settings')]

# Dashboard Widgets
${conversation_dashboard_canvas_element}    //canvas[@data-testid='dashboard-chart']
${widget_active_users}                      //div[@data-testid='widget-active-users']
${widget_messages_sent}                     //div[@data-testid='widget-messages-sent']
${widget_response_time}                     //div[@data-testid='widget-response-time']
${widget_user_satisfaction}                 //div[@data-testid='widget-satisfaction']

# User Menu & Account
${user_menu_button}                         //div[@data-testid='user-menu']
${logout_menu_item}                         //span[contains(text(), 'Logout')]
