class ChatsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @application = Application.find_by!(token: params[:application_token])
    @chats = @application.chats
    render json: @chats
  end

  def show
    @application = Application.find_by!(token: params[:application_token])
    @chat = @application.chats.find(params[:id])  # `params[:id]` should be used here to find the chat
    render json: @chat
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Chat not found' }, status: :not_found
  end

  def create
    @application = Application.find_by!(token: params[:application_token])
    
    next_chat_number = @application.chats_count + 1
    @chat = @application.chats.create!(chat_params.merge(number: next_chat_number))
    
    render json: @chat, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    @application = Application.find_by!(token: params[:application_token])
    @chat = @application.chats.find(params[:id])
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: { errors: @chat.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Chat not found' }, status: :not_found
  end

  def destroy
    @application = Application.find_by!(token: params[:application_token])
    @chat = @application.chats.find(params[:id])
    @chat.destroy!
    
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Chat not found' }, status: :not_found
  end

  private

  def chat_params
    params.require(:chat).permit(:some_attribute) # Remove `:number` and `:messages_count`
  end
end
