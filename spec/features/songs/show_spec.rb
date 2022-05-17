require 'rails_helper'

RSpec.describe 'the songs show page' do
  let!(:artist) { Artist.create!(name: 'Carly Rae Jepsen') }
  let!(:song) { artist.songs.create!(title: "I Really Like You", length: 208, play_count: 200) }
  let!(:song2) { artist.songs.create!(title: "Call Me Maybe", length: 205, play_count: 1000) }

  it 'displays the song title' do
    visit "songs/#{song.id}"

    expect(page).to have_content(song.title)
    expect(page).to_not have_content(song2.title)
  end

  it "displays the name of artist for the song" do
    visit "songs/#{song.id}"
    # save_and_open_page
    expect(page).to have_content(artist.name)
  end
end
