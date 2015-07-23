require 'rails_helper'

feature "Admin views students stats" do
  let(:user) { FactoryGirl.create(:user) }

  # As an admin I want to see a list of all students and their stats
  # so that I can adjust my teaching.
  # Acceptance criteria:
  # - Admin can see all non-admin users
  # - Admin can see the stats of those users
  # - Only Admin can get to the page

  scenario 'Admin can see all non-admin users' do
    user.admin = true
    user.save
    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.create(:user)

    stats1 = FactoryGirl.create(:userquestionstat)
    stats1.user = u1
    stats1.save

    stats2 = FactoryGirl.create(:userquestionstat)
    stats2.user = u2
    stats2.save

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_link 'all users'

    expect(page).to have_content(u1.name)
    expect(page).to have_content(u2.name)
    expect(page).to have_content(stats1.total_questions)
    expect(page).to have_content(stats2.total_questions)
    expect(page).to have_content(stats2.correct)
    expect(page).to have_content(stats2.incorrect)
  end

  scenario 'Only admin can see the page' do

    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to_not have_content 'all users'

    visit users_path

    expect(page).to_not have_content(u1.name)
    expect(page).to_not have_content(u2.name)
    expect(page).to have_content('You are not allowed there!')

  end
end
