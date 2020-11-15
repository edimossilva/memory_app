require 'rails_helper'

RSpec.describe MemoryTag, type: :model do
  describe 'relationship' do
    it { should belong_to(:tag).required }
    it { should belong_to(:memory).required }
  end

  describe 'uniqueness' do
    subject { create(:memory_tag) }
    it { should validate_uniqueness_of(:memory_id).scoped_to(:tag_id) }
  end
end
