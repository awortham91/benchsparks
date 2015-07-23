require 'rails_helper'

feature "Admin can see admin team and add new members" do
  let(:user) { FactoryGirl.create(:user) }

  # As an admin I want to see my team
  # and add a new members
  # Acceptance criteria:
  # - Admin can see all admin
  # - Admin can promote other admin

  scenario 'Admin can see all admin' do
    user.admin = true
    user.save

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_link 'admin team'

    expect(page).to have_content(user.name)
  end
  pending scenario 'Admin can add other admin' do
    user.admin = true
    user.save

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_link 'admin team'
    click_button 'add an admin'
    
  end

end
