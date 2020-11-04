require 'rails_helper'

RSpec.describe 'Home', type: :request do
  context '#hello' do
    before(:each) do
      get '/'
    end

    it { expect(response).to have_http_status(:ok) }
  end
end
