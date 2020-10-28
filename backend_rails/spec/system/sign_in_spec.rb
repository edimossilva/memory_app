describe "the signin process", type: :system do
  before :each do
    AdminUser.create(email: 'user@example.com', password: 'password')
  end

  it "signs me in" do
    visit '/admin'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'Back to app'
  end
end
