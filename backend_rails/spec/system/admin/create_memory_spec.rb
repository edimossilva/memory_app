describe "Admin::MemoriesController", type: :system, js:true do
  include Devise::Test::IntegrationHelpers
  describe 'Create memory' do
    let!(:admin) { AdminUser.create(email: 'user@example.com', password: 'password') }
    let!(:user) { create(:user) }
    before :each do
      sign_in admin, scope: :admin_user
    end

    it "signs me in" do
      visit '/admin/memories/new'
      # find(:select, from, options).find(:option, value, options).select_option
      # save_and_open_screenshot
      # select "User #1", :from => "memory_user_id-selectized"
      # binding.pry
      find('label', text: 'User2').click
      # find('div', text: "User #1").click
      find('.selectize-dropdown .option[data-selectable]', text: "User ##{user.id}").click

      # find("#memory_user_id option[value='1']").select_option


      fill_in 'Key', with: 'name'
      fill_in 'Value', with: 'example'
      click_button 'Create Memory'
      # save_and_open_screenshot
      expect(page).to have_content 'Memory was successfully created.'
    end
  end
end
