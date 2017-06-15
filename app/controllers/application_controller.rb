class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  respond_to :json, :html

  acts_as_token_authentication_handler_for User, if: lambda { |controller| controller.request.format.json? }

  rescue_from CanCan::AccessDenied do |exception|
    if request.format.json
      render json: { error: 'Access Denied' }, status: 401
    else
      redirect_to root_url, alert: exception.message
    end
  end
end
