require 'rails_helper'

RSpec.describe 'Vue', type: :request do
  context '#vue' do
    before(:each) do
      get '/something'
    end

    it { expect(response).to have_http_status(:ok) }
  end
end
