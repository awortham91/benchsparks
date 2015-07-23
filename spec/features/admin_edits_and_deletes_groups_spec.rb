require 'rails_helper'

feature "Admin edit and delete groups" do
  let(:user) { FactoryGirl.create(:user) }

  # As an admin I want to edit
  # and delete groups
  # so that I can arrange my classes.
  # Acceptance criteria:
  # - Admin can edit groups
  # - Admin can delete groups

  scenario 'Admin can edit a group', js: true do
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

    click_button 'edit'
    fill_in 'Name', with: 'Crazy people are sane'

    uncheck u1.name
    check u3.name

    click_button 'Submit Edits'

    expect(page).to have_content('Your edits were saved!')

    click_button 'show group'

    expect(page).to have_content('Crazy people are sane')
    expect(page).to have_content(u2.name)
    expect(page).to have_content(u3.name)
    expect(page).to_not have_content(u1.name)
  end

  scenario 'Admin can delete a group', js: true do
    user.admin = true
    user.save
    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.create(:user)

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
    expect(page).to have_content('Crazy people are crazy')

    click_button 'delete'

    page.evaluate_script('window.confirm = function() { return true; }')

    expect(page).to_not have_content('group added.')
  end


end
