require 'rails_helper'

describe 'Books API', type: :request do
  let(:first_author) { FactoryBot.create(:author, first_name: 'Maulana', last_name: 'Haikal', age: 22)}
  let(:second_author) { FactoryBot.create(:author, first_name: 'Waluh', last_name: 'Bajarang', age: 20)}
  describe 'GET /books' do
    before do
      FactoryBot.create(:book, title: '1984', author: first_author)
      FactoryBot.create(:book, title: 'The Time Machine', author: second_author)
    end

    it 'returns all books' do
      # call the api
      get '/api/v1/books'

      #check api return successully
      expect(response).to have_http_status(:success)
      # check the response body has 2 object
      expect(response_body.size).to eq(2)
      # check created book with it relation (author)
      expect(response_body).to eq(
        [
          {
            'id' => 1,
            'title' => '1984',
            'author_name' => 'Maulana Haikal',
            'author_age' => 22,
          }, {
            'id' => 2,
            'title' => 'The Time Machine',
            'author_name' => 'Waluh Bajarang',
            'author_age' => 20,
          }
        ]
      )
    end

    it 'returns a subset of books based on limit' do
      get '/api/v1/books', params: { limit: 1 }

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            'id' => 1,
            'title' => '1984',
            'author_name' => 'Maulana Haikal',
            'author_age' => 22
          }
        ]
      )
    end

    it 'return a subset of books based on limit and offset' do
      get '/api/v1/books', params: { limit: 1, offset: 1 }
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            'id' => 2,
            'title' => 'The Time Machine',
            'author_name' => 'Waluh Bajarang',
            'author_age' => 20,
          }
        ]
      )
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
      expect(response_body).to eq(
        {
          'id' => 1,
          'title' => 'MERN stack',
          'author_name' => 'Maulana Haikal',
          'author_age' => 22,
        }
      )
    end
  end

  describe 'DELETE /books/:id' do
    let!(:book) { FactoryBot.create(:book, title: '1984', author: first_author) }
    it 'deletes a book' do
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end

end
