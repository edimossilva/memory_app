# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MemoryTag', type: :request do
  let!(:registred_user) { create(:user, :registred) }
  let!(:registred_headers) { header_for_user(registred_user) }

  context '#create' do
    context 'when data is valid' do
      let!(:memories) { create_list(:memory, 2, user: registred_user) }
      let!(:tags) { create_list(:tag, 2, user: registred_user) }

      let!(:create_params) do
        {
          memory_tags: [
            {
              memory_id: memories[0].id,
              tag_id: tags[0].id
            },
            {
              memory_id: memories[1].id,
              tag_id: tags[1].id
            }
          ],
        }
      end

      before(:each) do
        post('/api/v1/memory_tags', params: create_params, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:created) }

      it 'contains fields from params' do
        expect(json_response_data[0]['id']).not_to be_nil
        expect(json_response_data[0]['memory']['id']).to eq(memories[0].id)
        expect(json_response_data[0]['tag']['id']).to eq(tags[0].id)
      end
    end

    context 'when data is invalid (user is not owner of memory and tag)' do
      let!(:memories) { create_list(:memory, 2) }
      let!(:tags) { create_list(:tag, 2) }

      let!(:create_params) do
        {
          memory_tags: [
            {
              memory_id: memories[0].id,
              tag_id: tags[0].id
            },
            {
              memory_id: memories[1].id,
              tag_id: tags[1].id
            }
          ],
        }
      end

      before(:each) do
        post('/api/v1/memory_tags', params: create_params, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:unauthorized) }

      # it 'contains fields from params' do
      #   expect(json_response_data['id']).not_to be_nil
      #   expect(json_response_data['key']).to eq(create_memory_params[:key])
      #   expect(json_response_data['value']).to eq(create_memory_params[:value])
      #   expect(json_response_data['visibility']).to eq(create_memory_params[:visibility])
      # end
    end
  end
end
