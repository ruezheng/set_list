class Artist < ApplicationRecord
  has_many :songs

  validates_presence_of :name

  def average_song_length
    songs.average(:length)
  end
end
