class ApplicationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @applications = Application.all
    render json: @applications
  end

  def show
    @application = Application.find_by!(token: params[:token])
    render json: @application
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Application not found' }, status: :not_found
  end

  def create
    @application = Application.new(application_params)
    @application.token = SecureRandom.uuid # Generate a unique token
    if @application.save
      render json: @application, status: :created
      Rails.logger.debug("Generated Token: #{@application.token}")
    else
      render json: { errors: @application.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    @application = Application.find_by!(token: params[:token])
    if @application.update(application_params)
      render json: @application
    else
      render json: { errors: @application.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Application not found' }, status: :not_found
  end

  def destroy
    @application = Application.find_by!(token: params[:token])
    @application.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Application not found' }, status: :not_found
  end

  private

  def application_params
    params.require(:application).permit(:name)
  end
end
