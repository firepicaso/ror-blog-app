# spec/requests/blogs_spec.rb
require 'swagger_helper'

describe 'RoR Blog App API' do
  path '/users/1/posts/' do

    get 'Retrieves posts for a specific user' do
      tags 'Posts'
      produces 'application/json'

      response '200', 'posts found' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              title: { type: :string },
            },
          },
          required: ['title']          
        run_test!
      end

      response '404', 'user not found' do
        let(:user_id) { 999 } # Assuming 999 is an invalid user_id
        run_test!
      end
    end
  end
end
