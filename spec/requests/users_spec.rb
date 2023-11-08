require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before do
      get users_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
    
    it 'includes the placeholder text' do
      expect(response.body).to include('Show all users in a list')
    end
  end

  describe 'GET /show' do
    before do
      user = User.create(name: 'John Doe', posts_counter: 0)
      get user_path(user)
    end

    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end

    it 'includes the placeholder text' do
      expect(response.body).to include('Show specific user:')
    end
  end
end
