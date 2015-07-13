require 'rails_helper'

feature 'Posts' do
  context 'there are no posts' do
    scenario 'should invite user to add a post' do
      visit '/'
      expect(page).to have_content 'No posts yet.'
      expect(page).to have_link 'Add a Post'
    end
  end

  xcontext 'there are posts' do
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

  context 'adding posts' do
    scenario 'visiting new post page' do
      visit '/'
      click_link 'Add a Post'
      expect(page).to have_content 'Upload new photo'
    end

    xscenario 'uploading new post' do
      visit new_post_path
      attach_file 'Upload new photo', 'spec/fixtures/glenfinnan.jpg'
      fill_in 'Say some words', with: 'Hogwarts Express. Choo choo!'
      click_button 'Post It!'
      expect(page).to have_selector 'img'
      expect(page).to have_content 'Choo choo!'
    end
  end

  context 'editing/deleting posts' do
    before do
      Post.create(message: 'Hogwarts Express! (Glenfinnan viaduct)', image: File.open("#{Rails.root}/spec/fixtures/glenfinnan.jpg"))
    end

    scenario 'deleting a post' do
      visit '/'
      click_link 'Delete'
      expect(page).not_to have_content 'Hogwarts Express'
    end

  end
end
