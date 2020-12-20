require 'rails_helper'

describe 'Books API', type: :request do
  it 'returns all books' do
    FactoryBot.create(:book, title: '1984', author: 'George')
    FactoryBot.create(:book, title: 'The Time Machine', author: 'Weels')

    # call the api
    get '/api/v1/books'

    #check api return successully
    expect(response).to have_http_status(:success)
    # check the response body has 2 object
    expect(JSON.parse(response.body).size).to eq(2)
  end
end
