class Api::V1::UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users/:id
  def show
    respond_with @user
  end

  # DELETE /users/:id
  def destroy
    @user.soft_delete
    sign_out @user
    
    render status: 200, json: { 
      message: 'your account has been deleted'
    }
  end
end
