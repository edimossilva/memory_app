require 'rails_helper'

RSpec.describe ShareableListMemory, type: :model do
  describe 'relationship' do
    it { should belong_to(:memory).required }
    it { should belong_to(:shareable_list).required }
  end
end
