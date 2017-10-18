require 'rails_helper'
require 'airborne'

describe 'GET /cards/count count' do
  let(:user){ create(:user) }
  let!(:question){ create(:question) }
  let!(:topic1){ create(:topic)}
  let!(:topic2){ Topic.create(id: 1,name: %Q|SAS Programming|, desc: %Q|Programming|)}
  let!(:topic3){ Topic.create(id: 2,name: %Q|SAS Macro|, desc: %Q|Macro|)}

  # params[:tags_not] || params[:tags_any] || params[:tags_all]

  # it 'Count question API search with tags_any' do
    
  #   get '/api/v1/cards/count.json', params: { "tags_not" => [2] }, headers: {
  #       'X-User-Email' => user.email,
  #       'X-User-Token' => user.authentication_token
  #     }
  #   expect_status("200")
  #   expect(Question.count).to eq(32)
  #   expect_json(count: 32)
  # end

  it 'Count question API search with tags_any' do
    
    get '/api/v1/cards/count.json', params: { "tags_not" => [2] }, headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("200")
    expect(Question.count).to eq(32)
    expect_json(count: 32)
  end

  it 'Count question API search with no params' do
    
    get '/api/v1/cards/count.json', params: { }, headers: {
        'X-User-Email' => user.email,
        'X-User-Token' => user.authentication_token
      }
    expect_status("200")
    expect_json(count: 0)
  end
end