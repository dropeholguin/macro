require 'rails_helper'
require 'airborne'

describe 'PUT /cards edit' do
  let(:user){ create(:user) }
  let!(:question){ create(:question) }
  let!(:answer1){ create(:answer) }
  let!(:answer2){ create(:answer) }
  let!(:answer3){ create(:answer) }
  let!(:topic){ create(:topic)}


  before do
    question.update(user_id: user.id)
    answer1.update(question_id: question.id)
    answer2.update(question_id: question.id)
    answer3.update(question_id: question.id)
  end

  it 'Edit question API, editing Description markdown' do
    
    put '/api/v1/cards/1.json', params: { 'question' => {'description_markdown' => "updated description" } }, headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("200")
    expect_json(message: "Successfully updated Card.")

    question.reload
    expect(question.description_markdown).to eq("updated description")
  end

  it 'Edit question API, editing Explanation markdown' do

    put '/api/v1/cards/1.json', params: { 'question' => {'explanation_markdown' => "updated explanation" } }, headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("200")
    expect_json(message: "Successfully updated Card.")

    question.reload
    expect(question.explanation_markdown).to eq("updated explanation")
  end

  it 'Edit question API, editing Choice' do

    put '/api/v1/cards/1.json', params: { 'question' => {'choice' => "multiple" } }, headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("200")
    expect_json(message: "Successfully updated Card.")

    question.reload
    expect(question.choice).to eq("multiple")
  end

  it 'Edit question API, editing Answers' do
  
    put '/api/v1/cards/1.json', params: { 'question' => { 'explanation_markdown' => "updated explanation" }, "answers" => [{"answer_markdown" => "first_answer", "is_correct" => "false"}, {"answer_markdown" => "second_answer", "is_correct" => "false"}, {"answer_markdown" => "three_answer", "is_correct" => "true"}] } , headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("200")
    expect_json(message: "Successfully updated Card.")

    question.reload
    expect(question.answers[0][:answer_markdown]).to eq("first_answer")
    expect(question.answers[1][:answer_markdown]).to eq("second_answer")
    expect(question.answers[2][:answer_markdown]).to eq("three_answer")
    expect(question.tag_list[1]).to eq("SAS Programming")
  end

  it 'Edit question API, editing Tags' do
  
    put '/api/v1/cards/1.json', params: { 'question' => { 'explanation_markdown' => "updated explanation" }, "tags" => [4] } , headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("200")
    expect_json(message: "Successfully updated Card.")

    question.reload
    expect(question.tag_list[0]).to eq("DI Studio")
    expect(question.tag_list[1]).to eq("SAS Macro")
    expect(question.tag_list[2]).to eq("SAS Programming")
  end
end
