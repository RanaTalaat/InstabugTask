class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat

  validates :body, presence: true
  validates :number, presence: true, uniqueness: { scope: :chat_id }
  validates :chat, presence: true

  # Elasticsearch index settings
  settings index: { number_of_shards: 1, number_of_replicas: 0 } do
    mappings dynamic: 'false' do
      indexes :body, type: 'text', analyzer: 'standard'
      indexes :number, type: 'integer'
    end
  end

  # Elasticsearch indexing
  def as_indexed_json(options = {})
    as_json(only: [:body, :number, :chat_id])
  end

  
  after_save :enqueue_chat_messages_count_update
  after_destroy :enqueue_chat_messages_count_update

  private

  def enqueue_chat_messages_count_update
    
    ChatMessagesCountUpdateJob.perform_later(chat.id)
  end
end
