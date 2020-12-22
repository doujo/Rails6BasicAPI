require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    before do
      author = FactoryBot.create(:author, first_name: 'Maulana', last_name: 'Haikal', age: 22)
      FactoryBot.create(:book, title: '1984', author_id: author.id)
      FactoryBot.create(:book, title: 'The Time Machine', author_id: author.id)
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
        post '/api/v1/books', params: {
          book: {title: 'MERN stack'},
          author: {first_name: 'Maulana', last_name: 'Haikal', age: '22'}
        }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
    end
  end

  describe 'DELETE /books/:id' do
    let!(:book) {
      author = FactoryBot.create(:author, first_name: 'Maulana', last_name: 'Haikal', age: 22)
      FactoryBot.create(:book, title: '1984', author_id: author.id)
    }
    it 'deletes a book' do
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
