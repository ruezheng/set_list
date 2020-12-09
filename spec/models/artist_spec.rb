require "rails_helper"

describe Artist do
  describe "relationships" do
    it { should have_many :songs }
  end

  describe "instance methods" do
    describe 'average_song_length' do
      it "returns the correct length" do
        talking_heads = Artist.create!(name: 'Talking Heads')
        she_was = talking_heads.songs.create!(title: 'And She Was', length: 234, play_count: 34)
        wild_life = talking_heads.songs.create!(title: 'Wild Wild Life', length: 456, play_count: 45)

        expect(talking_heads.average_song_length).to eq(345)

        talking_heads = Artist.create!(name: 'Talking Heads')
        she_was = talking_heads.songs.create!(title: 'And She Was', length: 3334, play_count: 34)
        wild_life = talking_heads.songs.create!(title: 'Wild Wild Life', length: 456, play_count: 45)

        expect(talking_heads.average_song_length).to eq(0.1895e4)
        bowie = Artist.create!(name: 'David Bowie')
        expect(bowie.average_song_length).to be_nil
      end
    end
  end

  describe 'class methods' do
    describe '.most_recently_updated' do
      it 'returns the correct record' do
        prince = Artist.create!(name: 'Prince')
        rtj = Artist.create!(name: 'Run The Jewels')
        caamp = Artist.create!(name: 'Caamp')

        rtj.update(name: 'Walk the Jewels')

        expect(Artist.most_recently_updated).to eq(rtj)
      end
    end
  end
end
