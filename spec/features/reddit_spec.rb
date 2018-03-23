require 'spec_helper'

feature 'Twitter', :post_deploy do

  scenario 'navigate to twitter and fail to login' do
    # this method comes from spec/helpers/login_spec_helper.rb  We can use it in
    # this test and in any future tests because that helper was included globally
    # in the rspec setup. To check that, take a look at the spec_helper.rb file.

    # in that file at line 23 we say look at the helpers directory and require every
    # file in that. Make every file in that helper directory available to be setup
    # in the spec file.

    # Then at line 88, we actually add it to the tests so it can be used here. We
    # get use of it here because at the top of this file we say require everything
    # from spec_helper

    navigate_to_twitter

    fill_in 'Phone, email, or username', with: 'barf@umn.edu'
    fill_in 'Password', with: 'krypt!k', match: :first
    click_button 'Log in'

    # expect(page).to have_text 'YOU FAILED MISERABLY TO LOG IN, TRY AGAIN!'
  end
end
