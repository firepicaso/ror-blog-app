require 'rails_helper'

RSpec.describe Like, type: :model do
  before :all do
    @user = User.create(name: 'John', posts_counter: 0)
    @post = Post.create(author: @user, title: 'Title', comments_counter: 0, likes_counter: 0)
  end

  context 'Add like' do
    it 'is not valid without user' do
      expect(Like.new(post: @post)).to_not be_valid
    end

    it 'is not valid without post' do
      expect(Like.new(user: @user)).to_not be_valid
    end
  end

  context 'update_likes_counter' do
    before :all do
      8.times { Like.create(user: @user, post: @post) }
    end

    it 'keeps track of Likes and equals 8' do
      expect(@post.likes_counter).to eq 8
    end
  end
end
