class ChatsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @application = Application.find_by!(token: params[:application_token])
    @chats = @application.chats
    render json: @chats
  end

  def show
    @application = Application.find_by!(token: params[:application_token])
    @chat = @application.chats.find(params[:id])  # Use `params[:id]` here
    render json: @chat
  end

  def create
    @application = Application.find_by!(token: params[:application_token])
    @chat = @application.chats.create!(chat_params)
    render json: @chat, status: :created
  end

  def update
    @application = Application.find_by!(token: params[:application_token])
    @chat = @application.chats.find(params[:id])  # Use `params[:id]` here
    @chat.update!(chat_params)
    render json: @chat
  end

  def destroy
    @application = Application.find_by!(token: params[:application_token])
    @chat = @application.chats.find(params[:id])  # Use `params[:id]` here
    @chat.destroy!
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Chat not found' }, status: :not_found
  end

  private

  def chat_params
    params.require(:chat).permit(:number, :messages_count)
  end
end
