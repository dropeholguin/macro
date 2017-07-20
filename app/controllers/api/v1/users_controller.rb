class Api::V1::UsersController < ApplicationController
  load_and_authorize_resource

  # DELETE /users/delete
  def destroy
    @user.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(:user)
    
    render status: 200, json: { 
      message: 'you have deleted your account'
    }
  end
end
