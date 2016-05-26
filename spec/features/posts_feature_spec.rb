require 'rails_helper'
require_relative '../helpers/user_helper'

feature 'Posts' do
  context 'signed in users' do
    before do
      sign_up
    end

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

    context 'editing/deleting/liking posts' do
      before do
        create_post
      end

      scenario 'deleting a post' do
        visit '/'
        page.find('.delete-button').click
        expect(page).not_to have_content 'Hogwarts Express'
        expect(page).not_to have_selector 'img'
      end

      scenario 'editing message' do
        visit '/'
        page.find('.edit-button').click
        fill_in 'Say some words.', with: 'Ferroequinology'
        click_button 'Post It!'
        expect(page).not_to have_content 'Hogwarts Express'
        expect(page).to have_content 'Ferroequinology'
      end
    end

    context 'interacting with posts' do
      before do
        @post = Post.create(message: 'Hogwarts Express! (Glenfinnan viaduct)', image: File.open("#{Rails.root}/spec/fixtures/glenfinnan.jpg"), user_id: User.last.id)
        visit '/'
      end

      scenario 'liking post', js: true do
        find('.add-like').click
        wait_for_ajax
        expect(@post.likes.count).to eq 1
        expect(page).to have_selector '.fa-heart'
      end

      scenario 'clicking like for second time unlikes post', js: true do
        Like.create(post_id: @post.id, user_id: User.last.id)
        find('.add-like').click
        wait_for_ajax
        expect(@post.likes.count).to eq 0
        expect(page).to have_selector '.fa-heart-o'
      end

      scenario 'comment on posts', js: true do
        find('.add-comment').click
        fill_in 'new-comment', with: 'Very nice!'
        find('.submit-comment').click
        wait_for_ajax
        expect(@post.comments.count).to eq 1
        expect(page).to have_content 'Very nice!'
        expect(@post.comments.last.user_id).to eq User.last.id
      end
    end

    context 'searching for posts' do
      scenario 'search box on the page' do
        visit '/'
        expect(page).to have_selector '.search-box'
        expect(page).to have_selector '.fa-search'
      end

      context 'displaying posts' do
        before do
          post_1 = Post.create(message: 'Hogwarts Express! #scotland', image: File.open("#{Rails.root}/spec/fixtures/glenfinnan.jpg"), user_id: User.last.id)
          post_2 = Post.create(message: 'No hashtags', image: File.open("#{Rails.root}/spec/fixtures/glenfinnan.jpg"), user_id: User.last.id)
          visit '/'
        end

        scenario 'searching for a hashtag' do
          fill_in "search", with: "scotland"
          page.find('.search-btn').click
          expect(page).to have_content "Hogwarts Express!"
          expect(page).not_to have_content "No hashtags"
        end

        scenario 'clicking on a hashtag' do
          click_link '#scotland'
          expect(page).to have_content "Hogwarts Express!"
          expect(page).not_to have_content "No hashtags"
        end
      end
    end
  end
end
feature 'signed out users' do
  before do
    @user = User.create(email: "test@test.com", username: "test", password: "password")
    @post = Post.create(message: 'Hogwarts Express! (Glenfinnan viaduct)', image: File.open("#{Rails.root}/spec/fixtures/glenfinnan.jpg"), user_id: @user.id)
  end

  scenario 'cannot like post', js: true do
    visit '/'
    find('.add-like').click
    wait_for_ajax
    expect(@post.likes.count).to eq 0
  end
end
