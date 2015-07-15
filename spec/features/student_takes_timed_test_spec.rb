require 'rails_helper'

feature "timed test allows students to get a count" do
  let(:user) { FactoryGirl.create(:user) }

  # As a student I want to be able to take a timed test
  # so that I can see how many questions I can answer in a minute
  # Acceptance criteria:
  # - Student can click to play math quiz
  # - number of questions answered will be tracked

  scenario 'I want to start a test and see my points' , js: true do

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    click_link 'TimedPractice'

    expect(page).to have_content('Ready?')

    click_button 'Start the timer!'

    fill_in 'answer_area', with: "400"

    find(:id, 'answer_area').native.send_keys("\n")

    expect(page).to have_content('-1')

    fill_in 'answer_area', with: "400"

    find(:id, 'answer_area').native.send_keys("\n")

    expect(page).to have_content('-2')
  end

  scenario 'I want to not be able to submit nothing' , js: true do

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    click_link 'TimedPractice'

    expect(page).to have_content('Ready?')

    click_button 'Start the timer!'

    fill_in 'answer_area', with: ""

    find(:id, 'answer_area').native.send_keys("\n")

    expect(page).to have_content('0')

    fill_in 'answer_area', with: "400"

    find(:id, 'answer_area').native.send_keys("\n")

    expect(page).to have_content('-1')
  end
end
