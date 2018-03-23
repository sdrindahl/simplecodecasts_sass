module LoginSpecHelper

  def navigate_to_twitter
    visit 'https://www.twitter.com'
    expect(page).to have_link 'Forgot password?'
  end
end
