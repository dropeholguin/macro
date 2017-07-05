class Api::V1::PrivaciesController < ApplicationController
  before_action :authenticate_user!, only: [:accept]

  # GET /
  def index
    @privacy = Privacy.order(created_at: :desc).first

    respond_to do |format|
      format.json { render json: { privacy: @privacy.as_json } }
    end
  end

  # PATCH /accept
  def accept
    @privacy = Privacy.find_by(id: params[:id])

    respond_to do |format|
      if @privacy.present?
        accepted_privacy = current_user.accepted_privacies.new(privacy_id: @privacy.id)

        if accepted_privacy.save && current_user.update(privacy_version: @privacy.version)
          format.json { render json: { success: true, privacy: @privacy.as_json }, status: :ok }
        else
          format.json { render json: { error: 'some error occurred' }, status: 500 }
        end
      else
        format.json { render json: { error: 'resource not found' }, status: 404 }
      end
    end
  end
end
