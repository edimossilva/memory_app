require 'rails_helper'

RSpec.describe ShareableList, type: :model do
  describe 'validations' do
    describe 'name' do
      it { should validate_presence_of(:name) }
    end
  end

  describe 'relationship' do
    it { should belong_to(:user).required }
    it { should have_many(:shareable_list_memories) }
    it { should have_many(:memories).through(:shareable_list_memories) }
  end
end
