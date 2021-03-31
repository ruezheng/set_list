require "rails_helper"

describe Artist do
  describe "relationships" do
    it { should have_many :songs }
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

    describe '#songs_by_title' do
      it 'returns songs sorted by title alphabetically, case insensitive' do
        talking_heads = Artist.create!(name: 'Talking Heads')

        z_song = talking_heads.songs.create!(title: 'z Song', length: 456, play_count: 45)
        wild_life = talking_heads.songs.create!(title: 'Wild Wild Life', length: 456, play_count: 45)
        she_was = talking_heads.songs.create!(title: 'and She Was', length: 3334, play_count: 34)

        expect(talking_heads.songs_by_title).to eq([she_was, wild_life, z_song])
      end

      it 'does not return songs from other artists' do
        talking_heads = Artist.create!(name: 'Talking Heads')

        bowie = Artist.create!(name: 'David Bowie')
        bowie_song = bowie.songs.create!(title: 'Suffragette City', length: 1, play_count: 1)

        z_song = talking_heads.songs.create!(title: 'z Song', length: 456, play_count: 45)
        wild_life = talking_heads.songs.create!(title: 'Wild Wild Life', length: 456, play_count: 45)
        she_was = talking_heads.songs.create!(title: 'and She Was', length: 3334, play_count: 34)

        expect(talking_heads.songs_by_title).to_not include(bowie_song)
      end
    end

    describe '#shortest_songs' do
      it 'returns the shortest songs for an artist' do
        talking_heads = Artist.create!(name: 'Talking Heads')

        bowie = Artist.create!(name: 'David Bowie')
        bowie_song = bowie.songs.create!(title: 'Suffragette City', length: 1, play_count: 1)

        z_song = talking_heads.songs.create!(title: 'z Song', length: 456, play_count: 45)
        wild_life = talking_heads.songs.create!(title: 'Wild Wild Life', length: 1, play_count: 45)
        she_was = talking_heads.songs.create!(title: 'and She Was', length: 3334, play_count: 34)

        expect(talking_heads.shortest_songs(2)).to eq([wild_life, z_song])
      end

      it 'defaults to the shortest with no argument' do
        talking_heads = Artist.create!(name: 'Talking Heads')

        bowie = Artist.create!(name: 'David Bowie')
        bowie_song = bowie.songs.create!(title: 'Suffragette City', length: 1, play_count: 1)

        z_song = talking_heads.songs.create!(title: 'z Song', length: 456, play_count: 45)
        wild_life = talking_heads.songs.create!(title: 'Wild Wild Life', length: 1, play_count: 45)
        she_was = talking_heads.songs.create!(title: 'and She Was', length: 3334, play_count: 34)

        expect(talking_heads.shortest_songs).to eq([wild_life])
      end
    end

    describe '#played_songs_count' do
      it 'returns the count of songs with at least 1 play and a length > 0' do
        talking_heads = Artist.create!(name: 'Talking Heads')

        bowie = Artist.create!(name: 'David Bowie')
        bowie_song = bowie.songs.create!(title: 'Suffragette City', length: 1, play_count: 1)

        z_song = talking_heads.songs.create!(title: 'z Song', length: 456, play_count: 45)
        wild_life = talking_heads.songs.create!(title: 'Wild Wild Life', length: 1, play_count: 45)
        she_was = talking_heads.songs.create!(title: 'and She Was', length: 3334, play_count: 34)
        talking_heads.songs.create!(title: 'unplayed song', length: 3334, play_count: 0)
        talking_heads.songs.create!(title: 'invalid length song', length: 0, play_count: 34)

        expect(talking_heads.played_songs_count).to eq(3)
      end
    end
  end

  describe "class methods" do
    describe '::by_name' do
      it 'returns Artists ordered by name alphabetically' do
        talking_heads = Artist.create!(name: 'Talking Heads')
        bowie = Artist.create!(name: 'David Bowie')
        jgb = Artist.create!(name: 'Jerry Garcia Band')

        expect(Artist.by_name).to eq([bowie, jgb, talking_heads])
      end
    end
  end
end
