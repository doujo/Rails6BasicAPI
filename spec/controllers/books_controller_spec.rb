# controller specific specs
require "rails_helper"

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'GET index' do
    it 'has a max limit of 100' do
      expect(Book).to receive(:limit).with(100).and_call_original

      #get '/api/v1/books', params: { limit: 999 }
      # convert into controller test
      get :index, params: { limit: 999 }
    end 
  end

  describe 'POST create' do
    let(:book_name) { 'Harry Potter' }

    it 'calls UpdateSkuJob with correct params' do
      expect(UpdateSkuJob).to receive(:perform_later).with(book_name)

      post :create, params: {
        author: {
          first_name: 'Maulana',
          last_name: 'Haikal',
          age: 48
        },
        book: {
          title: book_name 
        }
      }
    end
  end
end
