require 'spec_helper'

feature 'Visitor signs up' do
  given(:user) { User.create(email: 'user@example.com', first_name: 'user', last_name: 'example', username: 'userexample', password: 'password') }

  scenario 'Signing up with correct information' do
    sign_up_with [[:email, 'valid@example.com'], [:first_name, 'valid'], [:last_name, 'valid'], [:username, 'valid'], [:password, 'password'], [:confirmation_password, 'password']].to_h

    expect(page).to have_content 'Logout'
  end

  scenario 'Signing up with invalid email' do
    sign_up_with [[:email, 'valid@'], [:first_name, 'valid'], [:last_name, 'valid'], [:username, 'valid'], [:password, 'password'], [:confirmation_password, 'password']].to_h

    expect(page).to have_content 'Email is invalid'
  end

  scenario 'Signing up with blank first name' do
    sign_up_with [[:email, 'valid@example.com'], [:first_name, ''], [:last_name, 'valid'], [:username, 'valid'], [:password, 'password'], [:confirmation_password, 'password']].to_h

    expect(page).to have_content "First name can't be blank"
  end

  scenario 'Signing up with blank last name' do
    sign_up_with [[:email, 'valid@example.com'], [:first_name, 'valid'], [:last_name, ''], [:username, 'valid'], [:password, 'password'], [:confirmation_password, 'password']].to_h

    expect(page).to have_content "Last name can't be blank"
  end

  scenario 'Signing up with blank username' do
    sign_up_with [[:email, 'valid@example.com'], [:first_name, 'valid'], [:last_name, 'valid'], [:username, ''], [:password, 'password'], [:confirmation_password, 'password']].to_h

    expect(page).to have_content "Username can't be blank"
  end

  scenario 'Signing up with short username' do
    sign_up_with [[:email, 'valid@example.com'], [:first_name, 'valid'], [:last_name, 'valid'], [:username, 'user'], [:password, 'password'], [:confirmation_password, 'password']].to_h

    expect(page).to have_content "Username is too short (minimum is 5 characters)"
  end

  scenario 'Signing up with long username' do
    sign_up_with [[:email, 'valid@example.com'], [:first_name, 'valid'], [:last_name, 'valid'], [:username, 'this_username_is_not_valid'], [:password, 'password'], [:confirmation_password, 'password']].to_h

    expect(page).to have_content "Username is too long (maximum is 25 characters)"
  end

  scenario 'Signing up with password too short' do
    sign_up_with [[:email, 'valid@example.com'], [:first_name, 'valid'], [:last_name, 'valid'], [:username, 'valid'], [:password, 'pass'], [:confirmation_password, 'pass']].to_h

    expect(page).to have_content "Password is too short (minimum is 8 characters)"
  end

  scenario 'Signing up with invalid confirmation password' do
    sign_up_with [[:email, 'valid@example.com'], [:first_name, 'valid'], [:last_name, 'valid'], [:username, 'valid'], [:password, 'password'], [:confirmation_password, 'not_password']].to_h

    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario 'Signing up with email that already exists' do
    sign_up_with [[:email, user.email], [:first_name, 'valid'], [:last_name, 'valid'], [:username, 'valid'], [:password, 'password'], [:confirmation_password, 'password']].to_h

    expect(page).to have_content "Email has already been taken"
  end

  scenario 'Signing up with username that already exists' do
    sign_up_with [[:email, 'valid@example.com'], [:first_name, 'valid'], [:last_name, 'valid'], [:username, user.username], [:password, 'password'], [:confirmation_password, 'password']].to_h

    expect(page).to have_content "Username has already been taken"
  end
end

def sign_up_with(user)
  visit '/users/sign_up'
  fill_in 'user_email', with: user[:email]
  fill_in 'user_username', with: user[:username]
  fill_in 'user_first_name', with: user[:first_name]
  fill_in 'user_last_name', with: user[:last_name]
  fill_in 'user_password', with: user[:password]
  fill_in 'user_password_confirmation', with: user[:confirmation_password]
  click_button 'Sign up'
end