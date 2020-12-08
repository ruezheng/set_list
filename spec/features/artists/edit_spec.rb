require 'rails_helper'

RSpec.describe 'New Artist' do
  describe 'As a visitor' do
    describe 'When I visit the artists index' do
      it 'I can update an artist' do
        beatles = Artist.create(name: 'Beatles')

        visit '/artists'

        click_link 'Edit'

        expect(current_path).to eq("/artists/#{beatles.id}/edit")

        fill_in 'Name', with: 'The Beatles'
        click_on 'Update Artist'

        expect(current_path).to eq("/artists")
        expect(page).to have_content('The Beatles')
      end
    end
  end
end
