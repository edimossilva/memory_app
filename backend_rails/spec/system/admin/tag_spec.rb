describe "Admin::TagsController", type: :system, js:true do
  include Devise::Test::IntegrationHelpers
  describe 'Admin/tag' do
    let!(:admin) { AdminUser.create(email: 'user@example.com', password: 'password') }
    let!(:user) { create(:user) }

    before :each do
      sign_in admin, scope: :admin_user
    end

    describe 'Create tag' do
      let(:name) { 'tag_name' }

      describe 'When data is correct' do
        before(:each) do
          visit '/admin/tags/new'

          find('label', text: 'User').click
          find('.selectize-dropdown .option[data-selectable]', text: "User ##{user.id}").click
          fill_in 'Name', with: name
          click_button 'Create Tag'
        end

        it "creates tag" do
          expect(page).to have_content 'Tag was successfully created.'
          expect(page).to have_content name
        end
      end
    end
  end
end
