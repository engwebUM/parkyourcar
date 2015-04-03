require 'rails_helper'

feature 'Forgot password' do
  background do
    User.create(email: 'user@example.com', first_name: 'user', last_name: 'example', username: 'userexample', password: 'password')
  end

  scenario 'Forgot password with email that exists' do
    forgot_password 'user@example.com'

    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
  end

  given(:other_user) { User.create(email: 'other@example.com', password: 'password') }

  scenario 'Forgot password with email that does not exists' do
    forgot_password 'invaliduser@example.com'

    expect(page).to have_content 'Email not found'
  end
end

def forgot_password(email)
  visit '/users/password/new'
  fill_in 'user_email', with: email
  click_button 'Send me reset password instructions'
end
