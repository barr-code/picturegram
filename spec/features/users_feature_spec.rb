require 'rails_helper'
require_relative '../helpers/user_helper'

context 'no user signed in' do
  it 'has a sign in and sign up link' do
    visit '/'
    expect(page).to have_link 'Sign In'
    expect(page).to have_link 'Sign Up'
    expect(page).not_to have_link 'Sign Out'
  end
end

context 'a user is signed in' do
  before do
    sign_up
  end

  it 'has a sign out link, no sign in/up links' do
    visit '/'
    expect(page).to have_link 'Sign Out'
    expect(page).not_to have_link 'Sign Up'
    expect(page).not_to have_link 'Sign In'
  end
end

context "users' posts" do
  it 'no add link not signed in' do
    visit '/'
    expect(page).not_to have_link 'Add a Post'
  end

  it 'must be signed in to add post' do
    visit new_post_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  context 'managing other users\' posts' do
    before do
      sign_up
      create_post
    end

    it 'cannot delete another user\'s post' do
      expect(page).to have_css('.delete-button')
      click_link 'Sign Out'
      sign_up('new@test.com', 'password')
      expect(page).not_to have_css('.delete-button')
    end

    it 'cannot edit other user\'s post' do
      expect(page).to have_css('.edit-button')
      click_link 'Sign Out'
      sign_up('new@test.com', 'password')
      expect(page).not_to have_css('.edit-button')
    end
  end
end
