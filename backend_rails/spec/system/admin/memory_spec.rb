describe "Admin::MemoriesController", type: :system, js:true do
  include Devise::Test::IntegrationHelpers
  describe 'Admin/memory' do
    let!(:admin) { AdminUser.create(email: 'user@example.com', password: 'password') }
    let!(:user) { create(:user) }

    before :each do
      sign_in admin, scope: :admin_user
    end

    describe 'Create memory' do
      let(:key) { 'name_key' }
      let(:value) { 'cool_name' }

      describe 'When data is correct' do
        before(:each) do
          visit '/admin/memories/new'

          find('label', text: 'User').click
          find('.selectize-dropdown .option[data-selectable]', text: "User ##{user.id}").click
          fill_in 'Key', with: key
          fill_in 'Value', with: value
          click_button 'Create Memory'
        end

        it "creates memory" do
          expect(page).to have_content 'Memory was successfully created.'
          expect(page).to have_content key
          expect(page).to have_content value
        end
      end
    end
  end
end
