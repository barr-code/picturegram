require 'rails_helper'

feature 'Posts' do
  context 'there are no posts' do
    scenario 'should invite user to add a post' do
      visit '/'
      expect(page).to have_content 'No posts yet.'
      expect(page).to have_link 'Add a Post'
    end
  end
end