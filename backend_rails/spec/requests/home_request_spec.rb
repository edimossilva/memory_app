require 'rails_helper'

RSpec.describe 'Home', type: :request do
  context '#hello' do
    before(:each) do
      get '/'
    end

    it { expect(response).to have_http_status(:ok) }

    it 'contains fields from params' do
      response_json = JSON.parse(response.body)
      expect(response_json['data']).to eq 'hello :)'
    end
  end
end
