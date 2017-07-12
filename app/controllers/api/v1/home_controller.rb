class Api::V1::HomeController < ApplicationController

  # GET /terms_and_conditions
  def terms_and_conditions
    @terms = Privacy.where(category: :terms_and_conditions).order(created_at: :desc).first

    render json: { terms: @terms.as_json }
  end

  # GET /privacy
  def privacy_policy
    @privacy = Privacy.where(category: :privacy_policy).order(created_at: :desc).first

    render json: { privacy: @privacy.as_json }
  end
end
