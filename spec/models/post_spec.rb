require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    before :all do
      @author = User.create(name: 'John')
    end

    it 'is not valid without a title' do
      post = Post.new(title: nil)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'is valid with a title' do
      post = Post.new(author: @author, title: 'A valid title', comments_counter: 0, likes_counter: 0)
      expect(post).to be_valid
    end

    it 'is not valid with title exceeding 250 characters' do
      post = Post.new(author: @author, title: '0' * 251, comments_counter: 0, likes_counter: 0)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'allows only integer values for comments_counter' do
      post = Post.new(author: @author, title: 'A valid title', comments_counter: 'text', likes_counter: 0)
      expect(post).not_to be_valid

      post.comments_counter = 10.5
      expect(post).not_to be_valid

      post.comments_counter = 1
      expect(post).to be_valid
    end

    it 'ensures comments_counter is an integer greater than or equal to zero' do
      post = Post.new(author: @author, title: 'A valid title', comments_counter: 0, likes_counter: 0)
      expect(post).to be_valid

      post.comments_counter = -1
      expect(post).not_to be_valid
    end

    it 'ensures likes_counter is an integer greater than or equal to zero' do
      post = Post.new(author: @author, title: 'A valid title', comments_counter: 0, likes_counter: 0)
      expect(post).to be_valid

      post.likes_counter = 1
      expect(post).to be_valid

      post.likes_counter = -1
      expect(post).not_to be_valid
    end

    it 'allows only integer values for likes_counter' do
      post = Post.new(author: @author, title: 'A valid title', comments_counter: 0, likes_counter: 'text')
      expect(post).not_to be_valid

      post.likes_counter = 10.5
      expect(post).not_to be_valid

      post.likes_counter = 1
      expect(post).to be_valid
    end
  end
end
