require 'rails_helper'

RSpec.describe MemoryListMemory, type: :model do
  describe 'relationship' do
    it { should belong_to(:memory).required }
    it { should belong_to(:memory_list).required }
  end
end
