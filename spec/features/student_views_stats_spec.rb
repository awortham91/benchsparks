require 'rails_helper'

feature "Student views their stats" do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  # As a student I want to be able to track how many questions I have answered
  # so that I can see my progress.
  # Acceptance criteria:
  # - Student can see the number of questions they have answered

  scenario 'I want to see how many questions I have answered' do
    stats = FactoryGirl.create(:userquestionstat)
    stats.user_id = @user.id


    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Log in'
binding.pry
    click_link 'MyStats'

    expect(page).to have_content(stats.total_questions)
    expect(page).to have_content(stats.correct)
    expect(page).to have_content(stats.incorrect)
  end
end
