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

  describe '.initialize' do
    describe 'has public property false by default' do
      let(:shareable_list) { ShareableList.new }

      it 'public property is false' do
        expect(shareable_list).to_not be_public
      end
    end
  end
end
