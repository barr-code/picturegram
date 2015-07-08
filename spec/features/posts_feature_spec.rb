require 'rails_helper'

feature 'Posts' do
  context 'there are no posts' do
    scenario 'should invite user to add a post' do
      visit '/'
      expect(page).to have_content 'No posts yet.'
      expect(page).to have_link 'Add a Post'
    end
  end

  context 'there are posts' do
    before do
      Post.create(message: 'Hogwarts Express! (Glenfinnan viaduct)', image: File.open("#{Rails.root}/spec/fixtures/glenfinnan.jpg"))
    end

    scenario 'display posts' do
      visit '/'
      expect(page).to have_content 'Hogwarts Express'
      expect(page).not_to have_content 'No posts yet.'
      expect(page).to have_selector 'img'
    end
  end
end