require 'rails_helper'

feature "Admin creates and views groups" do
  let(:user) { FactoryGirl.create(:user) }

  # As an admin I want to see a list of all groups
  # and create my own groups
  # so that I can arrange my classes.
  # Acceptance criteria:
  # - Admin can see all groups
  # - Admin can create their own groups
  # - Only Admin can get to the page

  scenario 'Admin can create and see a group', js: true do
    user.admin = true
    user.save
    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.create(:user)
    u3 = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_link 'groups'

    expect(page).to have_content('All Groups')

    click_button 'Create a group'

    fill_in 'Name', with: 'Crazy people are crazy'
    check u1.name
    check u2.name

    click_button 'create group'

    expect(page).to have_content('group added.')
    click_button 'show group'


    expect(page).to have_content(u1.name)
    expect(page).to have_content(u2.name)
  end

  scenario 'Only admin can see the page' do

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to_not have_content 'groups'

    visit groups_path

    expect(page).to_not have_content('All Groups')
    expect(page).to have_content('You are not allowed there!')

  end
end
