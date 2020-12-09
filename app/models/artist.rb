class Artist < ApplicationRecord
  has_many :songs

  def average_song_length
    songs.average(:length)
  end

  def self.most_recently_updated
    Artist.order(updated_at: :desc).limit(1).first
  end
end
