# Create sample applications
app1 = Application.create!(name: 'App One', token: 'token78944', chats_count: 5)
app2 = Application.create!(name: 'App Two', token: 'token192344', chats_count: 10)

# Create sample chats with 'number' and 'messages_count'
chat1 = Chat.create!(application_id: app1.id, number: 1, messages_count: 2)
chat2 = Chat.create!(application_id: app1.id, number: 2, messages_count: 3)
chat3 = Chat.create!(application_id: app2.id, number: 1, messages_count: 1)

# Create sample messages with 'body' and 'number' attributes
Message.create!(chat_id: chat1.id, body: 'Hello from Chat 1 in App One!', number: 1)
Message.create!(chat_id: chat1.id, body: 'Another message in Chat 1 of App One!', number: 2)
Message.create!(chat_id: chat2.id, body: 'Hello from Chat 2 in App One!', number: 1)
Message.create!(chat_id: chat2.id, body: 'Another message in Chat 2 of App One!', number: 2)
Message.create!(chat_id: chat2.id, body: 'Yet another message in Chat 2 of App One!', number: 3)
Message.create!(chat_id: chat3.id, body: 'Hello from Chat 1 in App Two!', number: 1)
