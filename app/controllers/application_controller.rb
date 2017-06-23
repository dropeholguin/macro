class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  respond_to :json, :html

  acts_as_token_authentication_handler_for User, fallback_to_devise: false#, if: lambda { |controller| controller.request.format.json? }

  before_action :privacy_acceptance_check

  protected
    # check if user has accepted latest privacy
    def privacy_acceptance_check
      if user_signed_in? && controller_path != 'home' && !controller_path.starts_with?('admin/')
        latest_privacy = Privacy.order(created_at: :desc).first
        if latest_privacy.present?
          user_privacy = User.first.accepted_privacies.order(created_at: :desc).first
          unless user_privacy.present? && latest_privacy.id == user_privacy.privacy_id
            respond_to do |format|
              format.html { redirect_to privacy_path }
              format.json { render json: { error: 'You need to accept privacy policy first' }, status: 455 }
            end
          end
        end
      end
    end

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.html { redirect_to root_url, alert: exception.message }
        format.json { render json: { error: 'Access Denied' }, status: 401 }
      end
    end
end
