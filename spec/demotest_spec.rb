require 'rails_helper'

RSpec.describe 'ALL USERS', type: :system do
    describe 'index page' do
        it 'shows the right content' do
            visit users_path
            sleep(5)
            expect(page).to have_content('ALL USERS')
        end
    end
end
