require 'rails_helper'
require 'airborne'

describe 'GET /cards index' do
	let(:user){ create(:user) }
	let!(:question){ create(:question) }

  it 'Questions List API should throw exception when email and user token is not passed' do
    get '/api/v1/cards.json'
    expect_status("401")
    expect_json(error: "You need to sign in or sign up before continuing.")
  end

  it 'Questions List API should return events list with proper data' do
    get '/api/v1/cards.json', params: { }, headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token 
      }
    expect(response).to be_success
		expect_json_types('questions.*', id: :integer, title: :string )
		expect_json('questions.0', title: "A Catskill Eagle", description_markdown: "description_markdown" )
	end
end