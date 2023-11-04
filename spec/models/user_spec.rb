require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is not valid without a name' do
      user = User.new(name: nil, posts_counter: 0)
      expect(user).not_to be_valid
    end

    it 'is valid with a name' do
      user = User.new(name: 'John Doe', posts_counter: 0)
      expect(user).to be_valid
    end

    it 'allows only integer values for posts_counter' do
      user = User.new(name: 'John Doe', posts_counter: 5)
      expect(user).to be_valid

      user.posts_counter = 10.5
      expect(user).not_to be_valid

      user.posts_counter = 'text'
      expect(user).not_to be_valid
    end

    it 'validates that posts_counter is greater than or equal to zero' do
      user = User.new(name: 'John Doe', posts_counter: 0)
      expect(user).to be_valid

      user.posts_counter = 1
      expect(user).to be_valid

      user.posts_counter = -1
      expect(user).not_to be_valid
    end
  end

  context 'three_recent_posts' do
    before :all do
      @user = User.create(name: 'John', posts_counter: 0)
      5.times { |post_i| Post.create(author: @user, title: (post_i + 1).to_s, comments_counter: 0, likes_counter: 0) }
    end

    it 'returns three posts' do
      expect(@user.three_recent_posts.length).to eq 3
    end

    it 'returns most recent posts with titles 3, 4, 5' do
      titles = []
      @user.three_recent_posts.each do |post|
        titles.push(post.title.to_i)
      end
      expect(titles).to all(be_between(3, 5))
    end
  end
end
