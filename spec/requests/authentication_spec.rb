require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authentication' do
    it 'authenticates the client' do
      post '/api/v1/authenticate', params: { username: 'Waluhbajarang', password: "asd123"}

      expect(response).to have_http_status(:created)
      expect(response_body).to eq({
        'token' => '123'
      })
    end

    it 'return error when username is missing' do
      post '/api/v1/authenticate', params: { password: "asd123"}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: username'
      })
    end

    it 'return error when password is missing' do
      post '/api/v1/authenticate', params: { username: 'Waluhbajarang'}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: password'
      })
    end
  end
end
