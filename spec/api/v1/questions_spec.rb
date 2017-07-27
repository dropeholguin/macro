require 'rails_helper'
require 'airborne'

describe 'GET /cards index' do
	let(:user){ create(:user) }
	let!(:question){ create(:question) }

  it 'Questions List API should throw exception when email and token is not passed' do
    get '/api/v1/cards.json'
    expect_status("401")
    expect_json(error: "You need to sign in or sign up before continuing.")
  end

  it 'Questions List API should return events list with proper data' do
    get '/api/v1/cards.json', {},
      {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect(response).to be_success
		expect_json_types('questions.*', id: :integer, title: :string )
		expect_json('questions.0', title: "A Catskill Eagle", description_markdown: "description_markdown" )
	end
end

describe 'POST /cards create' do
	let(:user){ create(:user) }

	it 'Create question API Requires a tag' do
    get '/api/v1/cards.json', {},
      {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect(response).to be_success
		
	end
end

describe 'DELETE /cards/{questionId} destroy' do
  let(:user){ create(:user) }
  let!(:question){ create(:question) }

  def delete_question_API
    question.update_attribute(:user_id, user.id)

    delete '/api/v1/cards/1.json', {},
      {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
  end

  it 'Delete question API' do
    delete_question_API

    expect_status("200")
    expect_json(message: "Success")
  end

  it 'Delete question API question not found' do
    delete_question_API

    delete '/api/v1/cards/1.json', {},
      {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("404")
    expect_json(errors: "Question not found")
  end

  it 'Delete question API Invalid ID supplied' do
    delete '/api/v1/cards/10.json', {},
      {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("400")
    expect_json(errors: "Invalid ID supplied")
  end

  it 'Delete question API Access Denied' do
    delete '/api/v1/cards/1.json', {},
      {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("401")
    expect_json(error: "Access Denied")
  end

end
