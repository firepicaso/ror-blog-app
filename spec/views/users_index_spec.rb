require 'rails_helper'

RSpec.describe 'When I open user index page', type: :system do
  before :all do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
    bio: 'Teacher from Mexico.', posts_counter: 0)
    @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
    bio: 'Teacher from Poland.', posts_counter: 0)
  end
  
  it 'shows the usernames of the users' do
    visit users_path
    sleep(1)

    expect(page).to have_text(@first_user.name)
    expect(page).to have_text(@second_user.name)
  end
end
