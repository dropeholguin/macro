class HomeController < ApplicationController

  # GET /
  def index
  end

  # GET /react
  def react
    respond_to do |format|
      format.html { render layout: 'react-layout' }
    end
  end

  # GET /terms_and_conditions
  def terms_and_conditions
    @terms = Privacy.where(category: :terms_and_conditions).order(created_at: :desc).first

    respond_to do |format|
      format.html
      format.json { render json: { terms: @terms.as_json } }
    end
  end

  # GET /privacy
  def privacy_policy
    @privacy = Privacy.where(category: :privacy_policy).order(created_at: :desc).first

    respond_to do |format|
      format.html
      format.json { render json: { privacy: @privacy.as_json } }
    end
  end
end
