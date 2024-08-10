# app/models/message.rb
class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat

  validates :body, presence: true
  validates :number, presence: true, uniqueness: { scope: :chat_id }
  validates :chat, presence: true

  # index settings
  settings index: { number_of_shards: 1, number_of_replicas: 0 } do
    mappings dynamic: 'false' do
      indexes :body, type: 'text', analyzer: 'standard'
      indexes :number, type: 'integer'
    end
  end

  # for the elasticsearch
  def as_indexed_json(options = {})
    as_json(only: [:body, :number, :chat_id])
  end

  after_save :update_chat_messages_count
  after_destroy :update_chat_messages_count

  private

  def update_chat_messages_count
    chat.update(messages_count: chat.messages.size)
  end
end
