module Features
  module SessionHelpers
    def sign_up_with(user)
      visit '/users/sign_up'
      fill_in 'user_email', with: user[:email]
      fill_in 'user_username', with: user[:username]
      fill_in 'user_first_name', with: user[:first_name]
      fill_in 'user_last_name', with: user[:last_name]
      fill_in 'user_password', with: user[:password]
      fill_in 'user_confirmation_password', with: user[:confirmation_password]
      click_button 'Sign up'
    end

    def sign_in_with(email, password)
      visit '/users/sign_in'
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'Sign in'
    end
  end
end
