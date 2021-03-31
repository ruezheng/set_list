class Artist < ApplicationRecord
  has_many :songs

  def average_song_length
    binding.pry
    songs.average(:length)
  end

  def self.by_name
    binding.pry
    order(:name)
  end
end
