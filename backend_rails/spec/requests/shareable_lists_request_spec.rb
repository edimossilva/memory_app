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

  context '#update' do
    let!(:shareable_list) { create(:shareable_list, user: registred_user) }
    let!(:new_name) { 'new name' }

    describe 'When update only name' do
      before(:each) do
        put("/api/v1/shareable_lists/#{shareable_list.id}", params:{ name: new_name }, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:ok) }

      it 'contains fields from params' do
        expect(json_response_data["name"]).to eq(new_name)
      end
    end

    describe 'When add new memories' do
      let!(:memory_list) { create_list(:memory, 3, user: registred_user) }
      let!(:memories_ids) { memory_list.pluck(:id) }

      before(:each) do
        put("/api/v1/shareable_lists/#{shareable_list.id}", params:{ memories_ids: memories_ids }, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:ok) }

      it 'contains memories from params' do
        expect(json_response_data["memories"].count).to eq(3)
      end
    end

    describe 'When remove memories' do
      let!(:memory_list) { create_list(:memory, 3, user: registred_user) }
      let!(:memories_ids) { memory_list.pluck(:id) }
      let!(:shareable_list_memory0) { create(:shareable_list_memory, memory: memory_list[0], shareable_list: shareable_list) }
      let!(:shareable_list_memory1) { create(:shareable_list_memory, memory: memory_list[1], shareable_list: shareable_list) }
      let!(:shareable_list_memory2) { create(:shareable_list_memory, memory: memory_list[2], shareable_list: shareable_list) }

      before(:each) do
        put("/api/v1/shareable_lists/#{shareable_list.id}", params:{ memories_ids: [memory_list[0].id, memory_list[1].id] }, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:ok) }

      it 'contains only memories from params' do
        expect(json_response_data["memories"].count).to eq(2)
      end

      it 'destroy shareable memory from removed memory' do
        expect(ShareableListMemory.find_by(id: shareable_list_memory2.id)).to be_nil
      end
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

  context '#public_shareable_list' do
    describe 'when shareable list exist' do
      let!(:shareable_list_name) { 'super_name' }
      let!(:registred_user2) { create(:user, :registred, username: 'username2') }

      let!(:shareable_list) { create(:shareable_list, name: shareable_list_name, user: registred_user) }
      let!(:shareable_list2) { create(:shareable_list, name: shareable_list_name, user: registred_user2) }

      context 'when does find' do
        before(:each) do
          get("/api/v1/shareable_lists/public_shareable_list?username=#{registred_user2.username}&shareable_list_name=#{shareable_list_name}")
        end

        it { expect(response).to have_http_status(:ok) }

        it 'contains shareable list by username and shareable list name' do
          expect(json_response_data["name"]).to eq(shareable_list_name)
          expect(json_response_data["user_id"]).to eq(registred_user2.id)
        end
      end

      context 'when does not find by username' do
        before(:each) do
          get("/api/v1/shareable_lists/public_shareable_list?username=#{'not existing'}&shareable_list_name=#{shareable_list_name}")
        end

        it { expect(response).to have_http_status(:not_found) }
      end

      context 'when does not find by shareable list name' do
        before(:each) do
          get("/api/v1/shareable_lists/public_shareable_list?username=#{registred_user2.username}&shareable_list_name=#{'not existing'}")
        end

        it { expect(response).to have_http_status(:not_found) }
      end
    end
  end
end
