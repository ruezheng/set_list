require "rails_helper"

describe Song do
  before :each do
    Song.destroy_all
    Artist.destroy_all
    @prince = Artist.create!(name: 'Prince')
    @rtj = Artist.create!(name: 'Run The Jewels')
    @caamp = Artist.create!(name: 'Caamp')
    @jgb = Artist.create!(name: 'Jerry Garcia Band')
    @billie = Artist.create!(name: 'Billie Eilish')
    @lcd = Artist.create!(name: 'LCD Soundsystem')

    @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
    @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)

    @rtj.songs.create!(title: 'Legend Has It', length: 2301, play_count: 2300000)
    @rtj.songs.create!(title: 'Talk to Me', length: 2301, play_count: 2300000)

    @caamp.songs.create!(title: '26', length: 940, play_count: 150000)
    @caamp.songs.create!(title: 'Vagabond', length: 240, play_count: 120000)

    @jgb.songs.create!(title: 'Aint No Bread In The Breadbox', length: 540, play_count: 12000)
    @jgb.songs.create!(title: 'The Harder They Come', length: 240, play_count: 120000)

    @billie.songs.create!(title: 'bury a friend', length: 340, play_count: 1200000)
    @billie.songs.create!(title: 'bad guy', length: 240, play_count: 100000)

    @lcd.songs.create!(title: 'Someone Great', length: 500, play_count: 1000000)
    @lcd.songs.create!(title: 'I Can Change', length: 640, play_count: 100000)
  end
  describe "relationships" do
    it {should belong_to :artist}
  end

  describe "class methods" do
    describe "::play_count_above" do
      it "finds correct count above threshold" do

      expect(Song.play_count_above(20000)).to eq(9)
      end
    end
    describe "::shortest_two" do
      it "can find the shortest two songs by length" do
        expect(Song.shortest_two.length).to eq(2)
        expect(Song.shortest_two.first.title).to eq('Vagabond')
        expect(Song.shortest_two.last.title).to eq('The Harder They Come')
      end
    end
  end
end
