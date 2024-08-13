Rails.application.config.to_prepare do
  Chat.find_each do |chat|
    $redis.set("chat:#{chat.id}:messages_count", chat.messages.count)
  end
end
