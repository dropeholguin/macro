require 'rails_helper'
require 'airborne'

describe 'POST /cards create' do
	let(:user){ create(:user) }

	it 'Create question API Requires a tag' do
    get '/api/v1/cards.json', params: { }, headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token 
      }
    expect(response).to be_success
		
	end
end