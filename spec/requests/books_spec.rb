require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    before do
      FactoryBot.create(:book, title: '1984', author: 'George')
      FactoryBot.create(:book, title: 'The Time Machine', author: 'Weels')
    end

    it 'returns all books' do
      # call the api
      get '/api/v1/books'

      #check api return successully
      expect(response).to have_http_status(:success)
      # check the response body has 2 object
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /books' do
    it 'create a new book' do
      expect {
        post '/api/v1/books', params: {book: {title: 'MERN stack', author: 'Unknown'}}
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end
end
