require 'rails_helper'

RSpec.describe MemoryTag, type: :model do
  describe 'relationship' do
    it { should belong_to(:tag).required }
    it { should belong_to(:memory).required }
  end
end
