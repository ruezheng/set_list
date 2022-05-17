# As a visitor
# When I visit the artists index
# And click on 'New Artist'
# Then my current path is '/artists/new'
# and I fill in the artist's name
# Then I click 'Create Artist'
# I am redirected to the artist index page
# And I see the artist's name

require 'rails_helper'

RSpec.describe 'New Artist', type: :feature do
  describe 'As a visitor' do
    describe 'When I visit the new artist form by clicking a link on the index' do
      it 'I can create a new artist' do
        visit '/artists'

        click_link 'New Artist'

        expect(current_path).to eq('/artists/new')

        fill_in 'Name', with: 'Megan'
        click_on 'Create Artist'

        expect(current_path).to eq("/artists")
        expect(page).to have_content('Megan')
      end
    end
  end
end
