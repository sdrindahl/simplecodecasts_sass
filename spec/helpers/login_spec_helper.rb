module LoginSpecHelper

  def navigate_to_twitter
    visit 'https://www.twitter.com'
    expect(page).to have_link 'Forgot password?'
  end

  def navigate_to_facebook_login
    visit 'https://www.facebook.com'
    #expect(page).to have_text 'Sign Up'
  end

  def navigate_to_vikings
    visit 'http://www.vikings.com/'
    # expect(page).to have_link 'vikings'
  end
end
