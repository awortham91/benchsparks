require 'rails_helper'

feature "Benchsparks work" do
  let(:user) { FactoryGirl.create(:user) }

  # As a student I want to be able to earn harder problems
  # so that I can know when I have hit the benchmark
  # Acceptance criteria:
  # - Student can click to play a level.
  # - if the level is completed the next benchmark appears
  # - answering questions affects my stats

  scenario 'I want to select a level and play it' , js: true do

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    click_link 'Benchsparks'

    expect(page).to have_content('Multiplication Tables!')

    click_button '1s'

    click_button 'Start the timer!'

    fill_in 'answer_area', with: "400"

    find(:id, 'answer_area').native.send_keys("\n")

    expect(page).to have_content('-1')

    fill_in 'answer_area', with: "400"

    find(:id, 'answer_area').native.send_keys("\n")

    expect(page).to have_content('-2')
  end

  scenario 'I want to select a level and have it update my stats' , js: true do

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    click_link 'Benchsparks'

    expect(page).to have_content('Multiplication Tables!')

    click_button '1s'

    click_button 'Start the timer!'

    fill_in 'answer_area', with: "400"

    find(:id, 'answer_area').native.send_keys("\n")

    sleep(1)

    fill_in 'answer_area', with: "400"

    find(:id, 'answer_area').native.send_keys("\n")

    expect(page).to have_content('-2')

    sleep(1)

    click_link 'MyStats'

    expect(page).to have_content('2')

  end
end
