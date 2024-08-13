class SetDefaultMessagesCount < ActiveRecord::Migration[6.0]
  def up
    
    Chat.where(messages_count: nil).update_all(messages_count: 0)
  end

  def down
    
  end
end
