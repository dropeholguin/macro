class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:accept_privacy]

  # GET /
  def index
  end

  # GET /terms_and_conditions
  def terms_and_conditions
  end

  # GET /privacy
  def privacy_policy
    @privacy = Privacy.order(created_at: :desc).first

    respond_to do |format|
      format.html
      format.json { render json: { privacy: @privacy.as_json } }
    end
  end

  # PATCH /privacy/:id/accept
  def accept_privacy
    @privacy = Privacy.find_by(id: params[:id])

    respond_to do |format|
      if @privacy.present?
        accepted_privacy = current_user.accepted_privacies.new(privacy_id: @privacy.id)

        if accepted_privacy.save
          format.html
          format.json { render json: { success: true, privacy: @privacy.as_json }, status: :ok }
        else
          format.html
          format.json { render json: { error: 'some error occurred' }, status: 500 }
        end
      else
        format.html
        format.json { render json: { error: 'resource not found' }, status: 404 }
      end
    end
  end
end
