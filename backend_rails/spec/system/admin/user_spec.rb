describe "User", type: :system, js:true do
  include Devise::Test::IntegrationHelpers
  describe 'Admin/User' do
    let!(:admin) { AdminUser.create(email: 'user@example.com', password: 'password') }
    let!(:user) { create(:user) }

    before :each do
      sign_in admin, scope: :admin_user
    end

    describe 'Create user' do
      let(:username) { 'mock_username' }
      let(:user_type) { 'admin' }

      describe 'When data is correct' do
        before(:each) do
          visit '/admin/users/new'
          fill_in 'Username', with: 'mock_username'
          fill_in 'Password', with: 'mock_password'
          select user_type, :from => "user[access_level]"

          click_button 'Create User'
        end

        it "creates user" do
          expect(page).to have_content 'User was successfully created.'
          expect(page).to have_content username
          expect(page).to have_content user_type
        end
      end
    end
  end
end
