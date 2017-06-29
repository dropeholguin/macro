class AuthsController < ApplicationController

  # POST /getToken
  def getToken
    render json: { token: 'asdsdasdas' }, status: :ok
  end

  # POST /facebook
  def facebook
    client = OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], site: 'https://graph.facebook.com')
    token  = OAuth2::AccessToken.new(client, params[:auth_token])

    begin
      user_info = ActiveSupport::JSON.decode(token.get('/me').body)
      auth = Hashie::Mash.new({
        uid: user_info['id'],
        provider: 'facebook',
        info: user_info
      })

      user = User.from_omniauth(auth)

      if user.present? && user.valid?
        render json: { success: true, user: user.as_json }, status: :ok
      else
        render json: { success: false, error: 'Invalid user or some error occured' }, status: :ok
      end
    rescue OAuth2::Error => e
      render json: { error: 'Invalid auth_token' }, status: 401
    rescue Exception => e
      render json: { error: 'Unknown error occured, please try again later' }, status: 500
    end
  end

  # POST /google
  def google
    client = OAuth2::Client.new(ENV['GOOGLE_APP_ID'], ENV['GOOGLE_APP_SECRET'])
    token  = OAuth2::AccessToken.new(client, params[:auth_token])

    begin
      user_info = ActiveSupport::JSON.decode(token.get("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params[:auth_token]}").body)
      auth = Hashie::Mash.new({ 
        uid: user_info['sub'],
        provider: 'google_oauth2', 
        info: user_info
      });

      user = User.from_omniauth(auth)

      if user.present? && user.valid?
        render json: { success: true, user: user.as_json }, status: :ok
      else
        render json: { success: false, error: 'Invalid user or some error occured' }, status: :ok
      end
    rescue OAuth2::Error => e
      render json: { error: 'Invalid auth_token' }, status: 40
    rescue Exception => e
      render json: { error: 'Unknown error occured, please try again later' }, status: 500
    end
  end

  # POST /linkedin
  def linkedin
    client = LinkedIn::Client.new(ENV['LINKEDIN_ID'], ENV['LINKEDIN_SECRET'])

    begin
      consumer = client.consumer
      token = consumer.get_access_token(nil, {}, {
        'xoauth_oauth2_access_token' => params[:auth_token]
      })

      client.authorize_from_access(token.token, token.secret)
      user_info = client.profile({
        fields: ['id', 'first-name', 'last-name', 'picture-url', 'email-address', 'positions:(title,company:(name))']
      })

      user_info['name'] = "#{user_info["first-name"]} #{user_info["last-name"]}"
      user_info['email'] = user_info['email-address']
      auth = Hashie::Mash.new({
        uid: user_info['id'],
        provider: 'linkedin',
        info: user_info
      })

      user = User.from_omniauth(auth)

      if user.present? && user.valid?
        render json: { success: true, user: user.as_json }, status: :ok
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
