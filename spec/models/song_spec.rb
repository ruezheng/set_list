require 'rails_helper'

RSpec.describe Song do
  let!(:prince) { Artist.create!(name: 'Prince') }
  let!(:talking_heads) { Artist.create!(name: 'Talking Heads') }
  let!(:rasperry_beret) { prince.songs.create!(title: 'Raspberry Beret', length: 234, play_count: 34) }
  let!(:wild_life) { talking_heads.songs.create!(title: 'Wild Wild Life', length: 456, play_count: 45) }

  describe 'relationships' do
    it {should belong_to :artist}
  end

  describe 'class methods' do
    it '.song_count' do
      expect(Song.song_count).to eq(2)
    end
  end
end
