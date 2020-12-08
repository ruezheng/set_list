require 'rails_helper'

RSpec.describe 'Artists Index' do
  before :each do
    @prince = Artist.create!(name: 'Prince')
    @rtj = Artist.create!(name: 'Run The Jewels')
    @caamp = Artist.create!(name: 'Caamp')
  end

  it 'shows all artists and their names' do
    visit '/artists'

    expect(page).to have_content(@prince.name)
    expect(page).to have_content(@rtj.name)
    expect(page).to have_content(@caamp.name)
  end

  it 'can sort by name alphabetically' do
    visit '/artists'

    click_link 'Sort by name'

    expect(current_path).to eq('/artists')
    expect(all('.artist-name')[0].text).to eq(@caamp.name)
    expect(all('.artist-name')[1].text).to eq(@prince.name)
    expect(all('.artist-name')[2].text).to eq(@rtj.name)
  end

  it 'can sort by name alphabetically' do
    visit '/artists'

    click_link 'Sort by name reverse'

    expect(current_path).to eq('/artists')
    expect(all('.artist-name')[2].text).to eq(@rtj.name)
    expect(all('.artist-name')[1].text).to eq(@prince.name)
    expect(all('.artist-name')[0].text).to eq(@caamp.name)
  end
end
