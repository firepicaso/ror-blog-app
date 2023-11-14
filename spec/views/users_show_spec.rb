require 'rails_helper'

RSpec.describe 'When I open user show page', type: :system do
  before :all do
    Like.delete_all
    Comment.delete_all
    Post.delete_all
    User.delete_all

    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
    bio: 'Teacher from Mexico.', posts_counter: 0)
    @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
    bio: 'Teacher from Poland.', posts_counter: 0)

    Post.create(author: @first_user, title: 'Title 1', comments_counter: 0, likes_counter: 0)
    Post.create(author: @first_user, title: 'Title 2', comments_counter: 0, likes_counter: 0)
    Post.create(author: @first_user, title: 'Title 3', comments_counter: 0, likes_counter: 0)

    @latest_post= Post.create(author: @first_user, title: 'Title 4', comments_counter: 0, likes_counter: 0)
    Post.create(author: @second_user, title: 'Title 1', comments_counter: 0, likes_counter: 0)
    Post.create(author: @second_user, title: 'Title 2', comments_counter: 0, likes_counter: 0)
  end

  it 'shows the photos of users' do
    visit users_path
    sleep(1)
    click_link(href: user_path(@first_user))
    sleep(1)
    expect(page).to have_css('img[alt="photo"]')

    visit users_path
    sleep(1)
    click_link(href: user_path(@second_user))
    sleep(1)
    expect(page).to have_css('img[alt="photo"]')
  end

  it 'shows the user\'s name' do
    visit users_path
    sleep(1)
    click_link(href: user_path(@first_user))
    sleep(1)
    expect(page).to have_content('Tom')

    visit users_path
    sleep(1)
    click_link(href: user_path(@second_user))
    sleep(1)
    expect(page).to have_content('Lilly')
  end

  it 'shows the number of posts the user has written' do
    visit users_path
    sleep(1)
    click_link(href: user_path(@first_user))
    sleep(1)
    expect(page).to have_content('Number of posts: 8')

    visit users_path
    sleep(1)
    click_link(href: user_path(@second_user))
    sleep(1)
    expect(page).to have_content('Number of posts: 4')
  end
end
