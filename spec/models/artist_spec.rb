require "rails_helper"

describe Artist do
  describe "relationships" do
    it { should have_many :songs }
  end
  before :each do
    Song.destroy_all
    Artist.destroy_all
    @prince = Artist.create!(name: 'Prince')
    @rtj = Artist.create!(name: 'Run The Jewels')
    @caamp = Artist.create!(name: 'Caamp')
    @jgb = Artist.create!(name: 'Jerry Garcia Band')
    @billie = Artist.create!(name: 'Billie Eilish')
    @lcd = Artist.create!(name: 'LCD Soundsystem')
  end
  describe "class methods" do
    describe "::order_by_creation_time" do
      it 'orders artists correctly by creation time' do
        Song.destroy_all
        Artist.destroy_all
        prince = Artist.create!(name: 'Prince', created_at: 1.seconds.ago)
        rtj = Artist.create!(name: 'Run The Jewels', created_at: 10.seconds.ago)

        expect(Artist.order_by_creation_time.to_a).to eq([rtj, prince])
      end
    end
    describe "::order_by_creation_time" do
      it 'orders artists correctly by creation time' do
        Song.destroy_all
        Artist.destroy_all
        prince = Artist.create!(name: 'Prince', updated_at: 1.seconds.ago)
        rtj = Artist.create!(name: 'Run The Jewels', updated_at: 10.seconds.ago)

        expect(Artist.order_by_update_time.to_a).to eq([rtj, prince])
      end
    end
  end
  describe "instance methods" do
    describe '#average_song_length' do
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
    describe '#find_song_by_id' do
      it 'Create a test for a corresponding method that returns an artist’s song given a song id and an artist' do
        breadbox = @jgb.songs.create!(title: 'Aint No Bread In The Breadbox', length: 540, play_count: 12000)
        expect(@jgb.find_song_by_id(breadbox.id)).to eq(breadbox)
      end
    end

    describe '#random_song' do
      it 'Create a test for a corresponding method to retrieve a random song given an artist' do
        breadbox = @jgb.songs.create!(title: 'Aint No Bread In The Breadbox', length: 540, play_count: 12000)
        harder = @jgb.songs.create!(title: 'The Harder They Come', length: 240, play_count: 120000)
        expect(@jgb.random_song).to be_an_instance_of(Song)
        expect(@jgb.random_song).to eq(breadbox).or eq(harder)
      end
    end
    describe '#order_songs_by_title' do
      it 'Create a test for a corresponding method that orders an artist’s songs by title' do
        ras = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
        purple = @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)

        expect(@prince.order_songs_by_title.to_a).to eq([purple, ras])
      end
    end
    describe '#song_ids' do
      it 'Create a test for a corresponding method that will return all song ids given an artist' do
        ras = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
        purple = @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)

        # This method comes to you for free from AR! Wild!
        expect(@prince.song_ids).to eq([ras.id, purple.id])
      end
    end
    describe '#longest_song' do
      it 'Create a test for a corresponding method that finds an artist’s longest song' do
        ras = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
        purple = @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)
        breadbox = @jgb.songs.create!(title: 'Aint No Bread In The Breadbox', length: 540, play_count: 12000)
        harder = @jgb.songs.create!(title: 'The Harder They Come', length: 240, play_count: 120000)

        expect(@jgb.longest_song.id).to eq(breadbox.id)
        expect(@prince.longest_song.id).to eq(purple.id)
      end
    end
    describe '#top_5_songs' do
      it "Create a test for for a corresponding method that orders an artist’s songs by play_count and returns the top 5" do
        Song.destroy_all
        ras = @prince.songs.create!(title: 'Raspberry Beret', length: 345, play_count: 34)
        purple = @prince.songs.create!(title: 'Purple Rain', length: 524, play_count: 19)
        kiss = @prince.songs.create!(title: 'Kiss', length: 540, play_count: 100000000)
        doves = @prince.songs.create!(title: 'When Doves Cry', length: 540, play_count: 10000)
        nine_nine = @prince.songs.create!(title: '1999', length: 440, play_count: 1000)
        lover = @prince.songs.create!(title: 'I Wanna Be Your Lover', length: 340, play_count: 500)

        expect(@prince.top_5_songs.count).to eq(5)
        expect(@prince.top_5_songs.to_a).to eq([kiss, doves, nine_nine, lover, ras])
      end
    end
  end
end
