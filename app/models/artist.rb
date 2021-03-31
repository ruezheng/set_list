class Artist < ApplicationRecord
  has_many :songs

  def average_song_length
    self.songs.average(:length)
  end

  def self.by_name
    self.order(:name)
  end

  def songs_by_title
    # could also be songs.order('lower(title)')
    songs.by_title # this version reuses the Song class method, aka code is DRYer
  end

  def shortest_songs(limit = 1)
    songs.shortest(limit)
  end

  def played_songs_count
    songs.where('play_count > 0').where('length > 0').count
  end
end
