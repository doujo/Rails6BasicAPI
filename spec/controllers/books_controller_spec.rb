# controller specific specs
require "rails_helper"

RSpec.describe Api::V1::BooksController, type: :controller do
  it 'has a max limit of 100' do
    expect(Book).to receive(:limit).with(100).and_call_original

    #get '/api/v1/books', params: { limit: 999 }
    # convert into controller test
    get :index, params: { limit: 999 }
  end 
end
