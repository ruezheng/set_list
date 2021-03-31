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

    @beret = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
    @rain = @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)

    @legend = @rtj.songs.create!(title: 'Legend Has It', length: 2301, play_count: 2300000)
    @talk = @rtj.songs.create!(title: 'Talk to Me', length: 2301, play_count: 2300000)

    @twenty_six = @caamp.songs.create!(title: '26', length: 940, play_count: 150000)
    @vagabond = @caamp.songs.create!(title: 'Vagabond', length: 240, play_count: 120000)

    @breadbox = @jgb.songs.create!(title: 'Aint No Bread In The Breadbox', length: 540, play_count: 12000)
    @hard = @jgb.songs.create!(title: 'The Harder They Come', length: 240, play_count: 120000)

    @bury = @billie.songs.create!(title: 'bury a friend', length: 340, play_count: 1200000)
    @bad = @billie.songs.create!(title: 'bad guy', length: 240, play_count: 100000)

    @someone = @lcd.songs.create!(title: 'Someone Great', length: 500, play_count: 1000000)
    @change = @lcd.songs.create!(title: 'I Can Change', length: 640, play_count: 100000)

    @all_songs = [
                    @beret,
                    @rain,
                    @legend,
                    @talk,
                    @twenty_six,
                    @vagabond,
                    @breadbox,
                    @hard,
                    @bury,
                    @bad,
                    @someone,
                    @change
                  ]
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

    describe "::by_title" do
      it 'returns songs alphabetically by title, case insensitive' do
        expected = @all_songs.sort_by do |song|
          song.title.downcase
        end
        expect(Song.by_title).to eq(expected)
      end
    end

    describe '::shortest' do
      it 'returns the shortest song with no arguments' do
        short_song = @jgb.songs.create!(title: 'Shorty', length: 1, play_count: 48988)
        expect(Song.shortest).to eq([short_song])
      end

      it 'can return multiple songs specified by an argument' do
        expect(Song.shortest(3)).to include(@vagabond)
        expect(Song.shortest(3)).to include(@bad)
        expect(Song.shortest(3)).to include(@hard)
      end
    end

    describe '::love_songs' do
      it 'returns songs where the title contains the word love, case insensitive' do
        love_1 = @jgb.songs.create!(title: "Love", length: 1, play_count: 1)
        love_2 = @jgb.songs.create!(title: "I like love", length: 1, play_count: 1)
        love_3 = @jgb.songs.create!(title: "Sometimes LoVe is hard", length: 1, play_count: 1)

        expect(Song.love_songs.sort).to eq([love_1, love_2, love_3].sort) #call .sort because we don't care about the order
      end
    end

    describe '::three_most_played_with_a_length_updated_recently' do
      it 'returns the 3 songs that have the most plays, a length greater than x, and were updated within the last three days' do
        four_days_ago = Time.now - 4.days
        @legend.update(updated_at: four_days_ago)
        @twenty_six.update(updated_at: four_days_ago)
        expected = [@talk, @someone, @change]
        expect(Song.three_most_played_with_a_length_updated_recently(length: 350)).to eq(expected)
      end
    end
  end

  describe 'instance methods' do
    describe '#artist_name' do
      it 'returns the songs artists name' do
        expect(@beret.artist_name).to eq('Prince')
      end
    end
  end
end
