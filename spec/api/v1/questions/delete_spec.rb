require 'rails_helper'
require 'airborne'

describe 'DELETE /cards/{questionId} destroy' do
  let(:user){ create(:user) }
  let!(:question){ create(:question) }

  def delete_question_API
    question.update_attribute(:user_id, user.id)

    delete '/api/v1/cards/1.json', params: { }, headers: {
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

    delete '/api/v1/cards/1.json', params: { }, headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("404")
    expect_json(errors: "Question not found")
  end

  it 'Delete question API Invalid ID supplied' do
    delete '/api/v1/cards/10.json', params: { }, headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("400")
    expect_json(errors: "Invalid ID supplied")
  end

  it 'Delete question API Access Denied' do
    delete '/api/v1/cards/1.json', params: { }, headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("401")
    expect_json(error: "Access Denied")
  end
end