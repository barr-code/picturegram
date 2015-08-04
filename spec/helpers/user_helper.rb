def sign_up(username = "user_name", email = "test@test.com", password = "password")
  visit '/'
  click_link 'Sign Up'
  fill_in 'Email', with: email
  fill_in 'Username', with: username
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password
  click_button 'Sign up'
end

def create_post
  visit new_post_path
  attach_file 'Upload new photo', 'spec/fixtures/glenfinnan.jpg'
  fill_in 'Say some words', with: 'Hogwarts Express. Choo choo!'
  click_button 'Post It!'
end