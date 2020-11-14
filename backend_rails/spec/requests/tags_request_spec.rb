# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tag', type: :request do
  let!(:registred_user) { create(:user, :registred) }
  let!(:registred_headers) { header_for_user(registred_user) }
  let!(:user2) { create(:user) }
  let!(:registred_headers2) { header_for_user(user2) }

  context '#create' do
    context 'when data is valid' do
      let!(:create_tag_params) do
        { name: 'phone',}
      end

      before(:each) do
        post('/api/v1/tags', params: create_tag_params, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:created) }

      it 'contains fields from params' do
        expect(json_response_data['id']).not_to be_nil
        expect(json_response_data['name']).to eq(create_tag_params[:name])
        expect(json_response_data['user_id']).to eq(registred_user.id)
      end
    end

    context 'when data is not valid' do
      let!(:create_tag_params) do
        { name: '' }
      end

      before(:each) do
        post('/api/v1/tags', params: create_tag_params, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'contains fields from params' do
        expect(json_response_error).to eq("Validation failed: Name can't be blank")
      end
    end

    context 'when Tag with name alread exists for another user' do
      let!(:tag) { create(:tag, user: user2, name: 'existing_name') }
      let!(:create_tag_params) do
        { name: 'existing_name' }
      end

      before(:each) do
        post('/api/v1/tags', params: create_tag_params, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:created) }
    end
  end

  context '#destroy' do
    let!(:tag) { create(:tag, user: registred_user) }

    describe 'When find Tag' do
      before(:each) do
        delete("/api/v1/tags/#{tag.id}", headers: registred_headers)
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    describe 'When not find Tag' do
      before(:each) do
        delete('/api/v1/tags/999', headers: registred_headers)
      end

      it { expect(response).to have_http_status(:not_found) }

      it 'return error message related to not found' do
        expect(json_response_error).to eq("Couldn't find Tag")
      end
    end

    describe 'When is not owner' do
      before(:each) do
        delete("/api/v1/tags/#{tag.id}", headers: registred_headers2)
      end

      it { expect(response).to have_http_status(:unauthorized) }
      it { expect(tag.reload).to_not be_nil }
    end
  end

  context '#find' do
    let!(:tag) { create(:tag, user: registred_user, name: 'name') }

    describe 'When data is valid' do
      before(:each) do
        get("/api/v1/tags/#{tag.id}", headers: registred_headers)
      end

      it { expect(response).to have_http_status(:ok) }

      it 'returns Tag' do
        expect(json_response_data['id']).to eq(tag.id)
      end
    end

    describe 'When not find item' do
      before(:each) do
        put('/api/v1/tags/999', headers: registred_headers)
      end

      it { expect(response).to have_http_status(:not_found) }

      it 'return error message related to value' do
        expect(json_response_error).to eq("Couldn't find Tag")
      end
    end

    describe 'When Tag not belongs to user' do
      before(:each) do
        put("/api/v1/tags/#{tag.id}", headers: registred_headers2)
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it 'return error message related to value' do
        expect(json_response_error).to eq("not allowed to owner? this Tag")
      end
    end
  end

  context '#index' do
    before(:each) do
      create_list(:tag, 3)
      create_list(:tag, 2, user: registred_user)
      get('/api/v1/tags', headers: registred_headers)
    end

    it { expect(response).to have_http_status(:ok) }

    it 'contains all user tags' do
      expect(json_response_data.count).to eq(2)
    end
  end

  context '#update' do
    let!(:tag) { create(:tag, user: registred_user, name: 'name') }

    describe 'When data is valid' do
      let!(:update_memory_params) do
        { 'name' => 'new_name' }
      end

      before(:each) do
        put("/api/v1/tags/#{tag.id}", params: update_memory_params, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:ok) }

      it 'updates fields' do
        expect(json_response_data['name']).to eq('new_name')
      end
    end

    describe 'When data is invalid' do
      let!(:update_memory_params) do
        { 'name' => '' }
      end

      before(:each) do
        put("/api/v1/tags/#{tag.id}", params: update_memory_params, headers: registred_headers)
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'return error message related to value' do
        expect(json_response_error).to eq("Validation failed: Name can't be blank")
      end
    end

    describe 'When not find item' do
      before(:each) do
        put('/api/v1/tags/999', headers: registred_headers)
      end

      it { expect(response).to have_http_status(:not_found) }

      it 'return error message related to value' do
        expect(json_response_error).to eq("Couldn't find Tag")
      end
    end

    describe 'When Tag not belongs to user' do
      before(:each) do
        put("/api/v1/tags/#{tag.id}", headers: registred_headers2)
      end

      it { expect(response).to have_http_status(:unauthorized) }

      it 'return error message related to value' do
        expect(json_response_error).to eq("not allowed to owner? this Tag")
      end
    end
  end
end
