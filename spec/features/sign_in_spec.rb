require 'rails_helper'

feature 'Signing in' do
  background do
    User.create(email: 'user@example.com', first_name: 'user', last_name: 'example', username: 'userexample', password: 'password')
  end

  scenario 'Signing in with correct credentials' do
    sign_in_with 'user@example.com', 'password'

    expect(page).to have_content 'Logout'
  end

  given(:other_user) { User.create(email: 'other@example.com', password: 'password') }

  scenario 'Signing in as another user' do
    sign_in_with other_user.email, other_user.password

    expect(page).to have_content 'Invalid email or password'
  end
end

def sign_in_with(email, password)
  visit '/users/sign_in'
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_button 'Sign in'
end
