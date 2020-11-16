require 'rails_helper'

RSpec.describe 'Tests', type: :request do
  context '#delete_test_user_data' do
    let!(:user) { create(:user, username: 'test_user') }
    let!(:memories) { create_list(:memory, 3, user: user) }
    let!(:tags) { create_list(:tag, 3, user: user) }
    let!(:memory_tag) { create(:memory_tag, memory: memories[0], tag: tags[0]) }

    before(:each) do
      get("/api/v1/delete_test_user_data")
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(Memory.count).to eq(0) }
    it { expect(Tag.count).to eq(0) }
    it { expect(MemoryTag.count).to eq(0) }
  end
end
