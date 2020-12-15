# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SareableList', type: :request do
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
        post('/api/v1/shareable_lists', params: create_params, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:created) }

      it 'contains fields from params' do
        expect(json_response_data['id']).not_to be_nil
        expect(json_response_data['name']).to eq(name)
        expect(json_response_data["memories"][0]["id"]).to eq(memories[0]["id"])
        expect(json_response_data["memories"][1]["id"]).to eq(memories[1]["id"])
      end
    end
  end

  context '#index' do
    let!(:shareable_lists) { create_list(:shareable_list, 2, user: registred_user) }

    before(:each) do
      get('/api/v1/shareable_lists', headers: registred_headers)
    end

    it { expect(response).to have_http_status(:ok) }

    it 'contains fields from params' do
      expect(json_response_data[0]["id"]).to eq(shareable_lists[0]["id"])
      expect(json_response_data[1]["id"]).to eq(shareable_lists[1]["id"])
    end
  end

  context '#destroy' do
    let!(:shareable_list) { create(:shareable_list, user: registred_user) }

    describe 'When find shareable_list' do
      before(:each) do
        delete("/api/v1/shareable_lists/#{shareable_list.id}", headers: registred_headers)
      end

      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
