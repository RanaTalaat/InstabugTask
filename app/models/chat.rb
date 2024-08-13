# app/models/chat.rb
class Chat < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :application
  has_many :messages, dependent: :destroy

  validates :number, presence: true, uniqueness: { scope: :application_id }
  validates :application, presence: true

  after_create :increment_application_chats_count
  after_destroy :decrement_application_chats_count

  def as_indexed_json(options = {})
    as_json(only: [:number, :application_id])
  end

  def self.index_name
    'chats'
  end

  def self.settings
    {
      number_of_shards: 1,
      number_of_replicas: 1
    }
  end

  def self.mappings
    {
      properties: {
        number: { type: 'integer' },
        application_id: { type: 'integer' }
      }
    }
  end

  def redis
    @redis ||= Redis.new
  end

  def messages_count
    redis.get("chat:#{id}:messages_count").to_i
  end

  def increment_messages_count
    redis.incr("chat:#{id}:messages_count")
  end

  def decrement_messages_count
    redis.decr("chat:#{id}:messages_count")
  end

  private

  def increment_application_chats_count
    application.increment!(:chats_count)
  end

  def decrement_application_chats_count
    application.decrement!(:chats_count)
  end
end
