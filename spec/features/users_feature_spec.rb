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
end
