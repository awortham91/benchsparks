require 'rails_helper'

feature "practice page contains page tracker" do
  let(:user) { FactoryGirl.create(:user) }

  # As a student I want to be able to earn harder problems
  # so that I can know when I have hit the benchmark
  # Acceptance criteria:
  # - Student can click to play a level.
  # - if the level is completed the next benchmark appears

  pending scenario 'I want to answer some practice questions and see my progress' , js: true do
    stats = FactoryGirl.create(:userquestionstat)
    stats.user = user
    stats.save

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    click_link 'Benchsparks'

    expect(page).to have_content('Multiplication Tables!')

    click_button '1s'

    fill_in 'practice_answer_area', with: "1"

    find(:id, 'practice_answer_area').native.send_keys("\n")

    expect(page).to have_content('1')

    click_button 'Play Random'

    fill_in 'practice_answer_area', with: "1"

    find(:id, 'practice_answer_area').native.send_keys("\n")

    expect(page).to have_content('2')
  end
end
