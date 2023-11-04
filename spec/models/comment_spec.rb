require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :all do
    @user = User.create(name: 'John', posts_counter: 0)
    @post = Post.create(author: @user, title: 'Title', comments_counter: 0, likes_counter: 0)
  end

  context 'Create comment' do
    it 'is not valid without user' do
      expect(Comment.new(post: @post)).to_not be_valid
    end

    it 'is not valid without post' do
      expect(Comment.new(user: @user)).to_not be_valid
    end
  end
end
