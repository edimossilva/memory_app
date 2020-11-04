# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  context '#omniauth' do
    let(:user) { build(:user) }
    before(:each) do
      allow(User).to receive(:from_omniauth).and_return(user)
      get '/auth/google/callback'
    end

    it 'contains fields from params' do
      expect(response.body).to include('token=')
      expect(response.body).to include(user.id.to_s)
      expect(response.body).to include('registred')
    end
  end
end
