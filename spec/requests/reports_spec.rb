require 'rails_helper'

RSpec.describe 'Reports', type: :request do
  describe 'GET /update' do
    it 'returns http success' do
      get '/reports/update'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/reports/index'
      expect(response).to have_http_status(:success)
    end
  end
end
