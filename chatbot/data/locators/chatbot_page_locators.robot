*** Variables ***

# ============================================================================
# Chatbot Page Locators
# XPath and CSS selectors for WhatsApp Web chatbot automation
# ============================================================================

# Search & Contact Selection
${whatsapp_search_contact_bar}              //div[@title='Search input textbox']

# Message Input & Sending
${whatsapp_message_input_box}               //div[@title='Type a message']
${whatsapp_send_button}                     //span[@data-testid='send']

# Menu & Actions
${whatsapp_three_dot_menu}                  //div[@data-testid='conversation-menu-button']//span[@data-icon='menu']
${whatsapp_clear_messages_button}           //div[@aria-label='Clear messages']

# Response Container
${whatsapp_response_container}              //div[@role='application']//span
