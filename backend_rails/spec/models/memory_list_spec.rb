require 'rails_helper'

RSpec.describe MemoryList, type: :model do
  describe 'validations' do
    describe 'name' do
      it { should validate_presence_of(:name) }
    end
  end

  describe 'relationship' do
    it { should belong_to(:user).required }
    it { should have_many(:memory_list_memories) }
    it { should have_many(:memories).through(:memory_list_memories) }
  end
end
