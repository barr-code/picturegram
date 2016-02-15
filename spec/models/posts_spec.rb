require 'rails_helper'
describe Post do
  let(:user){double :user, id: 1}
  it 'can be filtered by hashtags' do
    post_1 = Post.create(message: '#scotland #glenfinnan', image: File.open("#{Rails.root}/spec/fixtures/glenfinnan.jpg"), user_id: user.id)
    post_2 = Post.create(message: 'No hashtags', image: File.open("#{Rails.root}/spec/fixtures/glenfinnan.jpg"), user_id: user.id)
    post_collection = Post.filter_by_hashtag('#scotland')
    expect(post_collection).to eq [post_1]
  end
end
