require 'rails_helper'

feature "practice page contains page tracker" do
  let(:user) { FactoryGirl.create(:user) }

  # As a student I want to be able to track my session
  # so that I can know how much work I have done.
  # Acceptance criteria:
  # - Student can click to play math game.
  # - After each questions the stats update without refresh
  # - practice affects my overall stats

  scenario 'I want to answer some practice questions and see my progress' , js: true do
    stats = FactoryGirl.create(:userquestionstat)
    stats.user = user
    stats.save

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    click_link 'Practice'

    expect(page).to have_content(0)

    click_button 'Play Random'

    fill_in 'practice_answer_area', with: "1"

    find(:id, 'practice_answer_area').native.send_keys("\n")

    expect(page).to have_content('1')

    click_button 'Play Random'

    fill_in 'practice_answer_area', with: "1"

    find(:id, 'practice_answer_area').native.send_keys("\n")

    expect(page).to have_content('2')
  end

  scenario 'I want to answer some practice questions and then check my stats' , js: true do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    click_link 'Practice'

    expect(page).to have_content(0)

    click_button 'Play Random'

    fill_in 'practice_answer_area', with: "1"

    find(:id, 'practice_answer_area').native.send_keys("\n")

    click_button 'Play Random'

    fill_in 'practice_answer_area', with: "1"

    find(:id, 'practice_answer_area').native.send_keys("\n")

    click_link 'MyStats'

    expect(page).to have_content(2)
  end
end
