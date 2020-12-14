class Artist < ApplicationRecord
  has_many :songs

  def self.order_by_creation_time
    order('created_at ASC')
  end

  def self.order_by_update_time
    order('updated_at ASC')
  end

  def average_song_length
    songs.average(:length)
  end

  def find_song_by_id(song_id)
    songs.find(song_id)
  end

  def random_song
    songs.sample
  end

  def order_songs_by_title
    songs.order(title: :asc)
  end

  def longest_song
    songs.order(length: :desc)
          .limit(1)
          .first
  end

  def top_5_songs
    songs.order('play_count DESC')
          .limit(5)
  end
end
