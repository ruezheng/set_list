require 'rails_helper'

RSpec.describe 'New Artist' do
  describe 'As a visitor' do
    describe 'When I visit the new artist form by clicking a link on the index' do
      #Happy Path
      it 'I can create a new artist' do
        visit '/artists'

        click_link 'New Artist'

        expect(current_path).to eq('/artists/new')

        fill_in 'Name', with: 'Megan'
        click_on 'Create Artist'

        expect(current_path).to eq("/artists")
        expect(page).to have_content('Megan')
      end
      #Sad Path
      describe "And click Create Artist without filling in a name" do
       it "Then I see a message telling me that I am missing required information And I still see the new artist form" do
         visit '/artists/new'

         click_on 'Create Artist'

         expect(page).to have_content('Artist not created: Missing required information')
         expect(page).to have_button('Create Artist')
       end
     end
    end
  end
end
