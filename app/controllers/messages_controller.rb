# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @chat = find_chat
    
    next_message_number = @chat.messages.maximum(:number).to_i + 1

    @message = @chat.messages.create!(message_params.merge(number: next_message_number))
    
    increment_messages_count(@chat.id)

    render json: @message, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def index
    @chat = find_chat
    @messages = @chat.messages.order(:number)
    render json: @messages
  end

  def show
    @chat = find_chat
    @message = @chat.messages.find(params[:id])
    render json: @message
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Message not found' }, status: :not_found
  end

  def update
    @chat = find_chat
    @message = @chat.messages.find(params[:id])
    if @message.update(message_params)
      render json: @message
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Message not found' }, status: :not_found
  end

  def destroy
    @chat = find_chat
    @message = @chat.messages.find(params[:id])
    @message.destroy
    
    decrement_messages_count(@chat.id)
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Message not found' }, status: :not_found
  end

  private

  def find_chat
    Application.find_by!(token: params[:application_token])
              .chats.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:body) # Remove `:number`
  end

  def increment_messages_count(chat_id)
    redis = Redis.new
    redis.incr("chat:#{chat_id}:messages_count")
  end

  def decrement_messages_count(chat_id)
    redis = Redis.new
    redis.decr("chat:#{chat_id}:messages_count")
  end
end
