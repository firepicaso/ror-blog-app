require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is not valid without a name' do
        user = User.new(name: nil)
        expect(user).not_to be_valid
        expect(user.errors[:name]).to include("can't be blank")
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
        expect(user.errors[:posts_counter]).to include('must be an integer')
  
        user.posts_counter = 'text'
        expect(user).not_to be_valid
        expect(user.errors[:posts_counter]).to include('is not a number')
    end

    it 'validates that posts_counter is greater than or equal to zero' do
        user = User.new(name: 'John Doe', posts_counter: 0)
        expect(user).to be_valid
  
        user.posts_counter = 1
        expect(user).to be_valid

        user.posts_counter = -1
        expect(user).not_to be_valid
        expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
    end
  end
end
