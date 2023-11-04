require 'rails_helper'

RSpec.describe Post, type: :model do
  before :all do
    @author = User.create(name: 'John', posts_counter: 0)
  end

  context 'title validations' do
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
  end

  context 'counters validations' do
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

  context '#five_recent_comments' do
    before :all do
      @post = Post.create(author: @author, title: 'Title', comments_counter: 0, likes_counter: 0)
      8.times { |comment_i| Comment.create(user: @author, post: @post, text: (comment_i + 1).to_s) }
    end

    it 'returns five comments' do
      expect(@post.five_recent_comments.length).to eq 5
    end

    it 'returns most recent comments with texts 4, 5, 6, 7, 8' do
      texts = []
      @post.five_recent_comments.each do |comment|
        texts.push(comment.text.to_i)
      end
      expect(texts).to contain_exactly(4, 5, 6, 7, 8)
    end
  end

  context 'update_posts_counter' do
    before :all do
      8.times { Post.create(author: @author, title: 'Harry Potter', comments_counter: 0, likes_counter: 0) }
    end

    it 'keeps track of posts and equals 9' do
      expect(@author.posts_counter).to eq 9
    end
  end
end
