class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  respond_to :json, :html

  acts_as_token_authentication_handler_for User, fallback_to_devise: false#, if: lambda { |controller| controller.request.format.json? }

  protected
    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.html { redirect_to root_url, alert: exception.message }
        format.json { render json: { error: 'Access Denied' }, status: 401 }
      end
    end

    def render_not_found_response(exception)
      render status: 400, json: {
        errors: "Invalid ID supplied"
      }
    end
end
