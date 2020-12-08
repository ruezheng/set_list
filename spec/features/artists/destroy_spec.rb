require 'rails_helper'

RSpec.describe 'As a Visitor' do
  it 'I can delete an artist' do
    talking_heads = Artist.create(name: 'Talking Heads')

    visit '/artists'

    click_button 'Delete'

    expect(current_path).to eq('/artists')
    expect(page).to_not have_content(talking_heads.name)
    expect(page).to_not have_button('Delete')
  end
end
