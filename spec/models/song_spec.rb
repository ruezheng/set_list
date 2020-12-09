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
    @i_can_change = @lcd.songs.create!(title: 'I Can Change', length: 640, play_count: 100000)
  end
  describe "relationships" do
    it {should belong_to :artist}
  end

  describe "instance methods" do
    describe '#artist_name' do
      it 'Create a test for a corresponding method that returns an artist name given a song' do
        expect(@i_can_change.artist_name).to eq('LCD Soundsystem')
      end
    end
  end

  describe "class methods" do
    describe "::random_song" do
      it "Create a test for a corresponding method to retrieve a random song" do
        Song.destroy_all
        ras = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
        purple = @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)

        expect(Song.random_song).to be_an_instance_of(Song)

        expect(Song.random_song).to eq(ras).or eq(purple)

        #Not great, but want to show the stub syntax
        Song.stub(:random_song) {@i_can_change}
        expect(Song.random_song).to eq(@i_can_change)
      end
    end
    describe "::all_ids" do
      it "Create a test for a corresponding method that will find all song ids" do
        Song.destroy_all
        ras = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
        purple = @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)
        expect(Song.all_ids).to eq([ras.id, purple.id])
      end
    end
    describe "::artist_name_by_song_id" do
      it "Create a test for a corresponding method that will find all artist names given a collection of song ids" do
        Song.destroy_all
        ras = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
        purple = @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)
        bury = @billie.songs.create!(title: 'bury a friend', length: 340, play_count: 1200000)
        bad = @billie.songs.create!(title: 'bad guy', length: 240, play_count: 100000)
        expect(Song.artist_name_by_song_id([ras.id, purple.id, bury.id, bad.id])).to eq(["Prince", "Billie Eilish"])
      end
    end
    describe "::artist_name_by_song_id" do
      it "Create a test for a corresponding method that finds the song with the most plays" do
        Song.destroy_all
        ras = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
        purple = @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)
        bury = @billie.songs.create!(title: 'bury a friend', length: 340, play_count: 1200000)
        bad = @billie.songs.create!(title: 'bad guy', length: 240, play_count: 100000)
        expect(Song.most_played).to eq(bury)
      end
    end
    describe "::shortest_two" do
      it "can find the shortest two songs by length" do
        expect(Song.shortest_two.length).to eq(2)
        expect(Song.shortest_two.first.title).to eq('Vagabond')
        expect(Song.shortest_two.last.title).to eq('The Harder They Come')
      end
    end
    describe "::play_count_above" do
      it "finds correct count above threshold" do

      expect(Song.play_count_above(20000)).to eq(9)
      end
    end
  end
end
