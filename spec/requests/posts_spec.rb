require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before do
      user = User.create(name: 'John Doe', posts_counter: 0)
      get user_posts_path(user)
    end

    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it "renders the 'index' template" do
      expect(response).to render_template('index')
    end

    it 'includes the placeholder text' do
      expect(response.body).to include('Show all post by user in a list:')
    end
  end

  describe 'GET /show' do
    before do
      user = User.create(name: 'John Doe', posts_counter: 0)
      post = Post.create(author: user, title: 'test post', comments_counter: 0, likes_counter: 0 )
      get user_post_path(user, post)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      expect(response).to render_template('show')
    end

    it 'includes placeholder text' do
      expect(response.body).to include('Show specific posts by user:')
    end
  end
end
