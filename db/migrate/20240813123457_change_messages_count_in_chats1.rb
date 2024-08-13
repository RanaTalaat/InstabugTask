class ChangeMessagesCountInChats1 < ActiveRecord::Migration[6.0]
  def change
    change_column :chats, :messages_count, :integer, null: false, default: 0
  end
end
