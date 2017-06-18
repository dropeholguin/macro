class AuthsController < ApplicationController

  # POST /linkedin
  def linkedin
    client = LinkedIn::Client.new(ENV["LINKEDIN_ID"], ENV['LINKEDIN_SECRET'])

    begin
      consumer = client.consumer
      token = consumer.get_access_token(nil, {}, {
        'xoauth_oauth2_access_token' => params[:oauth_token]
      })

      client.authorize_from_access(token.token, token.secret)
      user_info = client.profile({
        fields: ['id', 'first-name', 'last-name', 'picture-url', 'email-address', 'positions:(title,company:(name))']
      })

      user_info["name"] = "#{user_info["first-name"]} #{user_info["last-name"]}"
      user_info["email"] = user_info["email-address"]
      auth = Hashie::Mash.new({
        uid: user_info["id"],
        provider: 'linkedin',
        info: user_info
      })

      user = User.from_omniauth(auth)

      if user.present? && user.valid?
        render json: { success: true, user: user_info }, status: :ok
      else
        render json: { success: false, error: 'Invalid user or some error occured' }, status: :ok
      end
    rescue OAuth::Problem => e
      render json: { error: 'Invalid auth_token' }, status: 401
    rescue Exception => e
      render json: { error: 'Unknown error occured, please try again later' }, status: 500
    end
  end
end
