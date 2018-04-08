require 'spec_helper'

feature 'Vikings', :post_deploy do

  scenario 'navigate to vikings' do
    navigate_to_vikings
    click_link 'News'
    click_link 'Video'
    click_link 'Photos'
    # click_link 'Watch Games'
    # click_link 'Team'
    click_link 'Schedule'
    click_link 'U.S. Bank Stadium'
    click_link 'Cheer'
    # click_link 'Tickets'
    # click_link 'Shop'
    click_link 'More'
  end

  scenario 'Twitter' do
    navigate_to_twitter
    fill_in 'Phone, email, or username', with: 'tbone3414@gmail.com'
    fill_in 'Password', with: 'I_lovefootball34', match: :first
    click_button 'Log in'
    find(:path, ‘//*[@id=“tweet-box-home-timeline”]/div’).set(‘tweet tweet’)
    # find(:xpath, //*[@id="tweet-box-home-timeline"]/div)
  #   # expect(page).to have_link 'Rindahl34'
    # find(:xpath, //*[@id="Tweetstorm-tweet-box-0"]/div[2]/div[1]/div[2]/div[2]/div[2]/div[1].set("Hello this is my first tweet")
  #   # click_button 'Tweet'
  #   # find(:xpath, "//div[label='First Name']/input").set("text")
  end
end

# scenario 'navigate to twitter and fail to login' do
  # this method comes from spec/helpers/login_spec_helper.rb  We can use it in
  # this test and in any future tests because that helper was included globally
  # in the rspec setup. To check that, take a look at the spec_helper.rb file.

  # in that file at line 23 we say look at the helpers directory and require every
  # file in that. Make every file in that helper directory available to be setup
  # in the spec file.

  # Then at line 88, we actually add it to the tests so it can be used here. We
  # get use of it here because at the top of this file we say require everything
  # from spec_helper

  # navigate_to_twitter
  #
  # fill_in 'Phone, email, or username', with: 'barf@umn.edu'
  # fill_in 'Password', with: 'krypt!k', match: :first
  # click_button 'Log in'

  # expect(page).to have_text 'YOU FAILED MISERABLY TO LOG IN, TRY AGAIN!'
# end
