class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.create!(message_params)
    render json: @message, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def index
    @chat = Chat.find(params[:chat_id])
    @messages = @chat.messages.order(:number)
    render json: @messages
  end

  def show
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.find(params[:id])
    render json: @message
  end

  def update
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.find(params[:id])
    if @message.update(message_params)
      render json: @message
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.find(params[:id])
    @message.destroy
    head :no_content
  end

  private

  def message_params
    params.require(:message).permit(:body, :number)
  end
end
