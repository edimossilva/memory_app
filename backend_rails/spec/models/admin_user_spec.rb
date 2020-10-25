require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'When data is valid' do
    let(:secret) { "secret" }
    let(:admin) { AdminUser.new(email:"edimo@gmail.com", password: secret) }

    it 'is valid' do
      expect(admin).to be_valid
    end
  end

  describe 'When email is not valid' do
    let(:admin) { AdminUser.new(email:"edimo", password: "secret") }

    it 'is not valid' do
      expect(admin).to be_invalid
    end
  end
end
