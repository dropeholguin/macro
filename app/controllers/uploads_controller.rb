class UploadsController < ApplicationController

  # POST /uploads
  def create
    respond_to do |format|
      if params[:file].present? && params[:file] != 'undefined'
        upload = Upload.new(image: params[:file])
        if upload.save
          format.json  { render json: { success: true, image: { url: upload.image.url, name: Upload.first.image_file_name } } }
        else
          format.json  { render json: { success: false, error: upload.errors.messages } }
        end
      else
        format.json  { render json: { success: false, error: "File missing" } }
      end
    end
  end
end
