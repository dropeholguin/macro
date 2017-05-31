class UploadsController < ApplicationController

  # POST /uploads
  def create
    upload = Upload.new(image: params[:image])

    respond_to do |format|
      if upload.save
        format.json  { render json: { success: true, image: { url: upload.image.url, name: Upload.first.image_file_name } } }
      else
        format.json  { render json: { success: false, error: upload.errors.messages } }
      end
    end
  end
end
