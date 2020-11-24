# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MemoryList', type: :request do
  let!(:registred_user) { create(:user, :registred) }
  let!(:registred_headers) { header_for_user(registred_user) }

  context '#create' do
    context 'when data is valid' do
      let!(:memories) { create_list(:memory, 2, user: registred_user) }
      let!(:name) { 'super name :)' }

      let!(:create_params) do
        {
          name: name,
          memories_ids: memories.pluck(:id)
        }
      end

      before(:each) do
        post('/api/v1/memory_lists', params: create_params, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:created) }

      it 'contains fields from params' do
        expect(json_response_data['id']).not_to be_nil
        expect(json_response_data['name']).to eq(name)
      end
    end
  end
end
